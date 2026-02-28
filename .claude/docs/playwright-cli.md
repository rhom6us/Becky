# Playwright CLI Screenshot Reference

Self-contained reference for capturing browser screenshots with Playwright's CLI. No project dependencies required — everything runs via `npx`.

## Prerequisites

```bash
npx playwright install chromium
```

That's it. No `npm install`, no `package.json` needed. The `npx playwright` commands below will use the installed browser automatically.

## CLI Syntax

```bash
npx playwright screenshot [options] <url> <output-file>
```

The URL can be an `http://`, `https://`, or `file:///` URL.

## Token Cost Formula

Claude's vision charges are based on image dimensions, not file size:

```
tokens = (width x height) / 750
```

Images larger than 1568px on any edge are automatically resized (preserving aspect ratio) before token calculation. This means a 1600×1200 image gets shrunk, but an 800×600 image (640 tokens) is used as-is.

## Optimal Defaults

| Setting | Value | Why |
|---------|-------|-----|
| Viewport | `800,600` | 640 tokens/image; under 1568px threshold; forces responsive layouts |
| Format | JPEG (`.jpg`) | 60-80% smaller than PNG; token cost is identical (pixel-based) but transfer is faster |
| Color scheme | `light` | Better JPEG compression; more readable on white backgrounds |

Default command:

```bash
npx playwright screenshot --viewport-size="800,600" --color-scheme=light <url> <output>.jpg
```

## Local File URLs

Local paths must be converted to `file:///` URLs:

| Platform | Path | URL |
|----------|------|-----|
| Windows | `C:\Users\me\page.html` | `file:///C:/Users/me/page.html` |
| Windows | `C:/Users/me/page.html` | `file:///C:/Users/me/page.html` |
| Unix/Mac | `/home/me/page.html` | `file:///home/me/page.html` |

**Rules:**
- Always use three slashes after `file:`
- Replace all backslashes with forward slashes
- Do NOT URL-encode spaces in local paths (Playwright handles them)

## Full-Page Tiling Script

When `--full-page` produces a tall image that gets auto-shrunk to unreadable widths, use this scroll-and-tile approach instead. Each tile stays within the 800×600 viewport, so every tile is fully readable.

```javascript
// scroll-tile-screenshot.mjs
// Usage: node scroll-tile-screenshot.mjs <url> <output-prefix>
// Produces: <output-prefix>-tile-0.jpg, <output-prefix>-tile-1.jpg, ...

import { chromium } from 'playwright';

const [,, url, outputPrefix] = process.argv;
if (!url || !outputPrefix) {
  console.error('Usage: node scroll-tile-screenshot.mjs <url> <output-prefix>');
  process.exit(1);
}

const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 800, height: 600 }, colorScheme: 'light' });
await page.goto(url, { waitUntil: 'networkidle' });

const totalHeight = await page.evaluate(() => document.documentElement.scrollHeight);
const viewportHeight = 600;
const tiles = Math.ceil(totalHeight / viewportHeight);

for (let i = 0; i < tiles; i++) {
  await page.evaluate((y) => window.scrollTo(0, y), i * viewportHeight);
  await page.waitForTimeout(200); // let repaints settle
  await page.screenshot({ path: `${outputPrefix}-tile-${i}.jpg`, type: 'jpeg' });
}

await browser.close();
console.log(`Captured ${tiles} tile(s)`);
```

Run with: `node scroll-tile-screenshot.mjs <url> /tmp/page`

**Note:** This script requires Playwright's Node.js module. Since `npx playwright install chromium` was already run, the browser is available. The script uses ES module syntax (`.mjs`).

## Device Emulation

| Device | Viewport |
|--------|----------|
| `"iPhone 13"` | 390×844 |
| `"iPhone 13 Pro Max"` | 428×926 |
| `"iPad Mini"` | 768×1024 |
| `"Pixel 5"` | 393×851 |
| `"Galaxy S9+"` | 320×658 |

Usage: `npx playwright screenshot --device="iPhone 13" <url> <output>.jpg`

When `--device` is used, `--viewport-size` is ignored (the device preset sets the viewport).

## Available Flags Reference

| Flag | Description | Example |
|------|-------------|---------|
| `--viewport-size` | Viewport dimensions as `width,height` | `--viewport-size="1200,800"` |
| `--full-page` | Capture entire scrollable page (single tall image) | `--full-page` |
| `--wait-for-timeout` | Wait N milliseconds before capture | `--wait-for-timeout=3000` |
| `--device` | Emulate a device (overrides viewport) | `--device="iPhone 13"` |
| `--color-scheme` | `light` or `dark` | `--color-scheme=light` |
| `--browser` | Browser engine: `chromium`, `firefox`, `webkit` | `--browser=chromium` |

## Troubleshooting

| Error | Cause | Fix |
|-------|-------|-----|
| `browserType.launch: Executable doesn't exist` | Browser not installed | Run `npx playwright install chromium` |
| `page.goto: net::ERR_FILE_NOT_FOUND` | Bad file URL | Ensure `file:///` prefix with forward slashes |
| `page.goto: Timeout 30000ms exceeded` | Page didn't load in time | Add `--wait-for-timeout=5000` or check URL |
| Blank/white screenshot | JS hasn't rendered yet | Add `--wait-for-timeout=2000` |
| Unreadable full-page screenshot | Image too tall, auto-shrunk | Use tiling script instead of `--full-page` |
