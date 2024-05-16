# Docker

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

| parancs                              | leírás                                                                                          |
| ------------------------------------ | ----------------------------------------------------------------------------------------------- |
| `docker pull image`                  | docker hubról lehúzza a megadott imaget                                                         |
| `docker images`                      | Listázza a helyileg tárolt imageket                                                             |
| `docker run -d image`                | futtatja egy konténert ezzel az image-el. A -d kapcsoló segítségével a háttérben fog futni      |
| `docker exec -it konténer /bin/bash` | ezzel lehet elvileg előhozni a shell-t, ha a háttérben indítottuk a konténert.                  |
| `docker version`                     | részletes leírást ad vissza a telepített docker engineről                                       |
| `sudo usermod -aG docker $USER`<br>  | Felhasználó hozzáadása a docker csoporthoz. Így nem kell mindig a sudo-val kezdeni a parancsot. |
| `newgrp docker`                      | csoport frissítése, változások életbelépése                                                     |

## példa parancsok

```bash
#konténer futtatása shellel
sudo docker run -it ubuntu:latest bash

#konténer futtatása a háttérben
sudo docker run -d -t ubuntu:latest

#háttérben indított konténer shelljének előhozása
sudo docker exec -it konténerazonosító/név

# összes konténer kipucolása
sudo docker container prune
```

## docker-compose fájl automatikus létrehozása scripttel

```shell
#!/bin/bash

mkdir -p -v ~/Docker/jellyfin/config ~/Docker/jellyfin/cache ~/media ~/media/Filmek ~/media/Sorozatok

# A YAML fájl tartalma
yaml_content="
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
			- /home/andr0/media/filmek:/downloads/filmek
			- /home/andr0/media/sorozatok:/downloads/sorozatok
		ports:
			- 8080:8080
			- 6881:6881
			- 6881:6881/udp
		restart: unless-stopped

	plex:
		image: lscr.io/linuxserver/plex:latest
		container_name: plex
		network_mode: host
		environment:
			- PUID=1000
			- PGID=1000
			- TZ=Etc/UTC
			- VERSION=docker
		volumes:
			- /home/andr0/Docker/Plex:/config
			- /home/andr0/media/sorozatok:/tv
			- /home/andr0/media/filmek:/movies
		restart: unless-stopped
"

# A YAML tartalom beírása egy fájlba
echo "$yaml_content" > ~/Docker/docker-compose.yaml
```

Abban a könyvtárban kell lennünk ahol ezt a yaml fájlt létrehoztuk, és kiadhatjuk a 
`docker-compose up parancsot` ami létrehozza a konténereket, letölti az imageket, és a screen logban ott van a webUI jelszó is. Néhány konténernél így van megoldva az első bejelentkezés.

```bash
# konténerek létrehozása
docker-compose up

#konténerek leállítása
docker-compose stop

#konténerek elindítása
docker-compose start

# futó konténerek ellenőrzése
docker-compose ps

```
