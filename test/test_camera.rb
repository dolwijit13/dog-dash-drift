# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/camera'

class TestCamera < Minitest::Test
  def setup
    @camera = Camera.new(1.5)
  end

  def test_initialization
    assert_equal 0.0, @camera.x
    assert_equal 0.0, @camera.y
    assert_equal 1.5, @camera.scroll_speed
  end

  def test_update_scrolls_x
    @camera.update
    assert_equal 1.5, @camera.x

    @camera.update
    assert_equal 3.0, @camera.x
  end
end
