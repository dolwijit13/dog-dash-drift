# 🎯 Enemy Type: Sniper Cat (Ranged Attacker) — Technical Specification

## 🏗️ Architectural Overview & File Structure

This feature implements the **Sniper Cat** ranged attacker enemy and its associated **Yarn Ball** projectile. The Sniper Cat enters from the right edge, advances to a standing distance (250-350px), enters a `:standing_and_shooting` state, and fires Yarn Ball projectiles towards the player every 2.5 seconds.

```text
app/
├── enemy.rb             # SniperCat enemy class & YarnBall projectile class
├── enemy_spawner.rb     # Spawner configured with weighted enemy types (:evil_cat, :sniper_cat)
├── collision_system.rb  # Player-projectile & soundwave-enemy collision handling
└── main.rb              # Main tick loop managing enemy_projectiles state & rendering
```

---

## 🧩 Component Details

### 1. `SniperCat` & `YarnBall` (`app/enemy.rb`)
- **`YarnBall` Projectile**:
  - Dimensions: 12x12
  - Speed: 6.0 px/frame
  - Damage: 15 HP
  - Primitive: Orange box (`r: 230, g: 126, b: 34, path: :pixel`)
- **`SniperCat` Enemy**:
  - Dimensions: 32x32
  - Stats: **30 HP**, **15 Coins Reward**, **30 Score Reward**
  - Primitive: Purple box (`r: 155, g: 89, b: 182, path: :pixel`)
  - State Machine: `:moving` -> `:standing_and_shooting`
  - Cooldown: 2.5 seconds per `YarnBall` shot

### 2. Collision & Spawner (`app/collision_system.rb` & `app/enemy_spawner.rb`)
- `CollisionSystem.handle_player_enemy_projectile_collisions`:
  - Detects intersection between player and active `YarnBall` projectiles.
  - Applies 15 damage to player and deactivates projectile upon hit.
- `EnemySpawner`:
  - Randomly selects between `:evil_cat` and `:sniper_cat` for varied enemy encounters.

---

## 🧪 Unit Test Results & Verification

### Unit Test Execution
Automated unit tests were executed with Minitest:
```bash
ruby -I. -Iapp -e "Dir['test/test_*.rb'].each { |f| require_relative f }"
```

**Results:**
`43 runs, 230 assertions, 0 failures, 0 errors, 0 skips`

### Real Manual Testing Steps (วิธีการทดสอบเล่นจริง)
1. Launch game via DragonRuby GTK (`./dragonruby .`) or open Web Build on Browser.
2. Observe `SniperCat` (purple sprite) spawning from right edge and advancing to stopping distance.
3. Observe `SniperCat` stopping and periodically firing orange `YarnBall` projectiles (15 Damage) towards the player.
4. Dodge yarn balls and defeat `SniperCat` (30 HP) using Soundwaves to receive +15 Coins & +30 Score.
