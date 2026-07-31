# frozen_string_literal: true

require_relative 'stage'

class StageSelectUI
  def self.render(args, stage_manager, coins, grid_w = 1280, grid_h = 720)
    center_x = grid_w / 2
    center_y = grid_h / 2

    # Background
    args.outputs.sprites << { x: 0, y: 0, w: grid_w, h: grid_h, r: 25, g: 25, b: 38, path: :pixel }

    # Main Title
    args.outputs.labels << { x: center_x, y: grid_h - 40, text: 'DOG DASH DELUXE — STAGE HUB', size_enum: 8, alignment_enum: 1, r: 241, g: 196, b: 15 }
    args.outputs.labels << { x: center_x, y: grid_h - 90, text: "Bones Balance: $#{coins}", size_enum: 3, alignment_enum: 1, r: 46, g: 204, b: 113 }

    # Render 3 Stage Cards
    card_w = 340
    card_h = 320
    card_spacing = 30
    total_w = (card_w * 3) + (card_spacing * 2)
    start_x = center_x - (total_w / 2)
    card_y = center_y - 100

    (1..3).each do |stage_id|
      cx = start_x + (stage_id - 1) * (card_w + card_spacing)
      unlocked = stage_manager.stage_unlocked?(stage_id)
      is_current = (stage_manager.current_stage_id == stage_id)

      bg_r, bg_g, bg_b = unlocked ? (is_current ? [40, 70, 90] : [35, 45, 60]) : [20, 20, 25]
      border_r, border_g, border_b = unlocked ? [46, 204, 113] : [100, 100, 100]

      args.outputs.sprites << { x: cx, y: card_y, w: card_w, h: card_h, r: bg_r, g: bg_g, b: bg_b, path: :pixel }
      args.outputs.lines << { x: cx, y: card_y + card_h, x2: cx + card_w, y2: card_y + card_h, r: border_r, g: border_g, b: border_b }

      # Stage Number & Title
      stage_obj = Stage.new(stage_id)
      status_text = unlocked ? (is_current ? 'SELECTED' : 'UNLOCKED') : 'LOCKED'
      status_r, status_g, status_b = unlocked ? [46, 204, 113] : [180, 50, 50]

      args.outputs.labels << { x: cx + (card_w / 2), y: card_y + card_h - 30, text: "STAGE #{stage_id}", size_enum: 5, alignment_enum: 1, r: 255, g: 255, b: 255 }
      args.outputs.labels << { x: cx + (card_w / 2), y: card_y + card_h - 75, text: stage_obj.name, size_enum: 2, alignment_enum: 1, r: 241, g: 196, b: 15 }

      args.outputs.labels << { x: cx + (card_w / 2), y: card_y + card_h - 130, text: "Target: #{stage_obj.target_distance.to_i}m", size_enum: 1, alignment_enum: 1, r: 200, g: 200, b: 200 }
      args.outputs.labels << { x: cx + (card_w / 2), y: card_y + card_h - 170, text: "Status: #{status_text}", size_enum: 2, alignment_enum: 1, r: status_r, g: status_g, b: status_b }

      # Action Button inside card
      btn_w = 200
      btn_h = 40
      btn_x = cx + (card_w / 2) - (btn_w / 2)
      btn_y = card_y + 30

      btn_r, btn_g, btn_b = unlocked ? [52, 152, 219] : [60, 60, 60]
      btn_text = unlocked ? "PLAY (#{stage_id})" : "LOCKED"

      args.outputs.sprites << { x: btn_x, y: btn_y, w: btn_w, h: btn_h, r: btn_r, g: btn_g, b: btn_b, path: :pixel }
      args.outputs.labels << { x: cx + (card_w / 2), y: btn_y + 26, text: btn_text, size_enum: 1, alignment_enum: 1, r: 255, g: 255, b: 255 }
    end

    # Bottom Instructions & Shop Button
    args.outputs.labels << { x: center_x, y: 50, text: 'Press 1-3 to Select Stage | Press TAB/P for Shop | Press SPACE to Start', size_enum: 1, alignment_enum: 1, r: 255, g: 255, b: 255 }
  end

  def self.handle_inputs(args, stage_manager)
    kb = args.inputs && args.inputs.keyboard && args.inputs.keyboard.key_down
    mouse_click = args.inputs && args.inputs.respond_to?(:mouse) && args.inputs.mouse && args.inputs.mouse.click

    grid_w = (args.grid && args.grid.w) ? args.grid.w : 1280
    grid_h = (args.grid && args.grid.h) ? args.grid.h : 720
    center_x = grid_w / 2
    center_y = grid_h / 2

    # Keyboard stage select (keys 1, 2, 3)
    if kb
      if (kb.respond_to?(:one) && kb.one) || (kb.respond_to?(:digit_1) && kb.digit_1)
        stage_manager.select_stage!(1)
      elsif (kb.respond_to?(:two) && kb.two) || (kb.respond_to?(:digit_2) && kb.digit_2)
        stage_manager.select_stage!(2)
      elsif (kb.respond_to?(:three) && kb.three) || (kb.respond_to?(:digit_3) && kb.digit_3)
        stage_manager.select_stage!(3)
      end
    end

    # Mouse click on cards
    card_w = 340
    card_h = 320
    card_spacing = 30
    total_w = (card_w * 3) + (card_spacing * 2)
    start_x = center_x - (total_w / 2)
    card_y = center_y - 100

    selected = false

    if mouse_click
      (1..3).each do |stage_id|
        cx = start_x + (stage_id - 1) * (card_w + card_spacing)
        btn_w = 200
        btn_h = 40
        btn_x = cx + (card_w / 2) - (btn_w / 2)
        btn_y = card_y + 30

        if mouse_click.x >= cx && mouse_click.x <= (cx + card_w) &&
           mouse_click.y >= card_y && mouse_click.y <= (card_y + card_h)
          if stage_manager.select_stage!(stage_id)
            selected = true
          end
        end
      end
    end

    start_trigger = kb && (kb.respond_to?(:space) && kb.space || kb.respond_to?(:enter) && kb.enter)

    start_trigger || selected
  end
end
