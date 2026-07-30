# frozen_string_literal: true

begin
  require 'gosu'
rescue LoadError
  # Fallback for headless unit testing
end

class InputHandler
  def self.directional_vector(window)
    return [0.0, 0.0] unless window

    dx = 0.0
    dy = 0.0

    if defined?(Gosu) && window.respond_to?(:button_down?)
      dx -= 1.0 if window.button_down?(Gosu::KB_A) || window.button_down?(Gosu::KB_LEFT)
      dx += 1.0 if window.button_down?(Gosu::KB_D) || window.button_down?(Gosu::KB_RIGHT)
      dy -= 1.0 if window.button_down?(Gosu::KB_W) || window.button_down?(Gosu::KB_UP)
      dy += 1.0 if window.button_down?(Gosu::KB_S) || window.button_down?(Gosu::KB_DOWN)
    end

    normalize(dx, dy)
  end

  def self.normalize(dx, dy)
    return [0.0, 0.0] if dx == 0.0 && dy == 0.0

    length = Math.sqrt(dx * dx + dy * dy)
    [dx / length, dy / length]
  end
end
