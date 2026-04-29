# 🔥 Listing Forge

**An open-source, multi-model AI listing generator for Etsy and Shopify sellers. Self-hosted. ~$5–15/month total. Built for makers, by a maker.**

Drop in a product photo. Type one sentence describing what it is. Hit a button. About 90 seconds later you get a complete Etsy listing, a complete Shopify listing, AND a full ad campaign — all written in your brand voice with real research backing every claim.

![Listing Forge dashboard preview](docs/images/screenshot-main.png)

---

## ✨ What it does

In about 90 seconds, Listing Forge produces:

**For Etsy:**
- A keyword-optimized title under 140 characters
- A 4–7 paragraph product description in your maker voice (no AI slop)
- Exactly 13 search-optimized tags
- Materials list, category path, suggested price

**For Shopify:**
- A separate Google-Shopping-optimized title
- SEO meta title and meta description
- Full HTML body with proper headings and bullet lists
- Product type, vendor, 10–15 collection-filter tags
- Image alt text, URL handle
- Full JSON-LD structured data
- Google Shopping taxonomy category

**For ads + social:**
- 5 alternative product titles
- 6 ad headlines
- A 90–125 word primary ad copy
- Pinterest pin description
- Instagram caption with hashtags
- 5 email subject lines

**Plus:** real research with cited sources from live web search — comparable products, current pricing, trending tags, IP/copyright caveats, and buyer persona.

---

## 🤖 How it works

Three different AIs work together as a team, each handling what it's actually best at:

| Stage | Model | Job |
|---|---|---|
| 1. Vision analysis | **Google Gemini Flash** | Looks at your product photo, identifies materials, finish, color palette, distinctive details |
| 2. Market research | **Google Gemini Pro (grounded)** | Live Google search — comparable products, real prices, trending keywords, IP caveats. Returns cited source URLs. |
| 3. Brand voice copy | **Anthropic Claude** | Writes the long-form Etsy description and Shopify HTML in your actual maker voice |
| 4. Short-form variants | **OpenAI GPT** | Cranks out the 13 Etsy tags, ad headlines, Pinterest pin, Instagram caption, email subjects |
| 5. Technical SEO | **Google Gemini Pro** | Meta tags, alt text, URL handles, JSON-LD structured data |

The orchestration runs on **n8n**, a free open-source workflow automation tool. Everything runs on your hardware. No subscriptions. Just your AI API costs (~$0.05–0.15 per listing).

---

## 📦 What's in this repo

```
listing-forge/
├── docs/                       # Step-by-step guides
│   ├── 00-overview.md
│   ├── 01-prerequisites.md
│   ├── 02-install-n8n.md
│   ├── 03-import-workflow.md
│   ├── 04-get-api-keys.md
│   ├── 05-add-credentials.md
│   ├── 06-deploy-gui.md
│   ├── 07-first-forge.md
│   ├── 08-troubleshooting.md
│   ├── 09-cost-breakdown.md
│   └── 10-customize-for-your-shop.md
├── gui/                        # The web interface (single HTML file)
│   └── index.html
├── workflow/                   # The n8n workflow
│   └── listing-forge.json
├── deploy/                     # Docker setup files for the web GUI
│   ├── docker-compose.yml
│   └── nginx.conf
├── scripts/                    # Helper scripts
│   ├── install-quick.sh
│   └── update-gui.sh
├── LICENSE
├── CHANGELOG.md
└── README.md (you are here)
```

---

## 🚀 Quick start (TL;DR)

If you're impatient and technical, here's the speedrun:

1. Have Docker + n8n running somewhere (NAS, old PC, VPS — anywhere)
2. Get API keys from Google AI Studio, Anthropic, and OpenAI (~$5 each to start)
3. Import `workflow/listing-forge.json` into n8n
4. Add three HTTP Header Auth credentials in n8n (one per provider)
5. Activate the workflow, copy the production webhook URL
6. Host `gui/index.html` anywhere (or use the included `deploy/` folder)
7. Open the GUI, paste the webhook URL into settings, forge a listing

**If that paragraph made you nervous, ignore it. Follow the docs from the start — they assume zero prior knowledge.** Start at [docs/00-overview.md](docs/00-overview.md).

---

## 💰 Real monthly cost

Based on actual usage (your mileage may vary):

| Volume | Gemini | Claude | OpenAI | **Total/month** |
|---|---|---|---|---|
| 5 listings/week | ~$2 | ~$2 | ~$1 | **~$5** |
| 20 listings/week | ~$5 | ~$5 | ~$2 | **~$12** |
| 50 listings/week | ~$10 | ~$10 | ~$5 | **~$25** |

That's it. No subscriptions. You only pay for what you use. Most makers will land in the $5–15/month range.

[Full cost breakdown in the docs.](docs/09-cost-breakdown.md)

---

## 🛠 Requirements

You need:
- **A computer that's always on** — a NAS (Synology, etc.), an old desktop, a Raspberry Pi 4, or a cheap VPS works fine
- **Docker** installed on that computer
- **Three API keys** (Gemini, Anthropic, OpenAI) — total ~$15 to get started
- **About 30–60 minutes** for first-time setup

You **don't** need:
- A subscription to anything
- Coding knowledge
- A powerful computer (the AI runs on the model providers' servers, not yours)

---

## 📖 Documentation

Start with [docs/00-overview.md](docs/00-overview.md) and follow the chapters in order. The whole walkthrough is written for non-technical readers. Each chapter takes 5–15 minutes.

---

## ❓ FAQ

**Is this really free?**
The software is free and open source (MIT license). You pay the AI providers directly for the API calls — typically $5–15/month. No middleman, no markup.

**Can I sell what it generates?**
Yes. The output is yours. Use it commercially, edit it, mix it with your own writing — whatever helps you ship listings faster.

**Does it work for non-3D-printed products?**
Yes. It works for any handmade or curated product — paintings, woodwork, jewelry, candles, ceramics, vintage. Just describe what you're listing.

**Can I customize the brand voice?**
Yes. The voice anchors are configurable in the GUI ("warm," "playful," "luxe," "nerdy," etc.) and you can edit the Claude prompt directly in n8n if you want deeper control.

**Will it scrape Etsy/Shopify for me?**
No. It uses Google Search to research comparables (via Gemini's grounding feature) which respects robots.txt and is well within fair-use territory. It does not scrape platforms or violate ToS.

**Why these three AIs specifically?**
Because each one is genuinely best at its job: Gemini is unmatched for grounded web search and image vision; Claude is the best at long-form brand voice writing; GPT excels at concise, punchy short-form variants. Using one model for everything always produces worse output than using each for what they're built for.

---

## 🤝 Contributing

This started as a personal tool, then got cleaned up and released. PRs welcome. Bug reports welcome. Feature requests welcome.

If you build something cool on top of it, post about it — and tag the project so others can find it.

---

## 🙏 Credits

Built by [JP](https://www.linkedin.com/in/jp1490/) of [Luma-Isla Studios](www.luma-isla.com) in Oklahoma. Released free for the Oklahoma 3D Print community and any maker who wants it.

If this saves you time, consider buying something from a small maker today. We're all out here trying to make a living on our hobbies.

---

## 📄 License

MIT. Do whatever you want. No warranty. If it breaks your computer, that's on you (it won't, but legally I have to say that).
