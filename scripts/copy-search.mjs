import { cp } from 'node:fs/promises';
await cp('dist/pagefind', 'public/pagefind', { recursive: true });
