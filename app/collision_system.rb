# frozen_string_literal: true

class CollisionSystem
  def self.check_intersect(rect1, rect2)
    return false unless rect1 && rect2

    r1_x, r1_y, r1_w, r1_h = rect1
    r2_x, r2_y, r2_w, r2_h = rect2

    r1_x < r2_x + r2_w &&
      r1_x + r1_w > r2_x &&
      r1_y < r2_y + r2_h &&
      r1_y + r1_h > r2_y
  end

  def self.handle_soundwave_enemy_collisions(soundwaves, enemies)
    results = { kills: 0, score: 0, coins: 0 }

    soundwaves.each do |sw|
      next unless sw.active?

      enemies.each do |enemy|
        next unless enemy.active?

        if check_intersect(sw.rect, enemy.rect)
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
