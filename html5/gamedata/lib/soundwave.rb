# frozen_string_literal: true

begin
  require 'gosu'
rescue LoadError
  # Fallback for headless unit testing environments
end

class Soundwave
  WIDTH = 16
  HEIGHT = 8
  SPEED = 8.0
  COLOR = defined?(Gosu) && defined?(Gosu::Color) ? Gosu::Color::CYAN : 0xff_00ffff

  attr_accessor :x, :y, :speed, :active

  def initialize(x, y, speed = SPEED)
    @x = x.to_f
    @y = y.to_f
    @speed = speed.to_f
    @active = true
  end

  def update
    @x += @speed
  end

  def out_of_bounds?(boundary_width = 800)
    @x > boundary_width
  end

  def active?
    @active && !out_of_bounds?
  end

  def deactivate!
    @active = false
  end

  def draw
    Gosu.draw_rect(@x, @y, WIDTH, HEIGHT, COLOR) if defined?(Gosu) && Gosu.respond_to?(:draw_rect)
  end
end
