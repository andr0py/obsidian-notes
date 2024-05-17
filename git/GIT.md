## Git Alapok

### Git Telepítése

Először is, telepíteni kell a Git-et. A telepítési utasításokat megtalálhatod a [Git hivatalos weboldalán](https://git-scm.com/).

### Konfiguráció

Miután telepítetted a Git-et, be kell állítanod a neved és e-mail címed:

```shell
git config --global user.name "A Te Neved" git config --global user.email "a.te@email.cimed"
```
Ez azért fontos, mert minden commit (változtatás) tartalmazni fogja ezeket az információkat.
## Git Parancsok

### 1. Git Inicializálása

Egy új Git repository létrehozása a projekt mappájában:

```shell
git init
```


Ez létrehoz egy rejtett `.git` könyvtárat a projekt mappádban, ahol a Git tárolja az összes szükséges információt a verziókövetéshez.

### 2. Fájlok hozzáadása a Staging Area-hoz

Mielőtt commit-olnál, hozzá kell adnod a fájlokat a staging area-hoz:
```shell
git add <fájl_név>
```

Ha az összes módosított fájlt szeretnéd hozzáadni:
```shell
git add .
```
Ez a parancs az aktuális könyvtár összes változtatását hozzáadja a staging area-hoz.

### 3. Változtatások Commit-olása

A staging area-ban lévő változtatások mentése a repository-ba:
```shell
git commit -m "Commit üzenet"
```
A commit üzenet röviden leírja a változtatásokat, hogy később is érthető legyen, mi történt.

### 4. Repository Klónozása

Egy távoli repository klónozása a helyi gépre:
```shell
git clone <repository_URL>
```
Ez letölti az összes fájlt és a Git történetet a megadott URL-ről.
### 5. Változtatások Nyomon Követése

A repository-ban történt változtatások megtekintése:
```shell
git status
```
Ez a parancs megmutatja, mely fájlok módosultak, és melyek vannak a staging area-ban.
### 6. Változtatások Egyesítése

A staging area-ban lévő változtatások visszavonása:
```shell
git reset HEAD <fájl_név>
```
Ez eltávolítja a fájlt a staging area-ból, de a módosítások megmaradnak a munkakönyvtárban.
### 7. Branch-ek Kezelése

Új branch létrehozása:
```shell
git branch <branch_név>
```

Egy meglévő branch-re váltás:
```shell
git checkout <branch_név>
```

Új branch létrehozása és azonnali váltás rá:
```shell
git checkout -b <branch_név>
```
### 8. Változtatások Egyesítése (Merge)

Egy másik branch változtatásainak egyesítése a jelenlegi branch-be:
```shell
git merge <branch_név>
```
### 9. Távoli Repository-k Kezelése

Egy távoli repository hozzáadása:
```shell
git remote add origin <repository_URL>
```

Változtatások feltöltése a távoli repository-ba:
```shell
git push origin <branch_név>
```

Változtatások letöltése a távoli repository-ból:
```shell
git pull origin <branch_név>
```

### 10. Git Log

A commit történelem megtekintése:
```shell
git log
```
Ez megmutatja az összes commit-ot, azok üzeneteivel és a hozzátartozó részletekkel.
## Gyakori Parancsok és Fogalmak
### Staging Area
Az a terület, ahová a fájlokat először hozzá kell adni (git add), mielőtt commit-olnánk őket.
### Commit
Egy pillanatkép a kódról egy adott időpontban. Minden commit tartalmaz egy üzenetet, amely leírja a változtatásokat.
### Branch
Egy alternatív fejlesztési vonal. A branch-ek segítségével párhuzamosan lehet fejleszteni új funkciókat anélkül, hogy a fő (main) ágat befolyásolnánk.
### Merge
A branch-ek egyesítése. A változtatások beolvasztása egy másik branch-be.
### Repository (Repo)
A Git által verziókövetett projekt. Ez tartalmazza a projekt összes fájlját és a hozzá tartozó teljes történetet.
### Távoli Repository (Remote)
Egy Git repository, amely nem helyi gépen van, hanem egy szerveren (pl. GitHub, GitLab).
## Példák

### Új Projekt Létrehozása és Kezelése

1. Új repository inicializálása:
```shell
git init
```
2. Fájlok hozzáadása és commit-olása:
```shell
git add . git commit -m "Első commit"
```

3. Távoli repository hozzáadása és feltöltése:
```shell
git remote add origin https://github.com/felhasznalo/projekt.git git push -u origin main
```
### Létező Projekt Klónozása és Módosítása

1. Repository klónozása:
```shell
git clone https://github.com/felhasznalo/projekt.git
```

2. Új branch létrehozása és váltás rá:
```shell
git checkout -b uj-funkcio
```
 
 3. Változtatások hozzáadása és commit-olása:
```shell
git add . git commit -m "Új funkció hozzáadása"
```

 4. Változtatások feltöltése a távoli repository-ba:
```shell
git push origin uj-funkcio
```
