# 09. Cost breakdown

**Read time: 3 minutes**

The software is free forever. What you pay is the AI usage. Here's the realistic math.

## Per-listing cost

A single forge run uses:

| Stage | Model | Approx cost per call |
|---|---|---|
| Vision analysis | Gemini Flash | ~$0.005 |
| Grounded research | Gemini Pro + Google Search | ~$0.02 |
| Brand voice copy | Claude | ~$0.05 |
| Short-form variants | GPT | ~$0.015 |
| Technical SEO | Gemini Pro | ~$0.01 |
| **Total per listing** | | **~$0.10** |

That's about **10 cents per finished listing**.

Most of the cost comes from Claude's voice writing because long-form output uses more tokens. Gemini and GPT are pennies.

## Monthly cost estimates

| Volume | Cost per month |
|---|---|
| 5 listings/week (~20/month) | **~$2** |
| 20 listings/week (~80/month) | **~$8** |
| 50 listings/week (~200/month) | **~$20** |
| 100 listings/week (~400/month) | **~$40** |

You're paying these to the three AI providers directly. There's no markup, no middleman.

## What about the server?

The server (NAS, old laptop, Pi, or VPS) costs:

- **NAS or old hardware you already own**: $0 (just electricity, ~$2-5/month)
- **Raspberry Pi 4**: ~$1/month in electricity if you bought the Pi
- **Cheap VPS (Hetzner, DigitalOcean, Vultr)**: $5-7/month flat

So the absolute cheapest setup is **$0/month** if you already have a NAS or old computer. The most expensive is **~$10-30/month** total for a maker doing 50+ listings/week on a rented server.

## Compared to alternatives

What you'd pay for similar capability commercially:

| Service | Monthly | What you get |
|---|---|---|
| **Listing Forge (this)** | $5-15 | Full multi-AI pipeline, your voice, your control |
| Generic "Etsy SEO tool" | $20-50 | Keyword suggestions only, no description writing |
| AI listing writer SaaS | $30-100 | Single-model output, generic voice, monthly cap |
| Hiring a copywriter | $50-100/listing | Hand-written but slow |

## How to keep costs predictable

1. **Set monthly limits on each AI provider's dashboard.** All three (Google, Anthropic, OpenAI) let you cap monthly spending. Pick a number you're comfortable with.

2. **Set up email alerts at 50% of your cap.** That way if something runs wild (a bug, an attacker, a curious cat on the keyboard), you'll know.

3. **Avoid running the same product twice.** If you do a forge and don't like it, save the JSON output and edit it manually rather than re-running. Saves the ~10 cents.

4. **Don't expose your webhook URL publicly.** Keep it on your local network. If you must expose it (e.g., from a phone outside your home network), put it behind a password — see [10-customize-for-your-shop.md](10-customize-for-your-shop.md).

## Free tier reality check

Each provider has a free tier:

- **Google**: ~15 requests/min free, plenty for testing but breaks under real use
- **Anthropic**: NO free tier — must add credits
- **OpenAI**: NO free tier for API — must add credits

So the actual minimum to start is **$5 each on Anthropic and OpenAI = $10 to get going**. Most makers add another $5 to Google to lift the rate limits.

That **$15 will last most makers a few months** at typical volume.

---

**Next:** [10-customize-for-your-shop.md](10-customize-for-your-shop.md) — making the output match your specific brand.
