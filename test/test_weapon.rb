# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/weapon'
require_relative '../app/player'
require_relative '../app/soundwave'

class TestWeapon < Minitest::Test
  def setup
    @weapon = SoundwaveWeapon.new(1)
  end

  def test_initialization_level_1
    assert_equal 'Soundwave', @weapon.name
    assert_equal 1, @weapon.level
    assert_equal 5, @weapon.max_level
    assert_equal 0.5, @weapon.cooldown
    assert_equal 10, @weapon.damage
    assert_equal 16, @weapon.w
    assert_equal 8, @weapon.h
    assert_equal 1, @weapon.projectile_count
    assert @weapon.can_upgrade?
    assert_equal 50, @weapon.upgrade_cost
  end

  def test_upgrade_to_level_2
    assert @weapon.upgrade!
    assert_equal 2, @weapon.level
    assert_equal 0.375, @weapon.cooldown
    assert_equal 10, @weapon.damage
    assert_equal 16, @weapon.w
    assert_equal 8, @weapon.h
    assert_equal 1, @weapon.projectile_count
    assert_equal 100, @weapon.upgrade_cost
  end

  def test_upgrade_to_level_3
    @weapon.upgrade! # L2
    @weapon.upgrade! # L3
    assert_equal 3, @weapon.level
    assert_equal 0.375, @weapon.cooldown
    assert_equal 15, @weapon.damage
    assert_equal 24, @weapon.w
    assert_equal 12, @weapon.h
    assert_equal 1, @weapon.projectile_count
    assert_equal 200, @weapon.upgrade_cost
  end

  def test_upgrade_to_level_4_dual_soundwaves
    3.times { @weapon.upgrade! }
    assert_equal 4, @weapon.level
    assert_equal 2, @weapon.projectile_count
    assert_equal 350, @weapon.upgrade_cost

    bullets = @weapon.fire(100, 300)
    assert_equal 2, bullets.size
    assert_equal 100, bullets[0].x
    assert_equal 100, bullets[1].x
    assert_equal 308.0, bullets[0].y
    assert_equal 292.0, bullets[1].y
  end

  def test_upgrade_to_level_5_spread_soundwaves
    4.times { @weapon.upgrade! }
    assert_equal 5, @weapon.level
    assert_equal 3, @weapon.projectile_count
    refute @weapon.can_upgrade?
    assert_nil @weapon.upgrade_cost

    bullets = @weapon.fire(100, 300)
    assert_equal 3, bullets.size
    # Bullet 0: Straight
    assert_equal 8.0, bullets[0].vx
    assert_equal 0.0, bullets[0].vy

    # Bullet 1: Angled Up
    assert_equal 7.0, bullets[1].vx
    assert_equal 3.5, bullets[1].vy

    # Bullet 2: Angled Down
    assert_equal 7.0, bullets[2].vx
    assert_equal(-3.5, bullets[2].vy)
  end

  def test_player_weapon_firing_integration
    player = Player.new(100, 300)
    bullets = player.shoot

    assert_kind_of Array, bullets
    assert_equal 1, bullets.size
    assert_kind_of Soundwave, bullets[0]

    # Upgrade player weapon to Level 4
    3.times { player.weapon.upgrade! }
    player.cooldown = 0.0

    dual_bullets = player.shoot
    refute_nil dual_bullets
    assert_equal 2, dual_bullets.size
  end
end
