# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/main'

class MockKeyboard
  attr_accessor :a, :d, :w, :s, :left, :right, :up, :down, :key_down

  def initialize
    @key_down = Struct.new(:escape, :r, :tab, :p, :one, :two, :three, :four).new(false, false, false, false, false, false, false, false)
  end
end

class MockInputs
  attr_reader :keyboard, :mouse

  def initialize
    @keyboard = MockKeyboard.new
    @mouse = Struct.new(:click).new(nil)
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

  def initialize
    @w = 1280
    @h = 720
  end
end

class MockState
  attr_accessor :player, :camera, :soundwaves, :enemies, :collectibles, :obstacles, :spawner, :obstacle_timer, :score, :coins, :game_state

  def initialize
    @game_state = :playing
  end
end

class MockArgs
  attr_reader :inputs, :outputs, :grid, :state

  def initialize
    @inputs = MockInputs.new
    @outputs = MockOutputs.new
    @grid = MockGrid.new
    @state = MockState.new
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
    refute_nil @args.state.soundwaves
    refute_nil @args.state.enemies
    refute_nil @args.state.collectibles
    refute_nil @args.state.obstacles
    refute_nil @args.state.spawner
    assert_equal 0, @args.state.score
    assert_equal 0, @args.state.coins
    assert_equal :playing, @args.state.game_state
  end

  def test_restart_game_over_state
    @args.state.game_state = :game_over
    @args.state.coins = 100
    @args.state.score = 500

    # Simulate R key restart
    @args.inputs.keyboard.key_down.r = true

    tick(@args)

    assert_equal :playing, @args.state.game_state
    assert_equal 0, @args.state.score
    assert_equal 0, @args.state.coins
    refute_nil @args.state.player
  end

  def test_tick_render_output
    tick(@args)

    refute_empty @args.outputs.sprites
    refute_empty @args.outputs.lines
    refute_empty @args.outputs.labels
  end
end
