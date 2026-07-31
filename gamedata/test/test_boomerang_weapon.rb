# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/weapon'
require_relative '../app/soundwave'
require_relative '../app/enemy'
require_relative '../app/collision_system'

class TestBoomerangWeapon < Minitest::Test
  def setup
    @weapon = BoomerangWeapon.new(1)
  end

  def test_initialization_defaults
    assert_equal 1, @weapon.level
    assert @weapon.unlocked
    assert_equal 12, @weapon.out_damage
    assert_equal 12, @weapon.return_damage
    assert_equal 1.2, @weapon.cooldown
    assert_equal 150, @weapon.upgrade_cost
  end

  def test_locked_at_level_0
    locked_weapon = BoomerangWeapon.new(0)
    refute locked_weapon.unlocked
    assert_equal 100, locked_weapon.upgrade_cost
    assert_empty locked_weapon.fire(100, 100)

    assert locked_weapon.upgrade!
    assert_equal 1, locked_weapon.level
    assert locked_weapon.unlocked
    assert_equal 1, locked_weapon.fire(100, 100).size
  end

  def test_progression_level_1_to_5
    # Level 1
    assert_equal 12, @weapon.out_damage
    assert_equal 12, @weapon.return_damage

    # Level 2
    @weapon.upgrade!
    assert_equal 2, @weapon.level
    assert_equal 16, @weapon.out_damage
    assert_equal 0.9, @weapon.cooldown

    # Level 3 (2 projectiles)
    @weapon.upgrade!
    assert_equal 3, @weapon.level
    assert_equal 2, @weapon.fire(100, 100).size

    # Level 4 (+50% size, return bonus 36)
    @weapon.upgrade!
    assert_equal 4, @weapon.level
    assert_equal 24, @weapon.w
    assert_equal 36, @weapon.return_damage

    # Level 5 (Mega Bone Storm, 3 projectiles, 48x48)
    @weapon.upgrade!
    assert_equal 5, @weapon.level
    assert_equal 48, @weapon.w
    assert_equal 50, @weapon.return_damage
    assert_equal 3, @weapon.fire(100, 100).size
  end

  def test_projectile_trajectory_deceleration_and_return_flips
    projectile = BoomerangProjectile.new(100, 100, 10.0, 0.0, 12, 12, 16, 16, 1.0)
    refute projectile.returning?
    assert_equal 12, projectile.damage

    # Update 11 steps until vx turns negative
    11.times { projectile.update }

    assert projectile.returning?
    assert projectile.vx < 0
  end

  def test_piercing_collision_hits_multiple_enemies_and_resets_on_return
    projectile = BoomerangProjectile.new(100, 100, 5.0, 0.0, 12, 18, 16, 16, 1.0)
    enemy1 = EvilCat.new(102, 100, 50)
    enemy2 = EvilCat.new(105, 100, 50)

    # First forward pass hits enemy1 and enemy2
    results1 = CollisionSystem.handle_soundwave_enemy_collisions([projectile], [enemy1, enemy2])
    assert_equal 38, enemy1.hp # 50 - 12 = 38
    assert_equal 38, enemy2.hp # 50 - 12 = 38
    assert projectile.active? # Did not deactivate!

    # Decelerate until returning
    10.times { projectile.update }
    assert projectile.returning?

    # Second returning pass hits enemy1 again with return bonus damage (18)
    results2 = CollisionSystem.handle_soundwave_enemy_collisions([projectile], [enemy1])
    assert_equal 20, enemy1.hp # 38 - 18 = 20
  end
end
