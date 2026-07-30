# frozen_string_literal: true

require 'gosu'
require_relative 'lib/player'
require_relative 'lib/camera'
require_relative 'lib/input_handler'
require_relative 'lib/soundwave'
require_relative 'lib/enemy'
require_relative 'lib/enemy_spawner'
require_relative 'lib/collision_system'

class GameWindow < Gosu::Window
  attr_reader :soundwaves, :enemies, :score, :coins

  def initialize
    super 800, 600
    self.caption = "Dog Dash Drift"

    @player = Player.new(100, 284)
    @camera = Camera.new(1.5)
    @soundwaves = []
    @enemies = []
    @spawner = EnemySpawner.new(2.0, 3.0)
    @score = 0
    @coins = 0
  end

  def update
    @camera.update

    # Player and Projectile Spawning
    new_projectile = @player.update(self, width, height)
    @soundwaves << new_projectile if new_projectile

    # Enemy Spawning
    new_enemy = @spawner.update(1.0 / 60.0, width, height)
    @enemies << new_enemy if new_enemy

    # Update Entities
    @soundwaves.each(&:update)
    @enemies.each(&:update)

    # Collision Detection
    collision_results = CollisionSystem.handle_soundwave_enemy_collisions(@soundwaves, @enemies)
    @score += collision_results[:score]
    @coins += collision_results[:coins]

    # Cleanup Inactive / Out-of-bounds Entities
    @soundwaves.reject! { |sw| sw.out_of_bounds?(width) || !sw.active? }
    @enemies.reject! { |e| e.out_of_bounds? || !e.active? }
  end

  def draw
    # Background color
    Gosu.draw_rect(0, 0, width, height, Gosu::Color.argb(0xff_1e1e2e))

    # Grid background lines scrolling effect
    grid_spacing = 40
    offset_x = (@camera.x % grid_spacing).to_i

    ((width / grid_spacing) + 2).times do |i|
      x_pos = (i * grid_spacing) - offset_x
      Gosu.draw_line(x_pos, 0, Gosu::Color.argb(0x22_ffffff), x_pos, height, Gosu::Color.argb(0x22_ffffff))
    end

    @player.draw
    @soundwaves.each(&:draw)
    @enemies.each(&:draw)
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    close if id == Gosu::KB_ESCAPE
  end
end

GameWindow.new.show if __FILE__ == $0
