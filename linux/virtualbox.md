# Virtuális gép használata VirtualBox

## Telepítés

```bash
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
```

Egyszerűen fogalmazva, ez a parancs letölti a VirtualBox telepítéséhez szükséges hitelesítési kulcsot, eltávolítja a titkosítást, majd a rendszer kulcstárolójába menti. Ez lehetővé teszi a csomagkezelő számára a VirtualBox csomagok eredetiségének ellenőrzését a telepítés során.

```
sudo apt update && apt install apt install virtualbox-7.0
```

Ha ez nem tud települni, akkor letölthetjük .deb kiterjesztéssel és `dpkg -i valami.deb`


 Függőségi csomagok telepítése

```bash
sudo apt install -f
```

Hasznos lehet még később

```bash
sudo apt-get install linux-headers-`uname -r`; sudo vboxconfig
```