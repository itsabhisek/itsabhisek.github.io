# Abhisek's Blog

Personal blog at https://itsabhisek.github.io, built with [AstroPaper](https://github.com/satnaing/astro-paper) by Sat Naing. The theme's MIT license is preserved in `LICENSE`.

Includes light/dark mode, Markdown and MDX, tags, archives, Pagefind search, RSS, sitemap, and generated social preview images.

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
---

Write your post here.
```

Set `draft: false` when ready. Future-dated posts appear only after a new build runs once their publication time is reached. Draft source is visible in this public repository, although drafts are excluded from the built site and search.

Filenames determine URLs: `my-first-post.md` becomes `/posts/my-first-post/`. The original `/blog/welcome/` URL redirects to `/posts/welcome/`.

## Customize

- Blog title, description, author, social links, timezone, and features: `astro-paper.config.ts`
- Homepage introduction: `src/pages/index.astro`
- About page: `src/content/pages/about.md`
- Colors: `src/styles/theme.css`

The welcome post and About copy are starters you can edit.

## Publish and sync

Every push to `main` runs GitHub Actions and deploys to GitHub Pages.

```sh
git pull --rebase
git add .
git commit -m "Add a new blog post"
git push
```

You can also edit Markdown on GitHub and commit to `main`. Run `git pull` locally afterward to sync those changes.

Git authentication uses the personal `itsabhisek` account. If it expires, run `gh auth login --hostname github.com --git-protocol https --web`. Never commit access tokens.
