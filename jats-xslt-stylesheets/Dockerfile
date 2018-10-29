FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
RUN apt-get install less unzip wget openjdk-11-jdk-headless libxml2-utils -y --no-install-recommends

WORKDIR /usr/share/java
RUN wget -O saxon-he.zip "https://downloads.sourceforge.net/project/saxon/Saxon-HE/9.8/SaxonHE9-8-0-14J.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fsaxon%2Ffiles%2FSaxon-HE%2F9.8%2FSaxonHE9-8-0-14J.zip%2Fdownload%3Fuse_mirror%3Dnchc&ts=1540280157&use_mirror=kent"
RUN unzip saxon-he.zip && rm saxon-he.zip

WORKDIR /root
RUN wget https://github.com/ncbi/JATSPreviewStylesheets/archive/master.zip
RUN unzip master

RUN wget https://www-eu.apache.org/dist//xmlgraphics/fop/binaries/fop-2.3-bin.tar.gz
RUN tar xvzf fop-2.3-bin.tar.gz

RUN wget -O jeuclid.zip "https://downloads.sourceforge.net/project/jeuclid/3.1.x/3.1.9/jeuclid-3.1.9-distribution.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fjeuclid%2Ffiles%2Flatest%2Fdownload&ts=1540361047&use_mirror=kent"
RUN unzip jeuclid.zip
RUN cp ./jeuclid-3.1.9/repo/jeuclid-core-3.1.9.jar ./jeuclid-3.1.9/repo/jeuclid-fop-3.1.9.jar ./fop-2.3/fop/lib/

RUN wget --quiet ftp://ftp.ncbi.nlm.nih.gov/pub/jats/archiving/1.0/jats-archiving-dtd-1.0.zip
RUN unzip -d dtd jats-archiving-dtd-1.0.zip
RUN chown 1000:1000 -R ./dtd/

COPY transform.sh ./
