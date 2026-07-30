# Dog Dash Deluxe (DDD) 🐶

[![Deploy to GitHub Pages](https://github.com/dolwijit13/dog-dash-drift/actions/workflows/deploy.yml/badge.svg)](https://github.com/dolwijit13/dog-dash-drift/actions/workflows/deploy.yml)

A 2D Top-Down Side-Scrolling Action Runner & Auto-Shooter game built with Ruby, [Gosu Engine](https://www.libgosu.org/), and HTML5 Canvas Web Runner.

🌐 **Play Live Web Demo**: [https://dolwijit13.github.io/dog-dash-drift/](https://dolwijit13.github.io/dog-dash-drift/)

---

## 🕹️ Controls & Features

- **Controls**: `W / A / S / D` or Arrow Keys to move in 8 directions.
- **Auto-Attack**: Shiba Inu fires cyan Soundwave projectiles automatically every 0.5 seconds.
- **Enemies**: Evil Cats spawn from the right; shoot them to earn +10 Score and +5 Coins.
- **Reset**: Press `ESC` to reset player position.

---

## 🛠️ Desktop Requirements & Setup

### 1. Requirements

- Ruby 3.x
- Bundler (`gem install bundler`)
- Homebrew & SDL2 (macOS): `brew install sdl2`

### 2. Installation

Install system dependencies and configure Bundler for macOS linking:

```bash
# Install SDL2
brew install sdl2

# Configure Bundler to link macOS AppKit and SDL2 libraries
bundle config set --local force_ruby_platform true
bundle config set --local build.gosu "--with-cflags='-I/opt/homebrew/include' --with-ldflags='-L/opt/homebrew/lib -lSDL2 -framework AppKit -framework Foundation -framework OpenGL'"

# Install gem dependencies
bundle install
```

### 3. Run Native Desktop Game

```bash
bundle exec ruby main.rb
```

### 4. Run Unit Tests

```bash
ruby -Ilib:test test/test_web_build.rb
```
