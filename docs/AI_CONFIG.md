# AI agent configuration

AI agent configuration (instructions, skills, plugins, per-client settings) is
**not** in this repo. It lives in a separate private repo, because this one is
public and agent configuration accumulates project names, paths and notes that
should not be.

There is exactly one AI config source, and it is that repo. Nothing here is a
copy of it, and nothing there is a copy of anything here.

## Setup

```bash
git clone git@github.com:jnathanh/ai-customizations.git ~/src/ai-customizations
~/src/ai-customizations/link.sh plan      # review what it will do
~/src/ai-customizations/link.sh adopt     # once, on a machine with existing config
```

`adopt` is the first-run verb: it moves any pre-existing client config aside
into a journalled run directory before linking, so nothing is clobbered and
every move can be rolled back. On a machine with no existing config, or on
every run after the first, `link` is enough — and `bootstrap.sh` in this repo
runs `link` for you when the repo is present.

## Design

`docs/DESIGN.md` in that repo is the source of truth: what each client reads,
what gets linked where, and why. Read it before changing any of it.
