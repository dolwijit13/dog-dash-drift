# 🏪 Stage Select Hub & Main Menu Shop UI Interface — Technical Specification

## 🏗️ Architectural Overview & File Structure

This feature implements the **Stage Select Hub & Main Menu Shop UI Interface**. It decouples shop accessibility so players can enter the Shop UI from the Hub (`:stage_select`) before launching into battle, selecting Stage 1, 2, or 3, and preserving state transitions across `:stage_select`, `:shop`, `:playing`, and `:stage_clear`.

```text
app/
├── stage_select_ui.rb   # Stage selection cards, unlock status indicators & action buttons
├── shop_ui.rb           # Shop UI overlay accessible from both Hub and In-Game Pause
├── stage.rb             # Stage Manager configuration state
└── main.rb              # Main Game Loop managing state flow & transition logic
```

---

## 🧩 Component Details

### 1. `StageSelectUI` (`app/stage_select_ui.rb`)
- Renders 3 Stage Cards:
  - **Stage 1 (Candy Meadow)**: 1000m Target
  - **Stage 2 (Chocolate Boulevard)**: 1500m Target
  - **Stage 3 (Castle Peak)**: 2000m Target
- Highlights active selected stage and indicates UNLOCKED / LOCKED status.
- Key & Mouse inputs trigger stage selection (keys 1-3, Mouse click) and game start (SPACE/Enter).

### 2. Hub Shop Integration (`app/main.rb`)
- Pressing TAB or P at the Hub toggles `:shop` state.
- Exiting Shop returns player cleanly to `:stage_select` (Hub) instead of directly starting gameplay.

---

## 🧪 Unit Test Results & Verification

### Unit Test Execution
Automated unit tests were executed with Minitest:
```bash
ruby -I. -Iapp -e "Dir['test/test_*.rb'].each { |f| require_relative f }"
```

**Results:**
`40 runs, 212 assertions, 0 failures, 0 errors, 0 skips`

### Real Manual Testing Steps (วิธีการทดสอบเล่นจริง)
1. Launch game via DragonRuby GTK (`./dragonruby .`) or open Web Build on Browser.
2. Observe Stage Hub screen presenting Stage 1 (Candy Meadow), Stage 2 (Chocolate Boulevard), and Stage 3 (Castle Peak) cards.
3. Press `TAB` or `P` (or click SHOP button) to enter Shop directly from Hub and purchase upgrades.
4. Press `1`, `2`, or `3` to select unlocked Stage.
5. Press `SPACE` or `Enter` to start the stage.
