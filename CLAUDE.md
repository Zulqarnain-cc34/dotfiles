# Working rules for Claude on this repo

These are standing rules for this dotfiles repo, set by the user across sessions — the record that survives if a chat is lost, since it auto-loads whenever Claude Code opens this repo.

## Git workflow

*Rules below took effect 2026-11-21, replacing an older `develop`-based Git Flow setup and ad-hoc module-prefix commits — see `CHANGELOG.md`'s 2026-11-21 entry.*

- **GitHub Flow (one branch, PR-only), not Git Flow** — `main` is the only long-lived branch, no `develop`/`release` branches.
- **Every change gets its own branch off `main`, a PR, and a squash-merge — no exceptions for small changes.** A one-line fix is still a full branch+PR; it just merges in seconds. The repo only allows squash-merge (merge-commit and rebase-merge are disabled at the repo level) — one clean commit per PR on `main`, every time, enforced by GitHub itself.
- **Conventional Commits types**: `feat`, `fix`, `chore`, `docs`, `refactor`, `style`, `test`, `build`. One vocabulary used in three places — the branch name (`<type>/<name>`), each commit's prefix (`<type>: ...`), and the squashed subject that survives onto `main` — so it never needs a per-commit judgment call about what to call something.
- **Flow**: `git checkout -b <type>/<name>` off `main` → commit → push → open a PR → `gh pr merge --squash --delete-branch --subject "..." --body "..."`. Always write the subject/body yourself — never accept GitHub's auto-concatenated default; a branch with a real multi-step story deserves a message that keeps it, not one that flattens it.
- **After every merge, immediately sync local `main`**: `git checkout main && git pull origin main`, right away, not batched for later. `--delete-branch` already removed both the remote and local branch; `fetch.prune` is set globally so any stale remote-tracking ref still cleans itself up on the next `fetch`/`pull` too.
- **Commits within a branch should be atomic** — one logical change each, and each one should leave the repo working. If a commit message needs "and," that's the signal to split it into two.
- **Commit text after the prefix stays short, natural, human** — no em dashes, no AI-sounding language, reads like a person wrote it. **Never add** a "Generated with Claude Code" / "Co-Authored-By Claude" footer — in commits or PRs.
- **A finished PR gets merged promptly, not left open.** A PR still genuinely being worked on isn't "finished" yet — staying open while real iteration happens is normal. This is about not letting a *finished* PR's scope grow while it sits idle, not a cap on how many PRs can be open, and not a shortcut around the merge-approval rule below.
- **Independent tasks get independent PRs, opened in parallel — this is normal, not an exception**, even solo with no second reviewer. Branch off `main` for each separate task; don't queue unrelated work behind whatever PR happens to be open, and don't fold new unrelated work into an already-open PR's scope either.
- **When a sibling PR merges and leaves an open branch conflicting or stale against `main`**, rebase it: `git fetch origin main` → `git rebase origin/main` → resolve conflicts keeping the correct final content → re-run `scripts/validate.sh` → `git push --force-with-lease`. Safe here because these are private, unreviewed branches with no second collaborator.
- **A genuinely in-scope follow-up commit can go straight onto an already-open PR** (true continuation of what it already describes, e.g. a follow-up fix to the same bug) — update its title/description to match, and note it with a short `gh pr comment` in the same short, natural voice as a commit message. Unrelated new work always gets its own PR instead.
- **Always link a PR the moment it's opened, and reference follow-up commits by short SHA** — a clickable `[PR #N](url)` as soon as it exists, not just mentioned at merge time, keeps a visible trail back to exactly what changed and why throughout a session.
- **Do this autonomously** — create branches, commit, push, and open the PR without asking each time; opening a PR is just the normal next step once a branch's work is done. **Merging is the one step that always needs the user's explicit go-ahead, every time, not just the first** — never merge a PR just because it was opened or because checks passed.
- **`main` protection**: PR required (0 mandatory approvals — no second collaborator exists on this repo), passing `validate` + `gitleaks`, no force-push/deletion, enforced on admins — nobody, including the repo owner, can push straight to `main`. "Require branches to be up to date before merging" is deliberately off: at this repo's scale, the friction of resyncing every sibling PR each time one merges outweighs the risk it guards against, which running `validate.sh` locally before each merge already covers.
- **Write every PR's title and description yourself, always** — a specific, feature-oriented title; body bullets grouped by component. No "Summary" heading, no testing section. **PR descriptions follow the same voice as `CHANGELOG.md`** (bold tool names, plain language, no mechanism/internals).

## Changelog

- `CHANGELOG.md`: one dated heading per day, not per commit/PR/branch. A few short, high-level bullets, no `Added/Fixed/Removed` subsections, no file paths, no "verified via X" detail — that belongs in commit messages.
- **Never use a relative-time heading** like "Today's session, in short" — write a real, specific heading from the start.
- **Genuinely** small fixes don't get their own bullet (a restored dropped alias, a one-line tweak) — only substantial things earn one. If a whole day has nothing but one small fix, skip the day entirely rather than giving it its own heading.
- **One module = one bullet, even for a big feature** — fold it into that day's existing bullet as a 2-5 word noun phrase, never explaining how/why (no mechanism, config keys, file names). One-breath test: if you can't read it in one breath, cut it. Right: "...a do-not-disturb toggle, and clickable action buttons." Wrong: "...with mouse bindings reworked so a normal click does that instead of middle-click."
- Bold every software/tool/module name (`**dunst**`, `**polybar**`, `**Neovim**`, `**README**`). Don't bold generic nouns ("setup script", "idle timeout" stay unbolded).
- **Heading = the day's 1-2 biggest topics only**, short noun phrases, comma-separated — not every bullet, not chronological; smaller ones are fine left out since the bullets cover them. Keep phrases tight (shorter wins; drop filler like "overhaul"/"hardening"). Right: "fastfetch theme, newsboat audit" (from a 4-bullet day). Wrong: cramming in all 4, or padding with words that add nothing.

## CLAUDE.md hygiene

- Keep only actionable, prescriptive rules, not work history — that belongs in `git log`/`CHANGELOG.md`. Prune entries that drift into narrative.
- Update rules as real working practices change; remove outdated guidance.
- Never store identifying account names here (GitHub usernames, etc.) — describe the mechanism generically and point at the real config file (`zsh/.zshrc`) for the real names.

## Repository conventions

- Never commit compiled binaries — `scripts/validate.sh` hard-fails the build if it finds one. Build tools from source during `setup.sh` (follow `csakura/build.sh`'s pattern).
- csakura's patched source carries a matching `.patch` file (`csakura/csakura.src/*.patch`) documenting the upstream diff — historical only, not applied at build. When `csakura/csakura.src/src/csakura.c` changes, regenerate it via `git diff <pre-feature-commit>^ -- csakura/csakura.src/src/csakura.c`.
- Gitignore anything that could plausibly hold secrets, even untracked/unlinked (e.g. `gh/hosts.yml`).
- Prepend `bash_scripts/` onto `PATH` in `zsh/.zshenv` + `.profile`, never append — csakura's `-k` safety depends on this build winning over anything else named the same. Don't trust `echo $PATH` here (polluted inherited entries); verify with `env -i HOME="$HOME" TERM=xterm zsh -c '...'`.
- Dotfiles should only contain dotfiles — never vendor large third-party theme/asset bundles (SDDM themes, GTK themes, wallpapers) into this repo, even forked ones. Those live in a separate local-only `local/` directory next to this repo. Only the small selector config that picks one (e.g. `sddm/sddm.conf`'s `Current=`) belongs here, same split already used for Kvantum in `.gitignore`.

## Machine environment

- Audio: PulseAudio, not PipeWire. No Bluetooth audio.
- Daily desktop: bspwm/X11 only — no Wayland components in this repo.
- TUI/ncurses tools fail outright with no `TERM` set — export `TERM=xterm-256color` before any tmux-based TUI test.
- Never insert a raw ESC byte (`0x1b`) into **fastfetch**'s `config.jsonc` — go through Python (`json.load`/`json.dump(..., ensure_ascii=False)`) for ANSI colors.

## Verification discipline

- Don't assert behavior from a label, comment, or assumption alone — trace the real mechanism or test it, every time.
- For a fast-moving tool's config/API, pin to the exact installed version's git tag, never `main`/`master`. Live-test regardless of what the docs say.
- Never use X11 window-screenshot capture here — it's repeatedly grabbed the wrong window. Use `tmux capture-pane -p` or direct command/process-state checks; ask the user to look themselves if pixel-level confirmation is truly needed.
- Close GUI test processes right after confirming. Check `pgrep` before killing by name/pattern, to protect the user's real session.
- Test through the real invocation path, not an isolated/simulated one — a fix can look clean under a synthetic test but leak through the real trigger (a different parent process, different cleanup hooks).
- Test burst-driven behavior with a realistic burst, not a single event.

## When a fix doesn't work, or makes it worse

- Revert cleanly to the last known-good state before trying again — never stack a second fix on an unproven first one.
- Treat a user report of "this used to work" as a real regression signal, not "needs more debugging on the current approach."
- Own mistakes plainly — state what broke and why, don't minimize or bury it.
