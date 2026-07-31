# 🔊 Modular Soundwave Weapon Upgrade System — Feature Requirement

## 📌 Overview
ระบบอัปเกรดอาวุธนำร่อง (Pilot Weapon: Soundwave) ให้สามารถเพิ่มเลเวลเพื่อเพิ่มความถี่ในการยิง พลังโจมตี ขนาดกระสุน และจำนวนทิศทางในการยิง พร้อมดีไซน์สถาปัตยกรรมแบบ Modular เพื่อรองรับอาวุธใหม่ๆ ในอนาคต

---

## 🎯 User Story
**As a** ผู้เล่นเกม  
**I want** อัปเกรดเลเวลของอาวุธ Soundwave เพื่อเพิ่มเอฟเฟกต์ ความเร็ว ขนาดกระสุน และการยิงหลายทิศทาง  
**So that** กวาดล้างมอนสเตอร์จำนวนมากได้อย่างมีประสิทธิภาพและน่าตื่นเต้นยิ่งขึ้น

---

## 📋 Acceptance Criteria (AC)
- [ ] **Modular Weapon Base Architecture**: แยกโครงสร้างอาวุธให้อยู่ในรูปแบบ Modular (`app/weapon.rb` หรือ `SoundwaveWeapon`) เพื่อให้เพิ่มอาวุธชนิดอื่นใน Phase ถัดไปได้ง่าย
- [ ] **Soundwave Level Progressions**:
  - **Level 1**: ยิง 1 นัดตรงไปทางขวา (Damage: 10, Speed: 8, Size: 16x8, Cooldown: 0.5s)
  - **Level 2**: เพิ่มความเร็วการยิง Cooldown ลดลง (-25% Cooldown / Cooldown: 0.375s)
  - **Level 3**: เพิ่มพลังโจมตี +50% (Damage: 15) และขยายขนาดกระสุน (+50% Size: 24x12)
  - **Level 4**: ยิงคู่ขนาน (Dual Soundwaves - 2 นัดบนและล่าง)
  - **Level 5**: ยิง 3 ทิศทางแบบกระจาย (3-Way Spread: เฉียงขึ้น, ตรงกลาง, เฉียงลง)
- [ ] **Upgrade Cost Scaling**: กำหนดสูตรคำนวณราคาการอัปเกรดอาวุธเพิ่มขึ้นตามเลเวล (เช่น Level 1->2: $50, 2->3: $100, 3->4: $200, 4->5: $350)

---

## 🛠️ Technical Checklist (Atomic)
- [ ] **1. Weapon Architecture (`app/weapon.rb` & `app/soundwave.rb`)**
  - [ ] สร้างคลาส `Weapon` / `SoundwaveWeapon` เก็บค่า `level`, `base_damage`, `fire_rate`, `projectile_count`
  - [ ] ปรับปรับ `Soundwave` ให้รับพิกัด `(x, y)`, เวกเตอร์ทิศทาง `(vx, vy)`, ขนาด `(w, h)` และพลังโจมตี `damage`
- [ ] **2. Multi-Directional & Multi-Projectile Firing Logic**
  - [ ] Implement การคำนวณตำแหน่งและองศา/เวกเตอร์การยิงในระดับ 4 (Dual Wave) และระดับ 5 (3-Way Spread Wave)
- [ ] **3. Integration with Player Auto-Attack**
  - [ ] เชื่อมโยง `SoundwaveWeapon` เข้ากับตัวละคร Player
- [ ] **4. Verification & Web Export Check**
  - [ ] ทดสอบการยิงในแต่ละ Level (Level 1 ถึง Level 5) และตรวจสอบความถูกต้องของระบบการยิงบน Web Build
