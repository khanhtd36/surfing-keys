# Privacy Policy — Vimotion

Vimotion is an unofficial fork of [Surfingkeys](https://github.com/brookhong/Surfingkeys).
It has no server, no accounts, no analytics and no telemetry. The developer receives no data from it.

## What the extension reads

To provide keyboard navigation it reads, locally in your browser:

- The pages you visit (content scripts run on all sites), to find links, inputs and scrollable elements.
- Your tabs, history, bookmarks, sessions, top sites and downloads, to fill the omnibar and tab commands.
- The clipboard, when you use the copy and paste commands.
- Your key presses on every page, locally, only to detect your keyboard shortcuts. Key presses are not recorded or sent anywhere.

None of this is sent to the developer or any third party by the extension.

## What the extension stores

Your settings and key mappings are stored with `chrome.storage`. If you use browser sync, Chrome syncs them
through your own Google account under Google's privacy policy. The extension does not read them anywhere else.

## Network requests you cause

The extension makes a request only when you use a feature that needs one:

- Omnibar search suggestions go to the search engine you configured.
- The markdown viewer, `httpRequest` in your own settings snippets, and image commands fetch the URL you ask for.
- Native features (neovim editor, native clipboard, `~/.surfingkeys.js`) talk to a helper program on your own
  machine, only if you install it.

## Your settings snippets

Vimotion runs the JavaScript you write in its settings page. That code is yours, stays in your browser, and is
never loaded from a server by the extension.

## Contact

Questions or issues: https://github.com/khanhtd36/surfing-keys/issues
