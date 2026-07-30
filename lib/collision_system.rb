# frozen_string_literal: true

class CollisionSystem
  def self.check_aabb(rect1, rect2)
    return false unless rect1 && rect2

    rect1[:x] < rect2[:x] + rect2[:width] &&
      rect1[:x] + rect1[:width] > rect2[:x] &&
      rect1[:y] < rect2[:y] + rect2[:height] &&
      rect1[:y] + rect1[:height] > rect2[:y]
  end

  def self.handle_soundwave_enemy_collisions(soundwaves, enemies)
    results = { kills: 0, score: 0, coins: 0 }

    soundwaves.each do |sw|
      next unless sw.active?

      sw_box = { x: sw.x, y: sw.y, width: Soundwave::WIDTH, height: Soundwave::HEIGHT }

      enemies.each do |enemy|
        next unless enemy.active?

        if check_aabb(sw_box, enemy.bounding_box)
          sw.deactivate!
          enemy.take_damage(1)

          if enemy.hp <= 0
            results[:kills] += 1
            results[:score] += 10
            results[:coins] += 5
          end

          break
        end
      end
    end

    results
  end
end
