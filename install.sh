#!/usr/bin/env bash
# Downloads the latest prebuilt Surfingkeys (Chrome/Brave) release and unzips it locally.
# Usage: curl -fsSL https://raw.githubusercontent.com/khanhtd36/surfing-keys/master/install.sh | bash
set -euo pipefail

REPO="khanhtd36/surfing-keys"
DEST="${SURFINGKEYS_INSTALL_DIR:-$HOME/surfingkeys-ext}"

echo "Fetching latest release info for $REPO..."
DOWNLOAD_URL=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
  | grep '"browser_download_url"' \
  | grep 'sk-chrome.zip' \
  | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$DOWNLOAD_URL" ]; then
  echo "Could not find sk-chrome.zip in latest release. Aborting." >&2
  exit 1
fi

echo "Downloading $DOWNLOAD_URL"
TMP_ZIP=$(mktemp -t surfingkeys-XXXXXX.zip)
curl -fsSL "$DOWNLOAD_URL" -o "$TMP_ZIP"

rm -rf "$DEST"
mkdir -p "$DEST"
unzip -q "$TMP_ZIP" -d "$DEST"
rm -f "$TMP_ZIP"

echo ""
echo "Installed to: $DEST"
echo ""
echo "Next steps:"
echo "  1. Open chrome://extensions (Brave: brave://extensions)"
echo "  2. Enable Developer mode"
echo "  3. Click 'Load unpacked' and select: $DEST"

if command -v open >/dev/null 2>&1; then
  open "https://extensions" 2>/dev/null || true
  open -a "Google Chrome" "chrome://extensions" 2>/dev/null || open -a "Brave Browser" "brave://extensions" 2>/dev/null || true
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "chrome://extensions" 2>/dev/null || true
fi
