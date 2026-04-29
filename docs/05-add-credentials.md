# 05. Add credentials to n8n

**Read time: 5 minutes**
**Action time: 10 minutes**

You have three API keys saved somewhere. Now we tell n8n about them and connect them to the right boxes in the workflow.

## The pattern

You'll create three "credentials" in n8n. Each one is a saved password that the workflow can use without you having to type it every time.

The credential type we want is called **Header Auth**. (Not "Multiple Headers Auth" or "Custom Auth" — those exist but they cause problems for this workflow.)

| Credential to create | Header name | What goes in the value |
|---|---|---|
| `Gemini API` | `x-goog-api-key` | the Gemini key, raw (no Bearer, no quotes) |
| `Anthropic API` | `x-api-key` | the Anthropic key, raw (no Bearer, no quotes) |
| `OpenAI API` | `Authorization` | the literal word `Bearer`, then a space, then the OpenAI key |

OpenAI is the only one that needs `Bearer ` in front of the key. The other two are just the raw key.

## Step 1: Create the Gemini credential

1. In n8n, click **Credentials** in the left sidebar (key icon)
2. Click the orange **Create credential** button (top right)
3. In the search box that appears, type `header auth`
4. Click on **Header Auth** (the simple one with just Name and Value fields — NOT "Multiple Headers Auth," NOT "Custom Auth")
5. Fill it in:
   - **Credential name** (top of the page, click to edit): `Gemini API`
   - **Name** (the header field): `x-goog-api-key`
   - **Value** (the value field): paste your Gemini key here. Just the key — no quotes, no `Bearer`, no spaces before or after.
6. Click **Save** at the bottom

You should now see `Gemini API` listed on the Credentials page.

## Step 2: Create the Anthropic credential

Same steps. New credential. **Header Auth** type again.

- **Credential name**: `Anthropic API`
- **Name**: `x-api-key`
- **Value**: paste your Anthropic key — just the raw key, starts with `sk-ant-`. No `Bearer`, no quotes.
- Save

## Step 3: Create the OpenAI credential

Same again. **Header Auth** type.

- **Credential name**: `OpenAI API`
- **Name**: `Authorization` (capital A)
- **Value**: this one is different. Type the literal word `Bearer`, then a space, then paste your key. Like this: `Bearer sk-proj-XXXXXXXX`
- Save

You should now have three credentials on the Credentials page. All three should say `Header Auth` underneath the name.

## Step 4: Wire each credential to the workflow

Now we tell each box in the workflow which credential to use.

1. Click **Workflows** in the sidebar
2. Open **Listing Forge**

You'll see the workflow canvas. There are five boxes that need credentials. Do them one at a time:

### Gemini :: Vision

1. Double-click the **Gemini :: Vision** box
2. Look for **Authentication**: should already say `Generic Credential Type`
3. **Generic Auth Type**: should say `Header Auth`
4. **Credential for Header Auth**: click the dropdown, pick `Gemini API`
5. Close the box (X in top right or click outside)

### Gemini :: Research

Same steps. Pick `Gemini API`.

### Claude :: Voice

Same steps. Pick `Anthropic API`.

### GPT :: Variants

Same steps. Pick `OpenAI API`.

### Gemini :: SEO

Same steps. Pick `Gemini API`.

## Step 5: Verify

After wiring all five, look at the workflow canvas. **The red error badges on those five boxes should be gone**. If any are still red, double-check that you wired that specific node.

If everything looks clean: success. Move to the next chapter.

---

**Next:** [06-deploy-gui.md](06-deploy-gui.md) — putting up the web interface so you can actually use this thing.

## If something went wrong

**The credential dropdown is empty / says "No credentials yet"**:
- Make sure you actually saved the credential with the right name
- Hard-refresh your browser (Cmd+Shift+R or Ctrl+Shift+R)
- Confirm in the Credentials list that it says **Header Auth** as the type, not Multiple Headers Auth or Custom Auth — if it says something else, delete it and recreate as Header Auth

**I created it as "Multiple Headers Auth" by mistake**: just delete it and recreate it as **Header Auth**. The workflow expects Header Auth specifically.

**OpenAI keeps failing with "no API key provided"**: Most common cause is the `Bearer ` prefix being missing. Open your `OpenAI API` credential, edit the Value, and make sure it reads exactly:
```
Bearer sk-proj-YOUR_KEY_HERE
```
The word "Bearer" with a capital B, ONE space after it, then your key. No quotes around any of it.

**Anthropic keeps failing with "invalid x-api-key"**: do NOT add `Bearer` to the Anthropic credential. Anthropic uses a different header (`x-api-key`) and just wants the raw key. If you accidentally put `Bearer` in there, edit the Value and remove it.

**I think my key has a typo or stray space**: don't worry, just generate a fresh one. Anthropic and OpenAI consoles let you delete a key and create a new one in 30 seconds. Update the credential value with the new one.
