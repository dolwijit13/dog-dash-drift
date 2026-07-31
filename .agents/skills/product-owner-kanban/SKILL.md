---
name: product-owner-kanban
description: Standard workflow and responsibilities for a Product Owner (PO), breaking down EM project vision into atomic GitHub Issues, maintaining .docs/ feature specifications, and managing Kanban Backlog.
---

# Product Owner (PO) Standard Workflow

Skill นี้รวบรวมแนวทางและกระบวนการทำงานของ **Product Owner (PO)** ในการรับวิสัยทัศน์โปรเจกต์จาก EM (Engineering Manager) เพื่อย่อยเป็น Documentation และ GitHub Issues เข้าสู่ Kanban Backlog

---

## 🎯 1. Core Responsibilities

1. **รับ Vision / Features จาก EM**: แปลงไอเดียภาพรวมของ EM ให้เป็นข้อกำหนดและ Tasks ที่ทีมพัฒนาสามารถนำไปทำต่อได้ทันที
2. **สร้าง & อัปเดต Documentation**: จัดเก็บสเปกฟีเจอร์ไว้ภายใต้ `.docs/` ซึ่งถือเป็น **Single Source of Truth** ของโปรเจกต์
3. **แตก GitHub Issues (Backlog)**: สร้าง Issue บน GitHub ด้วยโครงสร้างที่ชัดเจน Atomic และรอบด้าน
4. **บริหารจัดการ Kanban Board**: ตรวจสอบสถานะ ปรับปรุงเนื้อหา Issue เมื่อมีการเปลี่ยนแปลงสถาปัตยกรรม (เช่น Migration) และปิด Issue ที่สำเสร็จหรือถูกยกเลิกด้วยเหตุผลที่ชัดเจน

---

## 📁 2. Documentation Structure Standard (`.docs/`)

ให้ใช้โครงสร้างไดเรกทอรีเอกสารย่อยตามชื่อ Feature ดังนี้:

```text
.docs/
├── main.md                                   # เอกสารภาพรวมโปรเจกต์ (Overview, Theme, Architecture, Feature Links, Directory Map)
├── [feature-name-1]/
│   ├── requirement.md                        # ข้อกำหนดของฟีเจอร์ (User Story, AC, Technical Checklist)
│   └── technical.md                          # (Optional) รายละเอียดเทคนิค/สถาปัตยกรรมเชิงลึก
└── [feature-name-2]/
    └── requirement.md
```

### การอัปเดต `.docs/main.md`
ทุกครั้งที่มีการเพิ่ม Feature ใหม่ หรือปรับเปลี่ยนสถาปัตยกรรม (เช่น ย้ายเอนจินเกม):
- ต้องเพิ่ม/อัปเดตลิงก์อ้างอิงไปยัง `.docs/[feature-name]/requirement.md` ใน `main.md`
- อัปเดตแผนผัง Directory Structure ใน `main.md` ให้ตรงกับความจริง

---

## 📝 3. GitHub Issue Format Standard

ทุก Issue ที่สร้างขึ้นต้องมีโครงสร้าง 3 ส่วนหลักดังนี้:

```markdown
## User Story
**As a** [ผู้ใช้งาน/ผู้เล่นเกม]  
**I want** [สิ่งที่ต้องการทำ/ฟีเจอร์ที่อยากได้]  
**So that** [คุณค่าหรือผลลัพธ์ที่ได้รับ]

---

## Acceptance Criteria (AC)
- [ ] **[Topic 1]**: เงื่อนไขและเกณฑ์การทดสอบเพื่อผ่านงานที่ชัดเจน
- [ ] **[Topic 2]**: เงื่อนไขเคสปกติและ Edge Cases

---

## Technical Checklist (Atomic)
- [ ] **1. Data Structure / Model Setup (`app/[module].rb`)**
  - [ ] ประกาศโครงสร้างข้อมูลและตัวแปรที่จำเป็น
- [ ] **2. Feature Logic & Interoperability**
  - [ ] พัฒนาฟังก์ชันการทำงานหลัก และระบบตรวจจับ/จัดการ Event
- [ ] **3. Verification & Web Export Check**
  - [ ] ทดสอบความถูกต้องบนเครื่อง และตรวจสอบความสมบูรณ์บน Browser (Web Build)

---
*Specification Link:* [.docs/[feature-name]/requirement.md](file://.docs/[feature-name]/requirement.md)
```

---

## 🔄 4. Migration & Backlog Maintenance Protocol

เมื่อมีการเปลี่ยนแปลงทางเทคนิคครั้งใหญ่ (เช่น การเปลี่ยน Framework/Engine):
1. **สร้าง Migration Document**: เขียนสเปกย้ายระบบใน `.docs/[migration-name]/requirement.md`
2. **เปิด Migration Issue**: สร้าง Issue ประเภท `[Architecture/Migration]`
3. **อัปเดต Open Issues**: ตรวจสอบ Issues ทั้งหมดใน Backlog ที่ยังไม่ปิด แล้วปรับเปลี่ยนคำอธิบายและ Technical Checklist ให้สอดคล้องกับเอนจิน/เครื่องมือใหม่
4. **ปิด Issue ที่ยกเลิก/ซ้ำซ้อน**: ปิด Issue ที่ไม่ได้ใช้งานแล้ว (เช่น deployment รูปแบบเก่า) พร้อมใส่เหตุผลและ Comment อธิบายอย่างชัดเจน

---

## 🚀 5. Git & Push Operations

- เมื่อสร้างหรือแก้ไขเอกสารเรียบร้อยแล้ว ให้ทำการ Commit ลงใน Repository
- ให้ทำการ Push ข้อมูลขึ้น GitHub Remote (`main` branch) โดยใช้ GitHub MCP Server (`push_files`) หรือ Git Command เพื่อให้ข้อมูลบน Remote ล่าสุดเสมอ
