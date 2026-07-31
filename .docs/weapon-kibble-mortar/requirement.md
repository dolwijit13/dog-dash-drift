# 💣 Weapon: Kibble Mortar (Levels 1-5 Detailed Design) — Feature Requirement

## 📌 Overview
อาวุธปืนระเบิดอาหารเม็ด (Kibble Mortar) มีรูปแบบการยิงกระสุนย้อยโค้งข้ามหัว (Parabolic Arc) ตกลงบนพื้นหรือชนมอนสเตอร์ แล้วเกิดการระเบิดรัศมี (AoE Explosion) ทำความเสียหายแก่มอนสเตอร์ทุกตัวในบริเวณใกล้เคียง โดยต้องปลดล็อกที่ Level 0 ใน Shop ($150)

---

## 🎯 User Story
**As a** ผู้เล่นเกม  
**I want** ปลดล็อกและอัปเกรดอาวุธ Kibble Mortar ทั้ง 5 เลเวล  
**So that** ยิงระเบิดอาหารเม็ดสร้างความเสียหายแบบวงกว้าง (AoE) กวาดล้างมอนสเตอร์ที่อยู่เป็นกลุ่มได้อย่างรวดเร็ว

---

## 📋 Detailed Level 1 to Level 5 Progression Design

| Level | Name / Tier | Cost | Direct / AoE Damage | Explosion Radius | Projectiles & Clusters | Special Mechanics & Description |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Level 0** | Locked | Free | - | - | 0 | ยังไม่ปลดล็อก ต้องซื้อในร้านค้า |
| **Level 1** | Single Mortar | **$150** | 15 / 10 | 40px | 1 Bomb | ยิงลูกระเบิด 1 ลูกย้อยโค้งตกลงบนพื้น แล้วเกิดระเบิด AoE รัศมี 40px |
| **Level 2** | Expanded Splash | **$220** | 22 / 16 | 65px (+62%) | 1 Bomb | รัศมีการระเบิดกว้างขึ้นเป็น 65px และเพิ่มความแรงระเบิด (CD: 1.2s) |
| **Level 3** | Double Barrage | **$350** | 28 / 20 | 75px | 2 Bombs | ยิงลูกระเบิด 2 ลูกพร้อมกัน ตกลงตำแหน่งกระจายด้านหน้า |
| **Level 4** | Cluster Burst | **$500** | 35 / 25 | 90px | 2 Bombs + **3 Clusters** | **Cluster Effect**: เมื่อลูกใหญ่ระเบิด จะแตกออกเป็นลูกอาหารเม็ดเล็กลอยกระจายอีก 3 ลูก (10 Damage/ลูก) |
| **Level 5** | **Kibble Apocalypse** | **$750** | 50 / **40** | 110px | 3 Bombs + **4 Clusters** + Burning Zone | **Master Tier**: ยิง 3 ลูกใหญ่ ทุกลูกแตกเป็น 4 Clusters พร้อมทิ้งพื้นที่ไหม้ร้อน (Burning Zone 2s) ทำความเสียหาย 8/sec |

---

## 🛠️ Technical Checklist (Atomic) — DragonRuby GTK
- [ ] **1. MortarWeapon Class (`app/weapons/mortar_weapon.rb`)**
  - [ ] ประกาศคลาส `MortarWeapon` จัดการ Level (0..5), Upgrade Cost, และ Firing Cooldown
- [ ] **2. Parabolic Projectile & Explosion Logic (`app/projectiles/kibble_mortar.rb`)**
  - [ ] คำนวณวิถีโค้ง Parabola: `vy -= gravity` และตรวจสอบเมื่อกระทบพื้น (`y <= ground_y`)
  - [ ] สร้างวัตถุ `ExplosionEffect` เรนเดอร์วงกลมระเบิดขยายตัวและจางหายไป
- [ ] **3. AoE & Cluster Damage Collision (`app/collision_system.rb`)**
  - [ ] ตรวจจับมอนสเตอร์ในรัศมีระเบิด (`Math.sqrt((ex-mx)**2 + (ey-my)**2) <= radius`)
  - [ ] กระจายลูกระเบิดย่อย Cluster Kibbles ใน Level 4 และ Level 5
- [ ] **4. Verification & Web Export Check**
  - [ ] ทดสอบยิงระเบิดอาหารเม็ดตั้งแต่ Level 1 ถึง Level 5 บน Web Build
