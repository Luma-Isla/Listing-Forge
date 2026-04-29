# 08. Troubleshooting

When something breaks, this is where you start. Find the error message that matches yours and follow the fix.

## How to read errors

When a forge fails, the GUI shows a brief error toast. The full picture is in **n8n's Executions tab**:

1. Open n8n at `http://YOUR_IP:5678`
2. Open the Listing Forge workflow
3. Click the **Executions** tab at the top
4. Click the most recent failed run (red icon)
5. n8n shows the workflow with one node highlighted in red — that's where it failed
6. Click that node to see the actual error

This is your single best diagnostic tool. Always start here.

---

## Authentication errors

### "Authorization failed - please check your credentials"
### "invalid x-api-key"
### "You didn't provide an API key"

**Cause:** Wrong key, missing key, or missing `Bearer ` prefix on OpenAI.

**Fix:**

| Provider | Header should be | Value should be |
|---|---|---|
| Gemini | `x-goog-api-key` | the key alone (e.g. `AIzaSy...`) |
| Anthropic | `x-api-key` | the key alone (e.g. `sk-ant-...`) — **NO Bearer** |
| OpenAI | `Authorization` | `Bearer ` then the key (e.g. `Bearer sk-proj-...`) |

1. Open n8n → Credentials → click the credential for the failing provider
2. Click **Edit** on the Value (it's masked, you can't see what's there)
3. Replace it with the correct format from the table above
4. Save and re-run

### "Your credit balance is too low"

**Cause:** You ran out of money on that AI provider.

**Fix:** Top up the relevant account:
- Anthropic: https://console.anthropic.com/settings/billing
- OpenAI: https://platform.openai.com/settings/organization/billing/overview
- Google: Google Cloud Console → Billing

---

## Rate limit errors

### "Service unavailable - try again later" (Gemini)
### "The service is receiving too many requests from you"
### "429 Too Many Requests"

**Cause:** You hit the free-tier rate limit. Free tier on Gemini is ~15 requests/minute.

**Fix:**
1. **Wait 60 seconds**, try again
2. If it keeps happening, **enable billing** on your Google Cloud project. The paid tier has 100x higher limits and the actual cost is pennies.

---

## Model not found errors

### "The resource you are requesting could not be found"
### "404 Model not found"

**Cause:** Google or OpenAI rotated their model names since this workflow was published.

**Fix (Gemini):**

1. Run this in your terminal to list available models, replacing `YOUR_KEY`:

```bash
curl -s "https://generativelanguage.googleapis.com/v1beta/models?key=YOUR_KEY" | grep -o '"name": "models/[^"]*"'
```

2. Pick a working flash model and a working pro model from the list
3. In n8n, open each Gemini node:
   - **Gemini :: Vision** — change the model name in the URL field. Use a flash model.
   - **Gemini :: Research** — use a pro model (better at grounded search)
   - **Gemini :: SEO** — use a flash or pro model

The URL format is:
```
https://generativelanguage.googleapis.com/v1beta/models/MODEL_NAME:generateContent
```

Just replace `MODEL_NAME` with what you found.

**Fix (OpenAI):**

If GPT :: Variants fails with "model not found": open the **Parse claude** node, find the line `model: 'gpt-5'` in the code, and change to whatever GPT model your account supports (e.g., `gpt-4o`, `gpt-4-turbo`).

**Fix (Claude):**

If Claude :: Voice fails with "model not found": open the **Parse research** node, find `model: 'claude-opus-4-5'`, change to whatever Claude model your account supports (check https://docs.anthropic.com/en/docs/about-claude/models for current names).

---

## JSON Body errors

### "The value in the 'JSON Body' field is not valid JSON"
### "Bad control character in string literal"

**Cause:** This was a known bug in the old workflow that should be fixed in the current version. If you're seeing it, you're probably running an old version.

**Fix:** Re-import the latest `workflow/listing-forge.json` from the GitHub repo. The current version uses Code nodes to build all request bodies, which avoids this entirely.

---

## Connection / network errors

### GUI shows "Cannot reach webhook"

**Cause:** The GUI can't talk to n8n.

**Fix:**
1. Confirm n8n is running: `docker ps` should show `n8n` container
2. Confirm the workflow is **Active** (toggle in top-right of workflow editor must be green)
3. Confirm the webhook URL is correct in the GUI settings — copy it again from the Webhook node's Production URL field
4. Try opening the URL directly in your browser. You should see something — even an error message means n8n received the request.

### "ENOTFOUND" or "getaddrinfo failed"

**Cause:** Your computer can't reach the AI provider's server.

**Fix:** Check your internet connection. If you're on a corporate or school network, an outbound proxy might be blocking the AI API endpoints.

---

## Output quality issues

### The Etsy description sounds robotic / generic

**Fix:** This is what voice anchors are for. Try different combinations:
- For warm/personal: pick "Warm" + "Maker-led"
- For luxury: pick "Luxe" + "Warm"
- For nerdy/fandom: pick "Nerdy" + "Playful"

You can also edit the Claude prompt directly in the **Parse research** node. Look for the `systemPrompt` variable in the code.

### Tags are repetitive or low-quality

**Fix:** GPT generates these. The issue is usually the input — give better notes, a clearer title, or a better photo. Garbage in, garbage out.

### The price suggestion is way off

**Fix:** Gemini's research is only as good as what's currently online. For unusual products, override it manually based on what you know. The AI is a starting point.

### Sources tab is empty

**Cause:** Gemini's grounded search didn't find good comparables, or the grounding feature timed out.

**Fix:** Run it again. If it consistently has no sources, your product might be too niche for Google to surface comparables. The output is still valid — just no external citations.

---

## When all else fails

1. Check n8n's full logs: `docker logs n8n`
2. Check the GUI container's logs: `docker logs listing-forge-web`
3. Restart everything:
   ```bash
   docker restart n8n listing-forge-web
   ```
4. If totally stuck, open an issue on the GitHub repo with:
   - What you were doing
   - The exact error from n8n's Executions tab
   - Screenshots if helpful (with API keys redacted!)

---

**Next:** [09-cost-breakdown.md](09-cost-breakdown.md) — what this thing actually costs to run.
