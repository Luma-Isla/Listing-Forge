# 02. Install n8n — the engine that runs the workflow

**Read time: 5 minutes**
**Action time: 5–10 minutes**

n8n (pronounced "n-eight-n," for "nodemation") is a free, open-source automation tool. Think of it like a switchboard. Listing Forge is a workflow that runs inside n8n.

## What we're doing

We're going to install n8n in a Docker container. A "container" is just a little self-contained box that holds the program and all its requirements. You don't need to understand how it works — just trust that this command starts it up.

## Pick your install method

### If you have a Synology NAS with Container Manager

You can do this through the web UI without touching a terminal.

1. Open Container Manager
2. Go to **Registry** in the left sidebar
3. Search for `n8nio/n8n`
4. Click the official one and hit **Download** (pick the `latest` tag)
5. Wait for it to download
6. Go to **Image** in the left sidebar
7. Click on the n8n image you just downloaded
8. Click **Run**
9. In the dialog that appears, set:
   - **Container name**: `n8n`
   - **Auto-restart**: ON
10. Click **Next**
11. **Port settings**: add a mapping. Local port `5678`, container port `5678`
12. **Volume settings**: click **Add Folder**. Pick or create a folder like `/docker/n8n` on your NAS. Mount path: `/home/node/.n8n`
13. **Environment**: add these two variables:
    - `N8N_HOST` = `YOUR_IP` (the IP from the last chapter)
    - `WEBHOOK_URL` = `http://YOUR_IP:5678/`
14. Click **Next**, then **Done**
15. The container starts. Check it's running by going to `http://YOUR_IP:5678` in your browser

Skip to [Setting up your n8n account](#setting-up-your-n8n-account) below.

### If you have a regular computer / Pi / VPS / non-Synology NAS with terminal access

This is the easier path actually. Just one command. Open your terminal (or SSH into your VPS), then run:

**On Mac, Linux, Pi, or VPS:**

```bash
docker run -d \
  --name n8n \
  --restart unless-stopped \
  -p 5678:5678 \
  -v ~/n8n_data:/home/node/.n8n \
  -e N8N_HOST=YOUR_IP \
  -e WEBHOOK_URL=http://YOUR_IP:5678/ \
  -e GENERIC_TIMEZONE=America/Chicago \
  n8nio/n8n
```

**On Windows (Command Prompt):**

```
docker run -d ^
  --name n8n ^
  --restart unless-stopped ^
  -p 5678:5678 ^
  -v %USERPROFILE%\n8n_data:/home/node/.n8n ^
  -e N8N_HOST=YOUR_IP ^
  -e WEBHOOK_URL=http://YOUR_IP:5678/ ^
  -e GENERIC_TIMEZONE=America/Chicago ^
  n8nio/n8n
```

**Replace `YOUR_IP` with the actual IP from the last chapter.** And change `America/Chicago` to your local timezone if you want — list of valid timezones: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

When the command finishes, n8n is running.

### Verify it's working

Open your web browser. Go to:

```
http://YOUR_IP:5678
```

(Replace `YOUR_IP` with your actual IP. If you installed on the same computer you're using right now, you can use `http://localhost:5678` instead.)

You should see a setup screen asking you to create an account.

If you see the setup screen: **success!** Go to the next section.

If the page doesn't load: see the troubleshooting at the bottom.

---

## Setting up your n8n account

The first time you load n8n, it asks you to create an "owner" account. This is **just for logging into n8n itself**, not connected to anything online.

1. Pick an email — it doesn't have to be real, but use something memorable like `me@home.local`
2. Pick a password — write it down somewhere safe (1Password, a sticky note, whatever)
3. Pick a first and last name
4. Click **Next** through any optional surveys (you can skip them)

You should now see the n8n dashboard with a sidebar that has **Workflows**, **Credentials**, **Executions**, etc.

**Save that login somewhere safe.** If you forget it, getting back in is annoying.

---

## What just happened?

You now have:

- A container called `n8n` running in the background
- A folder on your computer (`~/n8n_data` or similar) where n8n stores its workflows and settings
- A webpage at `http://YOUR_IP:5678` you can visit anytime to manage things

The container will automatically restart if your computer reboots. n8n will keep running until you stop it.

To stop n8n: `docker stop n8n`
To start it again: `docker start n8n`
To see if it's running: `docker ps`

You probably won't need any of those commands, but they're nice to know.

---

**Next:** [03-import-workflow.md](03-import-workflow.md) — importing the Listing Forge workflow into n8n.

## If something went wrong

**"port is already allocated" error**: Something else is using port 5678 on your computer. Either find what it is and stop it, or change the port number. To use port 5679 instead, change `-p 5678:5678` to `-p 5679:5678` in the command, and use that port in the URL.

**Page won't load at `http://YOUR_IP:5678`**:
- Check the container is running: `docker ps`. You should see `n8n` in the list.
- If on a VPS: did you open port 5678 in your provider's firewall?
- If on a Mac/Windows: try `http://localhost:5678` instead of the IP.

**"docker: Cannot connect to the Docker daemon"**: Docker isn't running. Start Docker Desktop (Mac/Windows) or `sudo systemctl start docker` (Linux).

**Container started but immediately stopped**: check logs with `docker logs n8n`. The error message will tell you what went wrong. Most common: typo in the environment variables.

**I can't reach n8n from another device on my network**: this is usually a firewall on the host computer. On Mac, check System Settings → Network → Firewall. On Windows, Windows Firewall might be blocking it. Allow incoming connections on port 5678.
