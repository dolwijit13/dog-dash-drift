# 🐱 Monster Health Pool & Damage System — Feature Requirement

## 📌 Overview
ปรับปรุงระบบมอนสเตอร์ (Evil Cat) ให้มีระบบพลังชีวิต (HP) และการรับความเสียหาย (Damage Detection) อย่างสมบูรณ์ เพื่อรองรับระบบอัปเกรดพลังโจมตีของตัวละครและเตรียมพร้อมสำหรับมอนสเตอร์หลากประเภทในอนาคต

---

## 🎯 User Story
**As a** ผู้เล่นเกม  
**I want** มอนสเตอร์ Evil Cat มีพลังชีวิต (HP) และไม่ตายในการยิงเพียงครั้งเดียวหากกระสุนยังมีพลังโจมตีไม่เพียงพอ  
**So that** เกิดความท้าทายในระดับความยากที่เหมาะสม และเห็นผลลัพธ์ชัดเจนเมื่ออัปเกรดความแรงของอาวุธ

---

## 📋 Acceptance Criteria (AC)
- [ ] **Monster HP Pool**: มอนสเตอร์ Evil Cat มีค่า HP สูงขึ้น (เช่น 25 HP) โดยค่าเริ่มต้น
- [ ] **Damage Calculation**: เมื่อ Soundwave ชนกับ Evil Cat มอนสเตอร์จะได้รับความเสียหายตามค่าพลังโจมตีของ Soundwave (`sw.damage`)
- [ ] **HP Bar / Visual Feedback**: มีการแสดงผลหลอดเลือด (HP Bar) ขนาดเล็ก หรือการกะพริบสีเมื่อมอนสเตอร์ได้รับความเสียหาย
- [ ] **Monster Death & Rewards**: มอนสเตอร์จะสลายไปและให้รางวัล (Coins/Score/Collectible Drop) ต่อเมื่อ HP <= 0 เท่านั้น
- [ ] **Extensible Enemy Contract**: โครงสร้างคลาสมอนสเตอร์รองรับการขยายไปสู่มอนสเตอร์ประเภทอื่นในอนาคต (เช่น Speed, Max HP, Reward Scale)

---

## 🛠️ Technical Checklist (Atomic)
- [ ] **1. Refactor Enemy Class (`app/enemy.rb`)**
  - [ ] เพิ่มคุณสมบัติ `max_hp` และ `hp` ให้กับ Evil Cat (ค่าเริ่มต้น: 25 HP)
  - [ ] เพิ่มเมธอด `take_damage(amount)` ที่หักลบ HP และตั้งค่า `hit_timer` สำหรับเอฟเฟกต์กะพริบ
  - [ ] เขียนเมธอดเรนเดอร์ HP Bar สี่เหลี่ยมเล็กๆ เหนือตัวมอนสเตอร์
- [ ] **2. Refactor Collision & Damage Logic (`app/collision_system.rb`)**
  - [ ] ปรับเมธอด `handle_soundwave_enemy_collisions` ให้ส่งผ่านค่า `sw.damage` เข้าไปหักลบ HP ของมอนสเตอร์
  - [ ] ตรวจสอบเงื่อนไขการให้ Reward และสลายมอนสเตอร์เมื่อ `enemy.hp <= 0`
- [ ] **3. Verification & Web Export Check**
  - [ ] ทดสอบยิงมอนสเตอร์หลายๆ นัดจนกระทั่ง HP หมดและสลายตัว
  - [ ] ตรวจสอบการทำงานทั้งบน Desktop และ Web Build (HTML5)
