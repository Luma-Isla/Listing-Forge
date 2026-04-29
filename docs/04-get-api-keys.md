# 04. Get your API keys

**Read time: 5 minutes**
**Action time: 15–25 minutes (mostly waiting for verification emails)**

An "API key" is just a long password that lets your workflow talk to an AI company's servers. You need three of them: one from Google (for Gemini), one from Anthropic (for Claude), and one from OpenAI (for ChatGPT).

You'll spend about $5 on each to fund your accounts. That's it. You only pay as you actually use the AI.

## Important: keep your keys private

API keys are passwords. If someone else gets your key, they can spend your money on AI calls. Don't:

- Post your keys publicly
- Share them in screenshots or screen recordings
- Email them to anyone
- Commit them to GitHub

If you ever expose a key by accident, **rotate it immediately** (generate a new one and delete the old one).

The good news: rotating a key takes 30 seconds in each provider's dashboard. So if you screw up, just rotate and move on.

---

## Google Gemini key

### 1. Go to AI Studio

Open: https://aistudio.google.com/apikey

You may need to sign in with a Google account. Use one you already have, or make a new one.

### 2. Enable billing

For the rate limits to be high enough for real use, you need to enable billing:

1. Click **Get API key** in the top right
2. If it asks you to set up a billing project, follow the prompts
3. You'll be taken to Google Cloud Console — create a new project if needed (call it "listing-forge" or whatever)
4. Enable billing on that project (you'll need to add a credit card — Google won't charge it unless you actually use the AI)
5. Set a **budget alert** for $20/month so you get an email if you ever go over (very unlikely to happen)

### 3. Create the key

1. Back at https://aistudio.google.com/apikey
2. Click **Create API key**
3. Pick the project you just made
4. Copy the key it shows you. It looks like `AIzaSy...` followed by a bunch of letters and numbers
5. **Save it somewhere safe** (password manager, secure note)

That's your **Gemini API key**. Done with Google.

---

## Anthropic Claude key

### 1. Go to the Anthropic Console

Open: https://console.anthropic.com/

### 2. Sign up

1. Click **Sign up** (or sign in if you already have an account)
2. Verify your email
3. Add a phone number when asked

### 3. Add credits

You need to put some money in before you can use the API.

1. Click your profile icon (top right) → **Plans & Billing**
2. Click **Buy credits** or **Add to balance**
3. Add **$5** to start. That's the minimum and it'll last most makers a couple months.
4. Add a credit card

### 4. Create the key

1. Go to **API Keys** in the left sidebar (or visit https://console.anthropic.com/settings/keys)
2. Click **Create Key**
3. Give it a name like "Listing Forge"
4. Copy the key it shows you. It looks like `sk-ant-` followed by a long string
5. **Important**: Anthropic only shows the key once. Save it immediately.
6. **Save it somewhere safe**

That's your **Anthropic API key**. Done with Anthropic.

---

## OpenAI key

### 1. Go to the OpenAI Platform

Open: https://platform.openai.com/

This is **NOT** the same as ChatGPT.com. ChatGPT.com is the chat app. We need the developer platform.

### 2. Sign up

1. Click **Sign up** if you don't have an account
2. Verify your email
3. Verify your phone

### 3. Add credits

1. Click your profile (top right) → **Billing**
2. Click **Add to credit balance**
3. Add **$5**. That's the minimum.
4. Add a credit card
5. Set a monthly limit so you don't overspend (try $20)

### 4. Create the key

1. Go to **API Keys** in the left sidebar (or https://platform.openai.com/api-keys)
2. Click **+ Create new secret key**
3. Name it "Listing Forge"
4. Choose project: "Default" is fine
5. Permissions: "All" is fine
6. Click **Create secret key**
7. Copy the key. It looks like `sk-proj-` followed by a long string
8. **Important**: OpenAI also only shows the key once. Save it immediately.
9. **Save it somewhere safe**

That's your **OpenAI API key**. Done with OpenAI.

---

## Quick checklist before moving on

You should now have three keys saved somewhere safe:

- ✅ Gemini key (starts with `AIzaSy`)
- ✅ Anthropic key (starts with `sk-ant-`)
- ✅ OpenAI key (starts with `sk-proj-` or `sk-`)

And all three accounts should be funded with at least $5.

If yes to all of the above: move to the next chapter.

---

**Next:** [05-add-credentials.md](05-add-credentials.md) — adding these keys to n8n so the workflow can use them.

## If something went wrong

**Google won't let me enable billing**: Google Cloud requires a verified payment method. Make sure your card has international transactions enabled. Some debit cards won't work — try a credit card if available.

**Anthropic shows my balance as $0 after I paid**: refresh the page. If still $0 after 5 minutes, check your email for a payment confirmation. If you don't have one, the payment didn't go through.

**OpenAI says my key has no access**: new OpenAI accounts sometimes have a delay before keys work. Wait 10 minutes and try again. If still failing, make sure you actually added credits — a new account with $0 balance can't make API calls.

**I lost the key right after creating it**: just create a new one. Old keys you can't see can be deleted from the same screen.
