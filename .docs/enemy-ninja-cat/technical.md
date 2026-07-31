# 🥷 Enemy Type: Ninja Cat (Homing Tracker) — Technical Specification

## 🏗️ Architectural Overview & File Structure

This feature implements the **Ninja Cat** homing tracker enemy. The Ninja Cat moves left at high speed (4.5 px/frame) while dynamically tracking and smoothly interpolating its Y coordinate towards the player's current Y coordinate (`@y += (player_y - @y) * 0.035`).

```text
app/
├── enemy.rb             # NinjaCat enemy class implementation
├── enemy_spawner.rb     # Spawner configured with weighted enemy types (:evil_cat, :ninja_cat)
├── collision_system.rb  # Dynamic touch damage & reward calculation
└── main.rb              # Main tick loop passing player Y coordinate into enemy update
```

---

## 🧩 Component Details

### 1. `NinjaCat` (`app/enemy.rb`)
- **Dimensions**: 32x32
- **Stats**: **45 HP**, **25 Coins Reward**, **50 Score Reward**, **20 Touch Damage**
- **Speed**: 4.5 px/frame (moves left `@x -= @speed`)
- **Y-Homing**: Interpolation rate `0.035` towards `player.y`
- **Primitive**: Dark Charcoal box (`r: 44, g: 62, b: 80, path: :pixel`)

### 2. Collision & Spawner (`app/collision_system.rb` & `app/enemy_spawner.rb`)
- `CollisionSystem.handle_player_enemy_collisions`:
  - Dynamically uses `enemy.touch_damage` (20 HP for NinjaCat vs 15 HP for default enemies).
- `EnemySpawner`:
  - Randomly selects between `:evil_cat` and `:ninja_cat` for fast-paced homing encounters.

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
2. Observe `NinjaCat` (dark charcoal sprite) spawning from right edge and advancing rapidly at 4.5 px/f.
3. Move player up and down along the Y-axis; observe `NinjaCat` turning and following player's Y position.
4. If touched, player takes 20 Damage. Defeat `NinjaCat` (45 HP) to earn +25 Coins & +50 Score.
