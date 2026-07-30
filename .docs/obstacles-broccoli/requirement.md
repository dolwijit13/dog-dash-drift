# Feature Requirement: Obstacles & Collision Penalty (Broccoli)

## Overview
ระบบสิ่งกีดขวางผักบร็อกโคลี (Broccoli) ที่วางกระจายบนพื้นฉาก เพื่อให้ผู้เล่นต้องคอยลากหลบ (ปรับปรุงตาม DragonRuby GTK API)

---

## User Story
**As a** ผู้เล่นเกม  
**I want** หลบหลีกบร็อกโคลีที่วางขวางอยู่บนพื้น  
**So that** ไม่โดนความเสียหาย หรือหักเงิน/คะแนนจากการชนสิ่งกีดขวาง

---

## Acceptance Criteria (AC)
1. **Obstacle Spawning**: บร็อกโคลี (สี่เหลี่ยมสีเขียวแก่ ขนาด 28x28) เกิดขึ้นจากขอบขวาและเคลื่อนที่มาตามฉาก
2. **Player Penalty Collision**: เมื่อ Player เดินชนบร็อกโคลี จะหักเงิน **-$5 Coins** พร้อมเอฟเฟกต์ชะลอความเร็ว (Slowdown) 1 วินาที
3. **Obstacle Persistence**: บร็อกโคลีไม่หายไปเมื่อถูกยิงด้วย Soundwave (ต้องขับหลบเท่านั้น)
4. **Cleanup**: ลบบร็อกโคลีออกเมื่อหลุดขอบซ้ายของหน้าจอ

---

## Technical Checklist (Atomic) — DragonRuby GTK
- [ ] **1. Obstacle Class / Data Structure (`app/obstacle.rb` หรือ `args.state.obstacles`)**
  - [ ] สร้างคลาส/โครงสร้างข้อมูล `Broccoli` มีพิกัด `(x, y)`, ขนาด `w: 28, h: 28`, สีเขียวแก่ (r: 34, g: 139, b: 34)
  - [ ] อัปเดตตำแหน่งเลื่อนไปทางซ้ายตามความเร็ว Scrolling ฉาก
  - [ ] เรนเดอร์ลงใน `args.outputs.solids` หรือ `args.outputs.sprites`
- [ ] **2. Player-Obstacle Collision & Invincibility (`args.geometry.intersect_rect?`)**
  - [ ] ตรวจจับ Collision ระหว่าง `args.state.player` กับ `Broccoli`
  - [ ] ยิง Soundwave ใส่ผักต้องไม่ถูกทำลาย (คงอยู่ตามปกติ)
  - [ ] เมื่อ Player ชน ให้หักเงิน `args.state.coins = (args.state.coins - 5).clamp(0, Float::INFINITY)`
  - [ ] ตั้งค่า Invincibility / Slowdown Timer (`args.state.player.slowdown_timer = 60`)
- [ ] **3. Verification & Web Export Check**
  - [ ] ทดสอบยิงใส่บร็อกโคลี (ไม่พัง) และเดินชนเพื่อดูว่าโดนหักเงิน/ติด Slowdown ทั้งบน Desktop และ Web Build
