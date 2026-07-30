# 🎮 Dog Dash Deluxe (DDD) — Project Documentation Overview

> **💡 Documentation Maintenance Guideline (Skill / Operating Rule)**
> เอกสารในโฟลเดอร์ `.docs/` (รวมถึง `main.md` และ `requirement.md` ของแต่ละโมดูล) คือ **Single Source of Truth** ของโปรเจกต์ ทั้ง Product Owner (PO) และ Developers **ต้องกลับมาอัปเดตไฟล์นี้และสเปกย่อยสม่ำเสมอ** เมื่อมีการเพิ่ม Feature ใหม่, ปรับปรุงระบบ หรือเปลี่ยนแปลงสถาปัตยกรรมซอฟต์แวร์

---

## 📌 Project Overview
- **Project Name**: Dog Dash Deluxe (DDD) *(Repository: `dog-dash-drift`)*
- **Engine**: Gosu (Ruby 2D Game Engine)
- **Genre**: Top-Down Side-Scrolling Action / Runner (2D Beat 'em up / Autoshooter hybrid)
- **Tone & Theme**: Cute, Whimsical, Pastel Candy Land, Playful, Pixel Art
- **Live Demo / Deployment**: [GitHub Pages Live Demo](https://dolwijit13.github.io/dog-dash-drift/) *(ดู [Deployment Requirement](file:///Users/bumpdolwijit/Desktop/bump/dog-dash-drift/.docs/github-pages-deployment/requirement.md))*

---

## 🕹️ Core Gameplay & Key Features

### 1. Player Character & Movement
- **สุนัขชิบะ (Shiba Inu)**: ตัวละครหลักที่ผู้เล่นควบคุมบนพรมลูกกวาด
- **Spike Initial Prototype**: [Mouse Tracking Prototype](file:///Users/bumpdolwijit/Desktop/bump/dog-dash-drift/.docs/player-mouse-movement/requirement.md)
- **Top-Down Free Movement & Side-Scrolling Camera**: [Movement & Camera Requirement](file:///Users/bumpdolwijit/Desktop/bump/dog-dash-drift/.docs/camera-scrolling-movement/requirement.md)
  - เดินหน้าลุยฉากแบบ Side-Scrolling 8 ทิศทาง (ขยับแกน X และ Y ได้อิสระ) พร้อมระบบกล้องติดตาม

### 2. Combat & Attack Mechanics
- **Auto-Attack Soundwave**: [Auto-Attack Requirement](file:///Users/bumpdolwijit/Desktop/bump/dog-dash-drift/.docs/auto-attack-soundwave/requirement.md)
  - ยิงคลื่นเสียง "โฮ่ง!" ออกไปทางขวาโดยอัตโนมัติตามระยะ Cooldown เพื่อกำจัดศัตรู
- **Enemies (Evil Cats)**: [Enemy Spawning & Hit Detection Requirement](file:///Users/bumpdolwijit/Desktop/bump/dog-dash-drift/.docs/enemy-evil-cat/requirement.md)
  - ฝูงแมวปีศาจสุ่มเกิดจากขอบขวา เคลื่อนที่มาทางซ้าย และถูกทำลายได้ด้วย Soundwave

### 3. Items & Obstacles
- **Collectibles (Bone Snacks)**: [Collectibles Requirement](file:///Users/bumpdolwijit/Desktop/bump/dog-dash-drift/.docs/collectibles-bone-snack/requirement.md)
  - ขนมหวานและกระดูกปรากฏบนพื้นฉากให้ผู้เล่นเดินเก็บเพื่อสะสมคะแนนและเงิน
- **Obstacles (Broccoli)**: [Obstacles Requirement](file:///Users/bumpdolwijit/Desktop/bump/dog-dash-drift/.docs/obstacles-broccoli/requirement.md)
  - ผักบร็อกโคลีสิ่งกีดขวางบนพื้น ยิงไม่พัง ต้องขับหลบหลีก หากชนจะถูกหักเงินและชะลอความเร็ว

### 4. Economy & Interface
- **Economy & Real-Time HUD**: [Economy & HUD Requirement](file:///Users/bumpdolwijit/Desktop/bump/dog-dash-drift/.docs/economy-hud-system/requirement.md)
  - ระบบนับคะแนน (Score) และเงินสะสม (Coins/Bones) พร้อมหน้าจอ HUD แสดงผลบริเวณมุมซ้ายบน

### 5. Deployment & CI/CD Pipeline
- **GitHub Pages Deployment**: [Deployment Requirement](file:///Users/bumpdolwijit/Desktop/bump/dog-dash-drift/.docs/github-pages-deployment/requirement.md)
  - ระบบ Build อัตโนมัติด้วย GitHub Actions เพื่อแปลงเกมเป็น Web (WASM/Canvas) และ Deploy ขึ้น GitHub Pages

---

## 📁 Directory Structure Overview
```text
.docs/
├── main.md                              # เอกสารสรุปภาพรวมโปรเจกต์ (ไฟล์นี้)
├── player-mouse-movement/               # Spike: การควบคุมเมาส์เบื้องต้น
│   └── requirement.md
├── camera-scrolling-movement/           # Feature: การเดิน 8 ทิศทางและกล้อง Side-Scrolling
│   └── requirement.md
├── auto-attack-soundwave/               # Feature: ระบบยิงคลื่นเสียงอัตโนมัติ
│   └── requirement.md
├── enemy-evil-cat/                      # Feature: แมวปีศาจและการตรวจจับการชน
│   └── requirement.md
├── collectibles-bone-snack/             # Feature: ไอเทมกระดูก/ขนมหวาน
│   └── requirement.md
├── obstacles-broccoli/                  # Feature: สิ่งกีดขวางบร็อกโคลี
│   └── requirement.md
├── economy-hud-system/                  # Feature: ระบบการเงินและหน้าจอ UI HUD
│   └── requirement.md
└── github-pages-deployment/             # Feature: ระบบ Web Build & CI/CD Deployment
    └── requirement.md
```
