# Dog Dash Deluxe (DDD) 🐶🐉

A 2D Top-Down Side-Scrolling Action Runner & Auto-Shooter game built with Ruby and [DragonRuby Game Toolkit (DRGTK)](https://dragonruby.org/).

🌐 **Live Web Demo**: [https://dolwijit13.github.io/dog-dash-drift/](https://dolwijit13.github.io/dog-dash-drift/)

---

## 🕹️ Controls & Features

- **Controls**: `W / A / S / D` or Arrow Keys to move in 8 directions.
- **Auto-Attack**: Shiba Inu fires cyan Soundwave projectiles automatically every 0.5 seconds.
- **Enemies**: Evil Cats spawn from the right; shoot them to earn +10 Score and +5 Coins.
- **Reset**: Press `ESC` to reset player position.

---

## 🛠️ Project Structure & Execution

### 1. File Structure

All DragonRuby source code is placed inside the `app/` directory:

```text
app/
├── main.rb                  # Entrypoint & 60 FPS tick(args) loop
├── player.rb                # Player character entity & auto-attack
├── soundwave.rb             # Soundwave projectile entity
├── enemy.rb                 # EvilCat enemy entity
├── enemy_spawner.rb         # Periodic random Y enemy spawner
├── camera.rb                # Side-scrolling viewport camera
├── collision_system.rb      # AABB collision & kill reward handler
└── input_handler.rb         # Keyboard & Mouse input handler
```

### 2. Run Desktop Game (DragonRuby)

Run the DragonRuby executable pointing to the repository:

```bash
./dragonruby .
```

### 3. Run Unit Tests

```bash
ruby -Iapp:test test/test_dragonruby_game.rb
```
