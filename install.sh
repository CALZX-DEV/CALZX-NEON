#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
BIN_DIR="$PREFIX/bin"
BASHRC="$HOME/.bashrc"
MARKER="# >>> CALZX TERMUX STARTUP >>>"
END_MARKER="# <<< CALZX TERMUX STARTUP <<<"

printf '\n\033[1;96m╔══════════════════════════════════════════════╗\033[0m\n'
printf '\033[1;96m║           CALZX TERMUX • NEON SETUP          ║\033[0m\n'
printf '\033[1;96m╚══════════════════════════════════════════════╝\033[0m\n\n'
printf 'This installer adds CALZX commands and a startup banner.\n'
printf 'No storage permission, root access, or API key is needed.\n\n'

mkdir -p "$BIN_DIR" "$HOME/.config/calzx"
if [[ -f "$BASHRC" ]] && ! grep -qF "$MARKER" "$BASHRC"; then
  cp "$BASHRC" "$BASHRC.calzx-backup.$(date +%Y%m%d%H%M%S)"
fi

install -m 755 "$PROJECT_DIR/bin/calzx" "$BIN_DIR/calzx"
install -m 755 "$PROJECT_DIR/bin/calzx-config" "$BIN_DIR/calzx-config"
install -m 755 "$PROJECT_DIR/bin/calzx-uninstall" "$BIN_DIR/calzx-uninstall"
install -m 644 "$PROJECT_DIR/lib/theme.sh" "$HOME/.config/calzx/theme.sh"

if [[ ! -f "$HOME/.config/calzx/settings" ]]; then
  cat > "$HOME/.config/calzx/settings" <<'SETTINGS'
CALZX_TITLE='CALZX'
CALZX_SUBTITLE='NEON TERMINAL'
CALZX_COLOR='cyan'
SETTINGS
fi

touch "$BASHRC"
if ! grep -qF "$MARKER" "$BASHRC"; then
  cat >> "$BASHRC" <<'HOOK'

# >>> CALZX TERMUX STARTUP >>>
if [[ $- == *i* ]] && command -v calzx >/dev/null 2>&1; then
  calzx --quiet
fi
# <<< CALZX TERMUX STARTUP <<<
HOOK
fi

printf '\n\033[1;92mInstallation complete!\033[0m\n'
printf 'Run \033[1;96mcalzx\033[0m to show the dashboard.\n'
printf 'Run \033[1;96mcalzx-config\033[0m to customize it.\n'
printf 'Close and reopen Termux to test automatic startup.\n\n'
printf 'Open the creator channel now? [y/N]: '
read -r answer || answer='n'
case "$answer" in
  y|Y|yes|YES)
    if command -v termux-open-url >/dev/null 2>&1; then
      termux-open-url 'https://youtube.com/@calzxchannel' || true
    else
      printf 'Open this link in your browser: https://youtube.com/@calzxchannel\n'
    fi
    ;;
esac
