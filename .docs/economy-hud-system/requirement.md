# Feature Requirement: Score, Currency (Bones/Coins), and HUD Display

## Overview
ระบบบริหารจัดการระบบการเงิน (Money/Coins), คะแนน (Score) และการแสดงผลส่วนหัว UI (Heads-Up Display - HUD) บนหน้าจอเกม (ปรับปรุงตาม DragonRuby GTK API)

---

## User Story
**As a** ผู้เล่นเกม  
**I want** เห็นจำนวนเงินและคะแนนสะสมที่ได้รับบนหน้าจอแบบ Real-time  
**So that** ทราบความก้าวหน้าและยอดเงินสะสมในรอบการเล่นนั้นๆ

---

## Acceptance Criteria (AC)
1. **Real-Time HUD**: แสดงข้อความจำนวนเงิน (Coins: $X) และคะแนน (Score: Y) บริเวณมุมซ้ายบนของหน้าจอ
2. **State Management**: รักษาสถานะ Coins และ Score ให้ถูกต้องตาม Events (เก็บของได้เงินเพิ่ม, ฆ่ามอนได้เงินเพิ่ม, ชนผักโดนหักเงิน)
3. **Non-Negative Coins**: ค่า Coins ต้องไม่ต่ำกว่า 0 (หากโดนหักเงินจนติดลบ ให้ Clamp อยู่ที่ 0)

---

## Technical Checklist (Atomic) — DragonRuby GTK
- [ ] **1. Score & Economy State (`args.state.coins`, `args.state.score`)**
  - [ ] กำหนดค่าเริ่มต้น `args.state.coins ||= 0` และ `args.state.score ||= 0`
  - [ ] เมธอด/ฟังก์ชัน helper เพิ่มเงิน, หักเงิน (พร้อม clamp >= 0) และเพิ่มคะแนน
- [ ] **2. HUD Renderer (`args.outputs.labels`)**
  - [ ] เรนเดอร์ข้อความ "Bones: $X" และ "Score: Y" ผ่าน `args.outputs.labels`
  - [ ] กำหนดพิกัด `(x: 30, y: 700)` (DragonRuby Origin Y0 อยู่ล่างสุด Y720 อยู่บนสุด)
  - [ ] ตั้งค่าขนาดตัวอักษร `size_enum`, สี `r, g, b` และ font ให้สวยงาม
- [ ] **3. Verification & Web Export Check**
  - [ ] ทดสอบการเพิ่ม/ลด Coins และ Score จากระบบต่างๆ แล้วดูผลลัพธ์บน HUD ทั้งบน Desktop และ Web Build
