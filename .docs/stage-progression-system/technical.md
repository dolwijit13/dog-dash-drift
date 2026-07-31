# 🏁 Stage Selection System & Level Completion Flow (Stages 1-3) — Technical Specification

## 🏗️ Architectural Overview & File Structure

This feature implements the **Stage Selection & Progression System**. It adds 3 distinct stages (Candy Meadow, Chocolate Boulevard, Castle Peak) with target distances (1000m, 1500m, 2000m), progress bar tracking, victory state transition (`:stage_clear`), and unlock mechanics for subsequent stages.

```text
app/
├── stage.rb             # Stage configuration & StageManager unlock state machine
├── stage_clear_ui.rb    # Overlay UI for Stage Clear victory summary & stage progression
├── enemy_spawner.rb     # Dynamic enemy list per stage configuration
└── main.rb              # Main tick loop managing distance calculation & state transitions
```

---

## 🧩 Component Details

### 1. `Stage` & `StageManager` (`app/stage.rb`)
- **`Stage` Configurations**:
  - **Stage 1**: `Candy Meadow` (1000.0m Target, Allowed Enemies: `[:evil_cat]`)
  - **Stage 2**: `Chocolate Boulevard` (1500.0m Target, Allowed Enemies: `[:evil_cat, :sniper_cat]`)
  - **Stage 3**: `Castle Peak` (2000.0m Target, Allowed Enemies: `[:evil_cat, :sniper_cat, :ninja_cat]`)
- **`StageManager`**:
  - Manages `@unlocked_stages` array (defaults to `[1]`).
  - `unlock_next_stage!`: Automatically unlocks next stage upon clearing current stage.

### 2. `StageClearUI` (`app/stage_clear_ui.rb`)
- Renders victory overlay card when `args.state.game_state == :stage_clear`.
- Displays Stage Name, Target Completed, Final Score, and Total Bones.
- Key & Mouse inputs trigger reset and progression into next unlocked stage.

---

## 🧪 Unit Test Results & Verification

### Unit Test Execution
Automated unit tests were executed with Minitest:
```bash
ruby -I. -Iapp -e "Dir['test/test_*.rb'].each { |f| require_relative f }"
```

**Results:**
`43 runs, 227 assertions, 0 failures, 0 errors, 0 skips`

### Real Manual Testing Steps (วิธีการทดสอบเล่นจริง)
1. Launch game via DragonRuby GTK (`./dragonruby .`) or open Web Build on Browser.
2. Observe Distance Progress Bar on HUD (`Stage 1: Candy Meadow | 0m / 1000m`).
3. Travel 1000m to trigger `:stage_clear` state overlay.
4. Observe `STAGE CLEAR!` screen, score summary, and unlock notification for Stage 2.
5. Press SPACE or Enter to progress to Stage 2 (`Chocolate Boulevard`).
