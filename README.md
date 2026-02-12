> This project is a personal initiative focused on live coding music and reproducible environments.

# marquis_strudel_prod — Strudel (Production) in Docker

`marquis_strudel_prod` provides a **portable, reproducible production setup** for **Strudel**, fully containerized and served locally via **Docker + nginx**.

The application is built at image creation time and served as static files. No dev server runs in production.

Strudel is available at:

[http://127.0.0.1:4321](http://127.0.0.1:4321)

---

## 🌐 Project Overview

**Goal:** Run Strudel locally in a clean, minimal, production-style container without installing Node, pnpm, or build tooling on the host.

This image:

* Clones Strudel from upstream
* Installs dependencies
* Generates required documentation files (`doc.json`)
* Builds the static website (Astro build)
* Serves it via nginx

Runtime is lightweight and contains **no Node.js tooling**.

---

## 🏗 Architecture

Multi-stage Docker build:

### Build stage

* Base: `node:20-bookworm`
* `pnpm install`
* `pnpm prestart` (generates `doc.json`)
* `pnpm -C website build`

### Runtime stage

* Base: `nginx:alpine`
* Copies `/website/dist`
* Serves static files on port 80
* SPA fallback configured (`try_files ... /index.html`)

Host port **4321** → Container port **80**

---

## 🚀 Quickstart

### Prerequisites

* Docker installed and running
* A modern web browser

---

### 1️⃣ Build the image

```bash
make build
```

---

### 2️⃣ Run Strudel

```bash
make run
```

Open:

[http://127.0.0.1:4321](http://127.0.0.1:4321)

---

### 3️⃣ Stop the container

```bash
make stop
```

---

### Useful commands

Follow logs:

```bash
make logs
```

Remove container and image:

```bash
make clean
```

---

## 🎵 Live Coding Workflow

This is a **production build**.

You can:

* Live code music inside the Strudel web interface
* Use all visualizers (piano roll, scope, etc.)
* Run fully offline once built

You cannot:

* Modify Strudel source code with hot reload
* Use Astro dev server features

If you need development mode (hot reload), a separate dev Docker setup would be required.

---

## 🧩 Notes

* Prefer `127.0.0.1` over `localhost` if you encounter IPv6 or proxy issues.
* This image rebuilds Strudel at build time. If upstream changes, rebuild the image.
* Audio is handled entirely by the browser (no PulseAudio or host audio bridging required).

---

## 📦 Makefile Targets

* `make build` → Build Docker image
* `make run` → Run container on port 4321
* `make stop` → Stop container
* `make logs` → Follow logs
* `make clean` → Remove container and image

---

> This is a personal project. No license is provided for this repository.
