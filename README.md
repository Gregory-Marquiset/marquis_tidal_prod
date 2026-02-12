> This project is a personal initiative focused on live coding music and reproducible environments.

# marquis_Strudel_prod — Strudel in Docker (local web app)

`marquis_Strudel_prod` provides a **portable, reproducible local setup** for **Strudel** (live coding music in the browser), packaged inside **Docker** and exposed on **[http://127.0.0.1:4321](http://127.0.0.1:4321)**.

Strudel runs as a local web app: you write patterns, hear audio, and see visual feedback (piano roll, scope, etc.) directly in the browser.

---

## 🌐 Project Overview

**Goal:** Run Strudel locally without installing Node/pnpm/tooling on the host—everything is containerized.

**Users:** Live coders, developers, musicians, and anyone who wants a reliable Strudel setup with a one-command startup.

### Key Features

* Strudel served locally from a Docker container
* Browser-based audio output + visualizers (piano roll, scope, etc.)
* Simple workflow via Makefile (`build`, `run`, `logs`, `sh`, `clean`)
* No host audio routing required (audio is handled by the browser)

### How it works

* The Docker image clones Strudel from upstream
* Installs dependencies with `pnpm`
* Generates `doc.json` via `pnpm prestart` (needed for the editor tooling)
* Starts the Strudel website dev server (Astro/Vite) on port **4321**

---

## 🚀 Quickstart

### Prerequisites

* Docker installed and running
* A web browser on the host

### 1) Check available commands

```bash
make help
```

### 2) Build the image

```bash
make build
```

### 3) Run Strudel

```bash
make run
```

Then open:

* [http://127.0.0.1:4321](http://127.0.0.1:4321)

Stop the container (in another terminal):

```bash
make stop
```

### Useful commands

Remove container + image:

```bash
make clean
```

---

## 🧩 Notes

* If your browser shows connection issues, prefer `127.0.0.1` over `localhost` (IPv6/proxy edge cases).
* This uses a dev server (Astro). If you want a production image (build static + serve), we can add a `Dockerfile.prod`.

---

## 📑 Resources & Upstream

* Strudel (upstream project): [https://strudel.cc](https://strudel.cc)
* Upstream repo (mirrors/moves may happen): [https://codeberg.org/uzu/strudel](https://codeberg.org/uzu/strudel)

> Licensing: Strudel itself is licensed upstream (AGPL-3.0). If you distribute a derived image/service, make sure you comply with upstream terms.

---

> This is a personal project. No license is provided for this repository.
