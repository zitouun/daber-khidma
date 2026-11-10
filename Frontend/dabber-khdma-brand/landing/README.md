# Dabber Khdma — Responsive Landing Page

## Local preview

From the `dabber-khdma-brand` folder:

```bash
python -m http.server 8080
```

Open `http://localhost:8080/landing/`.

The landing uses only HTML, CSS, vanilla JavaScript and bundled SVG assets. No CDN, external trackers or npm installation is needed for preview.

## Features
- Responsive hero and illustrative project board
- Freelancer/client CTAs and interactive audience tabs (accessible keyboard arrow navigation)
- FAQ accordion, mobile menu, early-access form validation
- `prefers-reduced-motion` support and keyboard focus indicators
- Explicitly labeled pre-launch features; no fabricated marketplace statistics

## Early-access API integration

**Important:** The form deliberately does NOT save emails until a backend is connected.

Inject an API URL into the HTML *before* `script.js` loads:

```html
<script>window.DABBER_KHDMA_API_URL = '/api/v1/early-access';</script>
<script src="script.js" defer></script>
```

Use this request body: `{ "email": "user@example.com", "role": "FREELANCER", "consent": true }`.

The frontend displays submission success only after a non-error HTTP response. Backend must implement rate limiting, request validation, bot protection, duplicate handling, verified opt-in as appropriate, retention and deletion policy, operational monitoring and CORS restrictions. Do not open the early-access endpoint without these measures.

For deployment behind a Spring Cloud Gateway, route `/api/v1/early-access` to a dedicated registration module or service. The website itself can be deployed on any static host. If the larger product uses Next.js, the page may be migrated into App Router components; avoid reimplementing its business logic in Next.js API routes unless there is a deliberate BFF decision.
