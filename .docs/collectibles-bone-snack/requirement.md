# Feature Requirement: Collectibles & Player Pickup (Bone Snacks)

## Overview
ระบบขนมหวาน/กระดูก (Bone Snacks) ที่ปรากฏบนพื้น และเมื่อสุนัขชิบะเดินเข้าไปสัมผัส จะเป็นการเก็บเพื่อสะสมเงินและคะแนน

---

## User Story
**As a** ผู้เล่นเกม  
**I want** เดินเก็บกระดูก/ขนมหวานที่วางอยู่ตามพื้น  
**So that** เพิ่มสะสมคะแนนและเงินในเกม

---

## Acceptance Criteria (AC)
1. **Collectible Spawning**: ขนมหวาน/กระดูก (สี่เหลี่ยมสีเหลืองทอง/ทองเหลือง ขนาด 20x20) ปรากฏบนพื้นฉาก หรือดร็อปจากศัตรูที่ถูกทำลาย (อัตรา 30%)
2. **Scrolling Item**: ไอเทมบนพื้นจะเลื่อนไปทางซ้ายตามความเร็วของฉาก Side-scrolling
3. **Player Pickup Collision**: เมื่อ Player เดินชนกับ Bone Snack ไอเทมจะถูกเก็บทันที พร้อมเสียง/Visual Feedback (ถ้ามี)
4. **Reward Value**: การเก็บแต่ละครั้งจะให้เงิน **+$10 Coins** และคะแนน **+20 Score**

---

## Technical Checklist (Atomic)
- [ ] **1. Collectible Class (`lib/collectible.rb` / `BoneSnack`)**
  - [ ] สร้างคลาส `BoneSnack` มีพิกัด `(x, y)` และประเภทไอเทม
  - [ ] เมธอด `update` ขยับตำแหน่งตาม Scrolling ความเร็วฉาก `x -= scroll_speed`
  - [ ] เมธอด `draw` แสดงผลเป็นรูปขนม/กระดูก (สีเหลืองทอง)
- [ ] **2. Pickup Collision Detection**
  - [ ] ตรวจสอบ AABB Collision ระหว่าง `Player` กับ `BoneSnack`
  - [ ] เมื่อเกิดการชน ให้ลบไอเทมออกจาก List และส่งมอบ Reward ให้กับผู้เล่น
- [ ] **3. Verification**
  - [ ] เดินชนไอเทมเพื่อตรวจสอบว่าไอเทมหายไปและค่าเงินเพิ่มขึ้นถูกต้อง
