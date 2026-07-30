# frozen_string_literal: true

class InputHandler
  def self.directional_vector(inputs)
    return [0.0, 0.0] unless inputs

    dx = 0.0
    dy = 0.0

    kb = inputs.keyboard
    if kb
      dx -= 1.0 if kb.a || kb.left
      dx += 1.0 if kb.d || kb.right
      dy -= 1.0 if kb.s || kb.down
      dy += 1.0 if kb.w || kb.up
    end

    normalize(dx, dy)
  end

  def self.normalize(dx, dy)
    return [0.0, 0.0] if dx == 0.0 && dy == 0.0

    length = Math.sqrt(dx * dx + dy * dy)
    [dx / length, dy / length]
  end
end
