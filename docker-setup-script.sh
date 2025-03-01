#!/bin/bash

set -e  # Hibakezelés: ha egy parancs hibát jelez, a script leáll

# Változók
DOCKER_COMPOSE_URL="https://github.com/andr0py/obsidian-notes/blob/87ddef8a5adfc98dc89b1802d6ad3e12d469ffde/docker/docker-compose.yaml"  # Itt add meg a letöltési URL-t
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
mkdir -p "$MEDIA_DIR/egyeb/filmek" "$MEDIA_DIR/egyeb/sorozatok"

# Docker Compose fájl letöltése és elérési utak frissítése
echo "Docker Compose fájl letöltése: $DOCKER_COMPOSE_URL"
wget -O "$DOCKER_DIR/docker-compose.yml" "$DOCKER_COMPOSE_URL"
sed -i "s|\${HOME}|$HOME|g" "$DOCKER_DIR/docker-compose.yml"

# Tűzfal beállítása
echo "Tűzfal beállítása..."
apt install -y ufw
ufw default deny incoming
ufw default allow outgoing

# Plex és Jellyfin portok engedélyezése
ufw allow 8096/tcp  # Jellyfin webes felület
ufw allow 32400/tcp  # Plex fő port
ufw allow 32469/tcp  # Plex DLNA
ufw allow 1900/udp   # Plex DLNA
ufw allow 5353/udp   # Plex mDNS
ufw allow 8324/tcp   # Plex Remote
ufw allow 32410:32414/udp  # Plex Network Discovery

ufw enable

echo "Tűzfal beállítva."

# Hosts fájl beállítása
echo "Lokális névfeloldás beállítása..."
echo "127.0.0.1 jellyfin.local" | sudo tee -a /etc/hosts
echo "127.0.0.1 plex.local" | sudo tee -a /etc/hosts
echo "127.0.0.1 qbittorrent.local" | sudo tee -a /etc/hosts

echo "Névfeloldás beállítva."

# Konténerek indítása
cd "$DOCKER_DIR"
echo "Konténerek indítása..."
docker compose up -d

echo "Kész! A konténerek futnak."

# Böngésző megnyitása kis késleltetéssel
echo "Szolgáltatások megnyitása böngészőben..."
sleep 5
xdg-open http://jellyfin.local:8096 &
sleep 2
xdg-open http://plex.local:32400/web &
sleep 2
xdg-open http://qbittorrent.local:8080 &

echo "Böngésző megnyitva."
