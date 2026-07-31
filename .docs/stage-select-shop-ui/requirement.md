# 🏪 Stage Select Hub & Main Menu Shop UI Interface — Feature Requirement

## 📌 Overview
ปรับปรุง Game Loop และหน้าเมนูหลัก (Main Menu / Hub) ให้ผู้เล่นสามารถเลือกด่าน (Stage 1-3) และเปิดใช้งานร้านค้าอัปเกรด (Shop UI) ได้จากหน้า Hub ก่อนเริ่มเล่นด่าน เพื่อเตรียมความพร้อมตัวละคร/อาวุธโดยไม่ถูกขัดจังหวะระหว่างต่อสู้

---

## 🎯 User Story
**As a** ผู้เล่นเกม  
**I want** เลือกด่านและใชัจ่ายเงินอัปเกรดตัวละคร/อาวุธจากหน้าเมนูหลัก (Hub) ก่อนเริ่มเล่น  
**So that** วางแผนเตรียมตัวก่อนลุยด่าน และไม่ถูกขัดจังหวะขณะต่อสู้

---

## 📋 Acceptance Criteria (AC)
- [ ] **Stage Select Hub (`app/stage_select_ui.rb`)**:
  - แสดงการ์ดเลือกรอบเล่น Stage 1-3 พร้อมสถานะ **UNLOCKED** (สีเขียว) หรือ **LOCKED** (สีเทา)
  - แสดงชื่อด่าน, ระยะทางเป้าหมาย (1,000m, 1,500m, 2,000m), และปุ่มคลิกเลือกด่าน (หรือกดปุ่ม 1-3)
- [ ] **Hub Shop Interface (`app/shop_ui.rb`)**:
  - รองรับการเปิด Shop จากหน้า Hub (กดปุ่ม SHOP หรือแป้น TAB/P)
  - ซื้ออัปเกรดตัวละคร (Max HP, Speed, Base Dmg) และปลดล็อกอาวุธใหม่
- [ ] **State Flow Loop**:
  - `:main_menu` / `:stage_select` -> `:shop` -> เลือก Stage -> `:playing` -> `:stage_clear` -> กลับสู่ Hub
