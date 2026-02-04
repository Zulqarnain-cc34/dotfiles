# 🔴 CRITICAL ISSUES FOUND - Fresh Audit

## Issue 1: Hardcoded Paths in .bash_profile 🔴
**File:** `.bash_profile` (lines 1-2)
```bash
if [ -r ~/.profile ]; then . /home/alpha/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . /home/alpha/.bashrc; fi ;; esac
```
**Problem:** Hardcoded `/home/alpha/` paths
**Fix:** Use `~` or `$HOME`

---

## Issue 2: Hardcoded Paths in Google Cloud SDK 🔴
**File:** `zsh/.zshrc` (lines 17, 20)
```bash
if [ -f '/home/alpha/Desktop/google-cloud-sdk/path.zsh.inc' ]; then ...
if [ -f '/home/alpha/Desktop/google-cloud-sdk/completion.zsh.inc' ]; then ...
```
**Problem:** Hardcoded `/home/alpha/Desktop/`
**Fix:** Use `$HOME/Desktop/`

---

## Issue 3: Hardcoded Paths in conda-init Function 🔴
**File:** `zsh/.zshrc` (lines 126, 130, 133)
```bash
__conda_setup="$('/home/alpha/anaconda3/bin/conda' ...)"
if [ -f "/home/alpha/anaconda3/etc/profile.d/conda.sh" ]; then
export PATH="/home/alpha/anaconda3/bin:$PATH"
```
**Problem:** Hardcoded `/home/alpha/anaconda3/`
**Fix:** Use `$HOME/anaconda3/`

---

## Issue 4: Hardcoded Path in luamake Alias 🔴
**File:** `zsh/.zshrc` (line 139)
```bash
alias luamake=/home/alpha/.config/nvim/lua-language-server/3rd/luamake/luamake
```
**Problem:** Hardcoded `/home/alpha/`
**Fix:** Use `$HOME`

---

## Issue 5: Wrong Symlink Direction in setup.sh 🔴
**File:** `setup.sh` (line 68)
```bash
[ ! -f "$HOME"/.config/zsh/.zshrc ] && ln -s "$HOME"/.config/zsh/.zshrc "$PWD"/.zshrc
```
**Problem:** Symlink points wrong direction (target → source instead of source → target)
**Fix:** Should be `ln -s "$PWD"/zsh/.zshrc "$HOME"/.config/zsh/.zshrc`

---

## Issue 6: Missing History Directory Check 🔴
**File:** `zsh/.zshrc` (line 11)
```bash
HISTFILE="$HOME/.logs/zsh/history"
```
**Problem:** Directory `$HOME/.logs/zsh/` may not exist
**Fix:** Add `mkdir -p "$HOME/.logs/zsh"` before setting HISTFILE

---

## Summary
- **6 CRITICAL issues** found
- **4 files** affected
- **Main problem:** Hardcoded `/home/alpha/` paths throughout configs
- **Impact:** Configs will break on different systems or user accounts

## Priority
🔴 **FIX IMMEDIATELY** - These break portability and may cause errors
