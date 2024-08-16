FROM ubuntu:24.04

# get curl, add-apt-repository
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y software-properties-common
# install FUSE https://github.com/AppImage/AppImageKit/wiki/FUSE
RUN add-apt-repository universe
RUN apt-get install -y libfuse2t64
# Install seaf-cli
RUN curl https://s3.eu-central-1.amazonaws.com/download.seadrive.org/Seafile-cli-x86_64-9.0.7.AppImage -o /seaf-cli
RUN chmod +x seaf-cli
RUN mv /seaf-cli /usr/local/bin/seaf-cli
RUN apt-get clean

RUN mkdir /seafile-state
RUN mkdir /home/seafile

WORKDIR /home/seafile

COPY start.sh /home/seafile/start.sh
RUN chmod +x /home/seafile/start.sh

RUN useradd -U -d /home/seafile -s /bin/bash seafile
RUN usermod -G users seafile
RUN chown seafile:seafile -R /home/seafile

CMD ["./start.sh"]
