# frozen_string_literal: true

class Camera
  attr_accessor :x, :y, :scroll_speed

  def initialize(scroll_speed = 1.5)
    @x = 0.0
    @y = 0.0
    @scroll_speed = scroll_speed.to_f
  end

  def update
    @x += @scroll_speed
  end
end
