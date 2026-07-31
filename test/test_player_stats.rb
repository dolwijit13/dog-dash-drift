# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/player'
require_relative '../app/enemy'
require_relative '../app/soundwave'
require_relative '../app/collision_system'

class TestPlayerStats < Minitest::Test
  def setup
    @player = Player.new(100, 344)
  end

  def test_initialization_defaults
    assert_equal 100, @player.hp
    assert_equal 100, @player.max_hp
    assert_equal 10, @player.base_damage
    assert_equal 1, @player.hp_level
    assert_equal 1, @player.move_speed_level
    assert_equal 1, @player.damage_level
    refute @player.invulnerable?
  end

  def test_take_damage_and_invulnerability_frame
    result = @player.take_damage(25)
    assert result
    assert_equal 75, @player.hp
    assert @player.invulnerable?

    # Secondary hit during invulnerability frame should be ignored
    second_result = @player.take_damage(25)
    refute second_result
    assert_equal 75, @player.hp

    # Advance timer past invulnerability frame
    @player.update(nil, 1280, 720, 1.1)
    refute @player.invulnerable?

    third_result = @player.take_damage(25)
    assert third_result
    assert_equal 50, @player.hp
  end

  def test_upgrade_max_hp
    @player.take_damage(30)
    assert_equal 70, @player.hp

    @player.upgrade_max_hp(25)
    assert_equal 2, @player.hp_level
    assert_equal 125, @player.max_hp
    assert_equal 95, @player.hp
  end

  def test_upgrade_speed
    initial_speed = @player.speed
    @player.upgrade_speed(0.5)

    assert_equal 2, @player.move_speed_level
    assert_equal initial_speed + 0.5, @player.speed
    assert_equal initial_speed + 0.5, @player.base_speed
  end

  def test_upgrade_damage_and_projectile_scaling
    assert_equal 10, @player.base_damage
    @player.upgrade_damage(5)

    assert_equal 2, @player.damage_level
    assert_equal 15, @player.base_damage

    bullet = @player.shoot
    refute_nil bullet
    assert_equal 15, bullet.damage
  end

  def test_player_enemy_collision_damage
    enemy = EvilCat.new(100, 344)
    results = CollisionSystem.handle_player_enemy_collisions(@player, [enemy])

    assert_equal 1, results[:hits]
    assert_equal 15, results[:damage_taken]
    assert_equal 85, @player.hp
    assert @player.invulnerable?
  end
end
