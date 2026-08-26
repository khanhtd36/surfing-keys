#!/usr/bin/env pwsh
# Downloads the latest prebuilt Surfingkeys (Chrome/Brave) release and unzips it locally.
# Usage: irm https://raw.githubusercontent.com/khanhtd36/surfing-keys/master/install.ps1 | iex

$ErrorActionPreference = "Stop"

$Repo = "khanhtd36/surfing-keys"
$Dest = if ($env:SURFINGKEYS_INSTALL_DIR) { $env:SURFINGKEYS_INSTALL_DIR } else { Join-Path $HOME "surfingkeys-ext" }

Write-Host "Fetching latest release info for $Repo..."
$release = Invoke-RestMethod -Uri "https://api.github.com/repos/$Repo/releases/latest"
$asset = $release.assets | Where-Object { $_.name -eq "sk-chrome.zip" }

if (-not $asset) {
    Write-Error "Could not find sk-chrome.zip in latest release."
    exit 1
}

$tmpZip = Join-Path $env:TEMP "sk-chrome-$([guid]::NewGuid()).zip"
Write-Host "Downloading $($asset.browser_download_url)"
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $tmpZip

if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
New-Item -ItemType Directory -Path $Dest -Force | Out-Null
Expand-Archive -Path $tmpZip -DestinationPath $Dest -Force
Remove-Item $tmpZip

Write-Host ""
Write-Host "Installed to: $Dest"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open chrome://extensions (Brave: brave://extensions)"
Write-Host "  2. Enable Developer mode"
Write-Host "  3. Click 'Load unpacked' and select: $Dest"

try {
    Start-Process "chrome://extensions"
} catch {
    try { Start-Process "brave://extensions" } catch {}
}
