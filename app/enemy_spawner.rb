# frozen_string_literal: true

require_relative 'enemy'

class EnemySpawner
  attr_accessor :spawn_timer, :min_interval, :max_interval, :allowed_types

  def initialize(min_interval = 2.0, max_interval = 3.0, allowed_types = [:evil_cat, :sniper_cat])
    @min_interval = min_interval.to_f
    @max_interval = max_interval.to_f
    @allowed_types = allowed_types
    reset_timer
  end

  def update(delta_time = 1.0 / 60.0, boundary_width = 1280, boundary_height = 720)
    @spawn_timer -= delta_time

    if @spawn_timer <= 0
      reset_timer
      spawn_enemy(boundary_width, boundary_height)
    else
      nil
    end
  end

  def spawn_enemy(boundary_width = 1280, boundary_height = 720)
    type = @allowed_types.sample || :evil_cat
    max_y = (boundary_height - 32).to_f
    spawn_y = rand_range(0.0, max_y)

    case type
    when :sniper_cat
      defined?(SniperCat) ? SniperCat.new(boundary_width, spawn_y) : EvilCat.new(boundary_width, spawn_y)
    when :ninja_cat
      defined?(NinjaCat) ? NinjaCat.new(boundary_width, spawn_y) : EvilCat.new(boundary_width, spawn_y)
    else
      EvilCat.new(boundary_width, spawn_y)
    end
  end

  def reset_timer
    @spawn_timer = rand_range(@min_interval, @max_interval)
  end

  private

  def rand_range(min, max)
    rand * (max - min) + min
  end
end
