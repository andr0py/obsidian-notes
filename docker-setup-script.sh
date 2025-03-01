#!/bin/bash

set -e  # Hibakezelés: ha egy parancs hibát jelez, a script leáll

# Változók
DOCKER_COMPOSE_URL="https://példa.hu/docker-compose.yml"  # Itt add meg a letöltési URL-t
DOCKER_DIR="$HOME/docker"
MEDIA_DIR="$HOME/media"

# Ellenőrizzük, hogy root joggal fut-e
echo "Ellenőrzés: root jog szükséges..."
if [ "$EUID" -ne 0 ]; then
    echo "Kérlek futtasd ezt a scriptet root (sudo) joggal!"
    exit 1
fi

# Docker telepítése a hivatalos Docker repository-ból
echo "Docker repository hozzáadása és telepítés..."
apt update
apt install -y ca-certificates curl gnupg

# Docker GPG kulcs letöltése
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.gpg > /dev/null
chmod a+r /etc/apt/keyrings/docker.gpg

# Repository beállítása
ARCH=$(dpkg --print-architecture)
echo "deb [arch=$ARCH signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker és Docker Compose plugin telepítése
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable --now docker

# Mappák létrehozása
mkdir -p "$DOCKER_DIR/jellyfin/config" "$DOCKER_DIR/jellyfin/cache"
mkdir -p "$DOCKER_DIR/qbittorrent/config"
mkdir -p "$DOCKER_DIR/plex"
mkdir -p "$MEDIA_DIR/filmek" "$MEDIA_DIR/sorozatok"

# Docker Compose fájl letöltése
echo "Docker Compose fájl letöltése: $DOCKER_COMPOSE_URL"
wget -O "$DOCKER_DIR/docker-compose.yml" "$DOCKER_COMPOSE_URL"

# Konténerek indítása
cd "$DOCKER_DIR"
echo "Konténerek indítása..."
docker compose up -d

echo "Kész! A konténerek futnak."
