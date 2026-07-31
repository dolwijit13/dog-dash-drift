# frozen_string_literal: true

class Soundwave
  WIDTH = 16
  HEIGHT = 8
  SPEED = 8.0
  DEFAULT_DAMAGE = 10

  attr_accessor :x, :y, :vx, :vy, :speed, :active, :damage, :w, :h

  def initialize(x, y, vx_or_speed = SPEED, vy_or_damage = 0.0, damage = DEFAULT_DAMAGE, w = WIDTH, h = HEIGHT)
    @x = x.to_f
    @y = y.to_f
    @w = w
    @h = h
    @active = true

    if vx_or_speed.is_a?(Numeric) && vy_or_damage.is_a?(Numeric) && damage.is_a?(Numeric) && w == WIDTH && h == HEIGHT && vy_or_damage > 1.0
      @vx = vx_or_speed.to_f
      @vy = 0.0
      @speed = vx_or_speed.to_f
      @damage = vy_or_damage
    else
      @vx = vx_or_speed.to_f
      @vy = vy_or_damage.to_f
      @speed = Math.sqrt(@vx * @vx + @vy * @vy)
      @damage = damage
    end
  end

  def update
    @x += @vx
    @y += @vy
  end

  def out_of_bounds?(boundary_width = 1280, boundary_height = 720)
    @x > boundary_width || @y < -@h || @y > boundary_height
  end

  def active?(boundary_width = 1280)
    @active && !out_of_bounds?(boundary_width)
  end

  def deactivate!
    @active = false
  end

  def primitive
    { x: @x, y: @y, w: @w, h: @h, r: 0, g: 255, b: 255, path: :pixel }
  end

  def rect
    [ @x, @y, @w, @h ]
  end
end
