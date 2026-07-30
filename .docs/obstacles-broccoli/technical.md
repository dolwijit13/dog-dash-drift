# Technical Specification: Obstacles & Collision Penalty (Broccoli)

## Architectural Overview
The `obstacles-broccoli` feature introduces ground obstacle entities (**Broccoli**) in **Dog Dash Deluxe (DDD)**. 

Broccoli obstacles scroll leftwards along with the side-scrolling background. They are persistent against player Soundwave projectiles (cannot be destroyed by shooting) and apply a -$5 Coins penalty and 1.0s player speed slowdown (50% movement speed reduction) upon collision.

---

## File Structure & Dependencies

```text
dog-dash-drift/
├── app/
│   ├── obstacle.rb                 # Broccoli obstacle entity (28x28 dark green)
│   ├── player.rb                   # Player entity with slowdown timer & speed penalty
│   ├── collision_system.rb         # AABB intersection & player-obstacle collision handler
│   ├── main.rb                     # Periodic spawner & tick loop integration
│   ├── collectible.rb              # BoneSnack collectible entity
│   ├── enemy.rb                    # EvilCat enemy entity
│   ├── enemy_spawner.rb            # Enemy spawner
│   ├── soundwave.rb                # Soundwave projectile
│   ├── camera.rb                   # Side-scrolling camera
│   └── input_handler.rb            # Input handler
├── test/
│   └── test_dragonruby_game.rb     # Unit tests for Broccoli, penalty & slowdown
└── .docs/
    └── obstacles-broccoli/
        ├── requirement.md          # Feature requirements & ACs
        └── technical.md            # Technical specification (this file)
```

---

## Component Details

### 1. `Broccoli` (`app/obstacle.rb`)
- **Constants**: `WIDTH = 28.0`, `HEIGHT = 28.0`, `COLOR = { r: 34, g: 139, b: 34 }`.
- **Attributes**: `@x`, `@y`, `@w`, `@h`, `@active`.
- **`update(scroll_speed)`**: Moves leftward `@x -= scroll_speed`. Deactivates when `@x + @w < 0`.

### 2. `Player` (`app/player.rb`)
- **Attributes**: `@slowdown_timer`, `@base_speed` (4.0 px/frame).
- **`apply_slowdown(duration = 1.0)`**: Sets `@slowdown_timer = 1.0`.
- **`update`**: Decrements `@slowdown_timer`. Effective speed is `@base_speed * 0.5` (2.0 px/frame) while `@slowdown_timer > 0`.

### 3. `CollisionSystem` (`app/collision_system.rb`)
- **`handle_player_obstacle_collisions(player, obstacles)`**:
  - Checks AABB intersection between player rect and active obstacle rect.
  - On hit: deactivates obstacle, applies -$5 Coins penalty, and invokes `player.apply_slowdown(1.0)`.

---

## Verification & Unit Testing

### Automated Unit Tests
Executed via:
```bash
ruby -Iapp:test test/test_dragonruby_game.rb
```
- Tests `Broccoli` entity initialization and primitive export.
- Tests player obstacle collision, coin deduction (-$5), non-negative clamping, and slowdown timer activation.

### Real Manual Testing Plan
1. **Run Game**: `./dragonruby dog-dash-drift`
2. **Observe Obstacles**: Dark green 28x28 Broccoli obstacles spawn from right and move left.
3. **Shoot Projectiles**: Confirm cyan Soundwaves pass over Broccoli without destroying it.
4. **Collision Test**: Drive player into Broccoli. Confirm -$5 Coins deduction and 1.0s slowdown speed reduction.
