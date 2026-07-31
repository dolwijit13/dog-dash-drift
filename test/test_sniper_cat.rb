# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/enemy'
require_relative '../app/player'
require_relative '../app/collision_system'

class TestSniperCat < Minitest::Test
  def setup
    @sniper = SniperCat.new(1000, 344, 30, 2.0, 300.0)
  end

  def test_initialization_defaults
    assert_equal 1000.0, @sniper.x
    assert_equal 344.0, @sniper.y
    assert_equal 30, @sniper.hp
    assert_equal 30, @sniper.max_hp
    assert_equal 2.0, @sniper.speed
    assert_equal :moving, @sniper.state
    assert_equal 700.0, @sniper.stop_x
    assert_equal 15, @sniper.coins_reward
    assert_equal 30, @sniper.score_reward
  end

  def test_movement_and_stop_transition
    # Advance position until stop_x (700)
    160.times { @sniper.update(1.0 / 60.0) }

    assert_equal 700.0, @sniper.x
    assert_equal :standing_and_shooting, @sniper.state
  end

  def test_shooting_yarn_ball_projectile
    @sniper.state = :standing_and_shooting
    @sniper.shoot_cooldown = 0.01

    projectile = @sniper.update(0.02)
    refute_nil projectile
    assert_kind_of YarnBall, projectile
    assert_equal 15, projectile.damage
    assert_equal 6.0, projectile.speed
  end

  def test_yarn_ball_projectile_movement_and_player_collision
    yarn = YarnBall.new(100, 344, 6.0, 15)
    yarn.update
    assert_equal 94.0, yarn.x

    player = Player.new(90, 344)
    results = CollisionSystem.handle_player_enemy_projectile_collisions(player, [yarn])

    assert_equal 1, results[:hits]
    assert_equal 15, results[:damage_taken]
    assert_equal 85, player.hp
    refute yarn.active?
  end
end
