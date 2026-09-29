# AGENTS.md

## This is a personal fork

Upstream: `brookhong/Surfingkeys`. This fork intentionally strips China-related
content the upstream project carries (Baidu search alias, `README_CN.md`,
weibo.com example domain, upstream donate/survey links, etc — see commit
`5d6c6a0`).

**When merging or cherry-picking from upstream**: check every changed file
for reintroduced China-related content (search aliases, CN-specific docs,
CN service URLs, CN-only default settings). If found, run `/grill-me` on
the removal before committing it — don't strip it unilaterally.

Exception: `/sync-fork` (`.claude/skills/sync-fork`) auto-strips patterns
already removed by `5d6c6a0`, in separate `chore: strip ...` commits after the
upstream merge commit. Anything new or ambiguous still goes to `/grill-me`.

This fork also removed the LLM chat feature completely (omnibar `A` chat, `;t`/`t` translate,
insert-mode `<Ctrl-g>` grammar fix, `llm.js`, `llmchat.js`, `llmtools.js`, `pageMarkdown.js`, their tests and docs,
the `aws4fetch` dependency). Upstream keeps developing it, so every upstream merge will conflict on it:
resolve by keeping the LLM code deleted.

Checklist for working on this Surfingkeys codebase.

## Before editing
- Read the surrounding file and existing patterns first; mirror naming and style.
- Prefer reusing existing utilities in `src/content_scripts/common/` over reimplementing logic (see "Avoid duplicating utils" below).
- Verify how modules import from `./utils.js` before adding exports; many helpers are already exported.
- On ANY fix or feature, the moment two defensible behaviors compete and you cannot have both, STOP and ask which one — before writing the code. Name each option as the behavior a user would notice and what it gives up, not as an implementation. This is not about big changes: the choice is usually small and buried (which side to err on, what to do with the awkward case, whether to be strict or forgiving), which is exactly why it slips through as a decision nobody made. Do not settle it yourself and write the comment that justifies it: a plausible rationale in the diff is what stops the user noticing there was a choice at all, and they are the one who lives with it.

## Common utils to reuse (do not reinvent)
- `getTextRect(node, offset[, endNode, endOffset])` — builds a range and returns its client rects **without touching the page selection**. Useful for positioning overlays near text.
- `createElementWithContent(tag, content, attrs)` — create DOM elements with class/content.
- `getTextNodePos`, `getVisibleElements`, `filterInvisibleElements`, `setSanitizedContent`, etc.

### Gotchas
- `getTextRect(...)` returns a **`DOMRectList`, not a real Array** — `.reduce()`, `.filter()` etc. will throw "is not a function". Wrap with `Array.from(getTextRect(...))` before calling array methods.
- `getTextNodePos(node, offset)` mutates `document.getSelection()` — avoid it when the page's current selection must be preserved; use a standalone `Range`/`getTextRect` instead.

## Patterns that work
- To keep a floating UI element from overlapping selected text, compute the text range's bounding rect, place the overlay below it (fallback: above), and clamp within the viewport.
- Define shared content-stylesheet rules in `src/content_scripts/content.css` (injected into every page via the manifest) instead of injecting `<style>` at runtime; keep only dynamic values inline.
- A comment explaining WHY must be anchored to the code under it: state the invariant first, then what breaking it costs. Keep that consequence — it is what stops a future edit from looking like harmless cleanup — but describe the wrong design as a BEHAVIOR, never as a named thing the file does not contain: a reader greps the name, finds nothing, and stops trusting the comment.

## Mapping conventions
- `mapkey('<Space>x', ...)` normal mode; `vmapkey(...)` visual mode; `imapkey(...)` insert mode; `cmapkey(...)` command mode.
- Give each mapping a `#N` category prefix in the hint text (e.g. `'#8Open commands'`).

## Commit messages
- Keep them short: a conventional-commit subject (`docs(hints): …`, `feat(hints): …`) plus a body that says what changed and the one reason it matters, then stop. This holds for `feat`/`fix` too — the long multi-paragraph bodies in the existing history are NOT the pattern to copy, and reasoning a future reader needs while looking at the code belongs in a comment there, where they will actually find it.

## Verification
- After editing any JS file, run `node --check <file>` to confirm it parses.
- If a behavior depends on new/changed config (e.g. `settings.hintAlign`), make sure it's defined in `runtime.js` `conf`.
