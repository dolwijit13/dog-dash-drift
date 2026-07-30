# Feature Requirement: Obstacles & Collision Penalty (Broccoli)

## Overview
ระบบสิ่งกีดขวางบนพื้น (ผักบร็อกโคลี) ที่เคลื่อนที่ตามความเร็วฉาก Side-scrolling โดยผู้เล่นต้องคอยขับสุนัขชิบะหลบหลีก หากขับชนจะถูกหักเงิน (-$5 Coins) และติดสถานะชะลอความเร็ว (Slowdown) 1 วินาที

---

## User Story
**As a** ผู้เล่นเกม  
**I want** หลบหลีกบร็อกโคลีที่วางขวางอยู่บนพื้น  
**So that** ไม่โดนความเสียหาย หรือหักเงิน/คะแนนจากการชนสิ่งกีดขวาง

---

## Acceptance Criteria (AC)
1. **Obstacle Spawning**: บร็อกโคลี (สี่เหลี่ยมสีเขียวแก่ ขนาด 28x28) เกิดขึ้นจากขอบขวาของหน้าจอ (Y สุ่ม) ทุกๆ 3.0 - 5.0 วินาที
2. **Player Penalty Collision**: เมื่อ Player เดินชนบร็อกโคลี จะหักเงิน **-$5 Coins** พร้อมเอฟเฟกต์ชะลอความเร็ว (Slowdown) 1 วินาที
3. **Obstacle Persistence**: บร็อกโคลีไม่หายไปเมื่อถูกยิงด้วย Soundwave (ยิงไม่พัง ต้องหลบหลีกเท่านั้น)
4. **Cleanup**: ลบบร็อกโคลีออกเมื่อหลุดขอบซ้ายของหน้าจอ (`x + w < 0`)

---

## Technical Checklist (Atomic) — DragonRuby GTK
- [x] **1. Obstacle Class / Data Structure (`app/obstacle.rb`)**
  - [x] สร้างคลาส `Broccoli` มีพิกัด `(x, y)`, ขนาด `w: 28, h: 28`, สีเขียวแก่ (`r: 34, g: 139, b: 34`)
  - [x] อัปเดตตำแหน่งเลื่อนไปทางซ้ายตามความเร็ว Scrolling ฉาก
  - [x] เรนเดอร์ลงใน `args.outputs.sprites` ด้วย `primitive_marker: :solid`
- [x] **2. Player-Obstacle Collision & Slowdown Effect (`CollisionSystem.handle_player_obstacle_collisions`)**
  - [x] ตรวจจับ Collision ระหว่าง `Player` กับ `Broccoli`
  - [x] กระสุน Soundwave ยิงใส่ต้องไม่ทำลายผักบร็อกโคลี
  - [x] เมื่อ Player ชน ให้หักเงิน `args.state.coins = (args.state.coins - 5).clamp(0, 999999)`
  - [x] ตั้งค่า Slowdown Timer ให้ตัวละครชะลอความเร็วลง 50% เป็นเวลา 1.0 วินาที
- [x] **3. Verification & Web Export Check**
  - [x] ทดสอบยิงใส่บร็อกโคลี (ไม่พัง) และเดินชนเพื่อดูว่าโดนหักเงิน/ติด Slowdown 1 วินาที
