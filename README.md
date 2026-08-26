# Surfingkeys (personal fork)

Personal fork of [brookhong/Surfingkeys](https://github.com/brookhong/Surfingkeys) — a browser extension
that adds VIM-style keyboard navigation and control of the web. For features, key mappings, and API docs,
see the [upstream README](https://github.com/brookhong/Surfingkeys#readme) and
[API docs](https://github.com/brookhong/Surfingkeys/blob/master/docs/API.md).

See [AGENTS.md](AGENTS.md) for what this fork changes from upstream and why.

## Install

Chrome/Brave (any Chromium browser), prebuilt via GitHub Releases — no local build needed:

**macOS / Linux**
```
curl -fsSL https://raw.githubusercontent.com/khanhtd36/surfing-keys/master/install.sh | bash
```

**Windows**
```
irm https://raw.githubusercontent.com/khanhtd36/surfing-keys/master/install.ps1 | iex
```

This downloads the [latest release](https://github.com/khanhtd36/surfing-keys/releases/latest), unpacks it
to `~/surfingkeys-ext`, and opens the extensions page. Then:

1. Enable **Developer mode** (`chrome://extensions` or `brave://extensions`).
2. Click **Load unpacked**, select the unpacked folder.
3. Disable the store-installed Surfingkeys if present, to avoid keybinding conflicts.

### Building from source

```
npm install
browser=chrome npm run build:prod   # or build:dev for an unminified build
```
Output goes to `dist/production/chrome` (or `dist/development/chrome`) — load that folder unpacked as above.

## License

MIT License
