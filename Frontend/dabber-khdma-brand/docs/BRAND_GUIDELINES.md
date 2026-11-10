# Dabber Khdma — Brand Guidelines v1.0

**Status:** Creative proposal, not an approved trademark or verified available domain.

## Positioning
A Tunisian-rooted freelance marketplace that helps clients find capable talent and helps freelancers discover projects, submit proposals, collaborate, and deliver work in clear milestones.

**Primary promise:** From a project idea to work that gets done.

**Primary tagline:** `Famma projet? Dabber khdma.` / `فمّا مشروع؟ دبّر خدمة.`

**Alternative freelancer tagline:** `Mawhoubtek testahel forsa.` / `موهبتك تستاهل فرصة.`

**Tone:** Warm, clear, energetic, competent. Tunisian Derja in expressive headings and CTAs, paired with accessible French/English where needed. Don't use transliteration as the only way to access essential instructions. Provide Arabic script equivalents and eventually language switching with RTL support.

## Naming
- Primary Latin name: **Dabber Khdma** (title case in prose, lowercase in wordmark).
- Arabic: **دبّر خدمة**.
- Suggested repo slug: `dabber-khdma`.
- Pronunciation: approximate Tunisian Derja; do not prescribe a single international pronunciation.
- Avoid shortening to simply **Dabber** in legal/business contexts: a separate service marketplace using that shorter name appears in web search results. Full legal/trademark clearance remains required.

## Identity system
- Symbol: Interwoven `D` stroke. Crossing paths represents a client and a freelancer meeting, and a project proceeding to completion.
- Use logo-horizontal on cream/white background; use logo-inverse on forest green/dark backgrounds; logo-mark for favicon, app icon, social avatars.
- Clear space: at least 20% of symbol width around standalone mark.
- Minimum mark size: 32px digital. Minimum horizontal wordmark width: 170px.
- No gradients inside the mark, no distortion, no unapproved colors, no surrounding effects that reduce contrast.

## Color palette
| Name | Hex | Usage |
|---|---|---|
| Forest | `#183D37` | Primary brand, headings, main surfaces |
| Dark forest | `#102D29` | Deep backgrounds |
| Cream | `#F7F0E4` | Main warm background |
| Paper | `#FCFAF6` | Cards and form surfaces |
| Terracotta | `#E27E53` | Warm accent and highlights |
| Peach | `#F4A46D` | Decorative and supporting accent |
| Muted sage | `#677A72` | Secondary body text |
| Border | `#D9DED7` | Dividers |

Check WCAG contrast before shipping different text/background combinations; don't use terracotta as the only accessibility cue.

## Typography
The demo deliberately uses system stacks for reliable offline rendering. Suggested production combination: **Manrope** or **Plus Jakarta Sans** for Latin headings/body; **IBM Plex Sans Arabic** or **Noto Sans Arabic** for Arabic. Verify licensing and font-loading performance prior to adoption. Use a consistent bilingual design grid.

## Audience and messaging
### Freelancers
- Need: relevant project discovery, transparent scope, fair consideration, clear delivery and milestone tracking.
- CTA: `Nlawwej 3la khedma` / `نلوّج على خدمة`.
### Clients
- Need: discover qualified talent, compare proposals, manage delivery, know what happens next.
- CTA: `3andi projet` / `عندي مشروع`.

## Brand copy examples
- Hero: `El khedma tal9a nes'ha.` / `الخدمة تلقى ناسها.`
- Supporting: `Projects worth building. People ready to build them.`
- Promise: `Post the idea. Find the talent. Deliver together.`
- Avoid claims such as thousands of users, verified experts, AI accuracy, secure escrow, or guaranteed outcomes unless deployed and evidenced.

## UX principles
1. Two audiences, one unified brand.
2. Primary action obvious within 2 seconds.
3. Strong visual hierarchy; friendly but not childish.
4. Milestones and project status presented transparently.
5. Functional keyboard controls, semantic landmarks, focus-visible and reduced-motion support.
6. No false testimonials or fabricated metrics.

## Landing sections
Navigation → hero with interactive project preview → audience choice → how it works → features → categories → FAQ → early-access sign-up → footer.

## Conversion funnel and analytics (when analytics consent/implementation is approved)
Track `hero_cta_clicked`, `audience_tab_selected`, `faq_opened`, and `waitlist_submit_success` without storing sensitive personal data in tracking events. Use accessible, non-invasive analytics.

## Backend handoff
The landing waitlist can call a public Spring Boot endpoint `POST /api/v1/early-access` routed through the gateway. Suggested request: `{ "email": "...", "role": "FREELANCER|CLIENT" }`. Suggested response: `202 Accepted` on first submission, `200 OK` for idempotent duplicate, `400/422` validation, `429` rate limit, `503` unavailable. Never expose broker credentials to the browser. Store a salted email hash for dedupe if appropriate; apply retention, consent, abuse prevention, and privacy policy before launch.

**Note:** Landing preview included in this pack does not collect or persist sign-ups. It shows a clear integration message until the API endpoint is configured.
