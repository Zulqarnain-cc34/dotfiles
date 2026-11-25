---
name: merge-pr
description: Squash-merge a PR for this repo the way CLAUDE.md's Git workflow requires -- deliberate subject/body, delete-branch, sync local main. Only runs on an explicit /merge-pr.
disable-model-invocation: true
---

Merging is the one Git step that always needs the user's explicit go-ahead (see `CLAUDE.md`'s Git workflow section) -- that's why this skill never starts itself. It only runs when the user types `/merge-pr <number>` (or just `/merge-pr` if there's exactly one open PR and it's unambiguous which one they mean).

1. **Confirm which PR.** If a number was given, use it. If not and there's exactly one open PR (`gh pr list --state open`), use that one. If there's more than one and the user didn't say which, ask -- don't guess.

2. **Check it's actually ready.** `gh pr view <n> --json mergeable,mergeStateStatus,statusCheckRollup`. If `mergeable` or the state is still `UNKNOWN` (GitHub computing it async), wait ~10-15s and recheck, up to a few times. Don't attempt the merge while checks are still running or mergeability is unresolved.

3. **Write the squashed commit's subject and body deliberately** -- never accept GitHub's auto-concatenated default. Read the PR's actual commits/diff if the branch had a real multi-step story (a bug found, then root-caused, then fixed), so the one commit that survives onto `main` keeps that story instead of flattening it. Same voice as `CHANGELOG.md`: bold tool/module names, plain language, no mechanism/internals, no "Summary" heading. Conventional Commits prefix on the subject (`feat:`, `fix:`, `chore:`, `docs:`, `refactor:`, `style:`, `test:`, `build:`). No em dashes, no AI-sounding language, reads like a person wrote it -- and never a "Generated with Claude Code" / "Co-Authored-By Claude" footer.

4. **Merge**: `gh pr merge <n> --squash --delete-branch --subject "<subject>" --body "<body>"`. `--delete-branch` removes both the remote and local branch in one step.

5. **Sync local `main` immediately**, not batched for later: `git checkout main && git pull origin main`.

6. **Report back** with the PR's link and a one-line summary of what landed, same as the rest of the session's PR-referencing style.

If the merge fails (conflicts, a check turned red since step 2, branch protection rejecting it), stop and surface the actual error -- don't retry with `--admin` or force anything through.
