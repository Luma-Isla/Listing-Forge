# 06. Deploy the GUI (the web interface)

**Read time: 5 minutes**
**Action time: 5–10 minutes**

n8n is the engine. The GUI is the thing you actually click. Let's get it running.

## What we're doing

We're going to put the `index.html` file from this repo into a tiny web server (nginx, also running in Docker) so you can open it in any browser on your network.

Just like n8n, this runs in a Docker container. One command to set up.

## Pick your method

### Option A: One-command install (easiest, recommended)

Open a terminal on your computer/NAS/VPS and run this. **Replace `/path/to/listing-forge` with the actual path to where you unzipped the repo.**

```bash
cd /path/to/listing-forge/deploy
docker compose up -d
```

That's it. Skip to [Step 3: Open the GUI](#step-3-open-the-gui).

### Option B: Manual setup (if Option A failed or you're on a non-standard NAS)

This is for when you can't run `docker compose` directly — for example, on Synology DSM where you'd use Container Manager's web UI.

#### Step 1: Place the GUI file

Copy `gui/index.html` from the repo to a permanent location on your computer/NAS:

- **Synology**: copy it into `/volume1/docker/listing-forge/web/index.html` using File Station
- **Mac/Linux/Pi**: copy it to `/srv/listing-forge/web/index.html` (you may need `sudo` to create the folders)
- **Windows**: copy it to `C:\listing-forge\web\index.html`
- **VPS**: copy it via `scp` to `/srv/listing-forge/web/index.html`

We'll call this folder **the GUI folder** for the rest of this chapter.

#### Step 2: Run an nginx container that serves the file

In your terminal, run:

```bash
docker run -d \
  --name listing-forge-web \
  --restart unless-stopped \
  -p 8088:80 \
  -v /path/to/your/GUI/folder:/usr/share/nginx/html:ro \
  nginx:alpine
```

Replace `/path/to/your/GUI/folder` with the actual folder path from Step 1 (NOT the `index.html` file path — the folder containing it).

For example, on a Synology NAS:
```bash
docker run -d --name listing-forge-web --restart unless-stopped \
  -p 8088:80 \
  -v /volume1/docker/listing-forge/web:/usr/share/nginx/html:ro \
  nginx:alpine
```

For Synology Container Manager web UI users:
- Search for `nginx` in the registry, download `nginx:alpine`
- Run it as a container named `listing-forge-web`
- Port mapping: `8088:80`
- Volume: mount your GUI folder to `/usr/share/nginx/html` as read-only

## Step 3: Open the GUI

In any web browser on the same network as your computer/NAS:

```
http://YOUR_IP:8088
```

Replace `YOUR_IP` with your IP address.

You should see the **Listing Forge** dashboard with a dark theme, a drop zone for an image, form fields, and a "Forge listing" button.

If you see this: success. Move to the next step.

## Step 4: Connect the GUI to your n8n workflow

The GUI needs to know where your n8n webhook is.

### First, get the webhook URL from n8n

1. Open n8n at `http://YOUR_IP:5678`
2. Open the **Listing Forge** workflow
3. **Activate** the workflow by flipping the toggle in the top-right (it turns green)
4. Click on the **Webhook** node (the very first one)
5. You'll see a **Production URL** — it looks like `http://YOUR_IP:5678/webhook/listing-forge`
6. Click the small copy icon next to it

### Then paste it into the GUI

1. Go back to the GUI (`http://YOUR_IP:8088`)
2. Click the **gear icon** in the top right
3. Paste the URL into the **Production URL** field
4. Click **Test connection**
5. You should see a green "✓ Webhook reachable" toast and the status pill flips green

If the test passes: you're done with setup. The whole pipeline is ready.

---

## Updating the GUI later

If you ever want to update the GUI (new version, custom tweaks):

1. Replace the `index.html` file in the GUI folder
2. Refresh your browser (Cmd+Shift+R / Ctrl+Shift+R)

That's it. The container doesn't need to restart because the GUI is mounted as a live folder.

---

**Next:** [07-first-forge.md](07-first-forge.md) — running your first real listing through the pipeline.

## If something went wrong

**Page won't load at port 8088**:
- Check the container is running: `docker ps`. Should show `listing-forge-web` in the list.
- Try a different port if 8088 is taken: change `-p 8088:80` to `-p 8089:80` (or any free port) and reach it at `http://YOUR_IP:8089`
- Firewall could be blocking it (especially on VPS — open port 8088 in your provider's firewall)

**Test connection fails / red toast**:
- Make sure the n8n workflow is set to **Active** (top-right toggle)
- Verify the webhook URL is the **Production URL**, not the Test URL
- Try opening the URL directly in a browser — you should see something like `{"message":"This webhook is not registered for GET requests..."}`. If you don't even see that, the URL is wrong.

**"Cannot reach webhook" but it should be reachable**:
- This is usually a CORS issue. Make sure the URL in the GUI starts with `http://` (or `https://` if you've set up SSL) and includes the port number.

**The GUI shows but it looks broken / no styling**: hard refresh (Cmd+Shift+R / Ctrl+Shift+R). The file might have been cached weirdly.
