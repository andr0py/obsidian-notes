A Docker egy nyílt forráskódú platform, amely lehetővé teszi a szoftverek konténerekben történő futtatását. A konténerek könnyű súlyú, önálló futtatási környezetek, amelyekben minden szükséges függőség szerepel az alkalmazás futtatásához. Ez a megközelítés számos előnnyel jár a hagyományos virtualizációhoz képest, beleértve:
- **Erőforrás-hatékonyság:** A konténerek csak az alkalmazás futtatásához szükséges operációs rendszerkomponenseket tartalmazzák, ami jelentősen csökkenti a memóriahasználatot és a CPU terhelést.
- **Hordozhatóság:** A konténerek hordozhatók, ami azt jelenti, hogy ugyanúgy futnak bármilyen gépen, amelyen telepítve van a Docker Engine. Ez megkönnyíti az alkalmazások fejlesztését, tesztelését és üzembe helyezését.
- **Gyors beállítás:** A konténerek gyorsan elindíthatók és leállíthatók, ami ideális a mikroszolgáltatások és a CI/CD folyamatok számára.
## A Docker célja

==A Docker célja, hogy egyszerűbbé és hatékonyabbá tegye a szoftverek fejlesztését==, tesztelését és üzembe helyezését. Ezt a konténerek használatával éri el, amelyek könnyű súlyúak, önálló futtatási környezetek, amelyekben minden szükséges függőség szerepel az alkalmazás futtatásához.
## A Docker alkalmazási területei

A Docker-t számos területen lehet alkalmazni, többek között:

- **Webfejlesztés:** A Docker ideális webes alkalmazások fejlesztéséhez, teszteléséhez és üzembe helyezéséhez.
- **Mikroszolgáltatások:** A Docker a mikroszolgáltatások architektúrájának ideális platformja.
- **DevOps:** A Docker a CI/CD folyamatok automatizálására használható.
- **Rendszergazdai feladatok:** A Docker a rendszerek karbantartására és üzemeltetésére használható.
## Telepítés
```bash
sudo apt update
sudo apt install docker.io docker-compose
```

## parancsok

| parancs                            | leírás                                                                                     |
| ---------------------------------- | ------------------------------------------------------------------------------------------ |
| docker pull image                  | docker hubról lehúzza a megadott imaget                                                    |
| docker images                      | Listázza a helyileg tárolt imageket                                                        |
| docker run -d image                | futtatja egy konténert ezzel az image-el. A -d kapcsoló segítségével a háttérben fog futni |
| docker exec -it konténer /bin/bash | ezzel lehet elvileg előhozni a shell-t, ha a háttérben indítottuk a konténert.             |
| docker version                     | részletes leírást ad vissza a telepített docker engineről                                  |

## valós parancsok
```bash
sudo docker run -it ubuntu:latest bash

# összes konténer kipucolása
sudo docker container prune
```
## docker-compose file

```yml
version: '3.8'
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    user: 1000:1000
    network_mode: 'host'
    volumes:
      - /home/andr0/Docker/jellyfin/config:/config
      - /home/andr0/Docker/jellyfin/cache:/cache
      - /home/andr0/media:/media
      - /home/andr0/media:/media2:ro
    restart: 'unless-stopped'
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - WEBUI_PORT=8080
    volumes:
      - /home/andr0/Docker/qbittorrent/config:/config
      - /home/andr0/media/Filmek:/downloads/filmek
      - /home/andr0/media/Sorozatok:/downloads/sorozatok
      - /home/andr0/media:/downloads
    ports:
      - 8080:8080
      - 6881:6881
      - 6881:6881/udp
    restart: unless-stopped
  homeassistant:
    container_name: homeassistant
    image: "ghcr.io/home-assistant/home-assistant:stable"
    volumes:
      - /home/andr0/Docker/homeassistant/config:/config
      - /etc/localtime:/etc/localtime:ro
      - /run/dbus:/run/dbus:ro
    restart: unless-stopped
    privileged: true
    network_mode: host
```
