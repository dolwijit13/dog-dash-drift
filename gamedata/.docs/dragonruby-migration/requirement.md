# Feature Requirement: Migrate Game Engine from Gosu to DragonRuby GTK

## Overview
เนื่องจากการ Export เกม Ruby ที่สร้างด้วย Gosu ไปยัง Web HTML5 มีข้อจำกัดเรื่อง C-Extensions และ SDL2 Binding บนเบราว์เซอร์ จึงทำการย้าย (Migrate) โครงสร้างเอนจินเกมหลักไปใช้ **DragonRuby Game Toolkit (GTK)** ซึ่งรองรับ HTML5 / WebAssembly Deployment และ Web Export ได้โดยตรง

---

## User Story
**As a** ผู้เล่นเกมและทีมพัฒนา  
**I want** ตัวเกมถูกพัฒนาบน DragonRuby Game Toolkit  
**So that** เกมสามารถ Build และ Export เป็น HTML5 รันบน Web Browser (GitHub Pages) ได้อย่างสมบูรณ์ และง่ายต่อการต่อยอดในอนาคต

---

## Acceptance Criteria (AC)
1. **Engine Replacement**: ย้ายโครงสร้างโปรเจกต์จาก Gosu GameWindow Loop มาเป็น DragonRuby GTK (`app/main.rb` และ `def tick args`)
2. **Feature Parity**: โค้ดเกมเดิมทั้งหมด (Player Movement, Soundwave Auto-Attack, Evil Cat Spawning, Collision Detection) ถูกพอร์ตมาใช้ API ของ DragonRuby (`args.inputs`, `args.outputs.solids/sprites/labels`) โดยยังคงเงื่อนไข Gameplay เดิมทุกประการ
3. **Native HTML5 Export**: สามารถรันคำสั่งสั่ง Build/Deploy ไปยัง HTML5 (`./dragonruby-deploy` หรือ Web Exporter) ได้ผลลัพธ์เป็นไฟล์ `index.html` และ Web Package ที่พร้อมอัปโหลดขึ้น GitHub Pages
4. **Clean Project Structure**: โครงสร้างไฟล์ถูกจัดวางภายใต้ `app/` ตามข้อกำหนดของ DragonRuby Toolkit (เช่น `app/main.rb`, `app/player.rb`, `app/enemy.rb` เป็นต้น)

---

## Technical Checklist (Atomic)
- [ ] **1. Toolkit Unpack & Setup**
  - [ ] แตกไฟล์ `dragonruby-gtk-macos.zip` และตั้งค่า Binary Executable (`dragonruby`)
  - [ ] วางโครงสร้างโปรเจกต์ `app/` สำหรับ Dog Dash Deluxe
- [ ] **2. Refactor Core Game Loop (`app/main.rb`)**
  - [ ] แปลง `GameWindow#update` & `GameWindow#draw` มาเป็น `def tick args`
  - [ ] ใช้ `args.state` ในการจัดการ Game State (Player, Projectiles, Enemies, Score, Coins)
- [ ] **3. Entity API Adaptation (DragonRuby Primitives)**
  - [ ] **Player**: อ่านเมาส์ผ่าน `args.inputs.mouse` หรือคีย์บอร์ดผ่าน `args.inputs.keyboard` และวาดตัวละครสี่เหลี่ยมด้วย `args.outputs.solids`
  - [ ] **Soundwave**: ยิงกระสุนและแสดงผลด้วย `args.outputs.solids` / `sprites`
  - [ ] **Evil Cat**: สปอว์นและเลื่อนตำแหน่ง วาดด้วย `args.outputs.solids`
  - [ ] **Collision**: ใช้ DragonRuby Collision Helper (`args.geometry.intersect_rect?`)
  - [ ] **HUD**: แสดงคะแนนและเงินด้วย `args.outputs.labels`
- [ ] **4. HTML5 Deploy & Verification**
  - [ ] ทดสอบรันเกมบนเครื่องด้วย `./dragonruby`
  - [ ] ทดสอบ Export Web HTML5 และรันผ่าน Local Server
  - [ ] ตรวจสอบว่าสามารถนำไฟล์ Web Package ไป Deploy ขึ้น GitHub Pages ผ่าน GitHub Actions ได้อย่างสมบูรณ์
