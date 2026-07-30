# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/player'
require_relative '../app/camera'
require_relative '../app/soundwave'
require_relative '../app/enemy'
require_relative '../app/enemy_spawner'
require_relative '../app/collision_system'
require_relative '../app/main'

# Mock DragonRuby args structure for unit testing
class MockKeyboard
  attr_accessor :a, :d, :w, :s, :left, :right, :up, :down, :key_down

  def initialize
    @key_down = Struct.new(:escape).new(false)
  end
end

class MockInputs
  attr_reader :keyboard

  def initialize
    @keyboard = MockKeyboard.new
  end
end

class MockOutputs
  attr_reader :solids, :lines, :labels

  def initialize
    @solids = []
    @lines = []
    @labels = []
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
  attr_accessor :player, :camera, :soundwaves, :enemies, :spawner, :score, :coins
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
    enemy = EvilCat.new(500, 300)
    soundwave = Soundwave.new(490, 300)

    results = CollisionSystem.handle_soundwave_enemy_collisions([soundwave], [enemy])

    refute soundwave.active?
    refute enemy.active?
    assert_equal 1, results[:kills]
    assert_equal 10, results[:score]
    assert_equal 5, results[:coins]
  end

  def test_tick_render_output
    tick(@args)

    refute_empty @args.outputs.solids
    refute_empty @args.outputs.lines
    refute_empty @args.outputs.labels
  end
end
