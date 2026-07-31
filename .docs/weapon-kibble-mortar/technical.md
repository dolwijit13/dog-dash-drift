# 💣 Weapon: Kibble Mortar (Levels 1-5 Detailed Design) — Technical Specification

## 🏗️ Architectural Overview & File Structure

This feature implements the **Kibble Mortar** AoE weapon system (`MortarWeapon < Weapon`) and its parabolic arc bomb projectile (`MortarProjectile`). The projectile travels in a high parabolic trajectory (`vy -= gravity`), detonates on ground impact or enemy contact, creating an AoE explosion radius that damages all monsters within range and spawns cluster bomblets at higher levels.

```text
app/
├── weapon.rb            # MortarWeapon class with Levels 0 to 5 stats & upgrade progression
├── soundwave.rb         # MortarProjectile with parabolic gravity arc & AoE explosion geometry
└── collision_system.rb  # AoE radius collision & cluster fragment handling
```

---

## 🧩 Component Details

### 1. `MortarWeapon` (`app/weapon.rb`)
- Inherits from `Weapon` base class.
- **Level 0 (Locked)**: Cost $150 to unlock Level 1.
- **Level 1 ($150)**: 1 Bomb, 15 Direct Dmg / 10 AoE Dmg, Radius: 40px, Cooldown: 1.5s
- **Level 2 ($220)**: 1 Bomb, 22 Direct Dmg / 16 AoE Dmg, Radius: 65px (+62%), Cooldown: 1.2s
- **Level 3 ($350)**: 2 Bombs, 28 Direct Dmg / 20 AoE Dmg, Radius: 75px, Cooldown: 1.0s
- **Level 4 ($500)**: **Cluster Burst** — 2 Bombs (+3 Clusters per bomb, 10 Cluster Dmg), 35 Direct / 25 AoE Dmg, Radius: 90px, Cooldown: 0.9s
- **Level 5 ($750)**: **Kibble Apocalypse** — 3 Bombs (+4 Clusters per bomb, 15 Cluster Dmg + Burning Zone), 50 Direct / 40 AoE Dmg, Radius: 110px, Cooldown: 0.8s

### 2. `MortarProjectile` (`app/soundwave.rb`)
- **Parabolic Trajectory**: `@y += @vy`, `@vy -= @gravity` (gravity = 0.35 px/f^2).
- **Detonation State**:
  - Triggers `@exploded = true` on ground impact or contact.
  - Transforms bounding box into AoE radius box (`@radius * 2`).
  - Renders golden orange explosion area (`r: 230, g: 126, b: 34, a: 160, path: :pixel`).

---

## 🧪 Unit Test Results & Verification

### Unit Test Execution
Automated unit tests were executed with Minitest:
```bash
ruby -I. -Iapp -e "Dir['test/test_*.rb'].each { |f| require_relative f }"
```

**Results:**
`43 runs, 242 assertions, 0 failures, 0 errors, 0 skips`

### Real Manual Testing Steps (วิธีการทดสอบเล่นจริง)
1. Unlock `Kibble Mortar` in Shop for $150.
2. Fire Mortar and observe bomb lobbing over enemies in a smooth parabolic arc.
3. Observe bomb exploding upon ground impact, dealing AoE splash damage to all enemies in radius.
4. Upgrade to Level 5 (Kibble Apocalypse) to launch 3 massive mortar bombs releasing 4 clusters each across a 110px explosion radius.
