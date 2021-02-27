FROM debian:buster
LABEL maintainer="me@ethandjeric.com"
LABEL docker_version="r1"
LABEL version="latest"

ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

ADD  https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb /tmp/ 
ADD  https://github.com/fmbot-discord/fmbot/releases/latest/download/BinaryFiles.zip /tmp/  
ADD  https://github.com/fmbot-discord/fmbot/releases/latest/download/BinaryRelease.zip /tmp/ 
RUN apt-get update \
    && apt-get install -y \
      apt-transport-https \
      ca-certificates \
      unzip \
    # install dotnet sdk - deb relies on ca-certificates 
    && dpkg -i /tmp/packages-microsoft-prod.deb \ 
    && apt-get update \
    && apt-get install -y dotnet-sdk-5.0 \ 
    # install fmbot 
    && mkdir -p /opt/fmbot \
    && unzip -o /tmp/BinaryFiles.zip -d /opt/fmbot \ 
    && unzip -o /tmp/BinaryRelease.zip -d /opt/fmbot \
    && apt-get clean \ 
    && rm -rf \
      /tmp/* \
      /var/lib/apt/lists/* \
      /var/cache/apt/* \
      /var/tmp/* 

VOLUME ["/opt/fmbot/configs"] 
USER root 
ENTRYPOINT ["/usr/bin/dotnet /opt/fmbot/FMBot.Bot.dll"] 



