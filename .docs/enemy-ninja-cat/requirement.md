# 🥷 Enemy Type: Ninja Cat (Homing Tracker) — Feature Requirement

## 📌 Overview
เพิ่มมอนสเตอร์ประเภทใหม่ **Ninja Cat (แมวนินจา)** ที่มีพฤติกรรมเคลื่อนที่เร็วและปรับทิศทาง Y พุ่งติดตามตำแหน่งของผู้เล่นตลอดเวลา (Homing Tracking)

---

## 🎯 User Story
**As a** ผู้เล่นเกม  
**I want** เผชิญหน้ากับมอนสเตอร์ Ninja Cat ที่วิ่งเร็วและพุ่งติดตามแนว Y ของตัวละคร  
**So that** เกิดความกดดันต้องคอยเคลื่อนที่หลบหลีกตลอดเวลา และได้รับรางวัล Coins สูงสุดเมื่อกำจัดได้

---

## 📋 Acceptance Criteria (AC)
- [ ] **Movement & Behavior**:
  - เดินหน้าไปทางซ้ายด้วยความเร็วสูง (4.5 px/f)
  - ค่อยๆ ปรับพิกัด Y เคลื่อนที่เข้าหาพิกัด Y ของ Player (Smooth Y Homing interpolation)
- [ ] **Enemy Stats & Reward**:
  - ค่าพลังชีวิต: **45 HP**
  - รางวัลเมื่อถูกกำจัด: **+25 Coins & 50 Score**
- [ ] **Player Touch Collision**:
  - ชน Player แล้วลด HP 20 หน่วย พร้อมกระเด็นกลับเล็กน้อย

---

## 🛠️ Technical Checklist (Atomic) — DragonRuby GTK
- [ ] **1. NinjaCat Class Implementation (`app/enemy.rb` หรือ `app/enemies/ninja_cat.rb`)**
  - [ ] ประกาศคลาส `NinjaCat` (x, y, hp=45, speed=4.5)
  - [ ] ในเมธอด `update` ให้ปรับค่า Y: `@y += (player_y - @y) * 0.035`
- [ ] **2. Spawner & Collision Integration (`app/enemy_spawner.rb` & `app/collision_system.rb`)**
  - [ ] เพิ่ม NinjaCat เข้าไปในอัตราสุ่มเกิดของ Stage 2 และ Stage 3 (ปรากฏตัวในสัดส่วน 20%)
  - [ ] ตรวจจับ Collision ระหว่าง Player กับ `NinjaCat`
- [ ] **3. Verification & Web Export Check**
  - [ ] ทดสอบการพุ่งติดตามของ Ninja Cat และการฆ่าเพื่อรับ 25 Coins บน Web Build
