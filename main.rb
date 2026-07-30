# frozen_string_literal: true

require 'gosu'
require_relative 'lib/player'

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
    self.caption = "Dog Dash Drift"

    @player = Player.new
  end

  def update
    @player.update(mouse_x, mouse_y)
  end

  def draw
    # Background color
    Gosu.draw_rect(0, 0, width, height, Gosu::Color.argb(0xff_1e1e2e))

    @player.draw
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    close if id == Gosu::KB_ESCAPE
  end
end

GameWindow.new.show if __FILE__ == $0
