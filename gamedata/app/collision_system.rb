# frozen_string_literal: true

require_relative 'collectible'

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
    results = { kills: 0, score: 0, coins: 0, dropped_collectibles: [] }

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

            # 30% drop chance for BoneSnack collectible
            if rand < 0.3
              results[:dropped_collectibles] << BoneSnack.new(enemy.x, enemy.y)
            end
          end

          break
        end
      end
    end

    results
  end

  def self.handle_player_collectible_collisions(player, collectibles)
    results = { score: 0, coins: 0, picked_up: 0 }
    return results unless player && collectibles

    collectibles.each do |item|
      next unless item.active?

      if check_intersect(player.rect, item.rect)
        item.active = false
        results[:picked_up] += 1
        results[:coins] += 10
        results[:score] += 20
      end
    end

    results
  end

  def self.handle_player_obstacle_collisions(player, obstacles)
    results = { hits: 0, coins_lost: 0 }
    return results unless player && obstacles

    obstacles.each do |obstacle|
      next unless obstacle.active?

      if check_intersect(player.rect, obstacle.rect)
        obstacle.active = false
        results[:hits] += 1
        results[:coins_lost] += 5
        player.apply_slowdown(1.0) if player.respond_to?(:apply_slowdown)
      end
    end

    results
  end
end
