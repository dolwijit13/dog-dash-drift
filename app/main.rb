# frozen_string_literal: true

require_relative 'input_handler'
require_relative 'camera'
require_relative 'player'
require_relative 'soundwave'
require_relative 'enemy'
require_relative 'enemy_spawner'
require_relative 'collision_system'

def tick(args)
  # Initialize Game State
  args.state.player ||= Player.new(100, 344)
  args.state.camera ||= Camera.new(1.5)
  args.state.soundwaves ||= []
  args.state.enemies ||= []
  args.state.spawner ||= EnemySpawner.new(2.0, 3.0)
  args.state.score ||= 0
  args.state.coins ||= 0

  grid_w = (args.grid && args.grid.w) ? args.grid.w : 1280
  grid_h = (args.grid && args.grid.h) ? args.grid.h : 720

  # Reset on ESC key
  if args.inputs && args.inputs.keyboard && args.inputs.keyboard.key_down && args.inputs.keyboard.key_down.escape
    args.state.player = Player.new(100, 344)
    args.state.soundwaves = []
    args.state.enemies = []
    args.state.score = 0
    args.state.coins = 0
  end

  # Update State
  args.state.camera.update

  new_bullet = args.state.player.update(args.inputs, grid_w, grid_h, 1.0 / 60.0)
  args.state.soundwaves << new_bullet if new_bullet

  new_enemy = args.state.spawner.update(1.0 / 60.0, grid_w, grid_h)
  args.state.enemies << new_enemy if new_enemy

  args.state.soundwaves.each(&:update)
  args.state.enemies.each(&:update)

  # Collision Detection
  collision_results = CollisionSystem.handle_soundwave_enemy_collisions(args.state.soundwaves, args.state.enemies)
  args.state.score += collision_results[:score]
  args.state.coins += collision_results[:coins]

  # Cleanup Inactive Entities
  args.state.soundwaves.reject! { |sw| sw.out_of_bounds?(grid_w) || !sw.active? }
  args.state.enemies.reject! { |e| e.out_of_bounds? || !e.active? }

  # Render Background & Grid Lines
  args.outputs.solids << { x: 0, y: 0, w: grid_w, h: grid_h, r: 30, g: 30, b: 46 }

  grid_spacing = 40
  offset_x = (args.state.camera.x % grid_spacing).to_i
  num_lines = (grid_w.to_i / grid_spacing.to_i) + 2
  num_lines.times do |i|
    x_pos = (i * grid_spacing) - offset_x
    args.outputs.lines << { x: x_pos, y: 0, x2: x_pos, y2: grid_h, r: 255, g: 255, b: 255, a: 30 }
  end

  # Render Player, Projectiles, and Enemies
  args.outputs.solids << args.state.player.primitive
  args.state.soundwaves.each { |sw| args.outputs.solids << sw.primitive }
  args.state.enemies.each { |e| args.outputs.solids << e.primitive }

  # Render HUD
  args.outputs.labels << { x: 20, y: grid_h - 20, text: "Coins: $#{args.state.coins}", size_enum: 2, r: 255, g: 255, b: 255 }
  args.outputs.labels << { x: 20, y: grid_h - 50, text: "Score: #{args.state.score}", size_enum: 2, r: 255, g: 255, b: 255 }
end
