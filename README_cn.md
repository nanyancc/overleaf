# Overleaf Docker 镜像

[English README](README.md)

这个仓库用于构建一个自定义的 Overleaf Community Edition Docker 镜像。
它面向 Docker Compose 自托管部署，并内置 Windows 中常见的中文字体，方便编译包含中文字体依赖的 LaTeX 文档。

> 其实是官方的sharelatex镜像没有中文字体和arm版本，不方便部署在Oracle的ARM服务器上，遂从头编译了一个arm版本，并且内置了常见的中文字体。

## 功能特性

- 基于 Overleaf Community Edition / ShareLaTeX。
- 内置 Windows 常见中文字体，例如宋体、黑体、微软雅黑、楷体、仿宋、等线以及相关字体族。
- 镜像内安装完整 TeX Live 方案。
- 提供可直接使用的 `docker-compose.yml`，包含 Overleaf、MongoDB 和 Redis。
- 通过 `docker compose up -d` 一键启动。

## 快速开始

启动完整服务：

```bash
git clone https://github.com/nanyancc/overleaf.git overleaf
cd overleaf
docker compose up -d
```

默认访问地址是`http://127.0.0.1:3000`。第一次访问需要在`http://127.0.0.1:3000/launchpad`页面创建一个管理员账户。

持久化数据会保存在`./data/`目录下，包含 MongoDB 数据、Redis 数据和 Overleaf 项目数据。

## Docker 镜像

当前 `docker-compose.yml` 默认使用：

```text
ghcr.io/nanyancc/sharelatex:latest
```

也可以直接拉取镜像：

```bash
docker pull ghcr.io/nanyancc/sharelatex:latest
```

如果latest镜像不可使用，请按日期查找之前的版本。如果需要使用按日期发布的版本：

```bash
docker pull ghcr.io/nanyancc/sharelatex:2026.5.10
```

## 常用命令

查看日志：

```bash
docker compose logs -f sharelatex
```

停止服务：

```bash
docker compose down
```

更新到最新镜像：

```bash
docker compose pull
docker compose up -d
```

## 配置说明

主要运行配置位于 `docker-compose.yml` 的 `sharelatex.environment` 部分。

例如，可以通过下面的变量设置站点地址：

```yaml
OVERLEAF_SITE_URL: "https://overleaf.example.com"
```

默认只监听本机地址：

```yaml
ports:
  - "127.0.0.1:80:80"
```

如果需要通过其他端口、外网地址或反向代理访问，可以修改这里的端口绑定。
