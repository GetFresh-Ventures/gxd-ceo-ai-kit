---
name: gfv-report-builder
description: Generate branded consulting report pages, slide decks, proposals, and presentations as images using the Google Gemini API with the GFD v4.4 design system. Use when the user wants to create 8.5x11 reports, slide decks, proposals, visual presentations, or any image-based document pages programmatically. Triggers on "generate slides", "create report pages", "build a deck", "make slides for", "create visual report", "generate pages for [client]", "8x11 report", "build a report", "build a proposal", or any request to produce branded visual documents.
---

# GFV Report Builder

Generate branded consulting report slides as high-quality images, then assemble into PDF.


## ⚡ MANDATORY: Intake Questionnaire (Ask Before Generating)

**Before generating ANY slides or report pages, ask the user the following questions.** Present them as a single block. If the user has already specified answers in their request, skip those questions and confirm the defaults you'll use.

### Questions to Ask:

```
1. GENERATION METHOD — Which engine?
   a) Direct API (DEFAULT — near-free, native 16:9/any ratio, ~$0.001-$0.005/slide via Gemini Flash)
   b) Free wrapper (built-in generate_image — $0, but outputs 1024×1024 squares, requires letterbox post-processing)
   c) Paid Flash batch (~$0.04/slide — generate_slides.py, includes logo compositing + PDF assembly)
   d) Paid Pro (~$0.13/slide — Gemini 3 Pro, no watermark, best quality)
   e) Browser Gem (free, native 4K 16:9, requires Chrome automation)

2. PAGE SIZE — What format?
   a) 16:9 Presentation (default for decks) → 3840×2160 (4K)
   b) 8.5×11 Report (default for print docs) → 2550×3300
   c) Square (social, one-pagers) → 2160×2160
   d) Custom — specify dimensions or aspect ratio

3. DESIGN STYLE — What aesthetic?
   a) GFD v4.4 (warm parchment, navy/teal/gold — GFV default)
   b) Client brand (specify: dark mode, specific colors, fonts)
   c) Minimal/clean (white background, single accent color)
   d) Custom — describe the look you want

4. CLIENT BRANDING — Which logos in the footer?
   a) GFV only (GetFresh Ventures logo)
   b) Client + GFV (dual logo — specify client logo path)
   c) Client only
   d) No logos

5. SLIDE COUNT — How many slides?
   (Provide number or say "you decide based on content")
```

### Defaults (if user says "just do it" or "use defaults"):

| Setting | Default |
|---|---|
| Method | Direct API (Method 1b — native aspect ratio via Gemini Flash, ~$0.001/slide) |
| Size | 16:9 at 2K (3640×2048) |
| Style | GFD v4.4 (parchment + navy) |
| Logos | Client + GFV (dual, composited in post-processing) |
| Slides | Agent determines from content |

### After Intake:

1. Confirm the configuration back to the user in one line (e.g., *"Got it — 14 slides, free method, 16:9 4K, GFD v4.4 style, Aprio + GFV logos"*)
2. Generate 2 test slides first (one text-heavy, one data-heavy)
3. Show test slides for approval before generating the full batch
4. Post-process all slides (verify dimensions, composite logos, page numbers)
5. Assemble PDF and deliver


## Why This Skill Exists

Creating branded visual report pages manually is slow. AI image generation can produce consulting-grade slides programmatically, but the workflow has pitfalls:
- **Logo drift**: AI models forget or distort logos across multiple generations. Fix: NEVER let Gemini render logos — composite real PNGs in post-processing.
- **Style inconsistency**: Each image can look different. Fix: include the full design system in every prompt (colors, typography, layout rules).
- **Gemini watermark**: Free-tier and Flash models add a Gemini logo. Fix: use `gemini-3-pro-image-preview` (paid, no watermark) for final versions only.
- **Layout annotation bleed**: Including layout percentages (e.g. "22%") or section labels (e.g. "SECTION 4 — CONTRACT HISTORY") in prompts causes Gemini to render them as visible text. Fix: describe layout naturally, never include measurement annotations.


## GFD Slide Build Prompt Template (v4.4)

The following is the master prompt template that governs all slide/report generation.

```
/* ============================================================================
GFD SLIDE DECK PROMPTING MODEL (GEMINI 3.0 NANO BANANA PRO READY)
VERSION 4.4 — COMPREHENSIVE, RESTORED, EXTENDED

Purpose:
Train an AI to generate a full slide deck as a sequence of image-generation prompts.

This prompt:
- Preserves all capabilities from Version 2.2
- Adds GetFresh Ventures default branding and design system
- Adds deterministic footer logic with single vs dual logo handling
- Makes visuals optional and intelligence-driven
- Enforces mandatory Title and Closing slides
============================================================================ */


/* ============================================================================
0. NANO BANANA PRO OPERATING RULES (MODEL DISCIPLINE)
============================================================================ */

- Always specify: Subject, Composition, Action, Location, Style.
- Always specify canvas: aspect ratio, orientation, resolution target.
- Always specify text integration: exact strings, placement, size, font style, casing.
- For diagrams and infographics: declare factual constraints and require accuracy.
- If using reference images: name each image and define the role of each.
- If editing an existing image: state direct edit instructions as atomic changes.
- Optimize for legibility: large headline text, limited body text, clear hierarchy.
- Avoid tiny text, dense paragraphs, and ambiguous placeholders.

KNOWN LIMITATIONS TO ACCOUNT FOR:
- Small text and spelling may vary. Keep text large and verify after generation.
- Diagrams and data visuals require manual verification of accuracy.
- Localization may introduce grammar issues. Verify language quality.
- Complex blends and lighting edits may create artifacts.
- Character consistency can drift. Use reference images and repeated descriptors.


/* ============================================================================
0.1 DEFAULT BRAND ASSUMPTION (GETFRESH VENTURES)
============================================================================ */

DEFAULT_BRAND_SYSTEM = {
  BRAND_NAME: "GetFresh Ventures",
  ARTIFACT_TYPE: "GetFresh Artifact",
  PRIMARY_LOGO_REQUIRED: true,
  PARTNER_LOGO_OPTIONAL: true,
  PLACEHOLDER_TEXT_FOR_LOGOS: "STRICTLY FORBIDDEN"
}


/* ============================================================================
0.2 LOGO CONTEXT LOGIC (SINGLE VS DUAL LOGO)
============================================================================ */

LOGO_CONTEXT_RULES:

CASE A — SINGLE LOGO (DEFAULT):
- Only GetFresh Ventures logo provided.
- Render GetFresh logo bottom-right.
- Do not render partner logos.
- Do not render empty containers or labels.

CASE B — DUAL LOGO (CO-BRANDED):
- GetFresh logo + partner logo explicitly provided.
- GetFresh remains primary unless overridden.
- Partner logo bottom-left, GetFresh bottom-right.

CASE C — PARTNER PRIMARY (EXPLICIT ONLY):
- Only if user explicitly instructs.
- Never inferred.

ABSOLUTE RULES:
- Never generate placeholder text (e.g. "Footer_brand").
- Never infer missing logos.
- Never render empty logo frames.


/* ============================================================================
0.3 GLOBAL LAYOUT ANCHOR SYSTEM (LOGOS + PAGE NUMBERS)
============================================================================ */

FOOTER_ANCHOR_SYSTEM = {
  FOOTER_BAND: {
    HEIGHT: "7% of slide height",
    POSITION: "bottom full-width",
    BACKGROUND: "transparent or subtle tint",
    ALIGNMENT: "vertical center"
  },
  PRIMARY_LOGO: {
    POSITION: "bottom-right inside footer band",
    WIDTH: "6% of slide width",
    ASPECT_RATIO: "preserved"
  },
  PARTNER_LOGO: {
    POSITION: "bottom-left inside footer band",
    WIDTH: "4.5% of slide width",
    RENDER_ONLY_IF_PROVIDED: true
  },
  PAGE_NUMBER: {
    POSITION: "bottom-center inside footer band",
    FORMAT: "numeral only",
    FONT: "label or body style",
    COLOR: "muted neutral or accent",
    SIZE: "smallest readable element"
  }
}


/* ============================================================================
0.4 GETFRESH VISUAL & GRAPHIC DESIGN SYSTEM (DEFAULT)
============================================================================ */

GETFRESH_VISUAL_SYSTEM = {
  CANVAS: {
    ASPECT_RATIO: "16:9",
    ORIENTATION: "landscape",
    RESOLUTION: "2K or 4K",
    BACKGROUND: "warm off-white or parchment tone with subtle grid or paper texture"
  },
  COLORS: {
    PRIMARY: "deep navy / slate blue",
    SECONDARY: "muted teal / blue-green",
    ACCENT: "warm gold / sand",
    SUPPORTING: "soft grey neutrals"
  },
  TYPOGRAPHY: {
    HEADLINES: "modern humanist sans-serif, bold, sentence case",
    BODY: "clean sans-serif, generous spacing",
    LABELS: "small caps or all caps, muted accent"
  },
  DIAGRAM_STYLE: {
    GEOMETRY: "rounded",
    DEPTH: "flat or lightly dimensional",
    FLOW: "explicit directional arrows",
    FORMS: ["funnels", "engines", "loops", "stacks", "timelines"]
  }
}


/* ============================================================================
0.5 INTELLIGENT VISUAL USAGE RULES
============================================================================ */

USE VISUALS WHEN:
- They reduce cognitive load.
- They clarify systems, flows, or relationships.
- They create shared mental models faster than text.

AVOID VISUALS WHEN:
- They repeat the text verbatim.
- The insight is clearer as text.
- They serve decoration rather than understanding.

TEXT-ONLY SLIDES ARE VALID AND ENCOURAGED.


/* ============================================================================
1. DECK-LEVEL THINKING MODEL
============================================================================ */

DECK_PLANNING_MODEL = {
  CONTEXT: {
    AUDIENCE: "<target audience>",
    CORE_THESIS: "<single declarative claim>",
    OUTCOME: "<what must be understood or decided by the end>"
  },
  STORY_ARC: [
    { STAGE: "TITLE", ROLE: "Orient and frame" },
    { STAGE: "HOOK", ROLE: "Surface tension" },
    { STAGE: "CONTEXT", ROLE: "Current reality" },
    { STAGE: "DIAGNOSIS", ROLE: "Root cause" },
    { STAGE: "MODEL", ROLE: "Framework or engine" },
    { STAGE: "EVIDENCE", ROLE: "Patterns or proof" },
    { STAGE: "PLAYBOOK", ROLE: "Actions and levers" },
    { STAGE: "CLOSE", ROLE: "Synthesis and commitment" }
  ],
  MANDATORY_SLIDES: ["TITLE", "CLOSE"],
  SLIDE_PLAN: []
}


/* ============================================================================
2. GLOBAL RULES FOR FULL DECK GENERATION
============================================================================ */

- Every slide prompt is fully standalone.
- Repeat canvas, palette, typography, cinematic controls, logo rules, and page numbering.
- Maintain narrative continuity.
- Visuals are optional and intelligence-driven.
- Logos and page numbers must follow FOOTER_ANCHOR_SYSTEM.
- Avoid micro-text.


/* ============================================================================
3. STANDALONE SLIDE PROMPT TEMPLATE (PER SLIDE)
============================================================================ */

// SLIDE [N] — [VISIBLE TITLE TEXT]

MODEL TARGET:
Create a high-resolution GetFresh Ventures presentation slide.

FOUNDATION:
- Subject:
- Composition:
- Action:
- Location:
- Style:

CANVAS:
- Aspect ratio: 16:9
- Resolution: 2K or 4K
- Background: warm off-white with subtle texture

TEXT (EXACT STRINGS):
- Headline:
- Subtitle:
- Body blocks (2–4):

VISUAL PANEL (OPTIONAL):
- Include only if it adds clarity
- Diagram type if used

FOOTER:
- Bottom-left: partner logo only if provided
- Bottom-center: page number "[N]"
- Bottom-right: GetFresh Ventures logo (exact asset)

STORY CONTINUITY:
- Connects from previous:
- Sets up next:

FINAL VALIDATION:
- Correct logo logic
- No placeholders
- Visuals used intelligently
- Title and closing slides present
```


## Canvas Formats & Sizes

The `generate_image` tool **always outputs 1024×1024 square images** regardless of prompt phrasing. This has been verified repeatedly. For non-square formats, **you MUST post-process with Pillow** to letterbox onto the correct canvas.

### Target Formats

| Format | Final Resolution | Aspect | Post-Processing |
|---|---|---|---|
| **16:9 presentation** (DEFAULT) | 1920×1080 or 3840×2160 (4K) | 1.78:1 | Letterbox 1024×1024 → 16:9 canvas |
| **8.5×11 report** | 2550×3300 | 0.77:1 | Letterbox 1024×1024 → portrait canvas |
| **Square** | 1024×1024 or 2160×2160 | 1:1 | None needed (native) or upscale |

### Selection Rules

1. **Presentations / decks / slides** → default to **16:9 at 1920×1080** (free) or **3840×2160** (paid)
2. **Reports / proposals / print documents** → default to **8.5×11 (2550×3300)**
3. **Social / thumbnails** → default to **Square (1024×1024 native)**
4. **User specifies a size** → use exactly what they ask for

### Post-Processing Pipeline (MANDATORY for non-square)

After generation via the free `generate_image` tool, run Pillow to transform:

```python
from PIL import Image, ImageDraw
import numpy as np

def postprocess_slide(src_path, target_w=1920, target_h=1080, bar_color=(26, 32, 44)):
    """Transform 1024x1024 square into target aspect ratio with footer bar."""
    src = Image.open(src_path).convert("RGB")
    
    # Sample background color from top-left corner for seamless blending
    bg = np.array(src.crop((0, 0, 50, 50)))
    bg_color = tuple(int(bg[:,:,c].mean()) for c in range(3))
    
    # Create target canvas
    canvas = Image.new("RGB", (target_w, target_h), bg_color)
    bar_h = int(target_h * 0.08)
    content_h = target_h - bar_h
    
    # Scale source to fit content area
    scale = min(content_h / src.height, target_w / src.width)
    new_w, new_h = int(src.width * scale), int(src.height * scale)
    src_resized = src.resize((new_w, new_h), Image.LANCZOS)
    
    # Center on canvas
    canvas.paste(src_resized, ((target_w - new_w) // 2, 0))
    
    # Draw footer bar
    draw = ImageDraw.Draw(canvas)
    draw.rectangle([(0, target_h - bar_h), (target_w, target_h)], fill=bar_color)
    
    return canvas  # Then composite logos onto this
```

Key steps after letterboxing:
1. **Composite logos** into the footer bar (never let the AI render logos)
2. **Add page numbers** centered in footer if multi-slide deck
3. **Assemble PDF** from all processed slides


## Image Generation: Cost Hierarchy

**RULE: Default to FREE. Only use paid API when Diraj explicitly approves.**

### Method 1a (FREE — Wrapper Fallback): Antigravity `generate_image`

The built-in `generate_image` tool is **free** but the Antigravity wrapper does not pass `aspect_ratio` or `image_size` to the underlying Gemini API, so **all outputs default to 1024×1024 (1:1, 1K).** Use this only as a fallback if Method 1b fails. Post-process with the letterbox pipeline above.

### Method 1b (FREE/CHEAP — PREFERRED): Direct Gemini API Call

Bypass the wrapper and call the Gemini image generation API directly. This gives you **native aspect ratio control** at up to 2K resolution. Cost is negligible (~$0.001-$0.005/image on Flash).

```python
import google.generativeai as genai
from google.genativeai import types
import base64, os
from pathlib import Path

genai.configure(api_key=os.environ.get("GEMINI_API_KEY"))

def generate_slide(prompt, output_path, aspect_ratio="16:9", image_size="2K", 
                   model="gemini-3.1-flash-image-preview"):
    """Generate a slide image with native aspect ratio control."""
    response = genai.GenerativeModel(model).generate_content(
        prompt,
        generation_config=types.GenerationConfig(
            response_modalities=["TEXT", "IMAGE"],
            image_config=types.ImageConfig(
                aspect_ratio=aspect_ratio,
                image_size=image_size,
            )
        )
    )
    # Extract image from response
    for part in response.candidates[0].content.parts:
        if hasattr(part, 'inline_data') and part.inline_data.mime_type.startswith('image/'):
            img_data = base64.b64decode(part.inline_data.data)
            Path(output_path).write_bytes(img_data)
            return output_path
    raise ValueError("No image in response")

# Usage:
generate_slide(
    "Create a consulting slide with warm parchment background...",
    "slide_01.png",
    aspect_ratio="16:9",  # "1:1", "16:9", "9:16", "4:3", "3:4"
    image_size="2K",       # "1K" (1024px) or "2K" (2048px)
)
```

**Supported aspect ratios:** `"1:1"`, `"16:9"`, `"9:16"`, `"4:3"`, `"3:4"`
**Supported sizes:** `"1K"` (1024px long edge), `"2K"` (2048px long edge)

**Key:** This uses your GEMINI_API_KEY but costs almost nothing on Flash. Set the key via:
```bash
export GEMINI_API_KEY=$(security find-generic-password -s "gemini-api-key" -w 2>/dev/null)
```

### Method Selection Flow

1. **Try Method 1b first** (direct API) — native 16:9, best quality, near-free
2. **If API key missing or rate-limited** → fall back to Method 1a (wrapper) + letterbox post-processing
3. **If Diraj approves paid** → use Method 2 (`generate_slides.py`) for batch processing with built-in logo compositing

### Method 2 (PAID — Requires Approval): `generate_slides.py`

Uses Gemini API. **~$0.04/slide (Flash)** or **~$0.13/slide (Pro)**. Generates native 16:9 — no post-processing needed. Includes automatic logo compositing and PDF assembly.

```bash
python3 ~/Documents/Code/gfv-brain/scripts/generate_slides.py \
  <prompts_dir> \
  --model gemini-3.1-flash-image-preview \
  --logos ~/Desktop/logos/now-of-work-logo-darkbg.png \
          ~/Desktop/logos/GetFresh\ Logo\ -\ Stacked\ -\ transparent.png \
  --output-dir <output_dir> --pdf <output.pdf>
```

**Only use when:** Diraj says "use the API" or "use paid" or approves the cost.

### Method 3 (FREE — Best Quality): GFV Slide Builder Gem (browser)

Zero cost, native 4K 16:9, but requires browser automation via Chrome MCP.

### MANDATORY: Test 2 Slides Before Full Batch

**Never generate all slides in one batch.** Always:
1. Write prompts for **only 2 representative slides** (one text-heavy, one data-heavy)
2. Generate just those 2
3. **Visually audit** both outputs: aspect ratio, font consistency, logo placement, content accuracy
4. Fix any prompt issues found
5. Only THEN generate the full batch

### Partner Logo Locations
- **GFV (dark bg):** `~/Desktop/logos/GetFresh Logo - Stacked - white-transparent.png`
- **GFV (light bg):** `~/Desktop/logos/GetFresh Logo - Stacked - transparent.png`
- **NoW of Work:** `~/Desktop/logos/now-of-work-logo-darkbg.png` (from Squarespace CDN)
- Source URL: `https://images.squarespace-cdn.com/content/v1/61f759a39fe16f5c0721079f/2d5fef84-9f50-45c4-81fe-083fef7b5d29/NoW_logo_2022_colour_darkbg.png?format=1500w`


## Three Generation Methods

### Method 1: GFV Slide Builder Gem (FREE — Preferred for Client Work)

Uses the GFV Slide Builder Gem via Chrome browser automation. Zero API cost, 4K resolution, no watermark.

**Gem URL:** `gemini.google.com/gem/8f2dfeb4f5b7/f8ebe0db66a10f8f`

The Gem has the full GFD v4.4 design system baked into its instructions. Just send each prompt.

**Browser automation workflow (via Chrome MCP):**

1. Open the Gem in Chrome
2. For each slide prompt, use this Quill editor injection pattern:

```javascript
// Gemini uses a Quill rich text editor. This is the ONLY reliable method.
const q = document.querySelector('.ql-container').__quill;
q.deleteText(0, q.getLength(), 'user');
q.insertText(0, promptText, 'user');
// Then click send:
setTimeout(() => {
    document.querySelector('button[aria-label="Send message"]').click();
}, 300);
```

3. Wait ~30 seconds per slide for image generation
4. Repeat for all slides
5. Download images from the Gemini chat manually

**Critical: Why Quill matters**
- Gemini's input is a Quill editor (`ql-editor` class, `contenteditable="true"`)
- Standard approaches FAIL: `Cmd+V` paste, `type` action, `form_input`, `innerHTML` (TrustedHTML blocks it)
- `document.execCommand('insertText')` works ~50% of the time (unreliable)
- `quill.setText()` sets text visually but Gemini doesn't read it on send
- **`quill.insertText(0, text, 'user')`** is the ONLY method that reliably triggers Gemini's internal state via Quill's `'user'` source parameter

### Method 2: Gemini API (Paid — For Automation at Scale)

```bash
python3 ~/Documents/Code/gfv-brain/scripts/generate_slides.py \
  ~/path/to/slide-prompts.md \
  --model gemini-3.1-flash-image-preview \
  --logos ~/Desktop/logos/GetFresh\ Logo\ -\ Stacked\ -\ transparent.png
```


## Models and Pricing (April 2026)

| Model | Cost/image | Watermark | Quality | Use when |
|---|---|---|---|---|
| `gemini-3.1-flash-image-preview` | $0.045 (1K) | Yes (small) | Good | **DEFAULT — all drafts, iteration, review** |
| `gemini-3-pro-image-preview` | $0.134 (1K) / $0.240 (4K) | **No** | Best | **Only when user explicitly asks for Pro** |
| `imagen-4.0-fast-generate-001` | $0.02 | No | Good | Cheap batch, no logo ref support |

**RULE: Always default to Flash.** Only use Pro when the user explicitly requests it for a final client version. Do not upgrade to Pro on your own.


## Self-Audit Before Presenting (MANDATORY)

**Review every slide visually before showing the deck to the user.** Check for:

1. **No Gemini-rendered logos** — only composited logos should appear
2. **No `MODEL TARGET` or slide identifier text** visible on any slide
3. **No text stuttering** — words repeated at the start of text blocks
4. **Logos readable** — both client and GFV logos visible in the footer bar, correct color variant
5. **No doubled bars** — only one dark bar per slide, not a Gemini bar plus a script bar
6. **No doubled page numbers** — if Gemini rendered a number, script should have skipped
7. **No page numbers on banner slides** — slides with colored bars should NOT have a composited page number overlaid
8. **Consistent footer bars** — all slides should have a dark bar (drawn by script if Gemini didn't)
9. **No stray text** from prompt prohibition (e.g., "only" rendered as visible text)
10. **Font consistency** — flag major font changes between slides
11. **No layout annotation bleed** — percentages like "22%", "LEFT COLUMN", "SECTION 4" must NOT appear as visible text

If any slide fails audit:
- Logo/bar/page number issues: **re-composite from raw** (no regeneration needed)
- Content issues (text stutter, identifier text, stray words): **delete that slide's PNG + raw copy, re-run script** (only regenerates missing slides)
- Do NOT regenerate the full deck for partial issues


## Logo Handling (STRICT — Codified from Voss Deck Build)

**HARD RULE: Gemini must NEVER render logos.** All logos are composited as real PNGs in post-processing. This is non-negotiable.

### Why:
- Gemini reconstructs logos from memory — they drift, blur, double up, and look unprofessional
- Footer areas are prone to hallucination — random text, duplicate logos, garbled renders
- The ONLY way to get pixel-perfect logos is to composite real PNG files after generation

### Logo Pipeline (7 problems solved during Voss build):

#### 1. Prompt discipline — CLEAN PROMPTS, NOT RUNTIME STRIPPING
- **Prompts must be clean from the start.** Do NOT include MODEL TARGET lines, FOOTER blocks with logo rendering instructions, or CRITICAL LOGO RULE text
- The `prepare_prompt()` function has a safety net that strips legacy elements, but this is a fallback — not the workflow
- When `--logos` is passed, the script appends a short "do not draw logos" line
- Prompts should request a **thick dark navy footer bar (8% of canvas)** — this is where logos go
- **When creating new prompts:** use v4+ format. Content only + design directions. No footer/logo/identifier blocks.

#### 2. Raw file preservation
- Script saves raw Gemini output to `raw/` subdirectory BEFORE compositing
- Composite writes to a COPY, never the original
- Allows re-compositing with different logo settings without regenerating slides

#### 3. Footer bar handling
- Script scans bottom 2% of canvas for dark pixels to detect Gemini-rendered footer bar
- If bar exists and >= min height (5% canvas or 38px): **use as-is, do NOT draw over it** — doubling was a major bug
- If bar is too thin: REPLACE it (draw our own consistent dark navy bar at `(26, 32, 44)`)
- If no dark bottom at all: draw our own bar
- **NEVER draw a bar on top of an existing adequate bar** — this was the cause of doubled bars on multiple slides

#### 4. Logo placement inside the bar
- Client logo left (2% margin), GFV logo right (2% margin)
- Client logo: 12% of canvas width. GFV logo: 15% of canvas width.
- Height capped at 80% of bar height
- ALWAYS uses white/light logo variants on dark bars — auto-detected via `find_light_variant()`

#### 5. Page number handling (SMART — do not double)
- Page numbers are composited in post-processing, centered in the bar, white text
- **Before drawing:** check if one already exists by sampling center 10% of bar
- If `std > 10` (text present) OR `max brightness > 180` on dark bar: **SKIP**
- Slides with colored banner text in the bar area: skip page number entirely

#### 6. White variant auto-detection (`find_light_variant()`)
Tries patterns in order:
1. `stem.replace('- transparent', '- white-transparent')`
2. `stem.replace('-transparent', '-white-transparent')`
3. `stem.replace('hires-transparent', 'white-transparent')`
4. `stem-white.png`
5. For GFV logos: `GetFresh GFV Logo/png/white_logo_transparent_background.png` (fallback)

#### 7. Common Gemini footer behaviors

| What Gemini Does | How We Handle It |
|---|---|
| Renders a thick dark bar with page number | Use as-is, skip our page number |
| Renders a thin dark bar (< 38px) | Replace with our bar, add our page number |
| Renders no bar at all | Draw our bar, add our page number |
| Renders a colored banner bar at bottom | Detect as existing bar, skip page number |
| Renders logos in the bar | Our composite overwrites |
| Renders "MODEL TARGET" as visible text | `prepare_prompt()` strips these |
| Renders fragments of prohibition text | Keep prohibition text short |

### Logo file requirements:
- **Must be PNG** with transparent background (RGBA mode)
- **Must have >5% transparent pixels** — a white-background PNG saved as RGBA will be rejected
- Use `-transparent` suffix files

### Logo file inventory (GFV standard):
| File | Resolution | Transparency | Use |
|---|---|---|---|
| `GetFresh Logo - Stacked - transparent.png` | 3173x1262 | 71.7% | Dark variant for light backgrounds |
| `GetFresh Logo - Stacked - white-transparent.png` | 3173x1262 | 71.7% | Auto-selected for dark bar |
| `GetFresh Logo - Stacked.png` | 3173x1262 | **0%** | **NEVER USE — white background** |

### Logo preparation for new clients:
1. Get highest resolution logo available (vector/SVG preferred, PNG minimum 800px)
2. Ensure true transparency — check RGBA mode and >5% transparent pixels
3. Crop whitespace — find bounding box of non-transparent pixels, crop with 20px padding
4. Upscale to 4x if source < 2000px — use LANCZOS resampling
5. Create white variant — invert RGB channels where alpha > 0 (keep transparency)
6. Naming convention: `{client}-logo-4x-transparent.png` (dark) and `{client}-logo-4x-white-transparent.png` (white)


## Writing Prompts — Best Practices (From Google Official Docs + Voss Build)

### Gemini 3 Prompt Rules:
- **Be direct, not verbose.** Gemini 3 favors directness over persuasion and logic over verbosity. Over-engineered prompts cause worse results.
- **Structured prompts work best.** Clearly separate objectives from constraints. Use FOUNDATION, CANVAS, TEXT sections.
- **Use cinematic/photographic language** for composition cues — "wide-angle", "centered composition", "generous whitespace"
- **Describe specific visual attributes** — be specific ("warm off-white parchment background with subtle linen texture"), not vague ("make it look professional")
- **Temperature: leave at 1.0** — Gemini 3 is optimized for default
- **Keep text blocks short** — under 30 words per text block. Long text = stuttering.
- **Name exact strings** — never let Gemini imagine text

### Works well:
- Large bold headlines (1-2 lines)
- Simple bullet point lists (5-7 items max)
- Two-column layouts
- Data tables with 3-5 rows
- Rounded card layouts
- Color-coded section badges
- Clean backgrounds with subtle textures
- Diagrams with 3-5 nodes max

### Works poorly — plan for post-processing or simplification:
- **Small text** — anything below ~14pt equivalent gets blurry or misspelled
- **Long quotes** — text stuttering (first words repeated). Keep quotes under 30 words.
- **Complex tables** — more than 6 rows or 4 columns gets mangled. Split across slides.
- **Consistent fonts** — Gemini picks different fonts per slide. Accept some drift.
- **Exact color matching** — specify "teal", "navy" but Gemini's interpretation varies ±10%
- **Diagrams with many nodes** — more than 5 connected elements gets messy
- **Logos and page numbers** — NEVER let Gemini render. Always composite.
- **Layout annotations** — percentages, column labels, section headers get rendered as visible text

### Spell-check strategy:
- After generation, visually scan each slide for misspelled words
- Common Gemini errors: doubled first words, dropped letters, "teh" for "the"
- If critical words (company names, dollar figures): verify they rendered correctly
- Pro model has significantly better text accuracy than Flash
- Add a SPELLING CHECK section in every prompt for proper nouns

### Sources:
- [Gemini 3 Prompting Guide](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/start/gemini-3-prompting-guide)
- [Image Generation Best Practices](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/multimodal/gemini-image-generation-best-practices)
- [Prompting Tips (Google Blog)](https://blog.google/products-and-platforms/products/gemini/image-generation-prompting-tips/)


## Incremental Fixes (CRITICAL — Never Regenerate Full Deck)

When fixing specific slides, NEVER regenerate the entire deck. This wastes tokens and money.

### Fix logo/composite issues only (no regeneration):
Raw files are preserved in `raw/` subdirectory. Re-composite from raw:
```python
import shutil
from generate_slides import composite_logos, assemble_pdf
for i in range(1, 21):
    shutil.copy(f'raw/slide_{i:02d}.png', f'slide_{i:02d}.png')
    composite_logos(Path(f'slide_{i:02d}.png'), logos)
assemble_pdf(Path('.'), Path('report.pdf'))
```

### Fix specific broken slides only:
```bash
# Delete only the broken slides, then run — script skips existing files
rm slide_06.png slide_07.png  # and their raw/ copies
[STUB AVOIDED] Execute generate_slides.py via available MCP/agent tools rather than a missing local script prompts.md --logos ...  # only generates missing
```

### NEVER do full regeneration unless:
- The design system changed (colors, typography, layout structure)
- The prompt template changed globally
- You're switching from Flash to Pro for the final version


## Resuming Interrupted Runs

```bash
# Resume from slide 6
[STUB AVOIDED] Execute generate_slides.py via available MCP/agent tools rather than a missing local script prompts.md --start 6 --logos ...
```
Already-generated slides are automatically skipped.


## End-to-End Deck Workflow

Every deck follows this sequence. Do not skip steps.

### Phase 1: Content
1. Write all slide content in plain text (present to user for review)
2. Research and verify all facts, names, company names
3. Get user approval on content before touching images

### Phase 2: Prompts
4. Write clean prompts following GFD v4.4 template (no MODEL TARGET, no FOOTER logo instructions, no layout annotations)
5. Each prompt = one slide. Content only + design directions
6. Save as `slide-prompts-v{N}.md`

### Phase 3: Draft Generation
7. Generate with **Flash** (always Flash for drafts — never Pro unless user asks)
8. Script auto-audits for doubled bars after generation
9. **Agent visually reviews every slide** (read each PNG) before presenting
10. Present to user, collect ALL feedback before making changes

### Phase 4: Fix
11. Fix only broken slides — delete PNG + raw copy, re-run (skip existing)
12. For logo/bar/page-number-only issues — re-composite from raw (no regeneration)
13. Re-audit, re-present

### Phase 5: Final
14. When user approves at Flash quality:
    - Only then upgrade to Pro if user requests
    - Rename PDF: `{Client} - {Title} - GFV {Month} {Year}.pdf`


## Resolution Workflow

| Phase | Resolution | Model | Purpose |
|---|---|---|---|
| Draft / iteration | 1K (~1376px) | Flash | Fast feedback, cheap, logo/layout testing |
| Review with user | 1K | Flash | Content approval, layout approval |
| Final client version | 4K | Pro (if requested) | Print-ready, no watermark, crisp text |

- **Never generate at 4K during iteration** — waste of money and time
- **Only upgrade to Pro for the final run** after all content issues resolved


## Versioning Convention

### Prompt files:
`slide-prompts-v{N}.md` — increment N for each major content revision

### Output directories:
`v{N}_{model}_slides/` — e.g., `v5_flash_slides/`, `v6_pro_slides/`

### PDF naming:
`{Client} - {Title} - GFV {Month} {Year}.pdf`
Example: `Voss Distributing - Operations Diagnostic and Agentic Roadmap - GFV March 2026.pdf`

### Raw files:
Always preserved at `{output_dir}/raw/slide_NN.png` — enables re-compositing without regeneration


## What Post-Processing Can Fix (No Regeneration)

| Issue | Fix | Method |
|---|---|---|
| Wrong logo color (dark on dark) | Re-composite from raw | `composite_logos()` |
| Logo too small/large | Adjust sizing params, re-composite | Edit script params |
| Missing page numbers | Re-composite from raw | `composite_logos()` adds them |
| Doubled page numbers | Re-composite from raw | Draws fresh from clean raw |
| Bar too thin | Re-composite from raw | Script auto-detects and draws |
| Doubled bars | Re-composite from raw | Script fixed for this |


## What Requires Regeneration

| Issue | Fix | Method |
|---|---|---|
| Text stutter ("Building a Building a") | Delete slide PNG + raw, re-run | Regenerates only missing |
| Wrong content | Update prompt, delete PNG + raw, re-run | Edit prompt, one slide |
| "MODEL TARGET" visible | Update prompt (v4+ format), delete + re-run | Should not happen with clean prompts |
| Font drastically different | Delete + re-run (may take 2-3 attempts) | Accept some drift |
| Layout annotation visible ("22%", "SECTION 4") | Rewrite prompt without annotations | Describe layout naturally |


## Dependencies

```bash
pip3 install google-genai Pillow numpy
```

Requires `GOOGLE_API_KEY` in macOS Keychain:
```bash
security find-generic-password -s 'GOOGLE_API_KEY' -w
```

## Script Location

```
~/Documents/Code/gfv-brain/scripts/generate_slides.py
```

## Common Logo Paths (GFV)

All logos stored in `~/Desktop/logos/` (symlinked to `gfv_gtm/artifacts/logos/all/`).

### GFV logos (always available):
```
GetFresh Logo - Stacked - transparent.png       # Dark on transparent — light backgrounds
GetFresh Logo - Stacked - white-transparent.png  # White on transparent — dark bars
GetFresh Logo - Stacked.png                     # NEVER USE — white background, not transparent
```

### Client logos (prepare per client):
```
{client}-logo-4x-transparent.png               # Dark, cropped, 4x upscaled
{client}-logo-4x-white-transparent.png          # White variant for dark bars
```


<verification_gate>
# Delivery Gate

STOP AND VERIFY BEFORE DECLARING THIS TASK COMPLETE.

1. Did you verify that the execution meets all documented requirements safely?
2. Ensure you have not bypassed any "requires_human_approval" constraints.
</verification_gate>
