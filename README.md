# CALZX TERMUX — NEON EDITION

Custom neon-style Bash welcome screen for Termux. No root, no API key, and no storage permission required.

## Install from GitHub

Replace `CALZX-DEV` below if your GitHub username differs:

```bash
pkg update
pkg install git bash
git clone https://github.com/CALZX-DEV/CALZX-TERMUX.git
cd CALZX-TERMUX
bash install.sh
```

Close and reopen Termux. The welcome screen appears automatically.

## Commands

- `calzx` — show the dashboard now
- `calzx-config` — change the banner name, subtitle, and color
- `calzx-uninstall` — remove the startup hook and installed commands

## Notes

- The installer does not use `termux-setup-storage`.
- The YouTube menu opens `https://youtube.com/@calzxchannel`.
- The theme uses Bash and ANSI terminal colors. On narrow screens, the banner may wrap.
- This project changes your shell startup file (`~/.bashrc`) and backs it up before editing.
