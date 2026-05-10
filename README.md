# Overleaf Docker Image

[中文说明](README_cn.md)

This repository is used to build a customized Overleaf Community Edition Docker image.
It is intended for self-hosted Docker Compose deployments and includes common Chinese fonts found on Windows, making it easier to compile LaTeX documents that depend on Chinese fonts.

> The official ShareLaTeX image does not include Chinese fonts or an ARM version, which makes it inconvenient to deploy on Oracle ARM servers. This image was therefore rebuilt from scratch for ARM and includes common Chinese fonts.

## Features

- Based on Overleaf Community Edition / ShareLaTeX.
- Includes common Chinese fonts found on Windows, such as SimSun, SimHei, Microsoft YaHei, KaiTi, FangSong, DengXian, and related font families.
- Installs a full TeX Live scheme inside the image.
- Provides a ready-to-use `docker-compose.yml` with Overleaf, MongoDB, and Redis.
- One-command startup with `docker compose up -d`.

## Quick Start

Start the full stack:

```bash
git clone https://github.com/nanyancc/overleaf.git overleaf
cd overleaf
docker compose up -d
```

The default access address is `http://127.0.0.1:3000`.
On the first visit, create an administrator account at `http://127.0.0.1:3000/launchpad`.

Persistent data is stored under the `./data/` directory, including MongoDB data, Redis data, and Overleaf project data.

## Docker Image

The current `docker-compose.yml` uses:

```text
ghcr.io/nanyancc/sharelatex:latest
```

You can pull the image directly:

```bash
docker pull ghcr.io/nanyancc/sharelatex:latest
```

If the `latest` image is not available, look for an earlier date-based version. To use a date-based release tag:

```bash
docker pull ghcr.io/nanyancc/sharelatex:2026.5.10
```

## Common Commands

View logs:

```bash
docker compose logs -f sharelatex
```

Stop the stack:

```bash
docker compose down
```

Update to the latest image:

```bash
docker compose pull
docker compose up -d
```

## Configuration

Most runtime settings are in `docker-compose.yml` under the `sharelatex.environment` section.

For example, change the public site URL by setting:

```yaml
OVERLEAF_SITE_URL: "https://overleaf.example.com"
```

By default, the service is bound to localhost only:

```yaml
ports:
  - "127.0.0.1:80:80"
```

Change this binding if you want to expose the service through another port, host, or reverse proxy.
