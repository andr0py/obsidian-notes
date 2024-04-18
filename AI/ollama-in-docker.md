# `ollama` használata `Docker` konténerben

![ollama](../img/ollama.png)
## konténer létrehozása
1. belépés a `home` könyvtárba
```bash
cd ~
```

2. `~/Docker/ollamadir` mappa létrehozása
```bash
mkdir -p -v Docker/ollamadir
```

3. konténer létrehozása
```bash
docker run -d -v /home/andr0/Docker/ollamadir:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```
## nyelvi modell kiválasztása és futtatása

1. futtatás
```bash
docker exec -it ollama ollama run llama2
```
2. aliaszolás
```bash
# a fenti parancs aliaszolása
alias ollama="docker exec -it ollama ollama"

# így következőleg már csak annyit kell megadnunk, hogy:
ollama run llama2
```
