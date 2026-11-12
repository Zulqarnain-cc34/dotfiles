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
- `transmission-daemon/settings.json` (the real file — it carries an `rpc-password` hash once generated; only `settings.json.example` is tracked)

Use `scripts/bootstrap-secrets.sh` to initialize machine-specific secrets. It copies `.example` templates into their real, gitignored paths — currently `.gitconfig`, the rofi ribbon colour theme, and `transmission-daemon/settings.json`.

## Gitleaks

Run a staged-content scan before committing:

```bash
gitleaks protect --staged --config .gitleaks.toml
