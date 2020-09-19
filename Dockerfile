FROM openjdk:8-jre
MAINTAINER Ronan Munro ronan18@live.nl

EXPOSE 25565

ENV MINECRAFT_VERSION=1.16.3
ENV MINECRAFT_HOME="/opt/minecraft"
ENV MINECRAFT_SRC="/usr/src/minecraft"
ENV MINECRAFT_EULA=false

VOLUME ["/opt/minecraft"]
WORKDIR /opt/minecraft

RUN apt-get update && apt-get install -y wget vim
RUN apt install git-all -y

COPY entrypoint.sh /root/entrypoint.sh

CMD /root/entrypoint.sh