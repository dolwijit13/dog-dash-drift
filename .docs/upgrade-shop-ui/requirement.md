# 🛒 In-Game Shop & Upgrade Overlay UI — Feature Requirement

## 📌 Overview
สร้างหน้าจออินเทอร์เฟซร้านค้าและเมนูอัปเกรด (Shop / Upgrade Overlay) ให้ผู้เล่นสามารถเปิดใช้งานระหว่างเล่นเกม เพื่อใช้ Coins ซื้ออัปเกรดสถานะตัวละครและอัปเกรดอาวุธ

---

## 🎯 User Story
**As a** ผู้เล่นเกม  
**I want** มีหน้าจอร้านค้าที่เปิดปิดได้ง่ายในเกม แสดงราคาและระดับการอัปเกรด  
**So that** เลือกใชัจ่าย Coins เพื่ออัปเกรดตัวละครและอาวุธได้อย่างสะดวก

---

## 📋 Acceptance Criteria (AC)
- [ ] **Shop Toggle Interface**: สามารถเปิด/ปิดหน้าจอร้านค้าด้วยการกดปุ่ม (เช่น `TAB` หรือ `P` หรือคลิกปุ่ม Shop บน HUD)
- [ ] **Game Pause on Shop**: เมื่อเปิดหน้าจอร้านค้า การอัปเดตตำแหน่งมอนสเตอร์และการเคลื่อนที่ของเกมจะหยุดชั่วคราว (Pause)
- [ ] **Upgrade Options Display**:
  - แสดงจำนวน Coins ปัจจุบันของผู้เล่น
  - ปุ่มอัปเกรด **Max HP** (พร้อมแสดง Level ปัจจุบัน & ราคา Coins)
  - ปุ่มอัปเกรด **Move Speed** (พร้อมแสดง Level ปัจจุบัน & ราคา Coins)
  - ปุ่มอัปเกรด **Base Attack** (พร้อมแสดง Level ปัจจุบัน & ราคา Coins)
  - ปุ่มอัปเกรด **Soundwave Weapon** (พร้อมแสดง Level ปัจจุบัน & ราคา Coins)
- [ ] **Validation & Feedback**: ปุ่มอัปเกรดจะกดใช้งานได้เฉพาะเมื่อ Coins เพียงพอ หาก Coins ไม่พอ ปุ่มจะมีสีเทา/กดไม่ได้

---

## 🛠️ Technical Checklist (Atomic)
- [ ] **1. Shop Manager & UI Renderer (`app/shop_ui.rb` หรือ `app/ui/shop.rb`)**
  - [ ] ออกแบบเมนู Overlay ด้วย `args.outputs.solids`, `args.outputs.labels`, และ `args.outputs.borders`
  - [ ] คำนวณพิกัดปุ่มและการตรวจจับคลิกเมาส์ (`args.inputs.mouse.click`) หรือปุ่มตัวเลข (1-4) บนคีย์บอร์ด
- [ ] **2. Integration with Player & Game Loop (`app/main.rb`)**
  - [ ] เพิ่ม Game State `:playing` และ `:shop`
  - [ ] เมื่ออยู่ใน state `:shop` ให้หยุดการอัปเดตศัตรู/ฉาก แต่ยังคงวาดภาพประกอบและ UI Shop
- [ ] **3. Verification & Web Export Check**
  - [ ] ทดสอบการเปิด/ปิด Shop การคลิกอัปเดตค่า และตรวจสอบการหักเงินทั้งบน Desktop และ Web Build
