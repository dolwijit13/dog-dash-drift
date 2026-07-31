# frozen_string_literal: true

class Stage
  attr_reader :id, :name, :target_distance, :allowed_enemies

  STAGES = {
    1 => { name: 'Candy Meadow', target_distance: 6000.0, allowed_enemies: [:evil_cat] },
    2 => { name: 'Chocolate Boulevard', target_distance: 9000.0, allowed_enemies: [:evil_cat, :sniper_cat] },
    3 => { name: 'Castle Peak', target_distance: 12000.0, allowed_enemies: [:evil_cat, :sniper_cat, :ninja_cat] }
  }.freeze

  def initialize(id)
    @id = id
    config = STAGES[id] || STAGES[1]
    @name = config[:name]
    @target_distance = config[:target_distance]
    @allowed_enemies = config[:allowed_enemies]
  end
end

class StageManager
  attr_accessor :current_stage_id, :unlocked_stages

  def initialize(current_stage_id = 1, unlocked_stages = [1])
    @current_stage_id = current_stage_id
    @unlocked_stages = unlocked_stages
  end

  def current_stage
    Stage.new(@current_stage_id)
  end

  def stage_unlocked?(stage_id)
    @unlocked_stages.include?(stage_id)
  end

  def unlock_next_stage!
    next_id = @current_stage_id + 1
    if next_id <= 3 && !@unlocked_stages.include?(next_id)
      @unlocked_stages << next_id
    end
    next_id
  end

  def select_stage!(stage_id)
    return false unless stage_unlocked?(stage_id)

    @current_stage_id = stage_id
    true
  end
end
