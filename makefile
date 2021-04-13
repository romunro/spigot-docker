#build:
#	docker build -t ronnieonthehub/spigotmc:latest	.
buildamd:
	docker buildx build --platform linux/amd64 -t alpine-amd64 --load .

buildarm64:
	docker buildx build --platform linux/arm64/v8 -t alpine-arm64/v8 --load .

buildarm32:
	docker buildx build --platform linux/arm/v8 -t ronnieonthehub/spigotmc:arm32 --load .

pushmerge:
	docker buildx build  --platform linux/amd64,linux/arm64/v8 -t ronnieonthehub/spigotmc: --push .

push:
	docker push ronnieonthehub/spigotmc:latest

pull:
	docker image pull ronnieonthehub/spigotmc:latest

run:
	-mkdir volume
	-docker stop ronnie
	-docker rm ronnie
	docker run --name ronnie -it \
	-v "/mnt/c/projects/spigot-docker/volume":/opt/minecraft \
	-v "/mnt/c/projects/spigot-docker":/root \
	-e "MINECRAFT_EULA=true" \
	-d ronnieonthehub/spigotmc:latest /bin/bash
	docker exec -it ronnie /bin/bash

clean:
	docker system prune
