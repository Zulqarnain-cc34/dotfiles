# Working rules for Claude on this repo

These are standing rules for this repo, set by the user across sessions — the record that survives if a chat is lost, since it auto-loads whenever Claude Code opens this repo.

<!-- This file is a reusable starting point for a new solo-maintainer repo.
     Add project-specific sections (repository conventions, environment
     quirks, etc.) as real conventions actually come up — don't pre-declare
     empty headings for them. Everything below is a default that has worked
     well across repos; keep it unless a real reason shows up to change it. -->

## Git workflow

- **GitHub Flow (one branch, PR-only), not Git Flow (`develop`/`release` branches)** — `main` is the only long-lived branch. No `develop`/integration branch.
- **Every change gets a branch off `main`, a PR, and a squash-merge back into `main` — no exceptions for small changes.** A one-word fix is just a one-line-diff PR that merges in seconds, not a reason to skip the branch/PR.
- **Flow**: `git checkout -b <type>/<name>` off `main` → commit → push → open a PR → squash-merge (`gh pr merge --squash`). `<type>` is whichever Conventional Commits type the change is (`feat/<name>`, `fix/<name>`, `chore/<name>`, `docs/<name>`, etc. — same list as the commit-prefix rule below). Branch deletion is automatic (repo setting) — no manual cleanup step needed.
- **Repo is configured to only allow squash-merge** (merge commits and rebase-merge disabled at the repo level, `gh api repos/<owner>/<repo> -X PATCH -f allow_merge_commit=false -f allow_rebase_merge=false -f allow_squash_merge=true`) — one clean commit per PR on `main`, every time, enforced by GitHub itself rather than relying on remembering the right flag.
- **Write the squashed commit's message deliberately** (`gh pr merge --squash --subject ... --body ...`) — don't accept GitHub's auto-concatenated default. For a branch with a real multi-step story, the default would flatten that narrative; a message written on purpose doesn't. The squashed subject uses a Conventional Commits prefix too — it's the one commit that survives onto `main`, so skipping the prefix here would mean `main`'s history has none at all.
- **Commits within a branch should be atomic** — one logical change each, and each one should leave the repo working. If a commit message needs "and," that's the signal to split it into two.
- **Commit messages use Conventional Commits prefixes** (`feat:`, `fix:`, `chore:`, `docs:`, `refactor:`, `style:`, `test:`, `build:`) — e.g. `fix: restore keyboard repeat rate after udev re-add`. Picked over an ad-hoc module-name prefix because the type is a fixed, external list (no per-commit judgment call), and it's the convention real tooling (changelog generators, semantic versioning) expects if this repo ever adopts any.
- **The text after the prefix stays short, natural, human** — no em dashes, no AI-sounding language. The Conventional Commits prefix is the only structured part; everything after the colon reads like a person wrote it. **Never add** a "Generated with Claude Code" / "Co-Authored-By Claude" footer — in commits or PRs, unless the user's own tooling requires it.
- **A *finished* PR shouldn't sit open indefinitely — merge promptly once it's actually ready.** This doesn't apply to a PR that's still genuinely being worked on (e.g. actively debugging a real issue) — staying open while real iteration is happening is normal, not something to rush. And it's about *scope*, not *count* or *autonomy*: don't let a finished PR's scope grow while it sits open, not that only one PR can be open at a time, and not that merging itself becomes automatic.
- **Independent tasks get independent PRs, opened in parallel — this is normal, not an exception**, even solo with no second reviewer. Branch off `main` for each separate task; don't queue unrelated work behind whatever PR happens to be open, and don't fold new unrelated work into an already-open PR's scope either.
- **If a genuinely in-scope follow-up commit gets pushed to an already-open PR** (true continuation of what it already describes), update its title/description to match and say so with a short PR comment (`gh pr comment`) noting what changed. Unrelated new work never gets folded in this way — it gets its own PR per the rule above.
- **Follow-up comments use the same short, natural voice as commit messages.** A sentence or two saying what changed is enough.
- **Do this autonomously** — create branches, commit, push, and open the PR without asking each time; opening a PR is just the normal next step once a branch's work is done. **Merging is the one step that always needs the user's explicit go-ahead, every time, not just the first** — never merge a PR just because it was opened or because checks passed.
- **`main` protection**: PR required (0 mandatory approvals — no second collaborator exists on this repo), passing CI [FILL IN: name the actual required checks once set up], no force-push/deletion, enforced on admins — nobody, including the repo owner, can push straight to `main`. "Require branches to be up to date before merging" is a judgment call: fine to leave off at small scale (avoids resync friction), worth turning on once CI genuinely needs to see the merged state.
- **Write PR titles and descriptions yourself, always** — a specific, feature-oriented title; body bullets grouped by component. No "Summary" heading, no testing section. **PR descriptions follow the same voice as `CHANGELOG.md`** (bold tool/component names, plain language, no mechanism/internals).

## Changelog

- `CHANGELOG.md`: one dated heading per day, not per commit/PR/branch. A few short, high-level bullets, no `Added/Fixed/Removed` subsections, no file paths, no "verified via X" detail — that belongs in commit messages.
- **Never use a relative-time heading** like "Today's session, in short" — write a real, specific heading from the start.
- **Genuinely** small fixes don't get their own bullet — only substantial things earn one. If a whole day has nothing but one small fix, skip the day entirely rather than giving it its own heading.
- **One component = one bullet, even for a big feature** — fold it into that day's existing bullet as a 2-5 word noun phrase, never explaining how/why (no mechanism, config keys, file names). One-breath test: if you can't read it in one breath, cut it.
- Bold every software/tool/component name. Don't bold generic nouns.
- **Heading = the day's 1-2 biggest topics only**, short noun phrases, comma-separated — not every bullet, not chronological. Cap at ~4 title slots; group smaller related items together past that point rather than listing every single one.

## CLAUDE.md hygiene

- Keep only actionable, prescriptive rules, not work history — that belongs in `git log`/`CHANGELOG.md`. Prune entries that drift into narrative.
- Update rules as real working practices change; remove outdated guidance.
- Never store identifying account names, tokens, or secrets here — describe the mechanism generically and point at the real (gitignored) config file for the real values.

## Verification discipline

- Don't assert behavior from a label, comment, or assumption alone — trace the real mechanism or test it, every time.
- For a fast-moving tool's config/API, pin to the exact installed version's docs/tag, never `main`/`latest`. Live-test regardless of what the docs say.
- If a screenshot or visual-capture tool in this environment turns out unreliable, don't trust it blindly — cross-check with a direct command/process-state check, or ask the user to look themselves when pixel-level confirmation is truly needed.
- Close test processes right after confirming. Check for an existing instance before killing by name/pattern, to avoid taking down the user's real session.
- Test through the real invocation path, not an isolated/simulated one — a fix can look clean under a synthetic test but leak through the real trigger (a different parent process, different cleanup hooks, a different shell).
- Test burst-driven behavior with a realistic burst, not a single event.

## When a fix doesn't work, or makes it worse

- Revert cleanly to the last known-good state before trying again — never stack a second fix on an unproven first one.
- Treat a user report of "this used to work" as a real regression signal, not "needs more debugging on the current approach."
- Own mistakes plainly — state what broke and why, don't minimize or bury it.
