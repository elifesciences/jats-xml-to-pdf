FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
RUN apt-get install less unzip wget openjdk-11-jdk-headless -y --no-install-recommends

WORKDIR /usr/share/java
RUN wget -O saxon-he.zip "https://downloads.sourceforge.net/project/saxon/Saxon-HE/9.8/SaxonHE9-8-0-14J.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fsaxon%2Ffiles%2FSaxon-HE%2F9.8%2FSaxonHE9-8-0-14J.zip%2Fdownload%3Fuse_mirror%3Dnchc&ts=1540280157&use_mirror=kent"
RUN unzip saxon-he.zip && rm saxon-he.zip

WORKDIR /root
RUN wget https://github.com/ncbi/JATSPreviewStylesheets/archive/master.zip
RUN unzip master

RUN wget https://www-eu.apache.org/dist//xmlgraphics/fop/binaries/fop-2.3-bin.tar.gz
RUN tar xvzf fop-2.3-bin.tar.gz

COPY transform.sh ./
