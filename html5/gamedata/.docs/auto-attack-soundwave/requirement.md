# Feature Requirement: Auto-Attack Soundwave Projectile System

## Overview
ระบบการยิงกระสุนคลื่นเสียง "โฮ่ง!" (Soundwave) ออกไปทางขวาโดยอัตโนมัติตามระยะเวลา Cooldown ที่กำหนดไว้

---

## User Story
**As a** ผู้เล่นเกม  
**I want** ตัวละครยิง Soundwave ออกไปทางขวาโดยอัตโนมัติเป็นระยะๆ  
**So that** โจมตีและทำลายแมวปีศาจที่เดินเข้ามาจากทางขวาได้โดยไม่ต้องกดปุ่มยิงเอง

---

## Acceptance Criteria (AC)
1. **Auto Firing Rate**: ยิง Soundwave ออกมาจากพิกัดตัวละครทุกๆ 0.5 วินาที (2 นัด/วินาที)
2. **Rightward Motion**: กระสุนเคลื่อนที่ไปทางขวาด้วยความเร็วคงที่ (8 px/frame)
3. **Offscreen Cleanup**: กระสุนที่วิ่งพ้นขอบขวาของหน้าจอจะถูกลบออกจากหน่วยความจำอัตโนมัติ

---

## Technical Checklist (Atomic)
- [ ] **1. Soundwave Projectile Class (`lib/soundwave.rb`)**
  - [ ] สร้างคลาส `Soundwave` ที่มีพิกัด `(x, y)`, ความเร็ว `speed`, และสถานะ `active`
  - [ ] เขียนเมธอด `update` เลื่อนตำแหน่งไปทางขวา `x += speed`
  - [ ] เขียนเมธอด `draw` แสดงผลกระสุน (รูปวงกลม/สี่เหลี่ยมสีฟ้า/เหลือง หรือ Sprite)
  - [ ] ตรวจจับเมื่อ `x > window_width` เพื่อทำเครื่องหมายลบ (`out_of_bounds?`)
- [ ] **2. Player Auto-Attack Manager (`lib/player.rb`)**
  - [ ] เพิ่มระบบ Cooldown Timer (`attack_cooldown = 0.5s`)
  - [ ] เมื่อ Cooldown ถึง 0 ให้ Instantiate `Soundwave` ใหม่ที่ตำแหน่งตัวละคร แล้ว Reset Cooldown
- [ ] **3. Projectile Manager Integration (`main.rb`)**
  - [ ] บริหารจัดการ List ของ Soundwaves ในเกม (`@soundwaves = []`)
  - [ ] วน Loop `update` และ `draw` กระสุนทุกนัด และลบกระสุนที่หลุดขอบฉากออก
- [ ] **4. Verification**
  - [ ] ทดสอบรันและสังเกตว่ากระสุนยิงออกไปทางขวาอย่างต่อเนื่อง และจำนวน Object ใน Array ไม่รั่วไหล
