# frozen_string_literal: true

class ShopUI
  WIDTH = 640
  HEIGHT = 440

  def self.upgrade_costs(player)
    hp_cost = 50 * player.hp_level
    speed_cost = 40 * player.move_speed_level
    damage_cost = 60 * player.damage_level
    weapon_cost = player.weapon ? player.weapon.upgrade_cost : nil

    {
      hp: hp_cost,
      speed: speed_cost,
      damage: damage_cost,
      weapon: weapon_cost
    }
  end

  def self.button_rects(origin_x, origin_y)
    btn_w = 560
    btn_h = 55
    start_y = origin_y + HEIGHT - 130

    [
      { id: :hp, x: origin_x + 40, y: start_y, w: btn_w, h: btn_h, key: '1' },
      { id: :speed, x: origin_x + 40, y: start_y - 70, w: btn_w, h: btn_h, key: '2' },
      { id: :damage, x: origin_x + 40, y: start_y - 140, w: btn_w, h: btn_h, key: '3' },
      { id: :weapon, x: origin_x + 40, y: start_y - 210, w: btn_w, h: btn_h, key: '4' }
    ]
  end

  def self.buy_upgrade(type, player, coins)
    costs = upgrade_costs(player)
    cost = costs[type]

    return { success: false, reason: :insufficient_coins } if cost.nil? || coins < cost

    case type
    when :hp
      player.upgrade_max_hp(25)
      { success: true, coins_spent: cost }
    when :speed
      player.upgrade_speed(0.5)
      { success: true, coins_spent: cost }
    when :damage
      player.upgrade_damage(5)
      { success: true, coins_spent: cost }
    when :weapon
      if player.weapon && player.weapon.can_upgrade?
        player.weapon.upgrade!
        { success: true, coins_spent: cost }
      else
        { success: false, reason: :max_level }
      end
    else
      { success: false, reason: :invalid_type }
    end
  end

  def self.handle_inputs(args, player, coins, grid_w = 1280, grid_h = 720)
    origin_x = (grid_w - WIDTH) / 2
    origin_y = (grid_h - HEIGHT) / 2
    kb = args.inputs && args.inputs.keyboard && args.inputs.keyboard.key_down

    # Keyboard shortcut 1-4
    target_type = nil
    if kb
      if kb.respond_to?(:one) && kb.one || kb.respond_to?(:raw_key) && kb.raw_key == 49
        target_type = :hp
      elsif kb.respond_to?(:two) && kb.two || kb.respond_to?(:raw_key) && kb.raw_key == 50
        target_type = :speed
      elsif kb.respond_to?(:three) && kb.three || kb.respond_to?(:raw_key) && kb.raw_key == 51
        target_type = :damage
      elsif kb.respond_to?(:four) && kb.four || kb.respond_to?(:raw_key) && kb.raw_key == 52
        target_type = :weapon
      end
    end

    # Mouse Click on Option Buttons
    mouse_click = args.inputs && args.inputs.respond_to?(:mouse) && args.inputs.mouse && args.inputs.mouse.click
    if mouse_click && !target_type
      mx = mouse_click.x
      my = mouse_click.y

      button_rects(origin_x, origin_y).each do |btn|
        if mx >= btn[:x] && mx <= (btn[:x] + btn[:w]) && my >= btn[:y] && my <= (btn[:y] + btn[:h])
          target_type = btn[:id]
          break
        end
      end
    end

    return { purchased: false } unless target_type

    result = buy_upgrade(target_type, player, coins)
    if result[:success]
      { purchased: true, coins_spent: result[:coins_spent], type: target_type }
    else
      { purchased: false, reason: result[:reason] }
    end
  end

  def self.render(args, player, coins, grid_w = 1280, grid_h = 720)
    origin_x = (grid_w - WIDTH) / 2
    origin_y = (grid_h - HEIGHT) / 2

    # Background dark overlay
    args.outputs.sprites << { x: 0, y: 0, w: grid_w, h: grid_h, r: 0, g: 0, b: 0, a: 180, path: :pixel }

    # Modal window panel
    args.outputs.sprites << { x: origin_x, y: origin_y, w: WIDTH, h: HEIGHT, r: 40, g: 44, b: 52, path: :pixel }

    # Header bar
    args.outputs.sprites << { x: origin_x, y: origin_y + HEIGHT - 50, w: WIDTH, h: 50, r: 52, g: 73, b: 94, path: :pixel }
    args.outputs.labels << { x: origin_x + 20, y: origin_y + HEIGHT - 15, text: "UPGRADE SHOP", size_enum: 4, r: 255, g: 255, b: 255 }
    args.outputs.labels << { x: origin_x + WIDTH - 20, y: origin_y + HEIGHT - 15, text: "Bones: $#{coins}", size_enum: 3, alignment_enum: 2, r: 241, g: 196, b: 15 }

    # Upgrade option items
    costs = upgrade_costs(player)
    rects = button_rects(origin_x, origin_y)

    items = [
      { type: :hp, title: "[1] Max HP (+25)", desc: "Current: #{player.max_hp} HP (Lv #{player.hp_level})", cost: costs[:hp] },
      { type: :speed, title: "[2] Move Speed (+0.5)", desc: "Current: #{player.speed} (Lv #{player.move_speed_level})", cost: costs[:speed] },
      { type: :damage, title: "[3] Base Damage (+5)", desc: "Current: #{player.base_damage} Dmg (Lv #{player.damage_level})", cost: costs[:damage] },
      { type: :weapon, title: "[4] Soundwave Weapon", desc: player.weapon ? "Current: Lv #{player.weapon.level}/#{player.weapon.max_level}" : "N/A", cost: costs[:weapon] }
    ]

    rects.each_with_index do |btn, idx|
      item = items[idx]
      cost = item[:cost]
      affordable = cost && coins >= cost

      bg_r, bg_g, bg_b = affordable ? [46, 204, 113] : [127, 140, 141]

      args.outputs.sprites << { x: btn[:x], y: btn[:y], w: btn[:w], h: btn[:h], r: bg_r, g: bg_g, b: bg_b, a: affordable ? 220 : 120, path: :pixel }

      args.outputs.labels << { x: btn[:x] + 15, y: btn[:y] + 38, text: item[:title], size_enum: 2, r: 255, g: 255, b: 255 }
      args.outputs.labels << { x: btn[:x] + 15, y: btn[:y] + 18, text: item[:desc], size_enum: -1, r: 236, g: 240, b: 241 }

      cost_text = cost ? "$#{cost}" : "MAX"
      args.outputs.labels << { x: btn[:x] + btn[:w] - 20, y: btn[:y] + 36, text: cost_text, size_enum: 3, alignment_enum: 2, r: affordable ? 241 : 200, g: affordable ? 196 : 200, b: affordable ? 15 : 200 }
    end

    # Footer instructions
    args.outputs.labels << { x: origin_x + (WIDTH / 2), y: origin_y + 25, text: "Press 1-4 or Click Button to Buy | Press TAB / P / ESC to Close", size_enum: 0, alignment_enum: 1, r: 189, g: 195, b: 199 }
  end
end
