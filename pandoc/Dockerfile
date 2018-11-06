FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
RUN apt-get install pandoc texlive lmodern texlive-xetex python3-pip python3-venv -y --no-install-recommends
WORKDIR /root

# create the virtualenv
COPY abstract.sh .
RUN ./abstract.sh

COPY transform.sh latex-template.tex abstract.py /root/
