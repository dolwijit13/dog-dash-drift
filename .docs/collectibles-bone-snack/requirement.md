# Feature Requirement: Collectibles & Player Pickup (Bone Snacks)

## Overview
ระบบขนมหวาน/กระดูก (Bone Snacks) ที่ปรากฏบนพื้น และเมื่อสุนัขชิบะเดินเข้าไปสัมผัส จะเป็นการเก็บเพื่อสะสมเงินและคะแนน (ปรับปรุงตาม DragonRuby GTK API)

---

## User Story
**As a** ผู้เล่นเกม  
**I want** เดินเก็บกระดูก/ขนมหวานที่วางอยู่ตามพื้น  
**So that** เพิ่มสะสมคะแนนและเงินในเกม

---

## Acceptance Criteria (AC)
1. **Collectible Spawning**: ขนมหวาน/กระดูก (สี่เหลี่ยมสีเหลืองทอง ขนาด 20x20) ปรากฏบนพื้นฉาก หรือดร็อปจากศัตรูที่ถูกทำลาย (อัตรา 30%)
2. **Scrolling Item**: ไอเทมบนพื้นจะเลื่อนไปทางซ้ายตามความเร็วของฉาก Side-scrolling
3. **Player Pickup Collision**: เมื่อ Player เดินชนกับ Bone Snack ไอเทมจะถูกเก็บทันที
4. **Reward Value**: การเก็บแต่ละครั้งจะให้เงิน **+$10 Coins** และคะแนน **+20 Score**

---

## Technical Checklist (Atomic) — DragonRuby GTK
- [ ] **1. Collectible Class / Data Structure (`app/collectible.rb` หรือ `args.state.collectibles`)**
  - [ ] กำหนดโครงสร้างข้อมูล `BoneSnack` มีพิกัด `(x, y)`, ขนาด `w: 20, h: 20`, และสี `primitive_marker: :solid` (สีเหลืองทอง)
  - [ ] เลื่อนตำแหน่งตาม Scrolling ฉาก `x -= scroll_speed`
  - [ ] เรนเดอร์ลงใน `args.outputs.solids` หรือ `args.outputs.sprites`
- [ ] **2. Pickup Collision Detection (`args.geometry.intersect_rect?`)**
  - [ ] ตรวจสอบ Collision ระหว่าง `args.state.player` กับ `BoneSnack` โดยใช้ `args.geometry.intersect_rect?`
  - [ ] เมื่อเกิดการชน ให้ลบไอเทมออกจาก List และเพิ่มค่า `args.state.coins += 10` และ `args.state.score += 20`
- [ ] **3. Verification & Web Export Check**
  - [ ] เดินชนไอเทมเพื่อตรวจสอบว่าไอเทมหายไป และยอดเงิน/คะแนนอัปเดตถูกต้องทั้งบน Desktop และ Browser (Web Build)
