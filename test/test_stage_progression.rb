# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/stage'
require_relative '../app/stage_clear_ui'

class TestStageProgression < Minitest::Test
  def setup
    @manager = StageManager.new(1, [1])
  end

  def test_initialization_defaults
    assert_equal 1, @manager.current_stage_id
    assert_equal [1], @manager.unlocked_stages
    assert @manager.stage_unlocked?(1)
    refute @manager.stage_unlocked?(2)
  end

  def test_current_stage_configuration
    stage1 = @manager.current_stage
    assert_equal 1, stage1.id
    assert_equal 'Candy Meadow', stage1.name
    assert_equal 1000.0, stage1.target_distance
    assert_equal [:evil_cat], stage1.allowed_enemies
  end

  def test_unlocking_next_stage
    next_id = @manager.unlock_next_stage!
    assert_equal 2, next_id
    assert_equal [1, 2], @manager.unlocked_stages
    assert @manager.stage_unlocked?(2)

    # Unlock Stage 3
    @manager.select_stage!(2)
    @manager.unlock_next_stage!
    assert_equal [1, 2, 3], @manager.unlocked_stages
    assert @manager.stage_unlocked?(3)
  end

  def test_selecting_locked_vs_unlocked_stage
    refute @manager.select_stage!(2)
    assert_equal 1, @manager.current_stage_id

    @manager.unlock_next_stage!
    assert @manager.select_stage!(2)
    assert_equal 2, @manager.current_stage_id
  end
end
