---
name: dragonruby-kanban-developer
description: Standard workflow for Ruby & DragonRuby developers to pull Ready to Dev issues from Kanban Board, update status to In Progress, create feature/ddd-[issue] branch, code to ACs, write Unit Tests, create technical docs, open PR linked to Issue, and update Kanban status to PR.
---

# DragonRuby & Ruby Kanban Feature Development Workflow

This skill outlines the step-by-step procedure for a Ruby / DragonRuby Developer responsible for picking issues from a Kanban board and taking them through implementation, unit testing, documentation, pull request creation, and board column updates.

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
- Write modular Ruby code adhering to DragonRuby GTK conventions:
  - Decouple entity/game logic into `app/[component].rb` (e.g., `app/player.rb`).
  - Keep `app/main.rb` focused on main game loop (`tick args`), rendering, and input events.
- Perform syntax validation:
  ```bash
  ruby -c app/main.rb && ruby -c app/[component].rb
  ```

### 4. Write Unit Tests (MANDATORY)
- **MUST write unit tests for every feature or component change** under `test/test_[component].rb`.
- Cover initialization, state updates, edge cases, and calculations.
- Run unit tests and ensure zero failures/errors:
  ```bash
  ruby test/test_dragonruby_game.rb
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
