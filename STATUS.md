# STATUS

## What was built

A free, fillable, printable KDP publishing kit for Asdale Dynamics, LLC, in
`/workspace/kilo-lab/free-kdp-publishing-kit`. Plain English, step by step,
large-print friendly, no account needed, nothing to install.

Files:

- `LICENSE` — MIT License, copyright line exactly
  `Copyright (c) 2026 Asdale Dynamics, LLC`
- `README.md` — kit overview, credits Asdale Dynamics, LLC and Dylan Asdale,
  links to dylanasdale.github.io
- `kit/pre-launch-checklist.md` — before-launch tasks (manuscript, cover,
  account, pricing, proof, launch-week prep)
- `kit/metadata-worksheet.md` — title, subtitle, description, categories,
  keywords, content details, rights and pricing fields
- `kit/upload-checklist.md` — step-by-step KDP upload from sign-in to after
  launch
- `kit/launch-week-calendar.md` — Day 0 through Day 7 launch plan with notes
- `html/style.css` — shared styles: 18px base, high contrast black-on-white,
  roomy checkboxes/inputs, print-friendly (@media print, @page margins)
- `html/pre-launch-checklist.html` — fillable checkbox version
- `html/metadata-worksheet.html` — fillable text/textarea version
- `html/upload-checklist.html` — fillable checkbox version
- `html/launch-week-calendar.html` — fillable calendar and task list version

Each HTML page opens in any browser, can be filled on screen, and prints cleanly
(File > Print, or Save as PDF). Print styles hide on-screen controls, strip
backgrounds, and avoid splitting rows across pages.

## How to run

1. Open any `html/*.html` file in Chrome, Edge, Firefox, or Safari.
2. Fill in the fields that apply to your book.
3. Print (Ctrl+P / Cmd+P) or choose "Save as PDF" in the print dialog.

No build step, no server, no internet needed after download. No personal data
is stored or sent anywhere.

## Verification results

- All 4 HTML files parse with zero errors (Python html.parser).
- All 4 HTML files link `style.css`.
- `LICENSE` contains the exact line `Copyright (c) 2026 Asdale Dynamics, LLC`.
- `README.md` credits Asdale Dynamics, LLC and Dylan Asdale.
- No `.github/workflows` directory; no secrets, API keys, or personal data in
  any file.
- Git initialized; commit `c4bd6dc` on branch `master` with plain message and
  no co-author trailers. Nothing pushed, no remote created.

## Known gaps

- Print rendering was validated structurally (CSS present, @media print rules
  in place) but not against a physical printer; print results can vary by
  browser and printer.
- HTML is standalone (single CSS file); no JavaScript validation or data
  export beyond browser print-to-PDF.
- Markdown files are static copies of the HTML content; if either is updated,
  the other should be updated by hand.
