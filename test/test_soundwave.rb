# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/soundwave'

class TestSoundwave < Minitest::Test
  def setup
    @soundwave = Soundwave.new(100.0, 200.0, 8.0)
  end

  def test_initialization
    assert_equal 100.0, @soundwave.x
    assert_equal 200.0, @soundwave.y
    assert_equal 8.0, @soundwave.speed
    assert @soundwave.active?
    assert_equal 16, Soundwave::WIDTH
    assert_equal 8, Soundwave::HEIGHT
  end

  def test_update_moves_right
    @soundwave.update
    assert_equal 108.0, @soundwave.x

    @soundwave.update
    assert_equal 116.0, @soundwave.x
  end

  def test_out_of_bounds_detection
    refute @soundwave.out_of_bounds?(800)

    @soundwave.x = 801.0
    assert @soundwave.out_of_bounds?(800)
    refute @soundwave.active?
  end

  def test_deactivate
    @soundwave.deactivate!
    refute @soundwave.active?
  end
end
