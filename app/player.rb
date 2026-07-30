# frozen_string_literal: true

require_relative 'input_handler'
require_relative 'soundwave'

class Player
  WIDTH = 32
  HEIGHT = 32
  FIRE_RATE = 0.5

  attr_accessor :x, :y, :speed, :base_speed, :cooldown, :fire_rate, :slowdown_timer

  def initialize(x = 100, y = 344, speed = 4.0, fire_rate = FIRE_RATE)
    @x = x.to_f
    @y = y.to_f
    @base_speed = speed.to_f
    @speed = speed.to_f
    @fire_rate = fire_rate.to_f
    @cooldown = 0.0
    @slowdown_timer = 0.0
  end

  def apply_slowdown(duration_sec = 1.0)
    @slowdown_timer = duration_sec.to_f
  end

  def update(inputs = nil, boundary_width = 1280, boundary_height = 720, delta_time = 1.0 / 60.0)
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

    @cooldown = @fire_rate
    spawn_x = @x + WIDTH
    spawn_y = @y + (HEIGHT / 2.0) - (Soundwave::HEIGHT / 2.0)
    Soundwave.new(spawn_x, spawn_y)
  end

  def clamp_position(boundary_width = 1280, boundary_height = 720)
    max_x = boundary_width - WIDTH
    max_y = boundary_height - HEIGHT

    @x = @x.clamp(0.0, max_x.to_f)
    @y = @y.clamp(0.0, max_y.to_f)
  end

  def primitive
    { x: @x, y: @y, w: WIDTH, h: HEIGHT, r: 46, g: 204, b: 113, primitive_marker: :solid }
  end

  def rect
    [ @x, @y, WIDTH, HEIGHT ]
  end
end
