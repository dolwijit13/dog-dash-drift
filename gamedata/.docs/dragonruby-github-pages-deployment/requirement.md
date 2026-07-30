# Feature Requirement: Deploy DragonRuby Web Build to GitHub Pages

## Overview
สร้างกระบวนการ Build และ Deploy อัตโนมัติสำหรับเกมที่พัฒนาด้วย **DragonRuby GTK** เพื่อส่งออกเป็น WebAssembly / HTML5 Static Web Package และเผยแพร่บน GitHub Pages (URL: `https://dolwijit13.github.io/dog-dash-drift/`)

---

## User Story
**As a** ผู้เล่นเกมและทีมงาน  
**I want** ตัวเกมที่สร้างด้วย DragonRuby GTK ถูก Build เป็น HTML5/WASM Package และ Deploy ขึ้นบน GitHub Pages ผ่าน GitHub Actions อัตโนมัติ  
**So that** ทุกคนสามารถคลิกเข้าเล่นเกมเวอร์ชันล่าสุดบน Web Browser ได้ทันทีโดยไม่ต้องติดตั้งซอฟต์แวร์เพิ่มเติม

---

## Acceptance Criteria (AC)
1. **DragonRuby Web Export**: ใช้สคริปต์/คำสั่งของ DragonRuby GTK (`./dragonruby` หรือ Publish CLI) ในการ Export Web Build เข้าโฟลเดอร์สำหรับ Static Host (เช่น `builds/web` หรือ `public/`)
2. **Automated CI/CD Workflow**: ไฟล์ `.github/workflows/deploy.yml` ทำการคอมไพล์/แพ็กเกจ DragonRuby Web App และ Deploy ขึ้น GitHub Pages เมื่อมี Commit/Merge เข้า `main` branch
3. **GitHub Pages Live Accessibility**: หน้าเว็บเกมสามารถเข้าเล่นได้ที่ `https://dolwijit13.github.io/dog-dash-drift/` โดยไม่มีปัญหา C-Extension หรือ Canvas Loading Error
4. **Game Metadata Integration**: กำหนดค่า `metadata/game_metadata.txt` (`devid`, `devtitle`, `gameid`, `gametitle`, `version`) อย่างถูกต้องเพื่อกำกับการ Build Web

---

## Technical Checklist (Atomic)
- [ ] **1. DragonRuby Web Build Configuration**
  - [ ] ตรวจสอบและกำหนดค่า `metadata/game_metadata.txt` (`devid=dolwijit13`, `gameid=dog-dash-drift`, `gametitle=Dog Dash Deluxe`)
  - [ ] ทดสอบ Export Web Local ด้วยคำสั่ง DragonRuby HTML5 Exporter
- [ ] **2. GitHub Actions Deployment Workflow (`.github/workflows/deploy.yml`)**
  - [ ] กำหนด Trigger `on: push: branches: [main]`
  - [ ] Download/Setup DragonRuby GTK CLI ใน CI Runner Environment
  - [ ] รันกระบวนการ Export Web Artifacts
  - [ ] Deploy Artifact ไปยัง GitHub Pages ผ่าน `actions/deploy-pages@v4` (หรือ `peaceiris/actions-gh-pages@v4`)
- [ ] **3. Verification & Live Demo**
  - [ ] ทดสอบเข้าเล่นบนเบราว์เซอร์ผ่าน GitHub Pages URL
  - [ ] ตรวจสอบว่า Graphics (Solids/Sprites), Sound Effects, และ Controls (Keyboard/Mouse) ทำงานได้อย่างลื่นไหล 60 FPS
- [ ] **4. Documentation Update**
  - [ ] อัปเดต `.docs/main.md` เชื่อมโยงระบบ Deployment ของ DragonRuby
