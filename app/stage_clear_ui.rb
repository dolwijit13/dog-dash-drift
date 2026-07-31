# frozen_string_literal: true

class StageClearUI
  def self.render(args, stage, score, coins, grid_w = 1280, grid_h = 720)
    center_x = grid_w / 2
    center_y = grid_h / 2

    # Dimmed background overlay
    args.outputs.sprites << { x: 0, y: 0, w: grid_w, h: grid_h, r: 15, g: 30, b: 20, a: 220, path: :pixel }

    # Main Card Box
    card_w = 540
    card_h = 360
    card_x = center_x - (card_w / 2)
    card_y = center_y - (card_h / 2)

    args.outputs.sprites << { x: card_x, y: card_y, w: card_w, h: card_h, r: 30, g: 60, b: 40, path: :pixel }
    args.outputs.lines << { x: card_x, y: card_y + card_h, x2: card_x + card_w, y2: card_y + card_h, r: 46, g: 204, b: 113 }

    # Title & Subtitle
    args.outputs.labels << { x: center_x, y: card_y + card_h - 30, text: 'STAGE CLEAR!', size_enum: 8, alignment_enum: 1, r: 46, g: 204, b: 113 }
    args.outputs.labels << { x: center_x, y: card_y + card_h - 75, text: "#{stage.name} Completed!", size_enum: 3, alignment_enum: 1, r: 241, g: 196, b: 15 }

    # Stats Summary
    args.outputs.labels << { x: center_x, y: center_y + 10, text: "Final Score: #{score}", size_enum: 3, alignment_enum: 1, r: 255, g: 255, b: 255 }
    args.outputs.labels << { x: center_x, y: center_y - 30, text: "Total Bones: $#{coins}", size_enum: 3, alignment_enum: 1, r: 241, g: 196, b: 15 }

    # Prompt Button
    btn_w = 260
    btn_h = 45
    btn_x = center_x - (btn_w / 2)
    btn_y = card_y + 40

    args.outputs.sprites << { x: btn_x, y: btn_y, w: btn_w, h: btn_h, r: 46, g: 204, b: 113, path: :pixel }
    args.outputs.labels << { x: center_x, y: btn_y + 30, text: 'NEXT / RESTART (SPACE/ENTER)', size_enum: 0, alignment_enum: 1, r: 255, g: 255, b: 255 }
  end

  def self.handle_inputs(args)
    kb = args.inputs && args.inputs.keyboard && args.inputs.keyboard.key_down
    mouse_click = args.inputs && args.inputs.respond_to?(:mouse) && args.inputs.mouse && args.inputs.mouse.click

    key_trigger = kb && (kb.respond_to?(:space) && kb.space || kb.respond_to?(:enter) && kb.enter || kb.respond_to?(:r) && kb.r)

    grid_w = (args.grid && args.grid.w) ? args.grid.w : 1280
    grid_h = (args.grid && args.grid.h) ? args.grid.h : 720
    center_x = grid_w / 2
    center_y = grid_h / 2

    btn_w = 260
    btn_h = 45
    btn_x = center_x - (btn_w / 2)
    btn_y = center_y - 180 + 40

    mouse_trigger = mouse_click &&
                    mouse_click.x >= btn_x && mouse_click.x <= (btn_x + btn_w) &&
                    mouse_click.y >= btn_y && mouse_click.y <= (btn_y + btn_h)

    key_trigger || mouse_trigger
  end
end
