# frozen_string_literal: true

require 'minitest/autorun'

# Mock Gosu module for headless unit testing environment if needed
unless defined?(Gosu)
  module Gosu
    class Color
      GREEN = 0xff_00ff00
    end

    def self.draw_rect(_x, _y, _width, _height, _color)
      true
    end
  end
end

require_relative '../lib/player'

class TestPlayer < Minitest::Test
  def setup
    @player = Player.new(100, 100)
  end

  def test_initialization
    assert_equal 100, @player.x
    assert_equal 100, @player.y
    assert_equal 32, Player::WIDTH
    assert_equal 32, Player::HEIGHT
  end

  def test_mouse_tracking_center_alignment
    mouse_x = 400.0
    mouse_y = 300.0

    @player.update(mouse_x, mouse_y)

    expected_x = mouse_x - (Player::WIDTH / 2.0)
    expected_y = mouse_y - (Player::HEIGHT / 2.0)

    assert_equal expected_x, @player.x
    assert_equal expected_y, @player.y
  end
end
