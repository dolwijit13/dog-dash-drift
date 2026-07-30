# frozen_string_literal: true

require_relative 'enemy'

class EnemySpawner
  attr_accessor :spawn_timer, :min_interval, :max_interval

  def initialize(min_interval = 2.0, max_interval = 3.0)
    @min_interval = min_interval.to_f
    @max_interval = max_interval.to_f
    @spawn_timer = rand(@min_interval..@max_interval)
  end

  def update(delta_time = 1.0 / 60.0, boundary_width = 800, boundary_height = 600)
    @spawn_timer -= delta_time

    if @spawn_timer <= 0
      reset_timer
      spawn_y = rand(0..(boundary_height - EvilCat::HEIGHT)).to_f
      EvilCat.new(boundary_width, spawn_y)
    else
      nil
    end
  end

  def reset_timer
    @spawn_timer = rand(@min_interval..@max_interval)
  end
end
