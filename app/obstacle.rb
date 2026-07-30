# frozen_string_literal: true

class Broccoli
  attr_accessor :x, :y, :w, :h, :active

  WIDTH = 28.0
  HEIGHT = 28.0
  COLOR = { r: 34, g: 139, b: 34 }.freeze

  def initialize(x = 1280, y = 284)
    @x = x.to_f
    @y = y.to_f
    @w = WIDTH
    @h = HEIGHT
    @active = true
  end

  def update(scroll_speed = 1.5)
    @x -= scroll_speed
    @active = false if @x + @w < 0
  end

  def active?
    @active
  end

  def out_of_bounds?
    @x + @w < 0
  end

  def rect
    [@x, @y, @w, @h]
  end

  def primitive
    {
      x: @x,
      y: @y,
      w: @w,
      h: @h,
      r: COLOR[:r],
      g: COLOR[:g],
      b: COLOR[:b],
      primitive_marker: :solid
    }
  end
end
