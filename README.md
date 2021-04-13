# Minecraft Spigot server Docker Image
## What is it?
A Docker image with which you can easily set up a dockerized version of a Spigot Minecraft server. You can choose between a openJDK flavour of 8 or 11, latest in 11.


## Enviroment Tables
There are several enviroment varbiables which can be altered.

### MINECRAFT_VERSION
`MINECRAFT_VERSION` is default set to `1.16.3`, because this is the latest version of Minecraft as of writing this image. During the install of the server a version file will be writen to the `MINECRAFT_HOME` directory. This is used to determine if there is a diffrence between `MINECRAFT_VERSION` (set by the user) and the version of the server installed. This variable can be changed to the desired version of the Minecraft.

### MINECRAFT_EULA
Set standard to `false`. `MINECRAFT_EULA` has to be set to `true` by the user to be able to start the server.

### MINECRAFT_SRC
`MINECRAFT_SRC` default set to `/usr/src/minecraft`. This is the directory where the server jar is generated. Which is later copied to the MINECRAFT_HOME directory. This directory is stateless, and won't be saved on shutdown. I would not change this variable.

### MINECRAFT_HOME
`MINECRAFT_HOME` default set to `/opt/minecraft`. This is the directory where the server files and world is located. I would not change this variable.

### MINECRAFT_OPTS
`MINECRAFT_OPTS` default set to the following extra parameters `-server -Xmx2048m -XX:MaxPermSize=512m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC`. You could change this if you desire more or less memory for the server.

### FORCE_UPDATE
`FORCE_UPDATE` default set to 'false' give you the option to update the .jar of the server. By changing `FORCE_UPDATE` to 'true' a new .jar will be made on startup, and the old .jar will be removed.

## Updating and config files
If there is a mismatch between the user set `MINECRAFT_VERSION` and currently installed server version, the server will do the following:
- Download the BuildTools.jar from Spigot, and generate a server jar with the desired `MINECRAFT_VERSION` .
- Write `MINECRAFT_SRC` to `MINECRAFT_HOME`.

## Volumes
Only one volume should be bound, with the path same path as `MINECRAFT_HOME`.