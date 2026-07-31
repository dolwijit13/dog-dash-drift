# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/weapon'
require_relative '../app/soundwave'
require_relative '../app/enemy'
require_relative '../app/collision_system'

class TestMortarWeapon < Minitest::Test
  def setup
    @weapon = MortarWeapon.new(1)
  end

  def test_initialization_defaults
    assert_equal 1, @weapon.level
    assert @weapon.unlocked
    assert_equal 15, @weapon.direct_damage
    assert_equal 10, @weapon.aoe_damage
    assert_equal 40, @weapon.radius
    assert_equal 1.5, @weapon.cooldown
    assert_equal 220, @weapon.upgrade_cost
  end

  def test_locked_at_level_0
    locked_weapon = MortarWeapon.new(0)
    refute locked_weapon.unlocked
    assert_equal 150, locked_weapon.upgrade_cost
    assert_empty locked_weapon.fire(100, 100)

    assert locked_weapon.upgrade!
    assert_equal 1, locked_weapon.level
    assert locked_weapon.unlocked
    assert_equal 1, locked_weapon.fire(100, 100).size
  end

  def test_progression_level_1_to_5
    # Level 1
    assert_equal 15, @weapon.direct_damage

    # Level 2
    @weapon.upgrade!
    assert_equal 2, @weapon.level
    assert_equal 22, @weapon.direct_damage
    assert_equal 65, @weapon.radius

    # Level 3 (2 projectiles)
    @weapon.upgrade!
    assert_equal 3, @weapon.level
    assert_equal 2, @weapon.fire(100, 100).size

    # Level 4 (Cluster burst 3 clusters)
    @weapon.upgrade!
    assert_equal 4, @weapon.level
    assert_equal 3, @weapon.cluster_count
    assert_equal 90, @weapon.radius

    # Level 5 (Kibble Apocalypse, 3 bombs, 4 clusters, 110px radius)
    @weapon.upgrade!
    assert_equal 5, @weapon.level
    assert_equal 110, @weapon.radius
    assert_equal 50, @weapon.direct_damage
    assert_equal 4, @weapon.cluster_count
    assert_equal 3, @weapon.fire(100, 100).size
  end

  def test_parabolic_trajectory_and_explosion
    bomb = MortarProjectile.new(100, 200, 8.0, 6.0, 15, 10, 40, 0, 0, 100)
    refute bomb.exploded

    # Update gravity steps until ground_y (100)
    60.times { bomb.update }

    assert bomb.exploded
    assert_equal 10, bomb.damage
  end
end
