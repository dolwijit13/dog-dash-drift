# 🪃 Weapon: Bone Boomerang (Levels 1-5 Detailed Design) — Feature Requirement

## 📌 Overview
อาวุธกระดูกบูมเมอแรง (Bone Boomerang) มีรูปแบบการยิงร่อนออกไปทางขวา ค่อยๆ ชะลอความเร็ว แล้วเลี้ยวร่อนกลับมาทางซ้ายทะลุมอนสเตอร์ทุกตัวในแนวเส้นทาง (Piercing Damage) โดยต้องปลดล็อกที่ Level 0 ใน Shop ($100)

---

## 🎯 User Story
**As a** ผู้เล่นเกม  
**I want** ปลดล็อกและอัปเกรดอาวุธ Bone Boomerang ทั้ง 5 เลเวล  
**So that** ยิงกระดูกร่อนทะลุมอนสเตอร์เป็นกลุ่ม ทำความเสียหายทั้งขาไปและขากลับได้อย่างสะใจ

---

## 📋 Detailed Level 1 to Level 5 Progression Design

| Level | Name / Tier | Cost | Damage (Out / Return) | Speed / Cooldown | Projectiles | Special Mechanics & Description |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Level 0** | Locked | Free | - | - | 0 | ยังไม่ปลดล็อก ต้องซื้อในร้านค้า |
| **Level 1** | Single Boomerang | **$100** | 12 / 12 | 10.0 px/f (CD: 1.2s) | 1 | ยิงกระดูก 1 ชิ้นร่อนไปทางขวาระยะ 500px แล้วร่อนกลับทางซ้ายทะลุมอนสเตอร์ทุกตัว |
| **Level 2** | Swift Returning | **$150** | 16 / 16 | 12.0 px/f (CD: 0.9s) | 1 | เพิ่มพลังโจมตี +33% และเพิ่มความเร็วร่อน หมุนกลับเร็วขึ้น (-25% Cooldown) |
| **Level 3** | Dual Orbit | **$250** | 20 / 20 | 12.0 px/f (CD: 0.8s) | 2 | ยิงกระดูก 2 ชิ้นพร้อมกันแบบเฉียงขึ้นและเฉียงลง (Dual Boomerang Curve) |
| **Level 4** | Heavy Piercer | **$400** | 24 / **36** (Return +50%) | 14.0 px/f (CD: 0.7s) | 2 | กระดูกขนาดใหญ่ขึ้น (+50% Size) ขากลับทำความเสียหายรุนแรงขึ้น +50% (36 Damage) |
| **Level 5** | **Mega Bone Storm** | **$600** | 35 / **50** (Return +42%) | 15.0 px/f (CD: 0.5s) | 3 | ยิง 3 ชิ้นกระจาย (บน/กลาง/ล่าง) ขนาดกระดูกยักษ์ (48x48) ร่อนกวาดเต็มหน้าจอ |

---

## 🛠️ Technical Checklist (Atomic) — DragonRuby GTK
- [ ] **1. BoomerangWeapon Class (`app/weapons/boomerang_weapon.rb`)**
  - [ ] ประกาศคลาส `BoomerangWeapon` จัดการ Level (0..5), Upgrade Cost, และ Firing Cooldown
- [ ] **2. BoomerangProjectile Trajectory Logic (`app/projectiles/boomerang.rb`)**
  - [ ] คำนวณความเร็วกลับทิศทาง: `@vx -= 0.35` เพื่อให้กระดูกเคลื่อนช้าลงแล้วร่อนกลับทางซ้าย
  - [ ] รองรับการทะลุมอนสเตอร์ (`piercing = true`) โดยไม่สลายตัวเมื่อโดนชน
- [ ] **3. Piercing Collision Handler (`app/collision_system.rb`)**
  - [ ] คำนวณความเสียหายขากลับ (Return Hit Damage) เมื่อ `vx < 0`
- [ ] **4. Verification & Web Export Check**
  - [ ] ทดสอบยิงกระดูกร่อนไป-กลับ ตั้งแต่ Level 1 ถึง Level 5 บน Web Build
