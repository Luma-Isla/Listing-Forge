# 10. Customize for your shop

**Read time: 5 minutes**
**Action time: depends on how deep you go (10 min — 1 hour)**

The default settings are tuned for handmade/maker shops. If your shop is different — more luxe, more techy, bilingual, whatever — you can tune things.

## Easy customization (in the GUI)

### Voice anchors

The chips you pick when forging a listing are voice modifiers. You can pick any combination:

| Anchor | Effect |
|---|---|
| Warm | Conversational, friendly tone |
| Maker-led | First-person, hands-on, process-focused |
| Playful | Lighter humor, casual punctuation |
| Luxe | Restrained, premium-feeling, less "y'all" |
| Nerdy | More fandom references, technical detail |
| Tropical | Beachy, sun-and-sea feel (good for coastal brands) |
| Bilingual EN/ES | Generates both English and Spanish versions |

You can mix any of these. Try combinations:
- "Warm + Luxe" for upscale handmade
- "Nerdy + Playful" for fandom shops
- "Maker-led + Bilingual" for Latine maker shops

### Settings drawer

The gear icon in the top-right has fields for:
- **Shopify store handle** (e.g. "lumaisla")
- **Etsy shop name** (e.g. "Lumaisla")

These are passed to the AI so it knows your brand name when writing.

## Medium customization (editing prompts in n8n)

If you want to permanently change how the AI writes for you, edit the prompts in n8n.

### Edit the Claude voice prompt

This controls the long-form description style.

1. Open n8n, open the workflow
2. Open the **Parse research** node
3. Find the variable `systemPrompt` in the code
4. Edit the system prompt to add your specifics. Examples:

**Add brand-specific phrasing rules:**
```
... Always include the phrase "made in Oklahoma" when relevant. Never use the word "elevate." ...
```

**Add a signature closing line:**
```
... End every Etsy description with: "Thanks for supporting small makers. — JP & family" ...
```

**Add tone-specific instructions:**
```
... Use second-person ("you") sparingly. Prefer third-person product descriptions. ...
```

5. Save the node

### Edit the GPT short-form prompt

This controls tags, headlines, social copy.

1. Open the **Parse claude** node
2. Find `gptUserContent` — that's the prompt
3. Edit. Common tweaks:
   - Add specific tag preferences ("always include 'oklahoma made'")
   - Change Pinterest pin tone
   - Adjust hashtag count

### Edit the Gemini research prompt

This controls what kind of comparables it looks for.

1. Open **Parse vision**
2. Find `researchText`
3. Edit. Common tweaks:
   - "Specifically search Etsy listings, not Amazon or eBay"
   - "Focus on US-based competitors only"
   - "Look for products in the $50-200 range"

## Heavy customization (forking)

If you want to:
- Add a new AI model (e.g. a local model via Ollama)
- Add output to a new platform (TikTok Shop, eBay, Bonanza)
- Auto-publish to Etsy/Shopify via their APIs
- Add a mobile-friendly photo capture mode

…you can fork this repo and modify it. The architecture is straightforward:

- `gui/index.html` is the entire frontend (one file, no build step)
- `workflow/listing-forge.json` is the n8n workflow
- The flow is: GUI → webhook → Code node prep → AI calls → assembly → response

To add a new step:
1. Add a Code node before each new HTTP node to build its request body
2. Add the HTTP Request node with the right URL/auth
3. Add a Code node after to parse the response
4. Update the **Assemble** node to include the new fields in the output
5. Update the GUI's `renderResults` function to display the new data

It's modular by design.

## Bilingual mode

If you sell to Spanish-speaking buyers (or any other language):

1. In the GUI, pick **Bilingual EN/ES** as a voice anchor
2. The output will include both English and Spanish versions of the description
3. Currently supports Spanish out of the box. For other languages, edit the Claude system prompt:
   ```
   ... Generate descriptions in BOTH English and [LANGUAGE]. Format as:
   English version
   ---
   [LANGUAGE] version ...
   ```

## Auto-publishing (advanced)

This isn't built in by default but is doable. The Etsy and Shopify both have APIs that n8n can talk to.

To auto-publish to Shopify after a forge:

1. Add a new HTTP Request node after **Assemble**
2. Hit the Shopify Admin API endpoint for creating products
3. Map the `shopify` fields from the assembled output to the API request body

⚠️ **Strongly recommended**: don't auto-publish. Always review and tweak. AI output is 80% there but the final 20% (matching exact dimensions, photo polish, custom phrasing) is what makes a listing convert. The 90 seconds you save isn't worth shipping bad listings.

## Sharing your customizations

If you build a great prompt or a cool customization, consider opening a pull request on the GitHub repo. Other makers benefit from your tuning.

---

That's the customization guide. You should now have everything you need to:

- Run it with default settings
- Tune the voice for your brand
- Edit prompts deeper if needed
- Extend it for other platforms or workflows

**Build something cool. Make more listings. Spend the saved time on the parts only you can do.**
