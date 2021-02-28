#!/bin/sh

cd /opt/fmbot 
echo "Running with config: "
cat ./configs/config.json 
dotnet ./FMBot.Bot.dll


