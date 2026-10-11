# Abhisek's Blog

An Astro blog for https://itsabhisek.github.io with Markdown posts, automatic dark mode, an RSS feed, and GitHub Pages deployment.

## Run locally

Requires Node.js 22.12 or later.

```sh
npm ci
npm run dev
```

Open the local address printed by Astro. Use `npm run build` to check types and build the site, and `npm run preview` to preview that build.

## Write a post

Create a Markdown file in `src/content/blog/`, for example `my-first-post.md`:

```markdown
---
title: "My first post"
description: "A short summary for the homepage and RSS feed."
pubDate: 2026-10-11
tags: [notes]
draft: true
---

Write your post here.
```

Set `draft: false` when ready. Drafts are excluded from the website and RSS, but their source is visible in a public repository. The filename determines the URL, such as `/blog/my-first-post/`.

The welcome post and About page are starter copy; edit them before sharing the site. Change the blog title, description, or author in `src/site.ts`.

## Publish and sync

The GitHub repository must be named `itsabhisek.github.io`. In the repository's **Settings → Pages**, select **GitHub Actions** as the source. Every push to `main` runs the build and deploys the site.

For normal updates:

```sh
git pull --rebase
git add .
git commit -m "Add a new blog post"
git push
```

You can also edit Markdown directly on GitHub and commit to `main`; run `git pull` locally afterward to sync those changes.

If authentication is needed, use `gh auth login --hostname github.com --git-protocol https --web` and sign in as `itsabhisek`. Never put tokens in this repository.
