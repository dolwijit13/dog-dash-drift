# Feature Requirement: Score, Currency (Bones/Coins), and HUD Display

## Overview
ระบบบริหารจัดการระบบการเงิน (Money/Coins), คะแนน (Score) และการแสดงผลส่วนหัว UI (Heads-Up Display - HUD) บนหน้าจอเกม

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

## Technical Checklist (Atomic)
- [ ] **1. Score & Economy Controller (`lib/game_state.rb` หรือ `Player`)**
  - [ ] ประกาศตัวแปร `@coins = 0` และ `@score = 0`
  - [ ] เมธอด `add_coins(amount)`, `deduct_coins(amount)` (พร้อม clamp >= 0), และ `add_score(amount)`
- [ ] **2. HUD Renderer (`lib/hud.rb` หรือ `GameWindow`)**
  - [ ] ใช้ `Gosu::Font` แสดงผลข้อความ "Bones: $X" และ "Score: Y"
  - [ ] จัดวางตำแหน่ง UI มุมซ้ายบนให้อ่านง่าย ชัดเจน
- [ ] **3. Verification**
  - [ ] ทดสอบการเพิ่ม/ลด Coins และ Score จากระบบต่างๆ แล้วดูผลลัพธ์บน HUD
