# frozen_string_literal: true

require_relative 'input_handler'
require_relative 'soundwave'
require_relative 'weapon'

class Player
  WIDTH = 32
  HEIGHT = 32
  DEFAULT_MAX_HP = 100
  DEFAULT_BASE_DAMAGE = 10

  attr_accessor :x, :y, :speed, :base_speed, :cooldown, :slowdown_timer,
                :hp, :max_hp, :hp_level, :move_speed_level, :damage_level, :base_damage, :invulnerable_timer, :weapon

  def initialize(x = 100, y = 344, speed = 4.0, fire_rate = nil, max_hp = DEFAULT_MAX_HP, base_damage = DEFAULT_BASE_DAMAGE)
    @x = x.to_f
    @y = y.to_f
    @base_speed = speed.to_f
    @speed = speed.to_f
    @slowdown_timer = 0.0

    @max_hp = max_hp
    @hp = max_hp
    @base_damage = base_damage
    @hp_level = 1
    @move_speed_level = 1
    @damage_level = 1
    @invulnerable_timer = 0.0

    @weapon = SoundwaveWeapon.new(1)
    @cooldown = 0.0
  end

  def fire_rate
    @weapon ? @weapon.cooldown : 0.5
  end

  def fire_rate=(val)
    @weapon.cooldown = val.to_f if @weapon
  end

  def move_by(dx, dy)
    @x += dx * @speed
    @y += dy * @speed
  end

  def apply_slowdown(duration_sec = 1.0)
    @slowdown_timer = duration_sec.to_f
  end

  def invulnerable?
    @invulnerable_timer > 0
  end

  def take_damage(amount = 10)
    return false if invulnerable?

    @hp -= amount
    @hp = 0 if @hp < 0
    @invulnerable_timer = 1.0
    true
  end

  def upgrade_max_hp(amount = 25)
    @hp_level += 1
    @max_hp += amount
    @hp = (@hp + amount).clamp(0, @max_hp)
  end

  def upgrade_speed(amount = 0.5)
    @move_speed_level += 1
    @base_speed += amount
    @speed = @base_speed
  end

  def upgrade_damage(amount = 5)
    @damage_level += 1
    @base_damage += amount
  end

  def update(inputs = nil, boundary_width = 1280, boundary_height = 720, delta_time = 1.0 / 60.0)
    @invulnerable_timer -= delta_time if @invulnerable_timer > 0

    if @slowdown_timer > 0
      @slowdown_timer -= delta_time
      @speed = @base_speed * 0.5
    else
      @speed = @base_speed
    end

    if inputs
      dx, dy = InputHandler.directional_vector(inputs)
      @x += dx * @speed
      @y += dy * @speed
    end

    clamp_position(boundary_width, boundary_height)
    update_auto_attack(delta_time)
  end

  def update_auto_attack(delta_time = 1.0 / 60.0)
    @cooldown -= delta_time if @cooldown > 0

    if can_shoot?
      shoot
    else
      nil
    end
  end

  def can_shoot?
    @cooldown <= 0
  end

  def shoot
    return nil unless can_shoot?

    @cooldown = fire_rate
    spawn_x = @x + WIDTH
    spawn_y = @y + (HEIGHT / 2.0) - ((@weapon ? @weapon.h : 8) / 2.0)

    if @weapon
      bullets = @weapon.fire(spawn_x, spawn_y)
      bullets.each { |b| b.damage += (@base_damage - 10) } if @base_damage > 10
      bullets
    else
      [Soundwave.new(spawn_x, spawn_y, Soundwave::SPEED, 0.0, @base_damage)]
    end
  end

  def clamp_position(boundary_width = 1280, boundary_height = 720)
    max_x = boundary_width - WIDTH
    max_y = boundary_height - HEIGHT

    @x = @x.clamp(0.0, max_x.to_f)
    @y = @y.clamp(0.0, max_y.to_f)
  end

  def primitive
    if invulnerable? && (@invulnerable_timer * 10).to_i % 2 == 0
      { x: @x, y: @y, w: WIDTH, h: HEIGHT, r: 255, g: 255, b: 255, path: :pixel }
    else
      { x: @x, y: @y, w: WIDTH, h: HEIGHT, r: 46, g: 204, b: 113, path: :pixel }
    end
  end

  def rect
    [ @x, @y, WIDTH, HEIGHT ]
  end
end
