# 🪃 Weapon: Bone Boomerang (Levels 1-5 Detailed Design) — Technical Specification

## 🏗️ Architectural Overview & File Structure

This feature implements the **Bone Boomerang** weapon system (`BoomerangWeapon < Weapon`) and its returning piercing projectile (`BoomerangProjectile`). The projectile flies rightwards, decelerates (`@vx -= @decel`), turns back leftwards (`@vx < 0`), and pierces enemies on both outward and return trips.

```text
app/
├── weapon.rb            # BoomerangWeapon class with Levels 0 to 5 stats & upgrade progression
├── soundwave.rb         # BoomerangProjectile with deceleration trajectory & piercing tracking
├── collision_system.rb  # Piercing hit registration & return damage calculation
```

---

## 🧩 Component Details

### 1. `BoomerangWeapon` (`app/weapon.rb`)
- Inherits from `Weapon` base class.
- **Level 0 (Locked)**: Cost $100 to unlock Level 1.
- **Level 1 ($100)**: 1 projectile, 12 Dmg out / 12 return, Speed: 10.0, Cooldown: 1.2s
- **Level 2 ($150)**: 1 projectile, 16 Dmg out / 16 return, Speed: 12.0, Cooldown: 0.9s
- **Level 3 ($250)**: 2 projectiles (Dual curved arc: `vy = +2.0, -2.0`), 20 Dmg out / 20 return, Cooldown: 0.8s
- **Level 4 ($400)**: 2 projectiles (+50% size: 24x24), 24 Dmg out / **36 Return Dmg (+50%)**, Cooldown: 0.7s
- **Level 5 ($600)**: **Mega Bone Storm** — 3 projectiles (3-Way spread: `vy = +3.0, 0, -3.0`), giant size 48x48, 35 Dmg out / **50 Return Dmg (+42%)**, Cooldown: 0.5s

### 2. `BoomerangProjectile` (`app/soundwave.rb`)
- **Deceleration Vector**: `@vx -= @decel` per tick.
- **Piercing Multi-Hit System**:
  - Maintains `@hit_enemies` array.
  - Clears `@hit_enemies` when `@vx` flips from positive to negative so returning pass deals hit damage to same enemies again.

---

## 🧪 Unit Test Results & Verification

### Unit Test Execution
Automated unit tests were executed with Minitest:
```bash
ruby -I. -Iapp -e "Dir['test/test_*.rb'].each { |f| require_relative f }"
```

**Results:**
`44 runs, 247 assertions, 0 failures, 0 errors, 0 skips`

### Real Manual Testing Steps (วิธีการทดสอบเล่นจริง)
1. Unlock `Bone Boomerang` in Shop for $100.
2. Fire Boomerang and observe bone projectile spinning rightwards, slowing down, and returning leftwards.
3. Observe bone piercing through lines of enemies both on the way out (Out Dmg) and on the way back (Return Dmg).
4. Upgrade to Level 5 (Mega Bone Storm) to test 3 giant (48x48) returning boomerangs covering the entire screen.
