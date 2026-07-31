# 🐕 Player Stat Upgrade & Health System — Feature Requirement

## 📌 Overview
พัฒนาระบบสถานะตัวละคร (Player Stats) ได้แก่ พลังชีวิตสูงสุด (Max HP), ความเร็วในการเคลื่อนที่ (Move Speed), และพลังโจมตีพื้นฐาน (Base Attack) พร้อมระบบ Game Over เมื่อพลังชีวิตหมด และความสามารถในการนำเงิน (Coins) มาอัปเกรดสถานะ

---

## 🎯 User Story
**As a** ผู้เล่นเกม  
**I want** นำเงิน (Coins) ที่สะสมได้ไปพัฒนาตัวละคร (เพิ่ม HP, เดินไวขึ้น, ตีแรงขึ้น)  
**So that** ตัวละครแข็งแกร่งขึ้น สามารถรับมือกับมอนสเตอร์และอยู่รอดในเกมได้นานยิ่งขึ้น

---

## 📋 Acceptance Criteria (AC)
- [ ] **Player Health State**: ตัวละครมีค่า `hp` และ `max_hp` (เช่น เริ่มต้น 100 HP) พร้อมการแสดงผลหลอดเลือด HP บน HUD
- [ ] **Damage & Invulnerability**: เมื่อ Player ชนกับมอนสเตอร์หรือสิ่งกีดขวาง จะได้รับความเสียหาย (HP ลดลง) พร้อมช่วงเวลาอมตะชั่วคราว (Invulnerability Frame 1.0 วินาที)
- [ ] **Stat Upgrade Logic**: รองรับการอัปเกรด 3 สายหลัก:
  - **Max HP Upgrade**: เพิ่ม HP สูงสุด (+25 HP / Level)
  - **Move Speed Upgrade**: เพิ่มความเร็วการเดิน (+0.5 Speed / Level)
  - **Attack Damage Upgrade**: เพิ่มพลังโจมตีพื้นฐาน (+5 Damage / Level)
- [ ] **Game Over Condition**: เมื่อ HP ของ Player ลดลงเหลือ 0 เกมจะเข้าสู่สถานะ Game Over แสดงหน้าจอจบเกมพร้อมปุ่ม Restart

---

## 🛠️ Technical Checklist (Atomic)
- [ ] **1. Player State Extension (`app/player.rb`)**
  - [ ] ประกาศตัวแปรสถานะ: `@max_hp`, `@hp`, `@move_speed_level`, `@hp_level`, `@damage_level`, `@invulnerable_timer`
  - [ ] เพิ่มเมธอด `take_damage(amount)` พร้อมระบบ Invulnerability Guard
  - [ ] เพิ่มเมธอดอัปเกรดสถานะ `upgrade_max_hp`, `upgrade_speed`, `upgrade_damage`
- [ ] **2. Player Collision & Damage Integration (`app/collision_system.rb`)**
  - [ ] ปรับปรับการชนระหว่าง Player กับ Evil Cat และ Obstacle ให้ลดค่า Player HP
- [ ] **3. HUD & Game Over State Integration (`app/main.rb`)**
  - [ ] แสดงค่า Player HP บน HUD (เช่น `HP: 80/100`)
  - [ ] จัดการ Game Over State เมื่อ `player.hp <= 0` และปุ่มกด Reset/Restart
- [ ] **4. Verification & Web Export Check**
  - [ ] ทดสอบการโดนทำร้าย การอัปเกรดค่า Stats และหน้าจอ Game Over บน Web Build
