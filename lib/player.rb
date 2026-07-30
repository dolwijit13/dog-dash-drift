# frozen_string_literal: true

begin
  require 'gosu'
rescue LoadError
  # Fallback for headless unit testing environments
end

class Player
  WIDTH = 32
  HEIGHT = 32
  COLOR = defined?(Gosu) && defined?(Gosu::Color) ? Gosu::Color::GREEN : 0xff_00ff00

  attr_reader :x, :y

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  def update(mouse_x, mouse_y)
    @x = mouse_x - (WIDTH / 2.0)
    @y = mouse_y - (HEIGHT / 2.0)
  end

  def draw
    Gosu.draw_rect(@x, @y, WIDTH, HEIGHT, COLOR) if defined?(Gosu) && Gosu.respond_to?(:draw_rect)
  end
end
