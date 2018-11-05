FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
# doesn't work, wkhtmltopdf requires a *patched* version of qt that isn't the repos
#RUN apt-get install less xvfb wkhtmltopdf python openjdk-11-jre-headless unzip wget -y --no-install-recommends
RUN apt-get install less nano xfonts-75dpi fontconfig xfonts-base python openjdk-11-jre-headless unzip wget -y --no-install-recommends

WORKDIR /root

# --no-check-certificate: temporary
RUN wget --quiet --no-check-certificate https://github.com/elifesciences/CaSSius/archive/master.zip
RUN unzip -q master.zip
RUN mv CaSSius-master CaSSius

# XML->HTML requires Python+Java+DTD
RUN wget --quiet ftp://ftp.ncbi.nlm.nih.gov/pub/jats/archiving/1.0/jats-archiving-dtd-1.0.zip
RUN unzip -d dtd jats-archiving-dtd-1.0.zip

# HTML->PDF
RUN wget --quiet -O wkhtmltox.deb https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN dpkg --install wkhtmltox.deb

COPY transform.sh ./
