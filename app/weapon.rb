# frozen_string_literal: true

require_relative 'soundwave'

class Weapon
  attr_accessor :name, :level, :max_level

  UPGRADE_COSTS = [50, 100, 200, 350].freeze

  def initialize(name = 'Base Weapon', level = 1, max_level = 5)
    @name = name
    @level = level.clamp(1, max_level)
    @max_level = max_level
  end

  def can_upgrade?
    @level < @max_level
  end

  def upgrade_cost
    return nil unless can_upgrade?

    UPGRADE_COSTS[@level - 1] || 500
  end

  def upgrade!
    return false unless can_upgrade?

    @level += 1
    update_stats_for_level
    true
  end

  def update_stats_for_level
    # To be overridden by subclasses
  end

  def fire(spawn_x, spawn_y)
    []
  end
end

class SoundwaveWeapon < Weapon
  attr_accessor :cooldown, :damage, :w, :h, :projectile_count, :speed

  def initialize(level = 1)
    super('Soundwave', level, 5)
    update_stats_for_level
  end

  def update_stats_for_level
    case @level
    when 1
      @cooldown = 0.5
      @damage = 10
      @w = 16
      @h = 8
      @speed = 8.0
      @projectile_count = 1
    when 2
      @cooldown = 0.375 # -25% cooldown
      @damage = 10
      @w = 16
      @h = 8
      @speed = 8.0
      @projectile_count = 1
    when 3
      @cooldown = 0.375
      @damage = 15 # +50% damage
      @w = 24 # +50% size
      @h = 12
      @speed = 8.0
      @projectile_count = 1
    when 4
      @cooldown = 0.375
      @damage = 15
      @w = 24
      @h = 12
      @speed = 8.0
      @projectile_count = 2 # Dual soundwaves
    when 5
      @cooldown = 0.375
      @damage = 15
      @w = 24
      @h = 12
      @speed = 8.0
      @projectile_count = 3 # 3-Way spread wave
    end
  end

  def fire(spawn_x, spawn_y)
    projectiles = []

    case @level
    when 1, 2, 3
      projectiles << Soundwave.new(spawn_x, spawn_y, @speed, 0.0, @damage, @w, @h)
    when 4
      # Dual parallel soundwaves (offset vertically up and down)
      projectiles << Soundwave.new(spawn_x, spawn_y + 8.0, @speed, 0.0, @damage, @w, @h)
      projectiles << Soundwave.new(spawn_x, spawn_y - 8.0, @speed, 0.0, @damage, @w, @h)
    when 5
      # 3-Way spread (straight right, angled up, angled down)
      projectiles << Soundwave.new(spawn_x, spawn_y, @speed, 0.0, @damage, @w, @h)
      projectiles << Soundwave.new(spawn_x, spawn_y + 4.0, 7.0, 3.5, @damage, @w, @h)
      projectiles << Soundwave.new(spawn_x, spawn_y - 4.0, 7.0, -3.5, @damage, @w, @h)
    end

    projectiles
  end
end
