# Chrome Web Store submission notes

Package: `npm run build:prod`, then upload `dist/production/chrome/sk.zip`. Visibility: Unlisted.
Privacy policy URL: https://github.com/khanhtd36/surfing-keys/blob/master/PRIVACY.md

## Listing

Name: Vimotion
Summary (max 132): Vim-style keyboard navigation for the web: click links, switch tabs, scroll. Unofficial fork of Surfingkeys.
Category: Productivity

Description:

> Vimotion lets you browse with the keyboard, vim style. Press `f` to follow a link, `j`/`k` to scroll,
> `E`/`R` to switch tabs, `t` to search tabs, history and bookmarks from the omnibar, and `v` to select text.
> Mappings and behaviour are configurable in the settings page with JavaScript.
>
> Vimotion is an unofficial fork of Surfingkeys by brookhong (MIT license) and is not affiliated with it.
> It has no server and collects no data. Source: https://github.com/khanhtd36/surfing-keys

Screenshots: 1280×800 (or 640×400), at least one, up to five. Take them yourself: link hints (`f`), the omnibar, the settings page.

## Single purpose

Provide vim-style keyboard shortcuts for navigating and controlling web pages and the browser.

## Permission justifications

- `<all_urls>` (content script): shortcuts and link hints must work on every page the user visits.
- `tabs`: list, switch, move and close tabs; the tab omnibar.
- `history`, `bookmarks`, `topSites`, `sessions`: omnibar suggestions and reopening closed tabs.
- `downloads`: download list and commands.
- `storage`: save the user's settings and key mappings.
- `scripting`: inject hints and UI into pages.
- `userScripts`: run the JavaScript the user writes in the settings page (custom mappings). It never loads code from a server.
- `clipboardRead`, `clipboardWrite`: copy link/text and paste commands.
- `favicon`: show site icons in the omnibar.
- `tabGroups`: group and ungroup tabs from the keyboard.
- `nativeMessaging`: optional helper program on the user's machine for the neovim editor, native clipboard and `~/.surfingkeys.js`.

## Remote code

No remotely hosted code. Settings snippets are typed or pasted by the user.
