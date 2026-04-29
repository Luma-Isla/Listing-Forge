# 07. Your first real forge

**Read time: 3 minutes**
**Action time: 2 minutes (90 seconds for the actual forge)**

You've got everything wired up. Time to test drive it.

## Pick a product

Grab any photo of something you'd actually list. Real product, decent photo. The better your photo, the better the AI's analysis.

Tips for a good test photo:
- Well-lit, clear focus
- Plain or simple background
- Shows the whole product (not just a detail shot)
- File under 10 MB

## Fill out the form

In the GUI:

1. **Drag the photo into the drop zone**, or click the zone and browse to it
2. **Title** field: type a brief sentence describing what it is. Don't overthink it. Something like:
   - "Hand-painted dragon figurine"
   - "Resin stitch markers, ocean theme"
   - "3D printed Baby Yoda planter"
3. **Notes** field (optional): add anything not obvious from the photo. Materials, time invested, dimensions, story behind it. The more context you give, the more accurate the output.
4. **Product type**: pick the closest chip
5. **Marketplace**: pick `Etsy + Shopify` for both, or just one if you only sell on one
6. **Made-to-order**: yes or no
7. **Price tier**: pick `Auto-suggest` and let the AI research it, or pick a tier if you already know
8. **Brand voice anchors**: pick the tags that match your brand. Most people use **Warm + Maker-led**. Add or remove based on your style.

## Hit "⚡ Forge listing"

A progress panel appears. You'll see steps tick through:

- Gemini :: vision analysis (~5 sec)
- Gemini :: grounded research + sources (~15-25 sec)
- Claude :: brand voice description (~10-20 sec)
- GPT :: titles, tags, ad variants (~5-10 sec)
- Gemini :: SEO meta + structured data (~5-10 sec)
- Assembling deliverables (~1 sec)

**Total: 40–90 seconds**

The progress meter is approximate — don't panic if a step looks stuck for 20-30 seconds. The AIs vary in how long they take.

## What you get

When it finishes, the bottom of the page fills with five tabs:

### Etsy tab
- A title (under 140 chars, keyword-optimized)
- A 4-7 paragraph product description in your voice
- Exactly 13 search tags
- Materials list
- Category and occasion
- Suggested price (based on real comparable products)

### Shopify tab
- A different title optimized for Google Shopping (60-70 chars)
- Meta description for SEO
- Body HTML with proper headings and bullet lists
- Product type, vendor, tags
- Image alt text, URL handle
- Google Shopping taxonomy category
- Full JSON-LD structured data

### Ad copy tab
- 5 alternative product titles
- 6 short ad headlines
- 90-125 word primary ad text for Meta/Facebook ads
- Pinterest pin description with hashtags
- Instagram caption with hashtags
- 5 email subject lines

### Sources tab
- Real URLs Gemini used during research
- Click them to verify the comparable products and pricing

### Raw JSON tab
- The full unfiltered response if you want to dig in

## Use it

Each block has a **Copy** button. Copy what you want, paste it into Etsy or Shopify, edit if you want to tweak the voice further, and publish.

## Run it again

Don't just trust the first output. Try it on 3-4 of your existing products. Tweak the voice anchors. See what works for your style.

The AI is a starting point, not a finished product. Treat the output as a really good first draft — about 80% of the work done. Spend the saved time on photo polish, customer service, or making more art.

---

**That's it. You're done with setup. Welcome to forging.**

The remaining chapters cover:
- [08-troubleshooting.md](08-troubleshooting.md) — common issues and fixes
- [09-cost-breakdown.md](09-cost-breakdown.md) — what each forge actually costs
- [10-customize-for-your-shop.md](10-customize-for-your-shop.md) — making it match your brand more closely

## If the first forge failed

Open n8n's **Executions** tab. Click the most recent failed run. n8n highlights the box that errored. Click that box to see the actual error.

The most common first-time errors:

- **API authentication errors** → re-check the credential value in n8n. Usually a typo or a missing `Bearer ` for OpenAI.
- **"Quota exceeded"** → your AI account ran out of free credits. Add money.
- **"Model not found"** → the model name has changed since this workflow was published. See [08-troubleshooting.md](08-troubleshooting.md) for how to swap models.
- **Timeout** → the AI took too long. Try again. If it consistently times out, it might be a rate limit on a free tier — add billing.
