FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
# doesn't work, wkhtmltopdf requires a *patched* version of qt that isn't the repos
#RUN apt-get install less xvfb wkhtmltopdf python openjdk-11-jre-headless unzip wget -y --no-install-recommends
# openjdk pulls in all the dependencies we need wkhtmltopdf to run
RUN apt-get install openjdk-11-jre-headless less nano xfonts-75dpi fontconfig xfonts-base unzip wget -y --no-install-recommends

WORKDIR /root

# HTML->PDF
RUN wget --quiet -O  wkhtmltox.deb --no-check-certificate https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN dpkg --install wkhtmltox.deb

RUN wget --quiet https://github.com/zopyx/print-css-rocks/archive/tekom-2017.tar.gz
RUN tar xvzf tekom-2017.tar.gz
RUN mv print-css-rocks-tekom-2017 print-css-rocks

COPY transform.sh ./

# borked
#WORKDIR /root/print-css-rocks
#RUN apt-get install make imagemagick -y --no-install-recommends
#RUN ./generate.sh

