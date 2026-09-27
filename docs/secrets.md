# Secrets

This repository contains configuration files intended to be safe to track in Git.

## Secret handling

Do not commit:

- `client_secrets.json`
- `credentials.json`
- `.mutt/accounts/`
- `.w3m/cookie`
- `.w3m/history`
- `polybar/gmail/`

Use `scripts/bootstrap-secrets.sh` to initialize machine-specific secrets.

## Gitleaks

Run a staged-content scan before committing:

```bash
gitleaks protect --staged --config .gitleaks.toml
