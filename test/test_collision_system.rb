# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/collision_system'
require_relative '../lib/soundwave'
require_relative '../lib/enemy'

class TestCollisionSystem < Minitest::Test
  def setup
    @soundwave = Soundwave.new(100.0, 100.0)
    @enemy = EvilCat.new(105.0, 100.0)
  end

  def test_aabb_check_overlapping
    box1 = { x: 0, y: 0, width: 10, height: 10 }
    box2 = { x: 5, y: 5, width: 10, height: 10 }
    box3 = { x: 20, y: 20, width: 10, height: 10 }

    assert CollisionSystem.check_aabb(box1, box2)
    refute CollisionSystem.check_aabb(box1, box3)
  end

  def test_soundwave_enemy_collision_handling
    soundwaves = [@soundwave]
    enemies = [@enemy]

    results = CollisionSystem.handle_soundwave_enemy_collisions(soundwaves, enemies)

    refute @soundwave.active?
    refute @enemy.active?
    assert_equal 0, @enemy.hp
    assert_equal 1, results[:kills]
    assert_equal 10, results[:score]
    assert_equal 5, results[:coins]
  end
end
