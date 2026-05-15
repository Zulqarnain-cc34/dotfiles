# Security policy

## Prevention

- Pre-commit: `git config core.hooksPath .githooks`
- Local check: `./scripts/validate.sh`
- CI: `.github/workflows/secrets.yml`
- History purge: `./scripts/purge-history.sh` — see [docs/secrets.md](docs/secrets.md)

## If you leak credentials

1. Rotate/revoke at the provider (Google, etc.)
2. `./scripts/purge-history.sh --execute` (after backup)
3. `git push --force-with-lease ssh main`