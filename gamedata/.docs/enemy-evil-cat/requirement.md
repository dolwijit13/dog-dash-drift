# Feature Requirement: Enemy Spawning & Hit Detection (Evil Cats)

## Overview
ระบบการเกิดของแมวปีศาจ (Evil Cats) จากขอบขวาของหน้าจอ เดินมาทางซ้าย และระบบตรวจจับการชน (Collision Detection) เมื่อโดน Soundwave ยิงใส่

---

## User Story
**As a** ผู้เล่นเกม  
**I want** มีศัตรูแมวปีศาจเดินมาจากทางขวา และเมื่อยิงกระสุนใส่จะสามารถทำลายแมวปีศาจได้  
**So that** เกิดความท้าทายและการต่อสู้ในเกม

---

## Acceptance Criteria (AC)
1. **Enemy Spawning**: แมวปีศาจ (สี่เหลี่ยมสีแดงขนาด 32x32) สุ่มเกิดที่ขอบขวาของหน้าจอ (Y สุ่ม) ทุกๆ 2.0 - 3.0 วินาที
2. **Leftward Movement**: เดินตรงไปทางซ้ายด้วยความเร็ว 3 px/frame
3. **Soundwave Collision**: เมื่อกระสุน Soundwave ชนกับ Evil Cat ทั้งคู่จะถูกทำลายและหายไปจากหน้าจอ
4. **Kill Reward**: เมื่อ Evil Cat ถูกทำลาย จะส่ง Signal/Event เพื่อเพิ่มคะแนน (+10 Score) และเงิน (+5 Coins)

---

## Technical Checklist (Atomic)
- [ ] **1. Enemy Class (`lib/enemy.rb` / `EvilCat`)**
  - [ ] สร้างคลาส `EvilCat` มีพิกัด `(x, y)`, ขนาด `width/height`, `hp = 1`
  - [ ] เมธอด `update` ขยับพิกัดไปทางซ้าย `x -= speed`
  - [ ] เมธอด `draw` วาดสี่เหลี่ยมสีแดง (หรือ Sprite แมว)
  - [ ] เมธอด `bounding_box` คืนค่า Rectangle สำหรับตรวจการชน
- [ ] **2. Enemy Spawner (`lib/enemy_spawner.rb`)**
  - [ ] สุ่มพิกัด Y (ขอบเขตเดินได้) และ Spawn ทุกๆ interval
  - [ ] ลบแมวที่เดินหลุดขอบซ้าย (`x < -width`) ออกจาก Memory
- [ ] **3. Collision Detection System (`lib/collision_system.rb` หรือ `main.rb`)**
  - [ ] เช็กการชน AABB (Axis-Aligned Bounding Box) ระหว่าง `Soundwave` กับ `EvilCat`
  - [ ] หากชนกัน ให้ทำลาย Soundwave และลด HP ของ Evil Cat จนตาย
  - [ ] ทริกเกอร์ Event เพิ่ม Reward (Score & Coin)
- [ ] **4. Verification**
  - [ ] ทดสอบยิงแมวปีศาจ และตรวจสอบว่าแมวและกระสุนหายไปอย่างถูกต้องเมื่อชนกัน
