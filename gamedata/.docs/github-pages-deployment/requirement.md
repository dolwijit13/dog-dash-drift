# Feature Requirement: Web Build & GitHub Pages Deployment Pipeline

## Overview
สร้างระบบ Build และ Deploy อัตโนมัติผ่าน GitHub Actions เพื่อคอมไพล์/แปลงเกม Ruby Gosu (Dog Dash Deluxe) ให้รันบน Web Browser และเปิดให้บริการบน GitHub Pages (URL: `https://dolwijit13.github.io/dog-dash-drift/`)

---

## User Story
**As a** ผู้เล่นเกมและทีมงาน  
**I want** เข้าเล่นเกม Dog Dash Deluxe บน Web Browser ผ่านลิงก์ GitHub Pages  
**So that** สามารถทดสอบ เล่นเกม และแชร์ลิงก์ให้ผู้อื่นลองเล่นได้ทันทีโดยไม่ต้องติดตั้ง Ruby หรือ SDL2 ลงในเครื่อง

---

## Acceptance Criteria (AC)
1. **Web Packaging Compatibility**: มี Web Runner / WebAssembly Wrapper (เช่น `ruby.wasm` ร่วมกับ Canvas Adapter) ที่สามารถรัน `main.rb` และ Gosu 2D Logic บน Browser ได้
2. **Automated CI/CD Workflow**: มีไฟล์ `.github/workflows/deploy.yml` ที่คอย Build หน้าเว็บอัตโนมัติทุกครั้งเมื่อมีการ Push หรือ Merge Code เข้าสู่ branch `main`
3. **GitHub Pages Accessibility**: หน้าเว็บเกมสามารถเปิดใช้งานได้ที่ `https://dolwijit13.github.io/dog-dash-drift/` โดยโหลด Asset ได้ถูกต้องและเล่นเกมได้ด้วย Framerate 60 FPS
4. **Zero-Downtime Deployment**: การ Deploy อัปเดตเวอร์ชันใหม่เกิดขึ้นแบบอัตโนมัติและไม่ทำให้ลิงก์หลักใช้งานไม่ได้

---

## Technical Checklist (Atomic)
- [ ] **1. Web Engine Adapter & Entrypoint**
  - [ ] สร้างโครงสร้างไฟล์สำหรับ Web Build (เช่น `web/index.html`, `web/main.js` หรือ `dist/`)
  - [ ] ติดตั้ง/ตั้งค่า `ruby.wasm` และ Gosu HTML5 Canvas Interoperability Layer
  - [ ] รองรับการรับ Input จาก Keyboard (W/A/S/D/Arrow Keys/ESC) และ Mouse บน HTML5 Canvas
- [ ] **2. GitHub Actions Deployment Workflow (`.github/workflows/deploy.yml`)**
  - [ ] กำหนด Trigger `on: push: branches: [main]`
  - [ ] ตั้งค่า Job `build-and-deploy` ใช้ `ubuntu-latest`
  - [ ] Step 1: Checkout repository
  - [ ] Step 2: Setup Ruby & Node/WASM toolchain
  - [ ] Step 3: Bundle & Compile static web files เข้าโฟลเดอร์ `public/` หรือ `dist/`
  - [ ] Step 4: Deploy ไปยัง GitHub Pages ผ่าน `actions/deploy-pages@v4` (หรือ `peaceiris/actions-gh-pages@v4`)
- [ ] **3. GitHub Repository Configuration**
  - [ ] เปิดใช้งาน GitHub Pages ใน Settings -> Pages (Build and deployment source: GitHub Actions)
  - [ ] ตรวจสอบว่า Workflow รันผ่าน (Green Checkmark) และหน้าเว็บสามารถเข้าถึงได้จริง
- [ ] **4. Documentation Update**
  - [ ] อัปเดตไฟล์ README.md เพิ่ม badge และลิงก์เข้าเล่นเกมบน GitHub Pages
  - [ ] อัปเดต `.docs/main.md` เชื่อมโยงระบบ Deployment
