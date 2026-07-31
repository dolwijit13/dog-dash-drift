# 🏁 Stage Selection System & Level Completion Flow (Stages 1-3) — Feature Requirement

## 📌 Overview
เพิ่มระบบด่าน (Stage 1: Candy Meadow, Stage 2: Chocolate Boulevard, Stage 3: Castle Peak) มีระยะทางเป้าหมายของแต่ละด่าน แถบความคืบหน้า (Progress Bar) และเมื่อผู้เล่นวิ่งถึงระยะทางเป้าหมาย จะเข้าสู่หน้าจอ **Stage Clear** สรุปคะแนนและปลดล็อกด่านถัดไป

---

## 🎯 User Story
**As a** ผู้เล่นเกม  
**I want** เลือกเล่นด่านต่างๆ (Stage 1, Stage 2, Stage 3) มีจุดจบเป้าหมายของด่าน และปลดล็อกด่านถัดไป  
**So that** มีเป้าหมายการเล่นที่ชัดเจน และสัมผัสความท้าทายที่ค่อยๆ เพิ่มขึ้นในแต่ละด่าน

---

## 📋 Acceptance Criteria (AC)
- [ ] **Stage Structure**:
  - มีทั้งหมด 3 ด่าน:
    - **Stage 1**: Candy Meadow (Target Distance: 1,000m, Enemies: EvilCat)
    - **Stage 2**: Chocolate Boulevard (Target Distance: 1,500m, Enemies: EvilCat, SniperCat)
    - **Stage 3**: Castle Peak (Target Distance: 2,000m, Enemies: EvilCat, SniperCat, NinjaCat)
- [ ] **Stage Unlock Flow**:
  - เริ่มต้นปลดล็อกเฉพาะ Stage 1 (`unlocked_stages = [1]`)
  - ชนะด่าน Stage 1 จะปลดล็อก Stage 2 (`unlocked_stages = [1, 2]`)
  - ชนะด่าน Stage 2 จะปลดล็อก Stage 3 (`unlocked_stages = [1, 2, 3]`)
- [ ] **Distance Progress Tracking**:
  - ขณะเล่นเกม กล้อง/ตัวละครขยับไปทางขวา จะสะสมระยะทาง `distance_covered`
  - HUD แสดงผล Progress Bar (%) และระยะทางปัจจุบัน / เป้าหมาย (เช่น 450m / 1,000m)
- [ ] **Stage Clear State**:
  - เมื่อ `distance_covered >= target_distance`, เปลี่ยนสถานะเกมเป็น `:stage_clear`
  - สรุปผลคะแนน, เงินที่ได้รับ, และปุ่ม Next Stage / Main Menu
