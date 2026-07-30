# frozen_string_literal: true

require 'gosu'
require_relative 'lib/player'
require_relative 'lib/camera'
require_relative 'lib/input_handler'
require_relative 'lib/soundwave'

class GameWindow < Gosu::Window
  attr_reader :soundwaves

  def initialize
    super 800, 600
    self.caption = "Dog Dash Drift"

    @player = Player.new(100, 284)
    @camera = Camera.new(1.5)
    @soundwaves = []
  end

  def update
    @camera.update
    new_projectile = @player.update(self, width, height)
    @soundwaves << new_projectile if new_projectile

    @soundwaves.each(&:update)
    @soundwaves.reject! { |sw| sw.out_of_bounds?(width) || !sw.active? }
  end

  def draw
    # Background color
    Gosu.draw_rect(0, 0, width, height, Gosu::Color.argb(0xff_1e1e2e))

    # Grid background lines scrolling effect
    grid_spacing = 40
    offset_x = (@camera.x % grid_spacing).to_i

    ((width / grid_spacing) + 2).times do |i|
      x_pos = (i * grid_spacing) - offset_x
      Gosu.draw_line(x_pos, 0, Gosu::Color.argb(0x22_ffffff), x_pos, height, Gosu::Color.argb(0x22_ffffff))
    end

    @player.draw
    @soundwaves.each(&:draw)
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    close if id == Gosu::KB_ESCAPE
  end
end

GameWindow.new.show if __FILE__ == $0
