# Dog Dash Drift

A 2D game built with Ruby and [Gosu](https://www.libgosu.org/).

## Requirements

- Ruby 3.x
- Bundler (`gem install bundler`)
- Homebrew & SDL2 (macOS): `brew install sdl2`

## Getting Started

### 1. Installation

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

> **Note:** `.bundle/config` is saved locally in the project so future `bundle install` commands will use these settings automatically.

### 2. Run the Game

```bash
bundle exec ruby main.rb
```
