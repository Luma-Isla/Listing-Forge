# 03. Import the Listing Forge workflow

**Read time: 3 minutes**
**Action time: 2 minutes**

n8n is running. Now we load the workflow file into it.

## Step 1: Get the workflow file

If you haven't already, download this entire repo by clicking the green **Code** button at the top of the GitHub page → **Download ZIP** → unzip it on your computer.

You're looking for the file:

```
listing-forge/workflow/listing-forge.json
```

Have it ready on the computer you're using right now.

## Step 2: Import it into n8n

1. Open n8n at `http://YOUR_IP:5678` and log in
2. In the left sidebar, click **Workflows**
3. In the top-right, click the small **menu icon** (three dots or downward arrow) next to the orange "+ Create workflow" button
4. Click **Import from File**
5. Browse to where you unzipped the repo, navigate into `workflow/`, select `listing-forge.json`
6. Click **Open**

The workflow loads. You'll see a chain of about 15 boxes ("nodes") on the screen, connected by lines.

## Step 3: Look at it

Don't be intimidated. You don't need to understand every box. Here's a quick map:

```
[Webhook] → [Is ping?] → [Respond ping]
                ↓
         [Prep payload]
                ↓
         [Gemini :: Vision]
                ↓
         [Parse vision]
                ↓
         [Gemini :: Research]
                ↓
         [Parse research]
                ↓
         [Claude :: Voice]
                ↓
         [Parse claude]
                ↓
         [GPT :: Variants]
                ↓
         [Parse gpt]
                ↓
         [Gemini :: SEO]
                ↓
         [Assemble]
                ↓
         [Respond]
```

Each colored box is a step in the pipeline. The data flows left to right (top to bottom).

You'll notice **four boxes have a red badge or warning icon**: `Gemini :: Vision`, `Gemini :: Research`, `Claude :: Voice`, `GPT :: Variants`, and `Gemini :: SEO`. That's expected — they're flagged because they need credentials (API keys) and we haven't added those yet. We'll do that in Chapter 5.

## Step 4: Save it

1. Click the workflow name at the top (it says "Listing Forge")
2. The workflow auto-saves, but you can also press `Ctrl+S` / `Cmd+S` to be sure
3. **Do not** flip the **Active** toggle in the top-right yet — we activate it later

## What just happened?

The workflow definition is now stored in n8n's database. It will survive restarts, reboots, and updates. You can come back to it anytime by clicking **Workflows** in the sidebar and selecting **Listing Forge**.

---

**Next:** [04-get-api-keys.md](04-get-api-keys.md) — getting the three API keys from Google, Anthropic, and OpenAI.

## If something went wrong

**Import button is grayed out**: you need to be logged in as the owner. If you set up multiple users, switch to the owner account.

**"Workflow could not be imported"**: re-download the JSON file. It might have gotten corrupted in transit. Make sure you opened the actual `listing-forge.json` file, not a copy of the README or another file.

**The nodes look weird or are missing**: your n8n version might be too old. Update by stopping the container (`docker stop n8n`), removing it (`docker rm n8n`), and re-running the install command from Chapter 2 — Docker will pull the latest version. Your workflows are saved in the `n8n_data` folder so they survive.
