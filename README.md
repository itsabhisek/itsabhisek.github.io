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

Every push to `main` runs GitHub Actions and deploys to GitHub Pages.

```sh
git pull --rebase
git add .
git commit -m "Add a new blog post"
git push
```

You can also edit Markdown on GitHub and commit to `main`. Run `git pull` locally afterward to sync those changes.

Git authentication uses the personal `itsabhisek` account. If it expires, run `gh auth login --hostname github.com --git-protocol https --web`. Never commit access tokens.
