# NeoMutt + Gmail

## One-time Google setup

1. Enable **2-Step Verification** on the Google account.
2. Enable **IMAP**: Gmail → Settings → See all settings → Forwarding and POP/IMAP → Enable IMAP.
3. Create an **App Password**: https://myaccount.google.com/apppasswords → Mail → Other (NeoMutt).
4. Save the 16-character password (spaces optional):

```bash
echo 'abcdefghijklmnop' > ~/.mutt/accounts/.auth.powerranger16918
chmod 600 ~/.mutt/accounts/.auth.powerranger16918
```

Use your **Google account password** here — only the app password works.

## Dotfiles layout

| File | Purpose |
|------|---------|
| `~/.mutt/muttrc` | Sources settings, account, sidebar |
| `.mutt/accounts/account.com.gmail.powerranger16918` | IMAP/SMTP (gitignored via `.mutt/accounts/`) |
| `.mutt/accounts/.auth.powerranger16918` | App password only (gitignored) |

After `setup.sh`, ensure `~/.mutt` symlinks to this repo’s `.mutt/`.