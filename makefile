# build:
# 	docker build -t ronnieonthehub/spigotmc:latest	.
buildamd:
	docker buildx build --platform linux/amd64 -t alpine-amd64 --load .

buildarm64:
	docker buildx build --platform linux/arm64/v8 -t alpine-arm64/v8 --load .

buildarm32:
	docker buildx build --platform linux/arm/v8 -t ronnieonthehub/spigotmc:arm32 --load .

build:
	docker buildx build --push --platform linux/arm64/v7,linux/arm64/v8,linux/amd64  --tag ronnieonthehub/spigotmc:latest .
# 	docker buildx build  --platform linux/amd64,linux/arm64/v8 -t ronnieonthehub/spigotmc:latest --push .

push:
	docker push ronnieonthehub/spigotmc:latest

pull:
	docker image pull ronnieonthehub/spigotmc:latest

run:
	-mkdir volume
	-docker stop ronnie
	-docker rm ronnie
	docker run --name ronnie -it \
	-v "/Users/ronan/Projects/spigot-docker/volume":/opt/minecraft \
	-v "/Users/ronan/Projects/spigot-docker":/root \
	-e "MINECRAFT_EULA=true" \
	-d ronnieonthehub/spigotmc:latest /bin/bash
	docker exec -it ronnie /bin/bash

clean:
	docker system prune
