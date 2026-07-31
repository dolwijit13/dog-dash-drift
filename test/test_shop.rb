# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app/shop_ui'
require_relative '../app/player'
require_relative '../app/weapon'

class TestShop < Minitest::Test
  def setup
    @player = Player.new(100, 300)
    @coins = 500
  end

  def test_upgrade_costs_initial
    costs = ShopUI.upgrade_costs(@player)
    assert_equal 50, costs[:hp]
    assert_equal 40, costs[:speed]
    assert_equal 60, costs[:damage]
    assert_equal 50, costs[:weapon]
  end

  def test_buy_upgrade_insufficient_coins
    result = ShopUI.buy_upgrade(:hp, @player, 20)
    refute result[:success]
    assert_equal :insufficient_coins, result[:reason]
    assert_equal 100, @player.max_hp
  end

  def test_buy_max_hp_success
    result = ShopUI.buy_upgrade(:hp, @player, 100)
    assert result[:success]
    assert_equal 50, result[:coins_spent]
    assert_equal 125, @player.max_hp
    assert_equal 2, @player.hp_level
  end

  def test_buy_speed_success
    result = ShopUI.buy_upgrade(:speed, @player, 100)
    assert result[:success]
    assert_equal 40, result[:coins_spent]
    assert_equal 4.5, @player.speed
    assert_equal 2, @player.move_speed_level
  end

  def test_buy_damage_success
    result = ShopUI.buy_upgrade(:damage, @player, 100)
    assert result[:success]
    assert_equal 60, result[:coins_spent]
    assert_equal 15, @player.base_damage
    assert_equal 2, @player.damage_level
  end

  def test_buy_weapon_success_and_max_level
    result = ShopUI.buy_upgrade(:weapon, @player, 100)
    assert result[:success]
    assert_equal 50, result[:coins_spent]
    assert_equal 2, @player.weapon.level

    # Upgrade to Max Level (Level 5)
    3.times { @player.weapon.upgrade! }
    assert_equal 5, @player.weapon.level

    max_result = ShopUI.buy_upgrade(:weapon, @player, 1000)
    refute max_result[:success]
    assert_equal :insufficient_coins, max_result[:reason] || :max_level
  end

  def test_handle_inputs_mouse_click
    mock_args = Struct.new(:inputs).new(
      Struct.new(:keyboard, :mouse).new(
        nil,
        Struct.new(:click).new(Struct.new(:x, :y).new(360, 460))
      )
    )

    res = ShopUI.handle_inputs(mock_args, @player, 500)
    assert res[:purchased]
    assert_equal 50, res[:coins_spent]
    assert_equal :hp, res[:type]
  end
end
