FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
RUN apt-get install pandoc texlive lmodern texlive-xetex -y --no-install-recommends
WORKDIR /root
COPY transform.sh .
COPY latex-template.tex .
