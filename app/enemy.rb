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

  def update(delta_time = 1.0 / 60.0, target_y = nil)
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

class YarnBall
  WIDTH = 12
  HEIGHT = 12
  SPEED = 6.0
  DAMAGE = 15

  attr_accessor :x, :y, :speed, :active, :damage, :w, :h

  def initialize(x, y, speed = SPEED, damage = DAMAGE)
    @x = x.to_f
    @y = y.to_f
    @w = WIDTH
    @h = HEIGHT
    @speed = speed.to_f
    @damage = damage
    @active = true
  end

  def update
    @x -= @speed
  end

  def out_of_bounds?
    @x + @w < 0
  end

  def active?
    @active && !out_of_bounds?
  end

  def deactivate!
    @active = false
  end

  def primitive
    { x: @x, y: @y, w: @w, h: @h, r: 230, g: 126, b: 34, path: :pixel }
  end

  def rect
    [@x, @y, @w, @h]
  end
end

class SniperCat
  WIDTH = 32
  HEIGHT = 32
  SPEED = 2.0
  DEFAULT_HP = 30
  COOLDOWN = 2.5
  COINS_REWARD = 15
  SCORE_REWARD = 30

  attr_accessor :x, :y, :hp, :max_hp, :speed, :active, :state, :stop_x, :shoot_cooldown, :coins_reward, :score_reward

  def initialize(x = 1280, y = 344, hp = DEFAULT_HP, speed = SPEED, stop_distance = 300.0)
    @x = x.to_f
    @y = y.to_f
    @hp = hp
    @max_hp = hp
    @speed = speed.to_f
    @active = true
    @state = :moving
    @stop_x = (x - stop_distance).to_f
    @shoot_cooldown = COOLDOWN
    @coins_reward = COINS_REWARD
    @score_reward = SCORE_REWARD
  end

  def update(delta_time = 1.0 / 60.0, target_y = nil)
    if @state == :moving
      @x -= @speed
      if @x <= @stop_x
        @x = @stop_x
        @state = :standing_and_shooting
      end
      nil
    elsif @state == :standing_and_shooting
      @shoot_cooldown -= delta_time
      if @shoot_cooldown <= 0
        @shoot_cooldown = COOLDOWN
        shoot
      else
        nil
      end
    end
  end

  def shoot
    spawn_x = @x - YarnBall::WIDTH
    spawn_y = @y + (HEIGHT / 2.0) - (YarnBall::HEIGHT / 2.0)
    YarnBall.new(spawn_x, spawn_y)
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
    { x: @x, y: @y, w: WIDTH, h: HEIGHT, r: 155, g: 89, b: 182, path: :pixel }
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
