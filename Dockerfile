ARG RELEASE_URL=https://github.com/Parallel-7/FlashForgeWebUI/releases/download/v1.2.0/flashforge-webui-linux-x64.bin

FROM debian:bookworm-slim

ARG RELEASE_URL
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    && curl -fL --retry 3 "$RELEASE_URL" -o /app/flashforge-webui \
    && chmod 0755 /app/flashforge-webui \
    && apt-get purge -y --auto-remove curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
ENV DATA_DIR=/data
EXPOSE 3000
VOLUME ["/data"]

CMD ["/app/flashforge-webui", "--no-printers"]
