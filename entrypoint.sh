#!/bin/sh

g1_new_size_percent=30
g1_max_new_size_percent=40
g1_heap_region_size=8
g1_reserve_percent=20

if [ $RAM_SIZE -ge 12288 ]; then
  g1_new_size_percent=40
  g1_max_new_size_percent=50
  g1_heap_region_size=16
  g1_reserve_percent=15
fi

if [ ! -f "/server/fabric-server-launch.jar" ]; then
  wget https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.1/fabric-installer-1.0.1.jar -O fabric-installer.jar
  java -jar fabric-installer.jar server -dir server -downloadMinecraft
fi

cd /server

if [ ! -f "eula.txt" ]; then
  cp /eula.txt .
fi

if [ ! -f "server.properties" ]; then
  cp /server.properties .
fi

sh -c "java -Xms${RAM_SIZE}M -Xmx${RAM_SIZE}M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=$g1_new_size_percent -XX:G1MaxNewSizePercent=$g1_max_new_size_percent -XX:G1HeapRegionSize=${g1_heap_region_size}M -XX:G1ReservePercent=$g1_reserve_percent -jar fabric-server-launch.jar --nogui"
