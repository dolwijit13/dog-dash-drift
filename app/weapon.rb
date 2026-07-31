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

class BoomerangWeapon < Weapon
  attr_accessor :cooldown, :out_damage, :return_damage, :w, :h, :projectile_count, :speed, :decel, :unlocked

  BOOMERANG_UPGRADE_COSTS = [100, 150, 250, 400, 600].freeze

  def initialize(level = 0)
    super('Bone Boomerang', [level, 1].max, 5)
    @level = level.clamp(0, @max_level)
    @unlocked = (@level > 0)
    update_stats_for_level
  end

  def can_upgrade?
    @level < @max_level
  end

  def upgrade_cost
    return nil unless can_upgrade?

    BOOMERANG_UPGRADE_COSTS[@level]
  end

  def upgrade!
    return false unless can_upgrade?

    @level += 1
    @unlocked = true
    update_stats_for_level
    true
  end

  def update_stats_for_level
    case @level
    when 0
      @unlocked = false
      @cooldown = 1.2
      @out_damage = 0
      @return_damage = 0
      @w = 16
      @h = 16
      @speed = 10.0
      @decel = 0.35
      @projectile_count = 0
    when 1
      @unlocked = true
      @cooldown = 1.2
      @out_damage = 12
      @return_damage = 12
      @w = 16
      @h = 16
      @speed = 10.0
      @decel = 0.35
      @projectile_count = 1
    when 2
      @unlocked = true
      @cooldown = 0.9
      @out_damage = 16
      @return_damage = 16
      @w = 16
      @h = 16
      @speed = 12.0
      @decel = 0.4
      @projectile_count = 1
    when 3
      @unlocked = true
      @cooldown = 0.8
      @out_damage = 20
      @return_damage = 20
      @w = 16
      @h = 16
      @speed = 12.0
      @decel = 0.4
      @projectile_count = 2
    when 4
      @unlocked = true
      @cooldown = 0.7
      @out_damage = 24
      @return_damage = 36
      @w = 24
      @h = 24
      @speed = 14.0
      @decel = 0.45
      @projectile_count = 2
    when 5
      @unlocked = true
      @cooldown = 0.5
      @out_damage = 35
      @return_damage = 50
      @w = 48
      @h = 48
      @speed = 15.0
      @decel = 0.5
      @projectile_count = 3
    end
  end

  def fire(spawn_x, spawn_y)
    return [] unless @unlocked && @level > 0

    projectiles = []

    case @level
    when 1, 2
      projectiles << BoomerangProjectile.new(spawn_x, spawn_y, @speed, 0.0, @out_damage, @return_damage, @w, @h, @decel)
    when 3, 4
      projectiles << BoomerangProjectile.new(spawn_x, spawn_y + 8.0, @speed, 2.0, @out_damage, @return_damage, @w, @h, @decel)
      projectiles << BoomerangProjectile.new(spawn_x, spawn_y - 8.0, @speed, -2.0, @out_damage, @return_damage, @w, @h, @decel)
    when 5
      projectiles << BoomerangProjectile.new(spawn_x, spawn_y, @speed, 0.0, @out_damage, @return_damage, @w, @h, @decel)
      projectiles << BoomerangProjectile.new(spawn_x, spawn_y + 12.0, @speed, 3.0, @out_damage, @return_damage, @w, @h, @decel)
      projectiles << BoomerangProjectile.new(spawn_x, spawn_y - 12.0, @speed, -3.0, @out_damage, @return_damage, @w, @h, @decel)
    end

    projectiles
  end
end
