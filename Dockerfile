FROM openjdk:16.0.1-jdk-buster
MAINTAINER Ronan Munro https://github.com/romunro

EXPOSE 25565

ENV MINECRAFT_VERSION="latest"
ENV MINECRAFT_HOME="/opt/minecraft"
ENV MINECRAFT_SRC="/usr/src/minecraft"
ENV MINECRAFT_EULA=false
ENV MINECRAFT_OPTS="-server -Xmx2048m"
ENV FORCE_UPDATE=false

EXPOSE 25565

VOLUME ["/opt/minecraft"]
WORKDIR /opt/minecraft

RUN apt-get update && apt-get install -y wget vim \
    && apt install git-all -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /root/entrypoint.sh

CMD /root/entrypoint.sh