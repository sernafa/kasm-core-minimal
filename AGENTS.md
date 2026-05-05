# AGENTS.md

## Build

```bash
docker buildx bake --load
```

Builds both `Dockerfile` and `Dockerfile.systemd` with `docker-bake.hcl`. Multi-arch targets: `linux/amd64`, `linux/arm64`. `--no-cache` is forced in bake config.

## Variants

- **`Dockerfile`** — standard image. Runtime stage copies from `scratch` for minimal size.
- **`Dockerfile.systemd`** — runs systemd as PID 1. Uses `antmelekhin/docker-systemd:ubuntu-24.04` as base image. Requires `--privileged`, `--cgroupns=host`, and `-v=/sys/fs/cgroup:/sys/fs/cgroup:rw` at runtime.

## Architecture

- Two-stage Docker build: `base_layer` (FROM ubuntu:24.04) installs everything, then copies into `scratch`.
- Source tree:
  - `src/common/` — shared startup scripts, profile sync, kasmvnc.yaml
  - `src/ubuntu/` — Ubuntu-specific install scripts, systemd unit, openbox defaults
- Container entrypoint chain (applies to both variants):
  1. `kasm_default_profile.sh` — copies default profile to `$HOME` if `.bashrc` missing, sets up symlinks
  2. `vnc_startup.sh` — full VNC lifecycle: cert gen, Xvnc launch, openbox, websocket proxy
  3. `kasm_startup.sh` — (not in this repo; expected at `/dockerstartup/kasm_startup.sh`)
  CMD is `--wait` which keeps the container alive.

## Key files

- `docker-bake.hcl` — defines build targets and tags (e.g. `kasm-core-minimal:1.4.1`)
- `src/common/install/kasm_vnc/kasmvnc.yaml` — KasmVNC server config (SSL cert path, UDP public_ip)
- `src/ubuntu/systemd/kasmvnc.service` — systemd unit for the systemd variant
- `src/ubuntu/defaults/openbox/autostart` — openbox autostart (launches stalonetray)
- `src/ubuntu/defaults/openbox/menu.xml` — right-click desktop menu (needs `obamenu` package)

## Version bump workflow

To add a new version target, add a new `target` block in `docker-bake.hcl` with `COMMIT_ID`, `KASMVNC_VER`, and corresponding tags. The Dockerfiles accept `COMMIT_ID`, `KASMVNC_VER`, and `BRANCH` as build args to control which KasmVNC version is pulled from git during `install_kasm_vnc.sh`.

## No tests, no CI

This repo has no test suite, linter, or CI workflow. Changes are validated by building the image and running a container.
