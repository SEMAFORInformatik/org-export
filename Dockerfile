# Inspired by https://gitlab.com/olberger/docker-org-teaching-export
# see also https://gitlab.com/oer/emacs-reveal
FROM debian:13
LABEL org.opencontainers.image.source=https://github.com/semaforinformatik/org-export

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i -e "s/ main/ main contrib/g" /etc/apt/sources.list.d/debian.sources
RUN apt-get update && apt-get -y upgrade

# Set the locale
RUN apt-get -y install locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Add emacs + texlive stuff
RUN apt-get -y --no-install-recommends install zip unzip \
    emacs org-mode git python3 python-is-python3 emacs-goodies-el
#    texlive-latex-recommended texlive-plain-generic \
#    texlive-fonts-recommended texlive-latex-extra \
#    texlive-lang-german texlive-pstricks texlive-luatex \
#    ttf-mscorefonts-installer git
ENV USER=exporter
ENV USERID=1000

RUN useradd --create-home --uid 1000 --user-group $USER

#COPY install.el /emacs
#RUN emacs --batch --load /emacs/install.el
#
# The script includes the exporter settings
COPY intens-mode.el publish.el /usr/share/emacs/site-lisp
