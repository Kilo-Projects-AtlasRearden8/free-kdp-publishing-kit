# STATUS

## What was built

A free, fillable, printable KDP publishing kit for Asdale Dynamics, LLC, in
`/workspace/kilo-lab/free-kdp-publishing-kit`. Plain English, step by step,
never condescending — built for Dylan Asdale (registered nurse turned AI
author of *The Massive AI Manual*) and Asdale Dynamics, LLC (Indiana, formed
October 2026). Large-print friendly, no account needed, nothing to install,
nothing sent to a server.

Files:

- `LICENSE` — MIT License, copyright line exactly
  `Copyright (c) 2026 Asdale Dynamics, LLC`
- `README.md` — warm, polished overview; credits Asdale Dynamics, LLC and Dylan
  Asdale; links dylanasdale.github.io; explains who the kit is for and how to
  use it
- `kit/pre-launch-checklist.md` — before-launch tasks (manuscript, cover,
  account, pricing, proof, launch-week prep)
- `kit/metadata-worksheet.md` — title, subtitle, description, categories,
  keywords, content details, rights and pricing fields
- `kit/upload-checklist.md` — step-by-step KDP upload from sign-in to after
  launch
- `kit/launch-week-calendar.md` — Day 0 through Day 7 launch plan with notes
- `html/style.css` — shared styles: 18 px base, high-contrast black-on-white,
  roomy checkboxes/inputs, print-friendly (`@media print`, `@page` margins)
- `html/pre-launch-checklist.html` — fillable checkbox version with print button
- `html/metadata-worksheet.html` — fillable text/textarea version with print button
- `html/upload-checklist.html` — fillable checkbox version with print button
- `html/launch-week-calendar.html` — fillable calendar and task list with print button
- `scripts/verify.sh` — the project's test suite (see verification below)

Each HTML page opens in any browser, can be filled on screen, and prints cleanly
(File > Print or the on-screen "Print this page" button, or Save as PDF).
Typed answers and checked boxes print with the page. Print styles hide on-screen
controls, strip colors/backgrounds, and avoid splitting rows across pages.

## How to run

1. Open any `html/*.html` file in Chrome, Edge, Firefox, or Safari.
2. Fill in the fields that apply to your book.
3. Click "Print this page" or press Ctrl+P / Cmd+P; choose "Save as PDF" to
   keep a digital copy of your filled-in form.

No build step, no server, no internet needed after download. No personal data
is stored or sent anywhere.

## Verification results

`scripts/verify.sh` — all checks passed:

- All 11 required files present (LICENSE, README, 4 HTML, 4 Markdown, style.css)
- No `.github/workflows` directory
- All 4 HTML files parse cleanly and link `style.css`
- `LICENSE` contains the exact line `Copyright (c) 2026 Asdale Dynamics, LLC`
- `README.md` credits Asdale Dynamics, LLC
- Secrets scan: no secret-like patterns (API keys, passwords, private keys)
- All 4 HTML pages contain fillable controls (`<input>` / `<textarea>`)

Physical-printed output was not tested against an actual printer; results can
vary by browser and printer.

## Known gaps

- Print rendering validated structurally (CSS `@media print` rules present) but
  not against a physical printer.
- HTML is standalone (single CSS file); no JavaScript validation or data export
  beyond browser print-to-PDF.
- Markdown files are static copies of the HTML content; if either is updated,
  the other should be updated by hand.
