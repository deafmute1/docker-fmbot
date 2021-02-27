FROM debian:buster
LABEL maintainer="me@ethandjeric.com"
LABEL docker_version="r1"
LABEL version="latest"

ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
#ENV POSTGRES_HOST=postgres, POSTGRES_PORT=5433, POSTGRES_DB=postgres, POSTGRES_USER=postgres, POSTGRES_PASS=password
#ENV DISCORD_API=none, LASTFM_API=none, GENIUS_API=none, SPOTIFY_API=none, GOOGLE_API=none

ADD  https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb /tmp/ 
ADD  https://github.com/fmbot-discord/fmbot/releases/latest/download/BinaryFiles.zip /tmp/  
ADD  https://github.com/fmbot-discord/fmbot/releases/latest/download/BinaryRelease.zip /tmp/ 
RUN dpkg -i /tmp/packages-microsoft-prod.deb \ 
    && apt-get update \
    && apt-get install -y \
      apt-transport-https \
      ca-certificates \
      unzip \
      dotnet-sdk-5.0 \ 
    && mkdir /opt/fmbot \
    && unzip -o /tmp/BinaryFiles.zip -f /opt/fmbot \ 
    && unzip -o /tmp/BinaryRelease.zip -f /opt/fmbot \
    && apt-get clean \ 
    && rm -rf \
      /tmp/* \
      /var/lib/apt/lists/* \
      /var/cache/apt/* \
      /var/tmp/* 

# COPY root/ / 
VOLUME ["/opt/fmbot/configs"] 
USER root 
ENTRYPOINT ["/usr/bin/dotnet /opt/fmbot/FMBot.Bot.dll"] 



