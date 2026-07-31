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

class BoomerangProjectile
  attr_accessor :x, :y, :vx, :vy, :w, :h, :decel, :active, :out_damage, :return_damage, :hit_enemies, :piercing

  def initialize(x, y, vx = 10.0, vy = 0.0, out_damage = 12, return_damage = 12, w = 16, h = 16, decel = 0.35)
    @x = x.to_f
    @y = y.to_f
    @vx = vx.to_f
    @vy = vy.to_f
    @w = w
    @h = h
    @out_damage = out_damage
    @return_damage = return_damage
    @decel = decel.to_f
    @active = true
    @piercing = true
    @hit_enemies = []
    @was_returning = false
  end

  def update
    @x += @vx
    @y += @vy
    @vx -= @decel

    if @vx < 0 && !@was_returning
      @was_returning = true
      @hit_enemies.clear
    end
  end

  def damage
    @vx >= 0 ? @out_damage : @return_damage
  end

  def returning?
    @vx < 0
  end

  def out_of_bounds?(boundary_width = 1280, boundary_height = 720)
    (@vx < 0 && @x + @w < 0) || @y < -@h || @y > boundary_height + @h
  end

  def active?(boundary_width = 1280)
    @active && !out_of_bounds?(boundary_width)
  end

  def deactivate!
    @active = false
  end

  def primitive
    { x: @x, y: @y, w: @w, h: @h, r: 241, g: 224, b: 176, path: :pixel }
  end

  def rect
    [@x, @y, @w, @h]
  end
end

class MortarProjectile
  attr_accessor :x, :y, :vx, :vy, :w, :h, :gravity, :active, :direct_damage, :aoe_damage, :radius, :exploded, :cluster_count, :cluster_damage, :ground_y, :aoe_applied

  def initialize(x, y, vx = 8.0, vy = 6.0, direct_damage = 15, aoe_damage = 10, radius = 40, cluster_count = 0, cluster_damage = 10, ground_y = 100)
    @x = x.to_f
    @y = y.to_f
    @vx = vx.to_f
    @vy = vy.to_f
    @w = 16
    @h = 16
    @gravity = 0.35
    @direct_damage = direct_damage
    @aoe_damage = aoe_damage
    @radius = radius
    @cluster_count = cluster_count
    @cluster_damage = cluster_damage
    @ground_y = ground_y
    @active = true
    @exploded = false
    @aoe_applied = false
  end

  def update
    if @exploded
      @explosion_timer ||= 10
      @explosion_timer -= 1
      deactivate! if @explosion_timer <= 0
      return
    end

    @x += @vx
    @y += @vy
    @vy -= @gravity

    if @vy < 0 && @y <= @ground_y
      explode!
    end
  end

  def explode!
    @exploded = true
  end

  def damage
    @exploded ? @aoe_damage : @direct_damage
  end

  def out_of_bounds?(boundary_width = 1280, boundary_height = 720)
    @x > boundary_width || @y < -@h
  end

  def active?(boundary_width = 1280)
    @active && !out_of_bounds?(boundary_width)
  end

  def deactivate!
    @active = false
  end

  def primitive
    if @exploded
      { x: @x - @radius, y: @y - @radius, w: @radius * 2, h: @radius * 2, r: 230, g: 126, b: 34, a: 160, path: :pixel }
    else
      { x: @x, y: @y, w: @w, h: @h, r: 139, g: 69, b: 19, path: :pixel }
    end
  end

  def rect
    if @exploded
      [@x - @radius, @y - @radius, @radius * 2, @radius * 2]
    else
      [@x, @y, @w, @h]
    end
  end
end
