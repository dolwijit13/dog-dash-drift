# frozen_string_literal: true

class EvilCat
  WIDTH = 32
  HEIGHT = 32
  SPEED = 3.0

  attr_accessor :x, :y, :hp, :speed, :active

  def initialize(x = 1280, y = 344, hp = 1, speed = SPEED)
    @x = x.to_f
    @y = y.to_f
    @hp = hp
    @speed = speed.to_f
    @active = true
  end

  def update
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
    @active = false if @hp <= 0
  end

  def rect
    [ @x, @y, WIDTH, HEIGHT ]
  end

  def primitive
    { x: @x, y: @y, w: WIDTH, h: HEIGHT, r: 255, g: 42, b: 42 }
  end
end
