import type { CollectionEntry } from "astro:content";
import { postFilter } from "./postFilter";

/**
 * Returns posts that are eligible to be shown to users, sorted by “last updated”
 * descending (uses `modDatetime` when present, otherwise `pubDatetime`).
 *
 * Note: filtering respects drafts and scheduled posts via `postFilter()`.
 */
export function getSortedPosts(posts: CollectionEntry<"posts">[], options: { allTranslations?: boolean } = {}) {
  const eligible = posts.filter(postFilter);
  const groups = new Map<string, CollectionEntry<"posts">[]>();
  for (const post of eligible) {
    const key = post.data.translationKey ? `translation:${post.data.translationKey}` : `post:${post.id}`;
    const group = groups.get(key) ?? [];
    if (group.some(existing => existing.data.lang === post.data.lang)) {
      throw new Error(`Duplicate ${post.data.lang} translation for ${post.data.translationKey}`);
    }
    group.push(post);
    groups.set(key, group);
  }
  const visible = options.allTranslations ? eligible : [...groups.values()].map(group => group.find(post => post.data.lang === "en") ?? group[0]);
  return visible
    .sort(
      (a, b) =>
        Math.floor(
          new Date(b.data.modDatetime ?? b.data.pubDatetime).getTime() / 1000
        ) -
        Math.floor(
          new Date(a.data.modDatetime ?? a.data.pubDatetime).getTime() / 1000
        )
    );
}
