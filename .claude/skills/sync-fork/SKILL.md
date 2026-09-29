---
name: sync-fork
description: Sync this fork's master with upstream/master, strip China-related content in separate commits, verify, build locally, and push — then report. Invoke by hand as /sync-fork.
disable-model-invocation: true
allowed-tools: Bash(git:*) Bash(npm:*) Bash(node:*) Bash(gh:*)
---

Fixed pipeline, no arguments, run start to finish every time it's invoked. Every
step below still owes the final report — an early stop skips later steps, not
the report.

Never add `Co-Authored-By`, `Claude-Session`, or any attribution footer to the
commits this skill creates.

## 1. Preflight

Confirm the current branch is `master` and `git status --porcelain` is empty.
Either check fails → stop, tell the user which one and why, skip everything
else, then go straight to the Report with the other sections marked not reached.

## 2. Fetch

`git fetch upstream`. Run `git log --oneline master..upstream/master` and keep
its output verbatim as the **changelog** — one line per upstream commit about
to be merged in.

Empty output → nothing to merge. Skip straight to the Report: changelog is
"up to date, nothing to merge", everything else "not reached".

Also record `version` from `package.json` (before the merge).

## 3. Merge

`git merge upstream/master --no-edit`. Commit normally — the merge commit must
mirror upstream exactly, with no cleanup folded in.

On conflict: stop immediately. Do not resolve it. Leave the merge in
progress exactly as git left it. Run `git diff --name-only --diff-filter=U`
and keep that file list for the report. Skip everything after.

## 4. Scan for China content

Per `AGENTS.md`, this fork strips China-related upstream content. Scan the
files changed by the merge (`git diff --name-only ORIG_HEAD HEAD`), reading
the added lines (`git diff ORIG_HEAD HEAD -- <file>`). Skip `package-lock.json`.
Scan `docs/api.md` too, but never hand-edit it (see step 5).

Two classes of hit:

- **Known** — patterns commit `5d6c6a0` already stripped: Baidu search alias
  and its doc mentions, `README_CN.md` and other CN-only files, `weibo.com`
  example domains, upstream donate/FUNDING/survey links, `.github`
  upstream-only files (FUNDING.yml, ISSUE_TEMPLATE, stale.yml), `*.cn`
  service URLs (e.g. siliconflow.cn), Chinese-language help/settings.
- **New/ambiguous** — anything else China-related: a new CN search alias,
  CN service URL, CN-only default setting, or unclear case.

No hits → record "none" and go to step 7.

## 5. Strip known hits

Remove **known** hits only. One commit per logical removal group (per upstream
feature or file group), never one big commit. Each message is
`chore: strip <what> from upstream <short-hash>` — name the upstream commit
the content came from, so a later "why doesn't this upstream feature work
here?" can be traced through history. If a removal is in `docs/api.md`, fix
the source and regenerate with `npm run build:doc` instead of editing by hand.

**New/ambiguous** hits: do not touch them. Stop here — skip verify, build
and push. Leave the merge and any removal commits local and unpushed. Tell the
user to run `/grill-me` on those hits, and list file:line for each.

## 6. Re-scan

Re-run the step-4 scan over the same range (`ORIG_HEAD..HEAD`, which now
includes the removal commits' net effect). Any known or new hit left → stop
exactly as in step 5's ambiguous case: commits stay local, nothing pushed,
report the leftover hits.

## 7. Verify

`npm test`, then `npm run build:prod`. If either fails, stop before push. Keep the failing command and the tail of its output for
the report. (Do not run `npm run build` — it rewrites `docs/api.md`.)

## 8. Deploy

The production build from step 7 lands in `dist/production/chrome`; that is
the local deploy — the user reloads the unpacked extension from there. Do not
create or push any tag; a `v*` tag triggers the public Release workflow and is
the user's call.

Compare `version` in `package.json` with the value recorded in step 2. Changed
→ note "version A → B, no tag yet" for the report.

## 9. Push

`git push` on `origin` first. If that fails or hangs, fall back to:

```
GH_CONFIG_DIR="$HOME/.config/gh-khanhtd36" git push https://github.com/khanhtd36/surfing-keys.git master:master
```

(this uses the personal `gh` login as the HTTPS credential). Record which of
the two actually succeeded.

## 10. Report

Always end with exactly these four sections, in this order, regardless of
where the pipeline stopped:

```
## Changelog
<the commits merged in, or "up to date, nothing to merge">

## Conflict resolution
<"none", or the conflicting files and that the merge was left in progress
for the user to resolve by hand>

## China strip
<"none", or each removal commit (hash + subject) and the upstream commit it
cleaned; plus any new/ambiguous or leftover hits as file:line with "commits
local, not pushed — run /grill-me">

## Deploy status
<test result, build:prod result, version change note, and which push path
succeeded — or "not reached" for whichever steps a stop above skipped>
```
