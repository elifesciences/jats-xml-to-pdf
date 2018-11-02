FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
RUN apt-get install less unzip wget openjdk-11-jdk-headless libxml2-utils -y --no-install-recommends

WORKDIR /usr/share/java
RUN wget -O saxon-he.zip "https://downloads.sourceforge.net/project/saxon/Saxon-HE/9.8/SaxonHE9-8-0-14J.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fsaxon%2Ffiles%2FSaxon-HE%2F9.8%2FSaxonHE9-8-0-14J.zip%2Fdownload%3Fuse_mirror%3Dnchc&ts=1540280157&use_mirror=kent"
RUN unzip saxon-he.zip && rm saxon-he.zip

WORKDIR /root
RUN wget --quiet https://github.com/PeerJ/jats-conversion/archive/master.zip
RUN unzip master

RUN apt-get install vim -y --no-install-recommends


RUN wget --quiet ftp://ftp.ncbi.nlm.nih.gov/pub/jats/archiving/1.0/jats-archiving-dtd-1.0.zip
RUN unzip -d dtd jats-archiving-dtd-1.0.zip

# HTML->PDF
RUN apt-get install xfonts-75dpi fontconfig xfonts-base --no-install-recommends -y
RUN wget --quiet -O wkhtmltox.deb https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN dpkg --install wkhtmltox.deb


COPY transform.sh ./
