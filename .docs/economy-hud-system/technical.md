# Technical Specification: Score, Currency (Bones/Coins), and HUD Display

## Architectural Overview
The `economy-hud-system` manages game economy state (`coins`, `score`) and renders real-time Heads-Up Display (HUD) overlay in **Dog Dash Deluxe (DDD)** using DragonRuby GTK's native `args.outputs.labels` primitive output.

---

## File Structure & Dependencies

```text
dog-dash-drift/
├── app/
│   ├── main.rb                     # State initialization & HUD labels renderer
│   ├── collision_system.rb         # Rewards & penalty calculations with non-negative clamping
│   ├── player.rb                   # Player entity
│   ├── enemy.rb                    # EvilCat entity (kill rewards)
│   ├── collectible.rb              # BoneSnack entity (pickup rewards)
│   └── obstacle.rb                 # Broccoli obstacle (penalty deductions)
├── test/
│   └── test_dragonruby_game.rb     # Unit tests for economy state & HUD rendering
└── .docs/
    └── economy-hud-system/
        ├── requirement.md          # Feature requirements & ACs
        └── technical.md            # Technical specification (this file)
```

---

## Component Details

### 1. `State Management` (`args.state`)
- `args.state.coins ||= 0`: Tracks player currency (bones/coins). Guaranteed non-negative via `.clamp(0, 999999)`.
- `args.state.score ||= 0`: Tracks total game score accumulated.

### 2. `HUD Renderer` (`app/main.rb`)
- Rendered every tick into `args.outputs.labels`:
  - `Bones: $X`: Position `(x: 30, y: 700)`, Gold color `r: 241, g: 196, b: 15`, `size_enum: 2`.
  - `Score: Y`: Position `(x: 30, y: 670)`, White color `r: 255, g: 255, b: 255`, `size_enum: 2`.

---

## Verification & Unit Testing

### Automated Unit Tests
Executed via:
```bash
ruby -Iapp:test test/test_dragonruby_game.rb
```
- Asserts presence and exact formatting of HUD labels (`Bones: $X` at `x: 30, y: 700`).

### Real Manual Testing Plan
1. **Run Game**: `./dragonruby dog-dash-drift`
2. **Verify HUD**: Top-left corner displays `Bones: $0` in gold text and `Score: 0` in white text.
3. **Earn Currency**: Defeat enemies and collect bone snacks to observe real-time value increments.
4. **Collision Penalty**: Drive into obstacles to verify coins deduction without dropping below $0.
