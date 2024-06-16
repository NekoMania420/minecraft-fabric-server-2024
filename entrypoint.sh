#!/bin/sh

if [ ! -f "/server/fabric-server-launch.jar" ]; then
  wget https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.1/fabric-installer-1.0.1.jar -O fabric-installer.jar
  java -jar fabric-installer.jar server -dir server -downloadMinecraft
fi

cd /server

if [ ! -f "eula.txt" ]; then
  cp /eula.txt .
fi

if [ ! -f "server.propreties" ]; then
  cp /server.properties .
fi

java -jar fabric-server-launch.jar
