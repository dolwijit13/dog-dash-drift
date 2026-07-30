# frozen_string_literal: true

class BoneSnack
  attr_accessor :x, :y, :w, :h, :active

  def initialize(x, y)
    @x = x.to_f
    @y = y.to_f
    @w = 20.0
    @h = 20.0
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
      r: 241,
      g: 196,
      b: 15
    }
  end
end
