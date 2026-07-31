# 🎯 Enemy Type: Sniper Cat (Ranged Attacker) — Feature Requirement

## 📌 Overview
เพิ่มมอนสเตอร์ประเภทใหม่ **Sniper Cat (แมวสไนเปอร์)** ที่มีพฤติกรรมหยุดยืนระยะไกลแล้วยิงกระสุนพุ่งใส่ผู้เล่น เพื่อเพิ่มมิติการต่อสู้และการหลบหลีก

---

## 🎯 User Story
**As a** ผู้เล่นเกม  
**I want** เผชิญหน้ากับมอนสเตอร์ Sniper Cat ที่ยิงกระสุนใส่จากระยะไกล  
**So that** ต้องคอยสังเกตและหลบหลีกกระสุนยิงระยะไกล และได้รับรางวัล Coins ที่สูงขึ้นเมื่อกำจัดได้

---

## 📋 Acceptance Criteria (AC)
- [ ] **Movement & Behavior**:
  - เดินเข้ามาจากขอบขวา แล้วหยุดเดินเมื่อระยะห่างจากขอบขวาประมาณ 250-350px
  - เข้าสู่สถานะยิง ยิงกระสุน **Yarn Ball Projectile** พุ่งไปทางซ้ายใส่ผู้เล่นทุกๆ 2.5 วินาที
- [ ] **Enemy Stats & Reward**:
  - ค่าพลังชีวิต: **30 HP**
  - รางวัลเมื่อถูกกำจัด: **+15 Coins & 30 Score**
- [ ] **Enemy Projectile Collision**:
  - กระสุน Yarn Ball (สีไหมพรมส้ม ขนาด 12x12) พุ่งไปทางซ้ายด้วยความเร็ว 6px/f
  - ชน Player แล้วลด HP 15 หน่วย และถูกลบออกจากฉาก

---

## 🛠️ Technical Checklist (Atomic) — DragonRuby GTK
- [ ] **1. SniperCat Class Implementation (`app/enemy.rb` หรือ `app/enemies/sniper_cat.rb`)**
  - [ ] ประกาศคลาส `SniperCat` (x, y, hp=30, speed=2.0)
  - [ ] จัดการ State Transition: `:moving` -> `:standing_and_shooting`
- [ ] **2. Enemy Projectile Class (`app/enemy_projectile.rb`)**
  - [ ] ประกาศคลาส `YarnBall` (x, y, speed=6.0, damage=15)
  - [ ] อัปเดตตำแหน่ง `x -= speed` และเช็กออกนอกขอบจอ
- [ ] **3. Spawner & Collision Integration (`app/enemy_spawner.rb` & `app/collision_system.rb`)**
  - [ ] เพิ่ม SniperCat เข้าไปในอัตราสุ่มเกิดของ Stage 2 และ Stage 3
  - [ ] ตรวจจับ Collision ระหว่าง Player กับ `YarnBall`
- [ ] **4. Verification & Web Export Check**
  - [ ] ทดสอบการหยุดยิงของ Sniper Cat และการหลบกระสุนบน Web Build
