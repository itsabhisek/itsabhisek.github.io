# Abhisek's Blog

Personal blog at https://itsabhisek.github.io, built with [AstroPaper](https://github.com/satnaing/astro-paper) by Sat Naing. The theme's MIT license is preserved in `LICENSE`.

Includes warm taupe light/dark backgrounds with Apricot copper accents, EB Garamond and Noto Serif Tamil typography, Tamil-first posts with English translations, tags, archives, search, RSS, and sitemap.

## Run locally

Requires Node.js 22.12 or later.

```sh
npm ci
npm run dev
```

Use `npm run build` to check types, build the site, and index posts for search. Use `npm run preview` to preview the production build. Search requires a build first.

## Write a post

Create a Markdown file under `src/content/posts/`, for example `my-first-post.md`:

```markdown
---
title: "My first post"
description: "A short summary for the homepage and RSS feed."
pubDatetime: 2026-10-11T10:00:00+05:30
tags: [notes]
draft: true
lang: ta
translationKey: my-first-post
---

Write your post here.
```

Set `draft: false` when ready. Future-dated posts appear only after a new build runs once their publication time is reached. Draft source is visible in this public repository, although drafts are excluded from the built site and search.

## Tamil and English versions

Write your Tamil version in `my-first-post.md` with `lang: ta`. To offer English, create `my-first-post-en.md`, set `lang: en`, and use exactly the same `translationKey` in both files. Translate the title, description, and body; keep publication dates and tags consistent. There can be only one published version of each language for a translation key.

The homepage, post list, archives, and RSS prefer the English version and list the article once. Each version has its own URL. When both versions are published, a small **தமிழில் வாசிக்க** link appears beneath the date on the English article, with only **தமிழில்** underlined; the Tamil article offers **Read in English**. Search indexes both languages. If no translation exists, the published version remains available on its own. Direct links to either language keep that language. Posts without `translationKey` are independent. The content language still defaults to Tamil when `lang` is omitted.

See `src/content/posts/welcome-ta.md` and `src/content/posts/welcome.md` for a working pair. Tamil posts use the site's social preview image unless you supply a custom `ogImage`; English posts retain generated title images.

Filenames determine URLs: `my-first-post.md` becomes `/posts/my-first-post/`. The original `/blog/welcome/` URL redirects to `/posts/welcome/`.

## Customize

- Blog title, description, author, social links, timezone, and features: `astro-paper.config.ts`
- Homepage introduction: `src/pages/index.astro`
- About page: `src/content/pages/about.md`
- Colors: `src/styles/theme.css`

The welcome post and About copy are starters you can edit.

## Publish and sync

### PowerShell helper

From the blog folder, run each step separately:

```powershell
# Build locally (installs dependencies first if node_modules is missing)
.\scripts\blog.ps1 Build

# Preview the successful build at the address printed in the terminal
npm run preview
# Press Ctrl+C before continuing

# Review changes, then stage and commit all non-ignored changes locally
git status
git diff
.\scripts\blog.ps1 Commit -Message "Update blog layout"

# Push committed code on the current branch to origin
.\scripts\blog.ps1 Push
```

Run the build successfully before committing and pushing. Each helper action is
independent: Commit does not build or push, and Push does not commit. Deployment
is manual: pushing `main` saves code on GitHub without deploying. The helper stops
on a failed command and never force-pushes or rebases. It works from any directory
when invoked by its full path. Add `-WhatIf` to preview an action.

If Windows blocks the script, invoke that specific command with:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\blog.ps1 Build
```

This applies the execution policy only to that process, not your saved settings.

### GitHub Pages deployment

In repository **Settings > Pages > Build and deployment**, set **Source** to
**GitHub Actions**. The existing `.github/workflows/deploy.yml` builds and
deploys the site; you do not need to upload `dist` manually.

Push to `main` after reviewing the site locally, then trigger deployment below.
After both jobs succeed, visit https://itsabhisek.github.io/.

To deploy the code already on GitHub manually:

1. Open https://github.com/itsabhisek/itsabhisek.github.io/actions/workflows/deploy.yml.
2. Click **Run workflow**, select **main**, then click **Run workflow** again.
3. Wait for the build and deploy jobs to succeed.

Or use GitHub CLI:

```powershell
gh workflow run deploy.yml --repo itsabhisek/itsabhisek.github.io --ref main
gh run list --repo itsabhisek/itsabhisek.github.io --workflow deploy.yml --limit 5
```

Manual deployment uses files committed and pushed to GitHub, not local edits.
See [GitHub's manual workflow instructions](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/manually-run-a-workflow).

### Plain Git commands

These commands save your code to GitHub. Deploy separately using **Run workflow**.

```sh
git pull --rebase
git add .
git commit -m "Add a new blog post"
git push
```

You can also edit Markdown on GitHub and commit to `main`. Run `git pull` locally afterward to sync those changes.

Git authentication uses the personal `itsabhisek` account. If it expires, run `gh auth login --hostname github.com --git-protocol https --web`. Never commit access tokens.
