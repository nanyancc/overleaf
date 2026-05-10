# Overleaf Docker Image

[中文说明](README_cn.md)

This repository is used to build a customized Overleaf Community Edition Docker image.
It is intended for self-hosted Docker Compose deployments and includes common Chinese fonts found on Windows, making it easier to compile LaTeX documents that depend on Chinese fonts.

## Features

- Based on Overleaf Community Edition / ShareLaTeX.
- Includes common Chinese fonts found on Windows, such as SimSun, SimHei, Microsoft YaHei, KaiTi, FangSong, DengXian, and related font families.
- Installs a full TeX Live scheme inside the image.
- Provides a ready-to-use `docker-compose.yml` with Overleaf, MongoDB, and Redis.
- One-command startup with `docker compose up -d`.

## Environment Requirements

- Docker
- Docker Compose v2

## Quick Start

Start the full stack:

```bash
docker compose up -d
```

The default compose file binds Overleaf to:

```text
http://127.0.0.1
```

Persistent data is stored under:

```text
./data/
```

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

## Configuration Notes

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
