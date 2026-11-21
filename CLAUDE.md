# Working rules for Claude on this repo

These are standing rules for this dotfiles repo, set by the user across sessions — the record that survives if a chat is lost, since it auto-loads whenever Claude Code opens this repo.

## Git workflow

- `main` is stable, reviewed-PRs only. `develop` is the integration branch. Feature work goes on `feat/<name>` (or `fix/<name>`) off `develop` → commit → merge into `develop` → delete the branch (local + remote). Periodically PR `develop → main` and merge.
- **Skip the branch for trivial one-liners** (changelog wording, bolding, heading trims) — commit straight to `develop`, which is unprotected for exactly this and reviewed by nothing anyway. Use the full branch workflow for real features/fixes: real logic, multiple files, or anything worth reverting as one unit.
- **Do this autonomously for branch/commit work** — create branches, commit, and push without asking each time. **PRs and merges are different: only open a PR or merge one when the user explicitly asks for it** (not automatically right after finishing a change) — and even then, confirm with the user before actually merging, every time, not just the first.
- Remote is `ssh`, not `origin`. Push with `git push ssh <branch>`; upstreams are `ssh/<branch>`. Compare against `ssh/main`/`ssh/develop`, not potentially stale local refs.
- `main` protection: PR required (0 mandatory approvals — no second collaborator exists on this repo), passing `validate` + `gitleaks`, no force-push/deletion, enforced on admins. `develop` is intentionally unprotected so `feat/*` merges stay fast.
- Write PR titles and descriptions yourself, always — a specific, feature-oriented title; body bullets grouped by component. No "Summary" heading, no testing section. **PR descriptions follow the same voice as `CHANGELOG.md`** (bold tool names, plain language, no mechanism/internals) — commit messages are where the full technical detail (root cause, what was tried, why) belongs.
- **Keep `develop → main` PRs small and single-purpose — once one is open, merge it promptly rather than leaving it open to absorb whatever comes next.** This holds even solo, with no second reviewer: small PRs stay easy to review, safe to revert as one unit, and keep history bisectable — the value isn't about having someone else look at it, it's a self-review checkpoint before anything reaches `main`. (Confirmed against real-world guidance, not just general instinct: https://artsy.github.io/blog/2021/03/09/strategies-for-small-focused-pull-requests/, https://dev.to/armorbreak/the-git-workflow-that-actually-works-for-solo-developers-2026-2mna.) If new, unrelated work starts on `develop` while a PR is already open, it queues for the *next* PR after the current one merges — it does not get folded into the open one. Only update an open PR's title/description for commits that are genuinely part of what it was already describing (e.g. a follow-up fix to the same bug), never to cover unrelated new work. Trivial one-liners (changelog wording, heading trims) are exempt from needing their own PR — they ride along with whichever real PR happens to contain them, same as they're exempt from needing their own branch.
- GitHub CLI: the repo owner's account is the default `gh` identity everywhere; a zsh `chpwd` hook in `zsh/.zshrc` switches to a different one inside `project_penny` (reverts on `cd` out) — see `zsh/.zshrc` for real names, never hardcode them elsewhere.

## Commits and changelog

- Commit messages: short, natural, human. No em dashes, no AI-sounding language. **Never add** a "Generated with Claude Code" / "Co-Authored-By Claude" footer — in commits or PRs.
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
