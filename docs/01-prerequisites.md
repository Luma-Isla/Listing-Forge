# 01. Prerequisites — Setting up your environment

**Read time: 10 minutes**
**Action time: 5–30 minutes (depends on what you already have)**

Before we install Listing Forge itself, you need a place for it to live and a basic tool called **Docker**. This chapter gets that ready.

## Pick where Listing Forge will live

You need a computer that's powered on most of the time. Pick one of these options:

### Option A: A NAS (best if you have one)

Synology, QNAP, TrueNAS, or any similar always-on storage box. These are perfect because they're already on 24/7 and most of them have Docker built in.

If you have one of these, **use it**. Skip to [Installing Docker on a NAS](#installing-docker-on-a-nas) below.

### Option B: An old laptop or desktop

If you have a computer you don't use anymore, plug it in, leave it on, and use it. Mac, Windows, or Linux all work.

If you go this route, jump to [Installing Docker on a regular computer](#installing-docker-on-a-regular-computer) below.

### Option C: A Raspberry Pi

A Raspberry Pi 4 or 5 with at least 4GB of RAM is enough. Quiet, low-power, cheap.

Skip to [Installing Docker on a Raspberry Pi](#installing-docker-on-a-raspberry-pi) below.

### Option D: A rented online server (VPS)

If you don't have any hardware, you can rent a cheap virtual server. **Hetzner**, **DigitalOcean**, and **Vultr** all offer servers for $5–7/month that are plenty for this.

Skip to [Installing Docker on a VPS](#installing-docker-on-a-vps) below.

---

## Installing Docker on a NAS

### If you have a Synology NAS

1. Open the **Package Center** on your NAS (in the DSM web interface)
2. Search for **Container Manager** (older versions called this **Docker**)
3. Install it
4. Open it from the main menu

That's it. Docker is now running. Move to the next chapter: [02-install-n8n.md](02-install-n8n.md).

### If you have a QNAP NAS

1. Open the **App Center**
2. Install **Container Station**
3. Open it

Done. Skip to [02-install-n8n.md](02-install-n8n.md).

### Other NAS brands

Most modern NAS brands have Docker available as an installable app. Check your manufacturer's app store. If yours doesn't, treat it like Option B — a regular Linux computer.

---

## Installing Docker on a regular computer

### Mac

1. Go to https://www.docker.com/products/docker-desktop/
2. Click **Download for Mac** (pick Apple Silicon if you have an M1/M2/M3/M4 Mac, otherwise Intel)
3. Open the `.dmg` file you downloaded
4. Drag Docker into Applications
5. Open Docker from Applications
6. Accept the terms when prompted
7. Wait for Docker to say "Engine running" in the bottom-left corner

Test it works by opening Terminal (search "Terminal" in Spotlight) and running:

```bash
docker --version
```

You should see a version number. Done.

### Windows

1. Go to https://www.docker.com/products/docker-desktop/
2. Click **Download for Windows**
3. Run the installer
4. Restart your computer when it asks
5. Open Docker Desktop after restart
6. Wait for it to say "Engine running"

Test it works. Open Command Prompt and run:

```
docker --version
```

You should see a version number.

**Heads-up for Windows**: Docker on Windows uses something called WSL2 (Windows Subsystem for Linux). The installer handles this automatically, but if it complains, follow the link it gives you to enable WSL2 first.

### Linux (Ubuntu / Debian)

Open a terminal and run:

```bash
sudo apt update
sudo apt install docker.io docker-compose-plugin
sudo usermod -aG docker $USER
```

Log out and back in. Then test:

```bash
docker --version
```

---

## Installing Docker on a Raspberry Pi

1. Make sure you've got Raspberry Pi OS installed (the standard one)
2. Open Terminal on the Pi
3. Run:

```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
```

4. Reboot the Pi:

```bash
sudo reboot
```

5. After it comes back, test:

```bash
docker --version
```

---

## Installing Docker on a VPS

After you sign up with Hetzner / DigitalOcean / Vultr / etc:

1. Create a new server. Pick the cheapest Ubuntu option (usually $5–7/month, 1–2 GB RAM is fine)
2. SSH into it (your provider gives you instructions)
3. Run:

```bash
curl -fsSL https://get.docker.com | sh
```

4. Test:

```bash
docker --version
```

**Important for VPS users:** You'll also need to **open ports 5678 (n8n) and 8088 (the GUI)** in your provider's firewall. Each provider has slightly different instructions. Look for "firewall rules" or "security groups" in your provider's dashboard.

---

## Find your computer's IP address

You'll need this in later chapters. Pick your case:

**On a NAS:** the IP is shown in the NAS's main web interface, usually at the top or in network settings. It looks like `192.168.1.41` or similar.

**On a Mac:** open System Settings → Network → click your active connection → look for "IP Address."

**On Windows:** open Settings → Network → click your connection → look for "IPv4 address."

**On Linux/Pi:** run `hostname -I` in the terminal.

**On a VPS:** your provider gives you a public IP when you create the server. It looks like `45.77.123.45` (numbers are different, but no leading 192).

**Write it down. You'll need it about ten times in the next chapters.**

For the rest of these docs, when we say `YOUR_IP`, replace it with this number.

---

## Quick sanity check before moving on

You should now have:

- ✅ Docker installed and running on a computer
- ✅ That computer's IP address written down
- ✅ The ability to leave that computer on for the next 30 minutes

If yes to all three: you're ready. Move to the next chapter.

If no: get those squared away first. Don't try to skip ahead — Docker is the foundation of everything that follows.

---

**Next:** [02-install-n8n.md](02-install-n8n.md) — installing n8n, the engine that runs the workflow.

## If something went wrong

**"docker: command not found" after install**: log out and back in (or restart). Docker often only becomes available after a fresh shell session.

**"permission denied" when running docker commands on Linux**: run `sudo usermod -aG docker $USER`, then log out and back in. This adds you to the Docker group so you don't need sudo.

**Docker Desktop won't start on Windows**: enable virtualization in your computer's BIOS. Search "enable virtualization [your computer model]" for instructions.

**Docker Desktop is too heavy on my Mac**: that's a known issue. Consider using **OrbStack** (free, much lighter) as a Docker Desktop replacement: https://orbstack.dev/
