---
name: gosu-kanban-developer
description: Standard workflow for Ruby & Gosu developers to pull Ready to Dev issues from Kanban Board, update status to In Progress, create feature/ddd-[issue] branch, code to ACs, write Unit Tests, create technical docs, open PR linked to Issue, and update Kanban status to PR.
---

# Gosu & Ruby Kanban Feature Development Workflow

This skill outlines the step-by-step procedure for a Ruby / Gosu Developer responsible for picking issues from a Kanban board and taking them through implementation, unit testing, documentation, pull request creation, and board column updates.

## Workflow Overview

### 1. Pick Issue & Update Board to `In Progress`
- Identify issues from the Kanban board in the `Ready to Dev` column.
- Before starting implementation, update the issue status/label to **`In Progress`** using GitHub MCP tool (`issue_write` with `labels: ["In Progress"]`).

### 2. Create Feature Branch
- Feature branch naming format **MUST** follow:
  ```bash
  feature/ddd-[issue_number]
  ```
  *(Example: `feature/ddd-1` for Issue #1)*
- Create the branch locally (`git checkout -b feature/ddd-[issue_number]`) and push to remote.

### 3. Implement Feature Code
- Write modular Ruby code adhering to Gosu game engine conventions:
  - Decouple entity/game logic into `lib/[component].rb` (e.g., `lib/player.rb`).
  - Keep `main.rb` (`GameWindow`) focused on window management, main game loop (`update`, `draw`), and input events.
- Perform syntax validation:
  ```bash
  ruby -c main.rb && ruby -c lib/[component].rb
  ```

### 4. Write Unit Tests (MANDATORY)
- **MUST write unit tests for every feature or component change** under `test/test_[component].rb`.
- Cover initialization, state updates, edge cases, and calculations.
- Handle headless GUI testing gracefully by rescuing `LoadError` or mocking Gosu rendering methods if necessary.
- Run unit tests and ensure zero failures/errors:
  ```bash
  ruby -Ilib:test test/test_[component].rb
  ```

### 5. Create Technical Documentation
- Maintain documentation under `.docs/[feature-name]/`:
  - Requirements: `.docs/[feature-name]/requirement.md`
  - Technical Spec: `.docs/[feature-name]/technical.md`
- Technical Specification structure must include:
  - Architectural Overview & File Structure.
  - Component details (constants, attributes, methods).
  - Sequence/Data Flow Diagram (Mermaid syntax).
  - Unit Test Results & Manual Testing & Verification Steps.

### 6. Commit & Push Code
- Commit changes using clean, conventional commit messages:
  ```bash
  git commit -m "feat: short description (#issue_number)"
  ```
- Push files to remote branch using Git or GitHub MCP tools (`create_or_update_file` / `push_files`).

### 7. Create Pull Request & Link to Issue
- Create PR from `feature/ddd-[issue_number]` into `main` using GitHub MCP (`create_pull_request`).
- PR Body MUST include:
  - Solution summary & key changes.
  - Unit test verification confirmation.
  - Closing keywords: `Fixes #[issue_number]`, `Closes #[issue_number]`, `Resolves #[issue_number]` for automatic GitHub issue linking.
  - Real manual testing steps (วิธีการทดสอบเล่นจริง).
- Add explicit cross-referencing comment on the issue using `add_issue_comment`.

### 8. Move Issue to Column `PR`
- Update issue status/label to **`PR`** using GitHub MCP (`issue_write` with `labels: ["PR"]`).
