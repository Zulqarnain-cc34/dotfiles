# Security policy

Do not commit credentials, OAuth tokens, mail account configs, or browser cookies. This repo uses gitignore rules, optional pre-commit hooks, and validation scripts to catch mistakes before push.

**Full policy:** [docs/secrets.md](docs/secrets.md) (what to keep local, bootstrap on new machines, gitleaks usage).

## Prevention

- Pre-commit: `git config core.hooksPath .githooks`
- Local check: `./scripts/validate.sh`
- CI: `.github/workflows/secrets.yml` (gitleaks + same validate script as local)
