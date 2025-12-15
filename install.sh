#!/usr/bin/env bash
set -euo pipefail

# Install Wine 10 (WineHQ stable) on Linux Mint (Ubuntu 24.04 base)
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install software-properties-common wget curl dirmngr ca-certificates unzip -y

sudo mkdir -p /usr/share/keyrings
curl -fsSL https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /usr/share/keyrings/winehq.gpg

cat <<EOF | sudo tee /etc/apt/sources.list.d/winehq.sources >/dev/null
Types: deb
URIs: https://dl.winehq.org/wine-builds/ubuntu/
Suites: noble
Components: main
Signed-By: /usr/share/keyrings/winehq.gpg
EOF

sudo apt update
sudo apt install --install-recommends winehq-stable -y

# Download + extract ObservatoryCore Wine portable to Desktop
URL="https://xjph.net/Observatory/1.3.0/WINE-ObservatoryPortable.zip"
DESKTOP="$HOME/Desktop"
DEST_DIR="$DESKTOP/ObservatoryCore"

mkdir -p "$DEST_DIR"
TMP_ZIP="$(mktemp --suffix=.zip)"

echo "Downloading ObservatoryCore portable..."
curl -L --fail -o "$TMP_ZIP" "$URL"

echo "Extracting to: $DEST_DIR"
unzip -o "$TMP_ZIP" -d "$DEST_DIR" >/dev/null
rm -f "$TMP_ZIP"

# Find the exe (in case the zip structure changes slightly)
EXE="$(find "$DEST_DIR" -maxdepth 3 -type f -iname "ObservatoryCore.exe" | head -n 1)"
if [[ -z "${EXE:-}" ]]; then
  echo "ERROR: ObservatoryCore.exe not found under $DEST_DIR"
  exit 1
fi

# Run it in a separate process
echo "Launching: $EXE"
nohup wine "$EXE" >/dev/null 2>&1 & disown

echo "Done. ObservatoryCore launched in the background."
echo "If you need the Elite journals path for Proton:"
echo "  Z:\\home\\$USER\\.steam\\steam\\steamapps\\compatdata\\359320\\pfx\\drive_c\\users\\steamuser\\Saved Games\\Frontier Developments\\Elite Dangerous"
