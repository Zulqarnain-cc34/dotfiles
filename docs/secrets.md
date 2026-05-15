# Secrets & history purge

## New machine

```bash
./setup.sh --backup
# optional local git identity:
cp .gitconfig.example .gitconfig   # edit name/email
```

## validate.sh

| Command | Use |
|---------|-----|
| `./scripts/validate.sh` | Fast: index + staged gitleaks |
| `./scripts/validate.sh --history` | Full history (~minutes) |
| `./scripts/validate.sh --full` | Working tree (~60s) |

Gitleaks showing the logo with no output for ~60s on `--full` is normal.

## Re-purge (if sensitive files return)

```bash
./scripts/purge-history.sh --dry-run
./scripts/purge-history.sh --execute   # type YES
./scripts/validate.sh --history
git push --force-with-lease ssh main
```