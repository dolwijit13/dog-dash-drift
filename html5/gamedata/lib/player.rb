# frozen_string_literal: true

begin
  require 'gosu'
rescue LoadError
  # Fallback for headless unit testing environments
end

require_relative 'input_handler'
require_relative 'soundwave'

class Player
  WIDTH = 32
  HEIGHT = 32
  COLOR = defined?(Gosu) && defined?(Gosu::Color) ? Gosu::Color::GREEN : 0xff_00ff00
  FIRE_RATE = 0.5

  attr_accessor :x, :y, :speed, :cooldown, :fire_rate

  def initialize(x = 100, y = 284, speed = 4.0, fire_rate = FIRE_RATE)
    @x = x.to_f
    @y = y.to_f
    @speed = speed.to_f
    @fire_rate = fire_rate.to_f
    @cooldown = 0.0
  end

  def update(window = nil, boundary_width = 800, boundary_height = 600, delta_time = 1.0 / 60.0)
    if window
      dx, dy = InputHandler.directional_vector(window)
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

  def move_by(dx, dy, boundary_width = 800, boundary_height = 600)
    norm_dx, norm_dy = InputHandler.normalize(dx, dy)
    @x += norm_dx * @speed
    @y += norm_dy * @speed
    clamp_position(boundary_width, boundary_height)
  end

  def clamp_position(boundary_width = 800, boundary_height = 600)
    max_x = boundary_width - WIDTH
    max_y = boundary_height - HEIGHT

    @x = @x.clamp(0.0, max_x.to_f)
    @y = @y.clamp(0.0, max_y.to_f)
  end

  def draw
    Gosu.draw_rect(@x, @y, WIDTH, HEIGHT, COLOR) if defined?(Gosu) && Gosu.respond_to?(:draw_rect)
  end
end
