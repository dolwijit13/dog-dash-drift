# frozen_string_literal: true

begin
  require 'gosu'
rescue LoadError
  # Fallback for headless unit testing environments
end

class EvilCat
  WIDTH = 32
  HEIGHT = 32
  SPEED = 3.0
  COLOR = defined?(Gosu) && defined?(Gosu::Color) ? Gosu::Color::RED : 0xff_ff0000

  attr_accessor :x, :y, :hp, :speed, :active

  def initialize(x = 800, y = 284, hp = 1, speed = SPEED)
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

  def bounding_box
    { x: @x, y: @y, width: WIDTH, height: HEIGHT }
  end

  def draw
    Gosu.draw_rect(@x, @y, WIDTH, HEIGHT, COLOR) if defined?(Gosu) && Gosu.respond_to?(:draw_rect)
  end
end
