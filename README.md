# Go Beyond Challenge — Modernised Static Site

A clean, modern re-build of [gobeyondchallenge.com](https://www.gobeyondchallenge.com) as a fully static site ready for GitHub Pages hosting.

## Features

- **Colour theme preserved** — orange `#fb681a`, teal `#0283aa`, dark `#262626`
- **No WordPress / jQuery** — pure HTML5, CSS custom properties, vanilla JS
- **Responsive** — mobile-first, hamburger nav, CSS Grid layouts
- **Dynamic Calendar** — `calendar.html` fetches `data/events.json` at render time; update events by editing the JSON only
- **Formspree forms** — contact form and mailing list signup via Formspree (`xwvndkow`)
- **Blog removed** — no blog pages or links
- **Favicon** — SVG + PNG favicon with Go Beyond GB mark
- **CDN fallback** — every `<img>` has a `data-cdn` attribute; if a local image is missing the browser auto-loads it from the original CDN

## Structure

```
gobeyondchallenge/
├── index.html              Home page — event grid
├── calendar.html           Dynamic calendar (data-driven)
├── about.html              About Us
├── contact.html            Contact + Formspree mailing list
├── ultras.html             Ultra Marathons overview
├── shorter-runs.html       Shorter Runs overview
├── triathlon.html          Triathlon overview
├── cyclosportive.html      Tour de Northamptonshire
├── events/                 Individual event detail pages (10 pages)
├── about/                  Sub-pages (she-races, marshal, terms, privacy)
├── data/
│   └── events.json         ← Edit this to update the calendar
├── css/style.css
├── js/main.js
├── img/                    ← Images go here (see below)
├── favicon.svg
└── scripts/
    └── download-assets.sh  ← Run once to download images
```

## Getting Images

Images are not committed to the repo. Run the download script once from your Mac Terminal:

```bash
cd /Users/tarnewestcott/Development/gobeyondchallenge
bash scripts/download-assets.sh
git add img/
git commit -m "Add image assets"
git push
```

> **Note:** The site works immediately in any browser without running the download script —
> each `<img>` automatically falls back to the original `gobeyondchallenge.com` CDN if the local file is missing.

## Updating the Calendar

Edit `data/events.json` — no HTML changes needed. Each event object:

```json
{
  "id": "unique-slug",
  "title": "Full Event Title",
  "date": "10 January 2026",
  "dateISO": "2026-01-10",
  "month": "January",
  "category": "ultra",
  "categoryLabel": "Ultra Marathon",
  "distance": "43 miles",
  "location": "Location, County",
  "description": "Short description...",
  "image": "../img/filename.jpg",
  "imageCDN": "2020/11/filename.jpg",
  "link": "../events/event-page.html",
  "entryUrl": "https://enter-link.com",
  "tags": ["ultra", "trail"]
}
```

## Deploying to GitHub Pages

1. Push to `main` branch
2. **Settings → Pages → Deploy from branch → main → / (root)**
3. Live at `https://tarne75.github.io/gobeyondchallenge-alt/`

## Local Preview

```bash
cd /Users/tarnewestcott/Development/gobeyondchallenge
python3 -m http.server 8080
# open http://localhost:8080
```
