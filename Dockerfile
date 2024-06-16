FROM alpine

COPY entrypoint.sh .
COPY eula.txt .
COPY server.properties .

RUN apk update && \
  apk add --no-cache openjdk21-jre-headless eudev && \
  chmod +x entrypoint.sh

VOLUME /server

EXPOSE 25565

ENTRYPOINT [ "./entrypoint.sh" ]
