# Repository Operating Rules

## Single Source of Truth & Zero JS Replicas Rule
1. **100% Ruby Single Source of Truth**: All game logic, entities, physics, rendering, and state management MUST be written strictly in Ruby (`app/*.rb`) for DragonRuby GTK.
2. **STRICT BAN on JavaScript Replicas & Inline JS**: NEVER generate, rewrite, or hardcode JavaScript files (`app.js`, inline `<script>` tags, or JS class replicas) in GitHub Workflows, build scripts, HTML loaders, or any deployment scripts.
