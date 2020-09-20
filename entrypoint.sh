#!/bin/bash
set -e
VERSION_FILE="$MINECRAFT_HOME/version"
CURRENT_VERSION=$(head -n 1 $VERSION_FILE || echo "does not exist")
MINECRAFT_OPTS=${MINECRAFT_OPTS:-"-server -Xmx2048m -XX:MaxPermSize=512m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC"}

SPIGOT_BUILDTOOLS_URL=${SPIGOT_BUILDTOOLS_URL:-"https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"}


mkdir -p $MINECRAFT_SRC || true
mkdir -p $MINECRAFT_HOME || true

check_env() {
    # Agree to EULA.
    if [ $MINECRAFT_EULA = true ]; then
        echo "Updating $MINECRAFT_HOME/eula.txt"
        echo "eula=$MINECRAFT_EULA" > $MINECRAFT_HOME/eula.txt
    else
        >&2 echo "Mojang requires you to accept their EULA. You need to set the MINECRAFT_EULA variable to true."
        exit 1
    fi
}

    #check for server version mismatch
if [ "$CURRENT_VERSION" != "$MINECRAFT_VERSION" ]; then
    cd $MINECRAFT_SRC

    #download and create new server jar from buildtools jar
    echo "Version mismatch: $MINECRAFT_VERSION (selected version) != $CURRENT_VERSION (current installed version). Downloading BuildTools"
    wget -O "$MINECRAFT_SRC/BuildTools.jar" "$SPIGOT_BUILDTOOLS_URL"
    echo "Creating new server jar"
    cd $MINECRAFT_SRC
    java -Xmx1024M -jar BuildTools.jar -- rev $MINECRAFT_VERSION

    #install new server version from source dir to server home dir
    echo "Removing old server jar, and moving new jar to server dir"
    rm -f $MINECRAFT_HOME/spigot*.jar
    cp -r $MINECRAFT_SRC/spigot-*.jar $MINECRAFT_HOME

    echo $MINECRAFT_VERSION > $VERSION_FILE

    #cleaning up Minecraft Source
    echo "Cleaning up install files after upgrade to server version $MINECRAFT_VERSION"
    rm -r "$MINECRAFT_SRC/"
fi

#check to see if $MINECRAFT_EULA var is set to true
echo "Eula variable is set to: $MINECRAFT_EULA"
check_env

#start the server
echo "Starting server"
cd $MINECRAFT_HOME
java -jar $MINECRAFT_OPTS spigot*.jar -nogui
