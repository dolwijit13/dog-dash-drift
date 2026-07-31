# 🎮 Dog Dash Deluxe (DDD) — Project Documentation Overview

> **💡 Documentation Maintenance Guideline (Skill / Operating Rule)**
> เอกสารในโฟลเดอร์ `.docs/` (รวมถึง `main.md` และ `requirement.md` ของแต่ละโมดูล) คือ **Single Source of Truth** ของโปรเจกต์ ทั้ง Product Owner (PO) และ Developers **ต้องกลับมาอัปเดตไฟล์นี้และสเปกย่อยสม่ำเสมอ** เมื่อมีการเพิ่ม Feature ใหม่, ปรับปรุงระบบ หรือเปลี่ยนแปลงสถาปัตยกรรมซอฟต์แวร์

---

## 📌 Project Overview
- **Project Name**: Dog Dash Deluxe (DDD) *(Repository: `dog-dash-drift`)*
- **Engine**: **DragonRuby Game Toolkit (GTK)** *(Migrated from Gosu for native WebAssembly/HTML5 Export)*
- **Genre**: Top-Down Side-Scrolling Action / Runner (2D Beat 'em up / Autoshooter hybrid)
- **Tone & Theme**: Cute, Whimsical, Pastel Candy Land, Playful, Pixel Art
- **Live Demo / Deployment**: [GitHub Pages Live Demo](https://dolwijit13.github.io/dog-dash-drift/) *(ดู [DragonRuby Deployment Requirement](file://.docs/dragonruby-github-pages-deployment/requirement.md) และ [Technical Specification](file://.docs/dragonruby-github-pages-deployment/technical.md))*

---

## 🛠️ Architecture & Engine Migration
- **DragonRuby GTK Migration**: [DragonRuby Migration Requirement](file://.docs/dragonruby-migration/requirement.md)
  - ปรับเปลี่ยนเอนจินหลักจาก Gosu มาเป็น DragonRuby GTK เพื่อให้รองรับการ Export เกมขึ้นบน Web HTML5 (GitHub Pages) ได้โดยตรงแบบ Zero-Dependency C-Extension

---

## 🕹️ Core Gameplay & Key Features

### 1. Player Character & Movement
- **สุนัขชิบะ (Shiba Inu)**: ตัวละครหลักที่ผู้เล่นควบคุมบนพรมลูกกวาด
- **Spike Initial Prototype**: [Mouse Tracking Prototype](file://.docs/player-mouse-movement/requirement.md)
- **Top-Down Free Movement & Side-Scrolling Camera**: [Movement & Camera Requirement](file://.docs/camera-scrolling-movement/requirement.md)
  - เดินหน้าลุยฉากแบบ Side-Scrolling 8 ทิศทาง (ขยับแกน X และ Y ได้อิสระ) พร้อมระบบกล้องติดตาม

### 2. Combat & Attack Mechanics
- **Auto-Attack Soundwave**: [Auto-Attack Requirement](file://.docs/auto-attack-soundwave/requirement.md)
  - ยิงคลื่นเสียง "โฮ่ง!" ออกไปทางขวาโดยอัตโนมัติตามระยะ Cooldown เพื่อกำจัดศัตรู
- **Enemies (Evil Cats)**: [Enemy Spawning & Hit Detection Requirement](file://.docs/enemy-evil-cat/requirement.md)
  - ฝูงแมวปีศาจสุ่มเกิดจากขอบขวา เคลื่อนที่มาทางซ้าย และถูกทำลายได้ด้วย Soundwave

### 3. Items & Obstacles
- **Collectibles (Bone Snacks)**: [Collectibles Requirement](file://.docs/collectibles-bone-snack/requirement.md)
  - ขนมหวานและกระดูกปรากฏบนพื้นฉากให้ผู้เล่นเดินเก็บเพื่อสะสมคะแนนและเงิน
- **Obstacles (Broccoli)**: [Obstacles Requirement](file://.docs/obstacles-broccoli/requirement.md)
  - ผักบร็อกโคลีสิ่งกีดขวางบนพื้น ยิงไม่พัง ต้องขับหลบหลีก หากชนจะถูกหักเงินและชะลอความเร็ว

### 4. Economy & Interface
- **Economy & Real-Time HUD**: [Economy & HUD Requirement](file://.docs/economy-hud-system/requirement.md)
  - ระบบนับคะแนน (Score) และเงินสะสม (Coins/Bones) พร้อมหน้าจอ HUD แสดงผลบริเวณมุมซ้ายบน

### 5. Progression, Upgrades & Combat Mechanics (Phase 2)
- **Monster Health Pool & Scaled Damage**: [Enemy HP System Requirement](file://.docs/enemy-hp-system/requirement.md) | [Technical Doc](file://.docs/enemy-hp-system/technical.md)
  - ระบบ HP ของ Evil Cat และการลดทอนตามพลังโจมตีของ Soundwave
- **Player Stat Upgrade & Health System**: [Player Stats Upgrade Requirement](file://.docs/player-stats-upgrade/requirement.md) | [Technical Doc](file://.docs/player-stats-upgrade/technical.md)
  - พัฒนาสถานะตัวละคร (Max HP, Speed, Base Damage) และระบบ Game Over
- **Modular Weapon Upgrade System (Soundwave Pilot)**: [Soundwave Weapon Upgrade Requirement](file://.docs/soundwave-weapon-upgrade/requirement.md) | [Technical Doc](file://.docs/soundwave-weapon-upgrade/technical.md)
  - ระบบเลเวลอาวุธ Soundwave (ยิงแรงขึ้น ใหญ่ขึ้น ยิงคู่ และยิงกระจาย 3 ทิศทาง)
- **In-Game Shop & Upgrade Overlay Interface**: [Upgrade Shop UI Requirement](file://.docs/upgrade-shop-ui/requirement.md) | [Technical Doc](file://.docs/upgrade-shop-ui/technical.md)
  - หน้าจออินเทอร์เฟซร้านค้าเพื่อนำ Coins มาอัปเกรดตัวละครและอาวุธ

### 6. Stage Progression, Granular Enemies & Detailed Arsenal (Phase 3)
- **Stage Selection & Progression System**: [Stage Progression Requirement](file://.docs/stage-progression-system/requirement.md) | [Technical Doc](file://.docs/stage-progression-system/technical.md)
  - ระบบเลือกเล่นด่าน 1-3, การนับระยะทางผ่านด่าน, และการปลดล็อกด่านถัดไป
- **Enemy Type: Sniper Cat (Ranged Attacker)**: [Sniper Cat Requirement](file://.docs/enemy-sniper-cat/requirement.md) | [Technical Doc](file://.docs/enemy-sniper-cat/technical.md)
  - มอนสเตอร์แมวสไนเปอร์หยุดยืนยิงกระสุนระยะไกล (30 HP / +15 Coins)
- **Enemy Type: Ninja Cat (Homing Tracker)**: [Ninja Cat Requirement](file://.docs/enemy-ninja-cat/requirement.md) | [Technical Doc](file://.docs/enemy-ninja-cat/technical.md)
  - มอนสเตอร์แมวนินจาวิ่งเร็วและพุ่งติดตามแนว Y ของผู้เล่น (45 HP / +25 Coins)
- **Weapon: Bone Boomerang (Levels 1-5 Detailed Design)**: [Bone Boomerang Requirement](file://.docs/weapon-bone-boomerang/requirement.md)
  - อาวุธกระดูกร่อนกลับทะลุมอนสเตอร์ ยิง 1-3 ชิ้น ทำความเสียหายขาไปและขากลับ
- **Weapon: Kibble Mortar (Levels 1-5 Detailed Design)**: [Kibble Mortar Requirement](file://.docs/weapon-kibble-mortar/requirement.md)
  - อาวุธระเบิดอาหารเม็ด AoE ย้อยโค้ง แตกตัวเป็น Cluster Kibbles และ Burning Zone
- **Stage Select & Hub Shop UI Interface**: [Stage Select & Shop UI Requirement](file://.docs/stage-select-shop-ui/requirement.md) | [Technical Doc](file://.docs/stage-select-shop-ui/technical.md)
  - ปรับเมนูหลัก Hub/Stage Select ย้ายระบบร้านค้ามาอยู่นอกเกมก่อนเริ่มเล่นด่าน

### 7. Deployment & CI/CD Pipeline
- **DragonRuby GitHub Pages Deployment**: [DragonRuby Deployment Requirement](file://.docs/dragonruby-github-pages-deployment/requirement.md) | [Technical Doc](file://.docs/dragonruby-github-pages-deployment/technical.md)
  - ระบบ Build อัตโนมัติด้วย GitHub Actions เพื่อแปลงเกม DragonRuby GTK เป็น Web (WASM/Canvas) และ Deploy ขึ้น GitHub Pages

---

## 📁 Directory Structure Overview
```text
.docs/
├── main.md                                   # เอกสารสรุปภาพรวมโปรเจกต์ (ไฟล์นี้)
├── dragonruby-migration/                     # Feature/Arch: การย้ายเอนจินมาใช้ DragonRuby GTK
│   └── requirement.md
├── dragonruby-github-pages-deployment/       # Feature: ระบบ Deploy DragonRuby Web บน GitHub Pages
│   ├── requirement.md
│   └── technical.md
├── player-mouse-movement/                    # Spike: การควบคุมเมาส์เบื้องต้น
│   └── requirement.md
├── camera-scrolling-movement/                # Feature: การเดิน 8 ทิศทางและกล้อง Side-Scrolling
│   └── requirement.md
├── auto-attack-soundwave/                    # Feature: ระบบยิงคลื่นเสียงอัตโนมัติ
│   └── requirement.md
├── enemy-evil-cat/                           # Feature: แมวปีศาจและการตรวจจับการชน
│   └── requirement.md
├── collectibles-bone-snack/                  # Feature: ไอเทมกระดูก/ขนมหวาน
│   └── requirement.md
├── obstacles-broccoli/                       # Feature: สิ่งกีดขวางบร็อกโคลี
│   └── requirement.md
├── economy-hud-system/                       # Feature: ระบบการเงินและหน้าจอ UI HUD
│   └── requirement.md
├── enemy-hp-system/                          # Phase 2: ระบบ HP มอนสเตอร์ Evil Cat
│   ├── requirement.md
│   └── technical.md
├── player-stats-upgrade/                     # Phase 2: ระบบอัปเกรดสถานะตัวละคร & HP/Game Over
│   ├── requirement.md
│   └── technical.md
├── soundwave-weapon-upgrade/                 # Phase 2: ระบบอัปเกรดเลเวลอาวุธ Soundwave
│   ├── requirement.md
│   └── technical.md
├── upgrade-shop-ui/                          # Phase 2: หน้าจออินเทอร์เฟซร้านค้าระหว่างเล่น
│   ├── requirement.md
│   └── technical.md
├── stage-progression-system/                 # Phase 3: ระบบด่าน Stage 1-3 & Stage Clear
│   ├── requirement.md
│   └── technical.md
├── enemy-sniper-cat/                         # Phase 3: มอนสเตอร์ Sniper Cat (ยิงระยะไกล)
│   ├── requirement.md
│   └── technical.md
├── enemy-ninja-cat/                          # Phase 3: มอนสเตอร์ Ninja Cat (พุ่งตาม Y)
│   ├── requirement.md
│   └── technical.md
├── weapon-bone-boomerang/                    # Phase 3: อาวุธ Bone Boomerang L1-L5
│   └── requirement.md
├── weapon-kibble-mortar/                     # Phase 3: อาวุธ Kibble Mortar L1-L5 (AoE)
│   └── requirement.md
└── stage-select-shop-ui/                     # Phase 3: หน้าจอ Stage Select & Hub Shop
    ├── requirement.md
    └── technical.md
```
