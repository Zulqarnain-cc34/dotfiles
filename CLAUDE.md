# Working rules for Claude on this repo

These are standing rules for working on this dotfiles repo, set by the user across sessions. They apply regardless of which conversation you're in — if a chat is lost, this file is the record that survives, since it loads automatically whenever Claude Code opens this repo.

## Git workflow

- **Branch model:** `main` is stable, only receives reviewed PRs. `develop` is the standing integration branch (renamed from `modernize-2026`). Feature work goes on `feat/<name>` (or `fix/<name>`) off `develop`.
- **The loop:** branch off `develop` → commit → merge back into `develop` → **delete the feature branch** (local + remote) → periodically open a PR `develop → main` and merge it.
- **Do this autonomously.** The user authorized running `git`/`gh` (branches, PRs, merges, deletes) without asking each time. Decide reasonable, reversible workflow/config choices yourself (e.g. "does branch protection apply to just `main` or both branches") rather than pausing to ask — reserve actual questions for things that are destructive, hard to reverse, or genuinely ambiguous about the user's *intent*.
- **The remote is named `ssh`, not `origin`.** Use `git push ssh <branch>`; upstreams are `ssh/<branch>`. A local `main`/`develop` ref can go stale — compare against `ssh/main`/`ssh/develop`.
- **`main` has branch protection:** PR required (0 mandatory approvals — no second collaborator exists on this repo), `validate` + `gitleaks` CI checks must pass, no force-push, no deletion, enforced on admins too. `develop` is intentionally unprotected so `feat/*` merges stay fast (direct local merge + push, no PR needed there).
- **PR title + description:** write these yourself, always. Title: a specific, feature-oriented one-liner. Body: feature-related bullets grouped by area/component. No "Summary" heading, no testing/verification section — just what was built.
- **GitHub CLI accounts:** `Zulqarnain-cc34` is the default `gh` identity everywhere. A zsh `chpwd` hook in `zsh/.zshrc` auto-switches to `precise456` inside `project_penny` (and subdirectories) and reverts on `cd` out.

## Commit style

- No em dashes. Short, compact, humanized — plain sentences, no AI-sounding flourishes.
- Never add a "Generated with Claude Code" / "Co-Authored-By Claude" footer to commits or PRs.

## CHANGELOG.md

- One high-level entry per **day**, not per commit/PR/branch. A handful of plain bullets — what got done, in a sentence each.
- No `### Added/Fixed/Removed` sub-sections, no file paths, no "verified via X" detail in the changelog itself — that level of detail belongs in the commit messages, which are already written with real reasoning. Don't duplicate it here.
- The file's own "Notes" section at the bottom already states this policy — follow it from the start rather than writing a detailed entry and condensing later.

## Verification discipline

- **Don't assert behavior from a label, comment, or assumption alone.** Trace the real mechanism or test it, every time — a `desc` string, a config comment, or "X probably renders this" is not verification.
- **When researching a fast-moving tool's config/API** (yazi, etc.), pin to the exact installed version's git tag, never the `main`/`master` branch — `main` can be ahead of what's actually installed. Live-test the result regardless of what the docs say.
- **Never use X11 window-screenshot capture on this machine.** It has repeatedly captured the wrong window's content (real, sensitive desktop content, unrelated to the target) even after verifying window ID/PID/name immediately before and after the capture — the failure isn't reuse or a race, something deeper is desynced. Use `tmux capture-pane -p` (text) or direct command/process-state verification instead. If pixel-level visual confirmation is genuinely required, say so plainly and ask the user to check themselves.
- When live-testing GUI apps, close each spawned window/process right after confirming — don't batch-kill at the end. Before killing any process by name/pattern, check it isn't the user's real, already-running session (`pgrep` first) — don't assume a matching process is yours just because you expect one to exist.
