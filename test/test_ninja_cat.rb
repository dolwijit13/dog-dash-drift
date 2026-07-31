# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/enemy'
require_relative '../app/player'
require_relative '../app/collision_system'

class TestNinjaCat < Minitest::Test
  def setup
    @ninja = NinjaCat.new(1000, 300, 45, 4.5)
  end

  def test_initialization_defaults
    assert_equal 1000.0, @ninja.x
    assert_equal 300.0, @ninja.y
    assert_equal 45, @ninja.hp
    assert_equal 45, @ninja.max_hp
    assert_equal 4.5, @ninja.speed
    assert_equal 25, @ninja.coins_reward
    assert_equal 50, @ninja.score_reward
    assert_equal 20, @ninja.touch_damage
  end

  def test_movement_and_y_homing
    # Player is at Y = 500, Ninja starts at Y = 300
    player_y = 500.0
    @ninja.update(1.0 / 60.0, player_y)

    assert_equal 995.5, @ninja.x
    assert @ninja.y > 300.0 # Moved towards 500
    assert_in_delta 307.0, @ninja.y, 0.5
  end

  def test_player_touch_collision_deals_20_damage
    player = Player.new(990, 300)
    results = CollisionSystem.handle_player_enemy_collisions(player, [@ninja])

    assert_equal 1, results[:hits]
    assert_equal 20, results[:damage_taken]
    assert_equal 80, player.hp # Default 100 - 20 = 80
  end

  def test_killing_ninja_cat_rewards_25_coins_and_50_score
    soundwave = Struct.new(:rect, :active?, :deactivate!, :damage).new([995, 300, 20, 20], true, nil, 50)
    def soundwave.deactivate!; end

    results = CollisionSystem.handle_soundwave_enemy_collisions([soundwave], [@ninja])

    assert_equal 1, results[:kills]
    assert_equal 25, results[:coins]
    assert_equal 50, results[:score]
  end
end
