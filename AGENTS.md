# AGENTS.md

## This is a personal fork

Upstream: `brookhong/Surfingkeys`. This fork intentionally strips China-related
content the upstream project carries (Baidu search alias, `README_CN.md`,
weibo.com example domain, upstream donate/survey links, etc — see commit
`5d6c6a0`).

**When merging or cherry-picking from upstream**: check every changed file
for reintroduced China-related content (search aliases, CN-specific docs,
CN service URLs, CN-only default settings). If found, run `/grill-me` on
the removal before committing the merge — don't strip it unilaterally.
