FROM ubuntu:18.04

ADD ./ ./app

RUN apt update
RUN apt install wget -y
RUN apt install curl -y
RUN wget https://github.com/EOSIO/eosio.cdt/releases/download/v1.6.2/eosio.cdt_1.6.2-1-ubuntu-18.04_amd64.deb
RUN apt install ./eosio.cdt_1.6.2-1-ubuntu-18.04_amd64.deb -y
RUN wget https://github.com/EOSIO/eos/releases/download/v1.8.6/eosio_1.8.6-1-ubuntu-18.04_amd64.deb
RUN apt install ./eosio_1.8.6-1-ubuntu-18.04_amd64.deb -y
ADD config.json epios-smart-contracts/config.json

RUN mkdir -p /eosio.contracts/build/contracts/eosio.bios
ADD local-node/stub/eosio.bios /eosio.contracts/build/contracts/eosio.bios
ENV EOSIO_BUILD_DIR /eosio.contracts/build/

CMD ["app/local-node/run.sh"]