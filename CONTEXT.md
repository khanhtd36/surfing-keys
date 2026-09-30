# Surfingkeys

Browser extension that adds vim-style keyboard control to web pages, through modes that decide who handles each keystroke.

## Language

**PassThrough mode**:
A mode where Surfingkeys ignores every keystroke so the page receives them untouched. A small status-line indicator reads "pass through" while it is active.
_Avoid_: Disabled, blocked, suspended

**Indefinite PassThrough**:
A PassThrough mode the user enters with `<Alt-i>` and leaves only with the exit key, `<Alt-I>` (Alt+Shift+i). `<Esc>` does not leave it.
_Avoid_: Sticky pass through, permanent pass through

**Ephemeral PassThrough**:
A PassThrough mode with a timeout that ends on its own, entered with `p`. `<Esc>` still leaves it early.
_Avoid_: Temporary pass through, timed pass through

**Exit key**:
The rebindable special key that leaves Indefinite PassThrough. Default `<Alt-I>` (Alt+Shift+i).
_Avoid_: Escape key, toggle key

**Blocklist toggle**:
The `<Alt-s>` special key that turns Surfingkeys on or off for the current site. Distinct from PassThrough mode, which lasts until exited and is not remembered per site.
_Avoid_: Disable, block
