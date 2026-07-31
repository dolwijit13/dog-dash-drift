# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/enemy'

class TestEvilCat < Minitest::Test
  def setup
    @enemy = EvilCat.new(800.0, 200.0, 25, 3.0)
  end

  def test_initialization
    assert_equal 800.0, @enemy.x
    assert_equal 200.0, @enemy.y
    assert_equal 25, @enemy.hp
    assert_equal 25, @enemy.max_hp
    assert_equal 3.0, @enemy.speed
    assert @enemy.active?
    assert_equal 32, EvilCat::WIDTH
    assert_equal 32, EvilCat::HEIGHT
    assert_equal 25, EvilCat::DEFAULT_HP
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
    @enemy.take_damage(10)
    assert_equal 15, @enemy.hp
    assert @enemy.active?

    @enemy.take_damage(15)
    assert_equal 0, @enemy.hp
    refute @enemy.active?
  end

  def test_hp_bar_primitives
    assert_empty @enemy.hp_bar_primitives

    @enemy.take_damage(10)
    prims = @enemy.hp_bar_primitives
    assert_equal 2, prims.size
    assert_equal 800.0, prims[0][:x]
    assert_equal 236.0, prims[0][:y]
    assert_equal 32, prims[0][:w]
  end

  def test_rect
    rect = @enemy.rect
    assert_equal [800.0, 200.0, 32, 32], rect
  end
end
