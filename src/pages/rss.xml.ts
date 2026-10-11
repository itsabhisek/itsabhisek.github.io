import rss from '@astrojs/rss';
import type { APIContext } from 'astro';
import { getPosts } from '../lib/posts';
import { site } from '../site';

export async function GET(context: APIContext) {
  return rss({
    title: site.title,
    description: site.description,
    site: context.site!,
    items: (await getPosts()).map(post => ({
      title: post.data.title,
      description: post.data.description,
      pubDate: post.data.pubDate,
      link: `/blog/${post.id}/`,
    })),
  });
}
