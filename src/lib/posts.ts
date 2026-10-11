import { getCollection } from 'astro:content';

export async function getPosts() {
  return (await getCollection('blog', ({ data }) => !data.draft))
    .sort((a, b) => b.data.pubDate.valueOf() - a.data.pubDate.valueOf());
}

export function formatDate(date: Date) {
  return date.toLocaleDateString('en-IN', {
    day: 'numeric', month: 'short', year: 'numeric', timeZone: 'UTC',
  });
}
