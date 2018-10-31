FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
RUN apt-get install less unzip wget openjdk-11-jre-headless -y --no-install-recommends

WORKDIR /root

RUN wget --quiet https://github.com/Vitaliy-1/JATS2LaTeX/releases/download/0.5.3/latex.jar
RUN wget --quiet ftp://ftp.ncbi.nlm.nih.gov/pub/jats/archiving/1.0/jats-archiving-dtd-1.0.zip

RUN unzip -d dtd jats-archiving-dtd-1.0.zip

COPY transform.sh ./
