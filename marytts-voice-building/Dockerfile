FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y vim && \
    apt-get install -y maven && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y wget && \
    apt-get install -y git && \
    apt-get install -y sudo && \
    apt-get install -y bc && \
    apt-get install -y sox && \
    apt-get install -y tcl-snack && \
    apt-get install -y build-essential

RUN git clone https://github.com/marytts/marytts.git && cd marytts && \
    mvn install

COPY HDecode-3.4.1.tar.gz HTK-3.4.1.tar.gz /

RUN git clone https://github.com/vojtsek/marytts-voice-building.git && cd marytts-voice-building && \
    echo -n "/home/vojta/marytts" > MR && echo -n "/home/vojta/marytts-voice-building" > RVB && echo -n "en_US" > LOC && \
    ./configure

