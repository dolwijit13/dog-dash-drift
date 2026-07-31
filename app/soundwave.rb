# frozen_string_literal: true

class Soundwave
  WIDTH = 16
  HEIGHT = 8
  SPEED = 8.0
  DEFAULT_DAMAGE = 10

  attr_accessor :x, :y, :speed, :active, :damage

  def initialize(x, y, speed = SPEED, damage = DEFAULT_DAMAGE)
    @x = x.to_f
    @y = y.to_f
    @speed = speed.to_f
    @active = true
    @damage = damage
  end

  def update
    @x += @speed
  end

  def out_of_bounds?(boundary_width = 1280)
    @x > boundary_width
  end

  def active?(boundary_width = 1280)
    @active && !out_of_bounds?(boundary_width)
  end

  def deactivate!
    @active = false
  end

  def primitive
    { x: @x, y: @y, w: WIDTH, h: HEIGHT, r: 0, g: 255, b: 255, path: :pixel }
  end

  def rect
    [ @x, @y, WIDTH, HEIGHT ]
  end
end
