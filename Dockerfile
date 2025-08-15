# Inspired by https://gitlab.com/olberger/docker-org-teaching-export
FROM debian:12

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i -e "s/ main/ main contrib/g" /etc/apt/sources.list.d/debian.sources
RUN apt-get update && apt-get -y upgrade

# Set the locale
RUN apt-get -y install locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Needed by startup.sh
RUN apt-get -y install sudo

# Add emacs + texlive stuff
RUN apt-get -y --no-install-recommends install ca-certificates emacs emacs-goodies-el org-mode zip unzip \
    texlive-latex-recommended texlive-plain-generic texlive-fonts-recommended texlive-latex-extra \
    texlive-lang-german texlive-pstricks texlive-luatex \
    ttf-mscorefonts-installer

WORKDIR /emacs
ENV HOME /emacs

RUN emacs --version | head -n 1 > /emacs/emacs-version.log \
    emacs --batch --eval '(message (org-version))' 2>&1 | tail -n 1 > /emacs/org-mode-version.log

# The script is the exporter
ADD publish.el /emacs/publish.el

ENV SHELL=/bin/bash
# Defaults to be overruled by launch script (docker run ... -e USERID=1001 ...)
ENV USER=ubuntu
ENV USERID=1000
