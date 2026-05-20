# Local secrets policy

Keep credentials on the machine, not in git. This repo uses gitignore rules, pre-commit hooks, and `./scripts/validate.sh` to help with that.

## Do not track

- OAuth / API keys (`client_secrets.json`, `credentials.json`)
- `.mutt/accounts/`, `.gitconfig` (use `.gitconfig.example` locally)
- `.w3m/cookie`, `.w3m/history`

Forking this repo? Review before publishing: `newsboat/urls`, `transmission-daemon/settings.json`.

## Checks

```bash
git config core.hooksPath .githooks
./scripts/validate.sh
```

Optional full history scan: `./scripts/validate.sh --history`

## New machine

```bash
./setup.sh             # runs scripts/bootstrap-secrets.sh (creates local .gitconfig and ribbon colors.rasi from examples)
# Optional: ./setup.sh --backup  # backup existing targets before linking
# Edit .gitconfig name/email after bootstrap
```

See also [SECURITY.md](../SECURITY.md) and `.gitleaks.toml`.
