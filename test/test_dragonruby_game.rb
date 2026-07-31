# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/player'
require_relative '../app/camera'
require_relative '../app/soundwave'
require_relative '../app/enemy'
require_relative '../app/enemy_spawner'
require_relative '../app/collectible'
require_relative '../app/obstacle'
require_relative '../app/collision_system'
require_relative '../app/main'

# Mock DragonRuby args structure for unit testing
class MockKeyboard
  attr_accessor :a, :d, :w, :s, :left, :right, :up, :down, :key_down

  def initialize
    @key_down = Struct.new(:escape, :r).new(false, false)
  end
end

class MockInputs
  attr_reader :keyboard

  def initialize
    @keyboard = MockKeyboard.new
  end
end

class MockOutputs
  attr_reader :solids, :lines, :labels, :sprites

  def initialize
    @solids = []
    @lines = []
    @labels = []
    @sprites = []
  end
end

class MockGrid
  attr_reader :w, :h

  def initialize(w = 1280, h = 720)
    @w = w
    @h = h
  end
end

class MockState
  attr_accessor :game_state, :player, :camera, :soundwaves, :enemies, :collectibles, :obstacles, :obstacle_timer, :spawner, :score, :coins
end

class MockArgs
  attr_reader :state, :inputs, :outputs, :grid

  def initialize
    @state = MockState.new
    @inputs = MockInputs.new
    @outputs = MockOutputs.new
    @grid = MockGrid.new
  end
end

class TestDragonRubyGame < Minitest::Test
  def setup
    @args = MockArgs.new
  end

  def test_initialization_in_tick
    tick(@args)

    refute_nil @args.state.player
    refute_nil @args.state.camera
    refute_nil @args.state.spawner
    assert_equal 0, @args.state.score
    assert_equal 0, @args.state.coins
    assert_kind_of Player, @args.state.player
    assert_kind_of Camera, @args.state.camera
  end

  def test_player_auto_attack_and_primitives
    player = Player.new(100, 344)
    assert player.can_shoot?

    bullet = player.shoot
    refute_nil bullet
    assert_equal 16, Soundwave::WIDTH
    assert_equal 8, Soundwave::HEIGHT

    prim = player.primitive
    assert_equal 32, prim[:w]
    assert_equal 32, prim[:h]
    assert_equal 46, prim[:r]
  end

  def test_enemy_spawning_and_collision
    enemy = EvilCat.new(500, 300, 10)
    soundwave = Soundwave.new(490, 300, 8.0, 10)

    results = CollisionSystem.handle_soundwave_enemy_collisions([soundwave], [enemy])

    refute soundwave.active?
    refute enemy.active?
    assert_equal 1, results[:kills]
    assert_equal 10, results[:score]
    assert_equal 5, results[:coins]
  end

  def test_collectible_bone_snack_creation_and_scrolling
    bone = BoneSnack.new(200, 300)
    assert bone.active?
    assert_equal 20, bone.w
    assert_equal 20, bone.h

    bone.update(1.5)
    assert_equal 198.5, bone.x

    prim = bone.primitive
    assert_equal 241, prim[:r]
    assert_equal 196, prim[:g]
    assert_equal 15, prim[:b]
  end

  def test_player_collectible_pickup_reward
    player = Player.new(100, 300)
    bone = BoneSnack.new(105, 305)

    results = CollisionSystem.handle_player_collectible_collisions(player, [bone])

    refute bone.active?
    assert_equal 1, results[:picked_up]
    assert_equal 10, results[:coins]
    assert_equal 20, results[:score]
  end

  def test_broccoli_obstacle_creation_and_penalty
    player = Player.new(100, 300)
    broccoli = Broccoli.new(105, 305)

    assert_equal 28.0, broccoli.w
    assert_equal 28.0, broccoli.h
    prim = broccoli.primitive
    assert_equal 34, prim[:r]
    assert_equal 139, prim[:g]
    assert_equal 34, prim[:b]

    results = CollisionSystem.handle_player_obstacle_collisions(player, [broccoli])

    refute broccoli.active?
    assert_equal 1, results[:hits]
    assert_equal 5, results[:coins_lost]
    assert player.slowdown_timer > 0
  end

  def test_tick_render_output
    tick(@args)

    refute_empty @args.outputs.sprites
    refute_empty @args.outputs.lines
    refute_empty @args.outputs.labels

    bones_label = @args.outputs.labels.find { |l| l[:text].start_with?("Bones:") }
    score_label = @args.outputs.labels.find { |l| l[:text].start_with?("Score:") }

    refute_nil bones_label
    refute_nil score_label
    assert_equal 30, bones_label[:x]
    assert_equal 700, bones_label[:y]
    assert_equal "Bones: $0", bones_label[:text]
    assert_equal "Score: 0", score_label[:text]
  end
end
