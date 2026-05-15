#!/usr/bin/env bash
# Quick sanity checks (non-destructive).
#   ./scripts/validate.sh           fast: index + staged gitleaks
#   ./scripts/validate.sh --history full git history (slow)
#   ./scripts/validate.sh --full    working tree scan (often ~60s)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
errors=0
HISTORY_SCAN=false
FULL_SCAN=false

for arg in "$@"; do
    case "$arg" in
        --history) HISTORY_SCAN=true ;;
        --full)    FULL_SCAN=true ;;
        -h|--help)
            echo "Usage: $0 [--history] [--full]"
            exit 0
            ;;
        *) echo "Unknown option: $arg" >&2; exit 1 ;;
    esac
done

ok()   { echo "  OK: $*"; }
warn() { echo "  WARN: $*"; }
fail() { echo "  FAIL: $*"; errors=$((errors + 1)); }

# Paths purged from history — must never return to git
SECRET_PATH_RE='(client_secrets\.json|credentials\.json|\.mutt/accounts/|^\.w3m/cookie$|^\.w3m/history$|polybar/gmail/)'

echo "==> Optional templates (for new machines / .gitconfig)"
for f in .gitconfig.example; do
    [[ -f "$f" ]] && ok "$f" || warn "missing $f (optional)"
done

echo "==> High-sensitivity paths must not be tracked"
tracked_secrets=0
while IFS= read -r path; do
    if [[ -n "$path" ]]; then
        fail "tracked sensitive path: $path"
        tracked_secrets=1
    fi
done < <(git ls-files 2>/dev/null | grep -E "$SECRET_PATH_RE" || true)
[[ "$tracked_secrets" -eq 0 ]] && ok "no purged sensitive paths in git index"

echo "==> Tracked config files"
for f in newsboat/urls transmission-daemon/settings.json; do
    git ls-files --error-unmatch "$f" &>/dev/null && ok "$f tracked" || warn "$f not in git"
done

echo "==> Tool checks"
if command -v nvim >/dev/null; then
    nvim --headless "+qa" 2>/dev/null && ok "nvim config loads" || warn "nvim headless check failed"
else
    warn "nvim not installed"
fi

if command -v polybar >/dev/null && [[ -f polybar/config.ini ]]; then
    polybar -m >/dev/null 2>&1 && ok "polybar -m" || warn "polybar -m failed"
fi

if command -v gitleaks >/dev/null && [[ -f .gitleaks.toml ]]; then
  if $HISTORY_SCAN; then
    echo "==> Gitleaks full git history (slow)"
    echo "  (can take several minutes; Ctrl+C to abort)"
    set +e
    timeout 600 gitleaks detect --config .gitleaks.toml --verbose 2>&1
    gl_exit=$?
    set -e
    [[ "$gl_exit" -eq 0 ]] && ok "gitleaks history clean" || warn "gitleaks history findings or timeout — see docs/secrets.md"
  else
    echo "==> Gitleaks (staged only — fast)"
    if git diff --cached --quiet 2>/dev/null; then
        ok "no staged changes"
        echo "  tip: ./scripts/validate.sh --history"
    else
        set +e
        gitleaks protect --staged --config .gitleaks.toml --verbose 2>&1
        [[ $? -eq 0 ]] && ok "gitleaks staged clean" || warn "gitleaks flagged staged content"
        set -e
    fi
  fi

  if $FULL_SCAN; then
    echo "==> Gitleaks working tree (often ~60s)"
    set +e
    timeout 300 gitleaks detect --source . --no-git --config .gitleaks.toml --verbose 2>&1
    gl_exit=$?
    set -e
    [[ "$gl_exit" -eq 0 ]] && ok "working tree clean" || warn "working tree findings — see docs/secrets.md"
  fi
else
    warn "gitleaks or .gitleaks.toml missing"
fi

echo "==> Summary"
if [[ "$errors" -gt 0 ]]; then
    echo "FAILED with $errors error(s)"
    exit 1
fi
echo "All checks passed (warnings are informational)."
