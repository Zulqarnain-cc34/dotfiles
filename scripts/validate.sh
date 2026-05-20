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

SECRET_PATH_RE='(client_secrets\.json|credentials\.json|\.mutt/accounts/|^\.w3m/cookie$|^\.w3m/history$|polybar/gmail/)'

echo "==> Required repo scripts and docs"
for f in scripts/bootstrap-secrets.sh scripts/validate.sh scripts/install-deps.sh docs/secrets.md docs/INSTALL.md scripts/host/README.md redshift/redshift.conf .aliases/aliases .aliases/functions; do
    [[ -f "$f" ]] && ok "$f" || fail "missing $f"
done

echo "==> packages/minimal.txt"
if [[ -f packages/minimal.txt ]]; then
    if grep -qx 'exa' packages/minimal.txt 2>/dev/null; then
        fail "packages/minimal.txt lists exa (use eza)"
    else
        ok "no exa in minimal.txt"
    fi
    for pkg in eza yazi fastfetch slock clipmenu; do
        grep -qx "$pkg" packages/minimal.txt 2>/dev/null && ok "minimal: $pkg" || fail "minimal.txt missing $pkg"
    done
else
    fail "missing packages/minimal.txt"
fi

echo "==> bash_scripts (~/bin/bash_scripts)"
for f in bash_scripts/urlportal.sh bash_scripts/random-wallpaper.sh bash_scripts/ytfzf \
         bash_scripts/notifytorrents bash_scripts/killandnotify; do
    if [[ -f "$f" ]]; then
        [[ -x "$f" ]] && ok "$(basename "$f") executable" || warn "$(basename "$f") not executable (chmod +x)"
    else
        fail "missing $f"
    fi
done
for f in bash_scripts/newsboat/dangerzone/bookmark.sh; do
    [[ -f "$f" ]] && ok "newsboat bookmark.sh" || warn "optional missing: $f (NEWSBOAT_BOOKMARKS)"
done

echo "==> Polybar scripts (active bar modules)"
if [[ -f polybar/config.ini ]]; then
    active_mods=""
    while IFS= read -r line; do
        active_mods+=" ${line#modules-* = }"
    done < <(grep -E '^modules-(left|center|right)' polybar/config.ini | sed 's/.*= //')
    poly_checked=0
    for mod in $active_mods; do
        exec_line=""
        for ini in polybar/config.ini polybar/modules.ini polybar/bars.ini polybar/user_modules.ini; do
            [[ -f "$ini" ]] || continue
            exec_line=$(awk -v m="$mod" '
                $0 ~ "^\\[module/" m "\\]" { in_mod=1; next }
                in_mod && /^\[/ { in_mod=0 }
                in_mod && /^exec(-if)?[[:space:]]*=/ {
                    sub(/^exec(-if)?[[:space:]]*=[[:space:]]*/, "")
                    gsub(/[[:space:]]+$/, "")
                    print
                    exit
                }
            ' "$ini")
            [[ -n "$exec_line" ]] && break
        done
        [[ -z "$exec_line" ]] && continue
        case "$exec_line" in
            *polybar/scripts/*|*\$HOME/.config/polybar/scripts/*|*~/.config/polybar/scripts/*)
                script_path="${exec_line//\$HOME/$HOME}"
                script_path="${script_path/#\~/$HOME}"
                script_path="${script_path%% *}"
                if [[ -f "$script_path" || -x "$script_path" ]]; then
                    ok "polybar module/$mod -> $(basename "$script_path")"
                else
                    fail "polybar module/$mod missing script: $script_path"
                fi
                poly_checked=1
                ;;
        esac
    done
    [[ "$poly_checked" -eq 0 ]] && ok "no script-backed modules on active bar (or all present)"
    grep -q 'check-network' polybar/config.ini polybar/*.ini 2>/dev/null && \
        fail "polybar still references removed check-network script" || ok "no check-network module reference"
else
    warn "polybar/config.ini missing"
fi

echo "==> Optional templates (for new machines / .gitconfig)"
for f in .gitconfig.example; do
    [[ -f "$f" ]] && ok "$f" || warn "missing $f (optional)"
done

echo "==> No hardcoded /home/alpha in tracked config files"
HARDCODED_EXCLUDE='^(README\.md|CHANGELOG\.md|scripts/validate\.sh|\.github/|docs/)'
if git ls-files | grep -Ev "$HARDCODED_EXCLUDE" | xargs grep -l '/home/alpha' 2>/dev/null | grep -q .; then
    while IFS= read -r f; do
        fail "hardcoded path: $f"
    done < <(git ls-files | grep -Ev "$HARDCODED_EXCLUDE" | xargs grep -l '/home/alpha' 2>/dev/null || true)
else
    ok "no /home/alpha in tracked configs"
fi

echo "==> High-sensitivity paths must not be tracked"
tracked_secrets=0
while IFS= read -r path; do
    if [[ -n "$path" ]]; then
        fail "tracked sensitive path: $path"
        tracked_secrets=1
    fi
done < <(git ls-files 2>/dev/null | grep -E "$SECRET_PATH_RE" || true)
[[ "$tracked_secrets" -eq 0 ]] && ok "no sensitive paths in git index"

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

if command -v sxhkd >/dev/null && [[ -f sxhkd/sxhkdrc ]]; then
    set +e
    timeout 0.5 sxhkd -c sxhkd/sxhkdrc 2>/dev/null
    sx_rc=$?
    set -e
    if [[ "$sx_rc" -eq 124 || "$sx_rc" -eq 0 ]]; then
        ok "sxhkd config loads"
    else
        warn "sxhkd -c check failed (exit $sx_rc)"
    fi
fi

profile="${DOTFILES_BSPWM_PROFILE:-desktop}"
if [[ -f "bspwm/profiles/$profile.sh" || -f "bspwm/profiles/default.sh" ]]; then
    ok "bspwm profile ($profile or default)"
else
    warn "no bspwm profile for DOTFILES_BSPWM_PROFILE=$profile"
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
