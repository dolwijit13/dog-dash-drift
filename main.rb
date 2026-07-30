# frozen_string_literal: true

require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
    self.caption = "Dog Dash Drift"

    @font = Gosu::Font.new(32)
    @sub_font = Gosu::Font.new(20)
  end

  def update
    # Game state logic updates will go here
  end

  def draw
    # Background color
    Gosu.draw_rect(0, 0, width, height, Gosu::Color.argb(0xff_1e1e2e))

    # Text rendering
    @font.draw_text("Welcome to Dog Dash Drift!", 210, 260, 1, 1.0, 1.0, Gosu::Color::WHITE)
    @sub_font.draw_text("Press ESC to exit", 330, 310, 1, 1.0, 1.0, Gosu::Color.argb(0xff_a6adc8))
  end

  def button_down(id)
    close if id == Gosu::KB_ESCAPE
  end
end

GameWindow.new.show if __FILE__ == $0
