---
name: stop-renovate
description: stop using Renovate on a repository and fall back to Dependabot security updates only
---

Help the user stop Renovate on a repository, keeping only Dependabot security updates.

## Overview

The user's preference is a low-maintenance cadence: no periodic dependency
update PRs, only security fixes. Renovate is noisy for this, so the target
state is:

- No `renovate.json` in the repository
- No `.github/dependabot.yml` (that file enables *version* updates — not wanted)
- Dependabot **security updates** stay enabled at the repository level, which
  works without any config file in the repo

Do NOT create a `.github/dependabot.yml` unless the user explicitly asks for
scheduled version updates.

## Steps

### 1. Survey the current state

```bash
find . -path ./node_modules -prune -o \( -iname "*renovate*" -o -iname "*dependabot*" \) -print
gh pr list --state open --json number,title,author --limit 50
```

Report what was found: the Renovate config, and how many open Renovate PRs exist.

### 2. Decide what to do with the open Renovate PRs

Ask the user. The usual choices are:

- Merge them all first (leaves the repo on current deps before Renovate goes away)
- Close them all
- Leave them alone

If merging, check CI first, then merge oldest-blocking-first. Lockfile PRs
conflict with each other, so merge them one at a time and confirm afterwards:

```bash
for n in <numbers>; do gh pr view $n --json title,mergeable,mergeStateStatus,statusCheckRollup \
  -q '"\(.title) | mergeable=\(.mergeable) | state=\(.mergeStateStatus) | checks=\([.statusCheckRollup[]? | "\(.name // .context)=\(.conclusion // .state)"] | join(","))"'; done

for n in <numbers>; do gh pr merge $n --merge; done

gh pr list --state open --json number,title   # confirm nothing is left behind
```

### 3. Remove the Renovate config on a branch

Follow the repo's git workflow — never commit to `main` directly.

```bash
git checkout -b stop-renovate
git fetch origin && git rebase origin/main   # pick up the PRs just merged
git rm renovate.json                          # also .github/renovate.json / .renovaterc* if present
```

Run the repository's pre-commit checks (e.g. `npm run format`, `npm run lint`,
`npm run build`, `npm run test`) before committing, even for a config-only
change. If deps were just bumped by step 2, reinstall first (`npm ci`).

Commit, push, and open a PR.

### 4. Tell the user about the manual step

Deleting the config is not enough on its own. Renovate is a GitHub App, and
while it is still installed it may open a "Configure Renovate" onboarding PR
again. The user must remove the repository from the App installation:

https://github.com/settings/installations

This cannot be done from the CLI — always surface it explicitly as a follow-up,
and mention it in the PR body too.

## Verifying the end state

- `renovate.json` gone, no `.github/dependabot.yml` added
- No open Renovate PRs
- Repository removed from the Renovate App installation (user-confirmed)
- Dependabot security updates still enabled under
  Settings → Code security and analysis
