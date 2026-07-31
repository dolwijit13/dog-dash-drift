# frozen_string_literal: true

class EvilCat
  WIDTH = 32
  HEIGHT = 32
  SPEED = 3.0
  DEFAULT_HP = 25

  attr_accessor :x, :y, :hp, :max_hp, :speed, :active

  def initialize(x = 1280, y = 344, hp = DEFAULT_HP, speed = SPEED)
    @x = x.to_f
    @y = y.to_f
    @hp = hp
    @max_hp = hp
    @speed = speed.to_f
    @active = true
  end

  def update(delta_time = 1.0 / 60.0, player_y = nil)
    @x -= @speed
  end

  def out_of_bounds?
    @x < -WIDTH
  end

  def active?
    @active && !out_of_bounds? && @hp > 0
  end

  def take_damage(amount = 1)
    @hp -= amount
    @hp = 0 if @hp < 0
    @active = false if @hp <= 0
  end

  def rect
    [ @x, @y, WIDTH, HEIGHT ]
  end

  def primitive
    { x: @x, y: @y, w: WIDTH, h: HEIGHT, r: 255, g: 42, b: 42, path: :pixel }
  end

  def hp_bar_primitives
    return [] unless active? && @hp < @max_hp

    bar_w = WIDTH
    bar_h = 4
    bar_x = @x
    bar_y = @y + HEIGHT + 4

    ratio = (@hp.to_f / @max_hp.to_f).clamp(0.0, 1.0)
    current_w = (bar_w * ratio).to_i

    [
      { x: bar_x, y: bar_y, w: bar_w, h: bar_h, r: 180, g: 40, b: 40, path: :pixel },
      { x: bar_x, y: bar_y, w: current_w, h: bar_h, r: 40, g: 220, b: 40, path: :pixel }
    ]
  end
end

class NinjaCat
  WIDTH = 32
  HEIGHT = 32
  SPEED = 4.5
  DEFAULT_HP = 45
  COINS_REWARD = 25
  SCORE_REWARD = 50
  TOUCH_DAMAGE = 20

  attr_accessor :x, :y, :hp, :max_hp, :speed, :active, :coins_reward, :score_reward, :touch_damage

  def initialize(x = 1280, y = 344, hp = DEFAULT_HP, speed = SPEED)
    @x = x.to_f
    @y = y.to_f
    @hp = hp
    @max_hp = hp
    @speed = speed.to_f
    @active = true
    @coins_reward = COINS_REWARD
    @score_reward = SCORE_REWARD
    @touch_damage = TOUCH_DAMAGE
  end

  def update(delta_time = 1.0 / 60.0, player_y = nil)
    @x -= @speed
    if player_y
      @y += (player_y.to_f - @y) * 0.035
    end
    nil
  end

  def out_of_bounds?
    @x < -WIDTH
  end

  def active?
    @active && !out_of_bounds? && @hp > 0
  end

  def take_damage(amount = 1)
    @hp -= amount
    @hp = 0 if @hp < 0
    @active = false if @hp <= 0
  end

  def rect
    [@x, @y, WIDTH, HEIGHT]
  end

  def primitive
    { x: @x, y: @y, w: WIDTH, h: HEIGHT, r: 44, g: 62, b: 80, path: :pixel }
  end

  def hp_bar_primitives
    return [] unless active? && @hp < @max_hp

    bar_w = WIDTH
    bar_h = 4
    bar_x = @x
    bar_y = @y + HEIGHT + 4

    ratio = (@hp.to_f / @max_hp.to_f).clamp(0.0, 1.0)
    current_w = (bar_w * ratio).to_i

    [
      { x: bar_x, y: bar_y, w: bar_w, h: bar_h, r: 180, g: 40, b: 40, path: :pixel },
      { x: bar_x, y: bar_y, w: current_w, h: bar_h, r: 40, g: 220, b: 40, path: :pixel }
    ]
  end
end
