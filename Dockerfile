FROM debian:bullseye-slim

RUN apt-get update && apt-get install procps grep curl -y
RUN curl https://linux-clients.seafile.com/seafile.asc -o /usr/share/keyrings/seafile-keyring.asc
RUN echo deb [arch=amd64 signed-by=/usr/share/keyrings/seafile-keyring.asc] https://linux-clients.seafile.com/seafile-deb/bullseye/ stable main | tee /etc/apt/sources.list.d/seafile.list
RUN apt-get update -y
RUN apt-get install -y seafile-cli
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

WORKDIR /seafile-client

COPY start.sh /seafile-client/start.sh

RUN chmod +x /seafile-client/start.sh
RUN useradd -U -d /seafile-client -s /bin/bash seafile
RUN usermod -G users seafile
RUN chown seafile:seafile -R /seafile-client
RUN su - seafile -c "seaf-cli init -d /seafile-client"

CMD ["./start.sh"]
