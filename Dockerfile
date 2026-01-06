#BUILD THE SERVER IMAGE
FROM --platform=linux/amd64 cm2network/steamcmd:root

RUN apt-get update && apt-get install -y --no-install-recommends \
    gettext-base=0.21-12 \
    procps=2:4.0.2-3 \
    jq=1.6-2.1+deb12u1 \
    wine \
    wine64 \
    xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

LABEL maintainer="support@indifferentbroccoli.com" \
      name="indifferentbroccoli/starrupture-server-docker" \
      github="https://github.com/indifferentbroccoli/starrupture-server-docker" \
      dockerhub="https://hub.docker.com/r/indifferentbroccoli/starrupture-server-docker"

ENV HOME=/home/steam \
    CONFIG_DIR=/starrupture-config \
    DEFAULT_PORT=7777 \
    SERVER_NAME=starrupture-server \
    MAX_PLAYERS=4 \
    MULTIHOME="" \
    UPDATE_ON_START=true

COPY ./scripts /home/steam/server/

COPY branding /branding

RUN mkdir -p /home/steam/server_files /home/steam/server_data && \
    chmod +x /home/steam/server/*.sh

WORKDIR /home/steam/server

HEALTHCHECK --start-period=5m \
            CMD pgrep "wine" > /dev/null || exit 1

ENTRYPOINT ["/home/steam/server/init.sh"]
