# docker-fmbot
Dockerised discord bot fmbot. 
Builds are available on (https://hub.docker.com/repository/docker/deafmute/fmbot)[DockerHub]. 

# Setup 
1. Run the container once to generate a default config.json: 
  `$ docker run -it --rm  -v /path/to/config:/opt/fmbot/configs/configs.json deafmute/fmbot`

2. Now edit this `configs.json` file as per (https://fmbot.xyz/setup/#getting-api-keys)[fmbot docs], adding API keys (minimum Discord) and postgres info.
   Using the example docker compose below, the postgres info should be: `Host=db;Port=5432;Username=fmbot;Password=secret;Database=fmbot`

3. Now, you can setup this container to run as you like. Example docker compose: 
`verison: '3'
services:
  fmbot: 
    image: deafmute/fmbot 
    container_name: fmbot
    volumes:
      - /path/to/configs:/opt/fmbot/configs 
    networks: 
      - internal 
    restart: always 

  db:
    image: postgres:13
    container_name: fmbot-db
    environment:
      - POSTGRES_DB=fmbot 
      - POSTGRES_USER=fmbot 
      - POSTGRES_PASSWORD=secret
    volumes:
      - /path/to/db/data:/var/lib/postgresql/data
      - /etc/localtime:/etc/localtime:ro
    hostname: db
    networks:
      - internal
    restart: always ` 





