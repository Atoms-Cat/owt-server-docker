FROM ubuntu:18.04
RUN apt-get update -y
RUN apt-get install git make gcc g++ libglib2.0-dev pkg-config libboost-regex-dev libboost-thread-dev libboost-system-dev liblog4cxx-dev rabbitmq-server mongodb openjdk-8-jre curl libboost-test-dev nasm yasm gyp libx11-dev libkrb5-dev intel-gpu-tools m4 autoconf libtool automake cmake libfreetype6-dev libgstreamer-plugins-base1.0-dev -y
RUN apt-get install wget -y
RUN mkdir /tools
ADD owt-server-5.0 /tools/owt-server-5.0
RUN export https_proxy="http://192.168.10.116:7890" && export http_proxy="http://192.168.10.116:7890" && /tools/owt-server-5.0/scripts/installDepsUnattended.sh

ADD owt-client-javascript-5.0 /tools/owt-client-javascript-5.0
RUN export https_proxy="" && export http_proxy="" && export NVM_DIR="/root/.nvm" && . "$NVM_DIR/nvm.sh" && nvm use v10.21.0 && cd /tools/owt-client-javascript-5.0/scripts && npm install && grunt

RUN export NVM_DIR="/root/.nvm" && . "$NVM_DIR/nvm.sh" && cd /tools/owt-server-5.0 && nvm use v10.21.0 && scripts/build.js -t all --check && scripts/pack.js -t all --install-module --app-path /tools/owt-client-javascript-5.0/dist/samples/conference

RUN cd /tools/owt-server-5.0/dist && ls -lh

COPY start.sh /
CMD ["/start.sh"]
