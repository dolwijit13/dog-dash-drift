# Feature Requirement: Score, Currency (Bones/Coins), and HUD Display

## Overview
ระบบแสดงผลข้อมูลคะแนน (Score) และเงินสะสม (Bones/Coins) บนหน้าจอเกมแบบ Real-time บริเวณมุมซ้ายบนผ่าน `args.outputs.labels` ของ DragonRuby GTK

---

## User Story
**As a** ผู้เล่นเกม  
**I want** เห็นจำนวนเงินและคะแนนสะสมที่ได้รับบนหน้าจอแบบ Real-time  
**So that** ทราบความก้าวหน้าและยอดเงินสะสมในรอบการเล่นนั้นๆ

---

## Acceptance Criteria (AC)
1. **Real-Time HUD**: แสดงข้อความจำนวนเงิน (`Bones: $X`) และคะแนน (`Score: Y`) บริเวณมุมซ้ายบนของหน้าจออย่างชัดเจน
2. **State Management**: รักษาสถานะ Coins และ Score ให้ถูกต้องตาม Events (เก็บกระดูกได้ +$10 Coins/+20 Score, ฆ่าแมวปีศาจได้ +$5 Coins/+10 Score, ชนบร็อกโคลีโดนหัก -$5 Coins)
3. **Non-Negative Coins**: ค่า Coins ต้องไม่ต่ำกว่า 0 (หากโดนหักเงินจนติดลบ ให้ Clamp อยู่ที่ 0 เสมอ)

---

## Technical Checklist (Atomic) — DragonRuby GTK
- [x] **1. Score & Economy State (`args.state.coins`, `args.state.score`)**
  - [x] กำหนดค่าเริ่มต้น `args.state.coins ||= 0` และ `args.state.score ||= 0`
  - [x] ควบคุมการเพิ่ม/หักเงินด้วย `clamp(0, 999999)` เพื่อป้องกันค่าเงินติดลบ
- [x] **2. HUD Renderer (`args.outputs.labels`)**
  - [x] เรนเดอร์ข้อความ `Bones: $X` และ `Score: Y` ผ่าน `args.outputs.labels`
  - [x] กำหนดพิกัด `(x: 30, y: 700)` สำหรับ Bones และ `(x: 30, y: 670)` สำหรับ Score
  - [x] ตั้งค่าขนาดตัวอักษร `size_enum: 2` สีทอง (`r: 241, g: 196, b: 15`) สำหรับ Bones และสีขาวสำหรับ Score
- [x] **3. Verification & Web Export Check**
  - [x] ทดสอบการเพิ่ม/ลด Coins และ Score จากระบบต่างๆ แล้วดูผลลัพธ์บน HUD ทั้งบน Desktop และ Web Build
