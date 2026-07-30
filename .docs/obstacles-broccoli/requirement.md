# Feature Requirement: Obstacles & Collision Penalty (Broccoli)

## Overview
ระบบสิ่งกีดขวางผักบร็อกโคลี (Broccoli) ที่วางกระจายบนพื้นฉาก เพื่อให้ผู้เล่นต้องคอยลากหลบ

---

## User Story
**As a** ผู้เล่นเกม  
**I want** หลบหลีกบร็อกโคลีที่วางขวางอยู่บนพื้น  
**So that** ไม่โดนความเสียหาย หรือหักเงิน/คะแนนจากการชนสิ่งกีดขวาง

---

## Acceptance Criteria (AC)
1. **Obstacle Spawning**: บร็อกโคลี (สี่เหลี่ยมสีเขียวแก่ ขนาด 28x28) เกิดขึ้นจากขอบขวาและเคลื่อนที่มาตามฉาก
2. **Player Penalty Collision**: เมื่อ Player เดินชนบร็อกโคลี จะหักเงิน **-$5 Coins** (หรือหักพลังชีวิต 1 หน่วย) พร้อมเอฟเฟกต์ชะลอความเร็ว (Slowdown) 1 วินาที
3. **Obstacle Persistence**: บร็อกโคลีไม่หายไปเมื่อถูกยิงด้วย Soundwave (ต้องขับหลบเท่านั้น)
4. **Cleanup**: ลบบร็อกโคลีออกเมื่อหลุดขอบซ้ายของหน้าจอ

---

## Technical Checklist (Atomic)
- [ ] **1. Obstacle Class (`lib/obstacle.rb` / `Broccoli`)**
  - [ ] สร้างคลาส `Broccoli` มีพิกัด `(x, y)` และขนาด
  - [ ] เมธอด `update` ขยับตำแหน่งตาม Scrolling ความเร็วฉาก
  - [ ] เมธอด `draw` แสดงผลผักบร็อกโคลี (สีเขียวแก่)
- [ ] **2. Player-Obstacle Collision Handling**
  - [ ] ตรวจจับ Collision ระหว่าง `Player` กับ `Broccoli`
  - [ ] หักเงิน/พลังชีวิตของผู้เล่น และติดสถานะ Cooldown ห้ามโดนซ้ำชั่วขณะ (Invincibility Frames ~ 1s)
- [ ] **3. Verification**
  - [ ] ทดสอบยิงใส่บร็อกโคลี (ต้องไม่พัง) และทดสอบเดินชนเพื่อดูว่าถูกหักเงิน/โดน Penalty หรือไม่
