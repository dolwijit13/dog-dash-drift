# Feature Requirement: Core Player Setup & Mouse Movement

## Overview
วางโครงสร้างพื้นฐานสำหรับเกม 2D (Dog Dash Drift) และสร้างตัวละครเอกตั้งต้นเป็นรูปสี่เหลี่ยมสีเขียว (Green Rectangle) ที่อัปเดตตำแหน่งตามพิกัดเมาส์ของผู้เล่นตลอดเวลา

---

## User Story
**As a** ผู้เล่นเกม  
**I want** ตัวละครเอก (สี่เหลี่ยมสีเขียว) เคลื่อนที่ตามตำแหน่งหัวชี้เมาส์ (Mouse Cursor) บนหน้าจอ  
**So that** ฉันสามารถควบคุมทิศทางของตัวละครเบื้องต้นด้วยเมาส์ได้อย่างลื่นไหล

---

## Acceptance Criteria (AC)
1. **Window Setup**: หน้าจอเกมรันที่ขนาด 800x600 พิกเซล Framerate 60 FPS พื้นหลังสีโทนเข้ม
2. **Player Rendering**: ตัวละครเอกแสดงผลเป็นสี่เหลี่ยมสีเขียว (Green Rectangle) ขนาด 32x32 พิกเซล
3. **Mouse Tracking**: จุดศูนย์กลาง (Origin) หรือมุมซ้ายบนของตัวละครอัปเดตพิกัด (X, Y) ตรงกับตำแหน่ง Cursor เมาส์ในทุก Frame
4. **Clean Exit**: ผู้เล่นกดปุ่ม `ESC` เพื่อปิดเกมได้อย่างสมบูรณ์โดยไม่มี Crash หรือ Error Log

---

## Technical Checklist (Atomic)
- [ ] **1. Project Directory & Class Setup**
  - [ ] จัดโครงสร้างไฟล์ภายใต้ `app/player.rb` และ `app/main.rb`
  - [ ] ใช้ DragonRuby GTK standard structure (`def tick args`)
- [ ] **2. Player Class Implementation (`Player` class)**
  - [ ] กำหนดขนาดสี่เหลี่ยม `WIDTH = 32`, `HEIGHT = 32` และ `primitive_marker = :solid`
  - [ ] รับพิกัด `(x, y)` ในเมธอด `update` โดยอ่านจาก `args.inputs.mouse.x` และ `args.inputs.mouse.y`
  - [ ] คำนวณจุดศูนย์กลางของสี่เหลี่ยมให้อยู่ตรงกับตำแหน่งเมาส์: `draw_x = mouse_x - (WIDTH / 2)`, `draw_y = mouse_y - (HEIGHT / 2)`
  - [ ] เติมลงใน `args.outputs.solids` หรือ `args.outputs.primitives`
- [ ] **3. Game Window Integration (`main.rb` / `GameWindow`)**
  - [ ] Instantiate `Player` ในเมธอด `initialize` ของ `GameWindow`
  - [ ] แสดงผล Cursor เมาส์ด้วย `self.needs_cursor? = true`
  - [ ] เรียก `player.update` ใน `update` loop
  - [ ] เรียก `player.draw` ใน `draw` loop
- [ ] **4. Verification & Testing**
  - [ ] ทดสอบรัน `bundle exec ruby main.rb`
  - [ ] เลื่อนเมาส์ไปทั่วหน้าจอเพื่อตรวจสอบความลื่นไหลและการติดตามของสี่เหลี่ยมสีเขียว
  - [ ] กด ESC เพื่อปิดเกมและตรวจสอบว่ากระบวนการจบลงอย่างสะอาด
