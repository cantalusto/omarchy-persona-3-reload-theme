#!/usr/bin/env bash
#
# Persona 3 Reload — full-image SDDM login ("Unlock") screen.
#
# Installs a custom layout for the reboot login screen: the underwater Makoto
# image full-bleed (no logo, no overlay) with the lock + password field on the
# right, over the blue water.
#
# IMPORTANT — this is a LOCAL, NON-DURABLE tweak:
#   * It overwrites the generated system file /usr/share/sddm/themes/omarchy/Main.qml
#     and drops in a background image (needs sudo).
#   * Running "Style -> Unlock -> <theme>" again, or `omarchy update`, regenerates
#     Main.qml and removes this. Just re-run this script afterwards to restore it.
#
# Recommended order:
#   1) Apply the unlock first:  Omarchy menu -> Style -> Unlock -> Persona 3 Reload
#      (so the lock/entry assets get the blue theme colors)
#   2) Then run this script:    bash sddm-background.sh
#
set -euo pipefail

THEME_DIR="$HOME/.config/omarchy/themes/persona-3-reload"
SDDM_DIR="/usr/share/sddm/themes/omarchy"
# Real PNG (SDDM's Qt greeter often lacks the JPEG plugin, so we ship a PNG)
BG_SRC="$THEME_DIR/extras/sddm/background.png"
QML_SRC="$THEME_DIR/extras/sddm/Main.qml"

[ -f "$BG_SRC" ]  || { echo "Background image not found: $BG_SRC" >&2; exit 1; }
[ -f "$QML_SRC" ] || { echo "Custom Main.qml not found: $QML_SRC" >&2; exit 1; }
[ -d "$SDDM_DIR" ] || { echo "SDDM omarchy theme not found ($SDDM_DIR). Apply an Unlock theme first." >&2; exit 1; }

echo "Backing up the current Main.qml (once)..."
sudo cp -n "$SDDM_DIR/Main.qml" "$SDDM_DIR/Main.qml.omarchy-bak" 2>/dev/null || true

echo "Installing the background image..."
sudo cp "$BG_SRC" "$SDDM_DIR/background.png"
# SDDM's greeter runs as the 'sddm' user, so the image must be world-readable
sudo chmod 644 "$SDDM_DIR/background.png"

echo "Installing the custom full-image layout..."
sudo cp "$QML_SRC" "$SDDM_DIR/Main.qml"

echo "Done. Log out or reboot to see the new Unlock screen."
