# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/player'
require_relative '../app/input_handler'
require_relative '../app/soundwave'

class TestPlayer < Minitest::Test
  def setup
    @player = Player.new(100, 100, 4.0, 0.5)
  end

  def test_initialization
    assert_equal 100.0, @player.x
    assert_equal 100.0, @player.y
    assert_equal 4.0, @player.speed
    assert_equal 0.5, @player.fire_rate
    assert_equal 0.0, @player.cooldown
    assert_equal 32, Player::WIDTH
    assert_equal 32, Player::HEIGHT
  end

  def test_move_by_cardinal_directions
    @player.move_by(1.0, 0.0)
    assert_equal 104.0, @player.x
    assert_equal 100.0, @player.y

    @player.move_by(0.0, 1.0)
    assert_equal 104.0, @player.x
    assert_equal 104.0, @player.y
  end

  def test_diagonal_normalization
    dx, dy = InputHandler.normalize(1.0, 1.0)
    expected_norm = 1.0 / Math.sqrt(2.0)

    assert_in_delta expected_norm, dx, 0.0001
    assert_in_delta expected_norm, dy, 0.0001
  end

  def test_boundary_clamping
    @player.x = -50.0
    @player.y = -50.0
    @player.clamp_position(800, 600)

    assert_equal 0.0, @player.x
    assert_equal 0.0, @player.y

    @player.x = 900.0
    @player.y = 700.0
    @player.clamp_position(800, 600)

    assert_equal 800 - Player::WIDTH, @player.x
    assert_equal 600 - Player::HEIGHT, @player.y
  end

  def test_auto_attack_spawning_and_cooldown
    assert @player.can_shoot?

    projectiles = @player.update(nil, 800, 600, 0.01)
    refute_nil projectiles
    refute_empty projectiles
    projectile = projectiles.first
    assert_kind_of Soundwave, projectile

    expected_spawn_x = @player.x + Player::WIDTH
    expected_spawn_y = @player.y + (Player::HEIGHT / 2.0) - (Soundwave::HEIGHT / 2.0)
    assert_equal expected_spawn_x, projectile.x
    assert_equal expected_spawn_y, projectile.y

    assert_equal 0.5, @player.cooldown
    refute @player.can_shoot?

    second_projectiles = @player.update(nil, 800, 600, 0.2)
    assert_nil second_projectiles
    assert_in_delta 0.3, @player.cooldown, 0.0001

    third_projectiles = @player.update(nil, 800, 600, 0.3)
    refute_nil third_projectiles
    refute_empty third_projectiles
    assert_kind_of Soundwave, third_projectiles.first
    assert_equal 0.5, @player.cooldown
  end

  def test_reset_for_stage_preserves_weapon_upgrades
    @player.boomerang_weapon.upgrade!
    assert_equal 1, @player.boomerang_weapon.level
    assert @player.boomerang_weapon.unlocked

    @player.x = 500
    @player.y = 500
    @player.reset_for_stage!

    assert_equal 100.0, @player.x
    assert_equal 344.0, @player.y
    assert_equal 1, @player.boomerang_weapon.level
    assert @player.boomerang_weapon.unlocked

    projectiles = @player.update(nil, 800, 600, 0.01)
    refute_nil projectiles
    assert projectiles.any? { |p| p.is_a?(BoomerangProjectile) }
  end
end
