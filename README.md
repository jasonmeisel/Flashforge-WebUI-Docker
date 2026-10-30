# FlashForge WebUI (Docker)

Run the prebuilt FlashForge WebUI Linux x64 release binary in Docker. The Docker build downloads the binary directly from the GitHub release; it does not build the application from source.

## Requirements

- Docker Engine with the Docker Compose plugin
- An x86-64 Linux-compatible Docker host (or compatible x86-64 emulation)
- Network access from the container to your FlashForge printer(s)

## Start

From this directory, build and start the container:

```sh
docker compose up -d --build
```

Open <http://localhost:3000> on the Docker host, or use `http://<server-ip>:3000` from another device on your network.

The first start creates runtime configuration and state under `./data`. The Compose file starts with `--no-printers`, so add/configure your printer using the WebUI. To follow logs or stop the service:

```sh
docker compose logs -f
docker compose down
```

## Configuration and security

- The default WebUI password is `changeme`. Change it in `./data/config.json` after first startup, or set a secure password in the config before exposing the service.
- Runtime state is persisted in `./data` through the `/data` volume.
- Port `3000` is the only published port. Do **not** publish port `1984`; go2rtc does not have authentication of its own. Camera streaming is tunneled through the WebUI.
- Keep the service on a trusted network or put it behind an appropriately secured reverse proxy if remote access is needed.

## Updating

To use another release, pass its binary URL as a build argument and rebuild:

```sh
docker compose build --build-arg RELEASE_URL=https://github.com/Parallel-7/FlashForgeWebUI/releases/download/v1.2.0/flashforge-webui-linux-x64.bin
docker compose up -d
```

Back up `./data` before updating. The default URL points to the v1.2.0 x64 release; this setup is not suitable as-is for ARM hosts.
