# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/enemy_spawner'
require_relative '../app/enemy'

class TestEnemySpawner < Minitest::Test
  def setup
    @spawner = EnemySpawner.new(2.0, 3.0)
  end

  def test_initialization
    assert_equal 2.0, @spawner.min_interval
    assert_equal 3.0, @spawner.max_interval
    assert @spawner.spawn_timer >= 2.0
    assert @spawner.spawn_timer <= 3.0
  end

  def test_spawning_enemy_when_timer_expires
    @spawner.spawn_timer = 0.05
    no_enemy = @spawner.update(0.01, 800, 600)
    assert_nil no_enemy

    enemy = @spawner.update(0.05, 800, 600)
    refute_nil enemy
    assert (enemy.is_a?(EvilCat) || enemy.is_a?(SniperCat) || enemy.is_a?(NinjaCat))
    assert_equal 800.0, enemy.x
    assert enemy.y >= 0.0
    assert enemy.y <= (600 - EvilCat::HEIGHT)
  end
end
