# frozen_string_literal: true

require 'gosu'

class Player
  WIDTH = 32
  HEIGHT = 32
  COLOR = Gosu::Color::GREEN

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
    Gosu.draw_rect(@x, @y, WIDTH, HEIGHT, COLOR)
  end
end
