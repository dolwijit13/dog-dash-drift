# frozen_string_literal: true

require_relative 'input_handler'
require_relative 'camera'
require_relative 'player'
require_relative 'soundwave'
require_relative 'enemy'
require_relative 'enemy_spawner'
require_relative 'collectible'
require_relative 'obstacle'
require_relative 'collision_system'

def tick(args)
  # Initialize Game State
  args.state.player ||= Player.new(100, 344)
  args.state.camera ||= Camera.new(1.5)
  args.state.soundwaves ||= []
  args.state.enemies ||= []
  args.state.collectibles ||= []
  args.state.obstacles ||= []
  args.state.spawner ||= EnemySpawner.new(2.0, 3.0)
  args.state.obstacle_timer ||= 3.5
  args.state.score ||= 0
  args.state.coins ||= 0

  grid_w = (args.grid && args.grid.w) ? args.grid.w : 1280
  grid_h = (args.grid && args.grid.h) ? args.grid.h : 720

  # Reset on ESC key
  if args.inputs && args.inputs.keyboard && args.inputs.keyboard.key_down && args.inputs.keyboard.key_down.escape
    args.state.player = Player.new(100, 344)
    args.state.soundwaves = []
    args.state.enemies = []
    args.state.collectibles = []
    args.state.obstacles = []
    args.state.score = 0
    args.state.coins = 0
  end

  # Update State
  args.state.camera.update

  new_bullet = args.state.player.update(args.inputs, grid_w, grid_h, 1.0 / 60.0)
  args.state.soundwaves << new_bullet if new_bullet

  new_enemy = args.state.spawner.update(1.0 / 60.0, grid_w, grid_h)
  args.state.enemies << new_enemy if new_enemy

  # Periodic Broccoli Obstacle Spawner
  args.state.obstacle_timer -= 1.0 / 60.0
  if args.state.obstacle_timer <= 0
    args.state.obstacle_timer = 3.0 + rand * 2.0
    spawn_y = rand * (grid_h - Broccoli::HEIGHT)
    args.state.obstacles << Broccoli.new(grid_w, spawn_y)
  end

  args.state.soundwaves.each(&:update)
  args.state.enemies.each(&:update)
  args.state.collectibles.each(&:update)
  args.state.obstacles.each(&:update)

  # Collision Detection (Soundwave vs Enemy)
  collision_results = CollisionSystem.handle_soundwave_enemy_collisions(args.state.soundwaves, args.state.enemies)
  args.state.score += collision_results[:score]
  args.state.coins += collision_results[:coins]
  args.state.collectibles.concat(collision_results[:dropped_collectibles]) if collision_results[:dropped_collectibles]

  # Collision Detection (Player vs Collectible)
  pickup_results = CollisionSystem.handle_player_collectible_collisions(args.state.player, args.state.collectibles)
  args.state.score += pickup_results[:score]
  args.state.coins += pickup_results[:coins]

  # Collision Detection (Player vs Obstacle Penalty)
  obstacle_results = CollisionSystem.handle_player_obstacle_collisions(args.state.player, args.state.obstacles)
  if obstacle_results[:coins_lost] > 0
    args.state.coins = (args.state.coins - obstacle_results[:coins_lost]).clamp(0, 999999)
  end

  # Cleanup Inactive Entities
  args.state.soundwaves.reject! { |sw| sw.out_of_bounds?(grid_w) || !sw.active? }
  args.state.enemies.reject! { |e| e.out_of_bounds? || !e.active? }
  args.state.collectibles.reject! { |c| c.out_of_bounds? || !c.active? }
  args.state.obstacles.reject! { |o| o.out_of_bounds? || !o.active? }

  # Render Background & Grid Lines
  args.outputs.sprites << { x: 0, y: 0, w: grid_w, h: grid_h, r: 30, g: 30, b: 46, primitive_marker: :solid }

  grid_spacing = 40
  offset_x = (args.state.camera.x % grid_spacing).to_i
  num_lines = ((grid_w.to_f / grid_spacing.to_f) + 2).to_i
  num_lines.times do |i|
    x_pos = (i * grid_spacing) - offset_x
    args.outputs.lines << { x: x_pos, y: 0, x2: x_pos, y2: grid_h, r: 255, g: 255, b: 255, a: 30 }
  end

  # Render Player, Projectiles, Collectibles, Obstacles, and Enemies
  args.outputs.sprites << args.state.player.primitive
  args.state.soundwaves.each { |sw| args.outputs.sprites << sw.primitive }
  args.state.collectibles.each { |c| args.outputs.sprites << c.primitive }
  args.state.obstacles.each { |o| args.outputs.sprites << o.primitive }
  args.state.enemies.each { |e| args.outputs.sprites << e.primitive }

  # Render HUD
  hud_y_top = grid_h - 20
  args.outputs.labels << { x: 30, y: hud_y_top, text: "Bones: $#{args.state.coins}", size_enum: 2, r: 241, g: 196, b: 15 }
  args.outputs.labels << { x: 30, y: hud_y_top - 30, text: "Score: #{args.state.score}", size_enum: 2, r: 255, g: 255, b: 255 }
end
