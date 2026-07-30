# Feature Requirement: Top-Down Free Movement & Side-Scrolling Camera

## Overview
ระบบการเคลื่อนที่ของตัวละครเอก (สุนัขชิบะ) แบบ Free Movement (แกน X และ Y) บนมุมมอง Top-Down และระบบกล้อง Side-Scrolling ที่เลื่อนฉากไปทางขวาตามการเดินทาง

---

## User Story
**As a** ผู้เล่นเกม  
**I want** ควบคุมสุนัขชิบะเคลื่อนที่ขึ้น-ลง-ซ้าย-ขวา ได้อย่างอิสระ พร้อมกล้องที่ค่อยๆ เลื่อนไปทางขวาตามฉาก  
**So that** สำรวจพื้นที่พรมลูกกวาดและเดินหน้าลุยด่านได้อย่างต่อเนื่อง

---

## Acceptance Criteria (AC)
1. **Free Movement**: ผู้เล่นกดปุ่มทิศทาง (W/A/S/D หรือ Arrow Keys) เพื่อขยับตัวละคร 8 ทิศทาง
2. **Boundary Clamp**: ตัวละครไม่สามารถเดินหลุดขอบหน้าจอ (Top, Bottom, Left)
3. **Side-Scrolling Camera**: ฉาก/พื้นหลังและวัตถุในโลกเกมเคลื่อนที่ไปทางซ้ายจำลองการเดินหน้าของกล้องไปทางขวาอัตโนมัติ (หรือตามการเดินของ Player)
4. **Smooth Physics**: ความเร็วการเคลื่อนที่แบบ Diagonal ต้องได้รับการ Normalize เพื่อไม่ให้เดินทแยงไวกว่าปกติ

---

## Technical Checklist (Atomic)
- [ ] **1. Input Handler Setup (`lib/input_handler.rb` / `Player`)**
  - [ ] ตรวจจับปุ่ม `Gosu::KB_W`, `Gosu::KB_S`, `Gosu::KB_A`, `Gosu::KB_D` และ Arrow Keys
  - [ ]คำนวณเวกเตอร์ทิศทาง `(dx, dy)` และทำ Normalization เมื่อเคลื่อนที่ทแยง
- [ ] **2. Player Movement Logic (`lib/player.rb`)**
  - [ ] เพิ่มคุณสมบัติ `speed` (เช่น 4.0 px/frame)
  - [ ] อัปเดตพิกัด `x` และ `y` ตามทิศทางและขอบเขตหน้าจอ (`clamp`)
- [ ] **3. Camera & World Scrolling (`lib/camera.rb` หรือ `GameWindow`)**
  - [ ] กำหนดค่าความเร็ว Scrolling ของฉาก `scroll_speed` (เช่น 1.5 px/frame)
  - [ ] เลื่อนพิกัด World Offset เพื่อให้รู้สึกถึงการเดินทาง Side-Scrolling
- [ ] **4. Verification**
  - [ ] ทดสอบเดิน 8 ทิศทาง และตรวจสอบว่าขอบเขตหน้าจอป้องกันตัวละครหลุดฉาก
