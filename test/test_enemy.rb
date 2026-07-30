# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/enemy'

class TestEvilCat < Minitest::Test
  def setup
    @enemy = EvilCat.new(800.0, 200.0, 1, 3.0)
  end

  def test_initialization
    assert_equal 800.0, @enemy.x
    assert_equal 200.0, @enemy.y
    assert_equal 1, @enemy.hp
    assert_equal 3.0, @enemy.speed
    assert @enemy.active?
    assert_equal 32, EvilCat::WIDTH
    assert_equal 32, EvilCat::HEIGHT
  end

  def test_update_moves_left
    @enemy.update
    assert_equal 797.0, @enemy.x

    @enemy.update
    assert_equal 794.0, @enemy.x
  end

  def test_out_of_bounds_detection
    refute @enemy.out_of_bounds?

    @enemy.x = -33.0
    assert @enemy.out_of_bounds?
    refute @enemy.active?
  end

  def test_take_damage_and_deactivation
    @enemy.take_damage(1)
    assert_equal 0, @enemy.hp
    refute @enemy.active?
  end

  def test_bounding_box
    box = @enemy.bounding_box
    assert_equal 800.0, box[:x]
    assert_equal 200.0, box[:y]
    assert_equal 32, box[:width]
    assert_equal 32, box[:height]
  end
end
