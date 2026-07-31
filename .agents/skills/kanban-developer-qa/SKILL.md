---
name: kanban-developer-qa
description: Standard process workflow for Developers and Tech Lead / QA to pick Ready to Dev issues from Kanban Board, manage branches, implement features, write automated unit tests, create technical docs, open PRs linked to Issues, and perform strict QA audits.
---

# Kanban Feature Development & Tech Lead / QA Review Process

This skill defines the standard process workflow for Developers and Tech Lead / QA engineers working on Kanban-based feature development, quality assurance, code review, and board management.

---

## 🚀 Part 1: Developer Workflow (Step-by-Step)

### 1. Pick Issue & Update Board to `In Progress`
- Identify issues from the Kanban board in the `Ready to Dev` column.
- Update the issue status/label to **`In Progress`** using GitHub MCP (`issue_write` with `labels: ["In Progress"]`).

### 2. Create Feature Branch
- Feature branch naming format **MUST** follow:
  ```bash
  feature/ddd-[issue_number]
  ```
  *(Example: `feature/ddd-7` for Issue #7)*
- Create the branch locally (`git checkout -b feature/ddd-[issue_number]`) or remotely (`create_branch`).

### 3. Implement Feature Code
- Write clean, modular, and maintainable code adhering to the project's established conventions.
- Strictly satisfy all Acceptance Criteria (AC) specified in the issue and design documents.

### 4. Write Automated Unit Tests (MANDATORY)
- Every feature or component change **MUST** include automated unit tests.
- Cover component initialization, logic updates, edge cases, state management, and calculations.
- Execute unit tests and ensure zero failures and zero errors before proceeding.

### 5. Create Technical Documentation
- Create or update documentation under `.docs/[feature-name]/`:
  - Requirement spec: `.docs/[feature-name]/requirement.md`
  - Technical spec: `.docs/[feature-name]/technical.md`
- The Technical Specification must include:
  - Architectural Overview & File Structure.
  - Component details (classes, interfaces, attributes, methods).
  - Sequence / Data Flow Diagram (using Mermaid syntax).
  - Unit Test Results & Real Manual Testing Steps.

### 6. Commit, Push & Create Pull Request
- Commit changes using clean, conventional commit messages:
  ```bash
  git commit -m "feat: description (#issue_number)"
  ```
- Push changes to the remote branch (`push_files` or `git push`).
- Open a Pull Request from `feature/ddd-[issue_number]` into `main` using `create_pull_request`.
- PR description **MUST** include:
  - Solution summary & key changes.
  - Automated unit testing verification results.
  - Closing keywords: `Fixes #[issue_number]`, `Closes #[issue_number]`, or `Resolves #[issue_number]`.
  - Real manual testing instructions (วิธีการทดสอบเล่นจริง).
- Add an explicit cross-referencing comment on the issue using `add_issue_comment`.
- Update issue status label to **`PR`** using `issue_write(labels: ["PR"])`.

---

## 🔍 Part 2: Tech Lead / QA Review Workflow

When reviewing Pull Requests, Tech Lead / QA MUST perform a strict multi-dimensional audit:

### 1. Functional & Acceptance Criteria (AC) Verification
- Cross-reference PR implementation against `.docs/[feature-name]/requirement.md` and the linked GitHub Issue.
- Confirm every single AC bullet point is fully satisfied and tested.

### 2. Strict Architectural Integrity Audit (Single Source of Truth)
- **Single Source of Truth**: Reject PRs that introduce dual-codebase maintenance (e.g., duplicate logic in parallel languages or inline script strings inside CI configuration files). All logic must reside strictly in the primary project codebase.
- **No Fragile Abstractions**: Reject custom string regex transpilers or unmaintainable code generation shortcuts.

### 3. Dead Code & Legacy Cleanup
- Verify that obsolete entrypoints, deleted directories, and unneeded legacy test files are cleaned up during refactoring or migrations.

### 4. Documentation & Repository Hygiene
- Verify that `README.md` and project documentation are kept in sync with active run, build, and test commands.
- Ensure build outputs, temporary artifacts, and large binary/zip files are listed in `.gitignore` and not tracked in git.

### 5. Review Decision & Board Status Update
- **If issues exist**: Submit a **🛑 REQUEST CHANGES** review comment with itemized actionable feedback, and set the Issue label back to **`In Progress`**.
- **If all checks pass**:
  - Check off `[x]` completed checklist items in the Issue body using `issue_write`.
  - Update Issue status label to **`Testing`** using `issue_write(labels: ["Testing"])`.
  - Submit QA Review **PASSED & APPROVED** comment on the PR using `pull_request_review_write`.
