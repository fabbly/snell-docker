FROM fabbly/glibc
LABEL maintainer="fabbly" \
         org.label-schema.name="snell-docker"

#Changed due to snell
#ENV SNELL_VERSION 3.0.1
#ARG SNELL_URL=https://github.com/surge-networks/snell/releases/download/v${SNELL_VERSION}/snell-server-v${SNELL_VERSION}-linux-amd64.zip

ARG SNELL_URL=https://dl.nssurge.com/snell/snell-server-v4.0.0-linux-amd64.zip

ENV SERVER_HOST 0.0.0.0
ENV SERVER_PORT=17855
ENV PSK=
ENV OBFS=off
ENV ARGS=

COPY Entrypoint.sh /usr/bin/

RUN \
    wget -O snell.zip $SNELL_URL && \
    unzip snell.zip && \
    mv snell-server /usr/bin/  

EXPOSE ${SERVER_PORT}/tcp
EXPOSE ${SERVER_PORT}/udp

ENTRYPOINT ["Entrypoint.sh"]
