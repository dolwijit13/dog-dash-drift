# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/stage'
require_relative '../app/stage_select_ui'

class TestStageSelectUI < Minitest::Test
  def setup
    @manager = StageManager.new(1, [1])
  end

  def test_stage_selection_inputs
    assert_equal 1, @manager.current_stage_id

    # Unlock Stage 2 & Select Stage 2
    @manager.unlock_next_stage!
    assert @manager.select_stage!(2)
    assert_equal 2, @manager.current_stage_id

    # Attempt selecting locked Stage 3
    refute @manager.select_stage!(3)
    assert_equal 2, @manager.current_stage_id
  end
end
