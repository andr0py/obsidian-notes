# `ollama` használata `Docker` konténerben

![ollama](../img/ollama.png)
## konténer létrehozása
```bash
cd /home/andr0/Docker

mkdir ollamadir

docker run -d -v /home/andr0/Docker/ollamadir:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```
## nyelvi modell kiválasztása és futtatása
```bash
docker exec -it ollama ollama run llama2

# a fenti parancs aliaszolása
alias ollama="docker exec -it ollama ollama"

# így következőleg már csak annyit kell megadnunk, hogy:
ollama run llama2
```
