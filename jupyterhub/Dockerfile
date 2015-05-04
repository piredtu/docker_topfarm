# JupyterHub Docker image built from specific commit on master GitHub branch
# docker build -t piredtu/topfarm_hub .

FROM ubuntu:14.10

MAINTAINER Pierre-Elouan Rethore <pire@dtu.dk>



ENV DEBIAN_FRONTEND noninteractive

# Not essential, but wise to set the lang
# Note: Users with other languages should set this in their derivative image
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update \
 && apt-get install -y -q language-pack-en \
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales \
 && apt-get autoremove -y \
 && apt-get clean -y

# Python binary dependencies, developer tools
RUN apt-get update \
 && apt-get install -y -q \
    build-essential \
    curl \
    make \
    gcc \
    zlib1g-dev \
    git \
    python \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    python-sphinx \
    python3-sphinx \
    libzmq3-dev \
    sqlite3 \
    libsqlite3-dev \
    pandoc \
    libcurl4-openssl-dev \
    nodejs \
    nodejs-legacy \
    npm \
 && apt-get autoremove -y \
 && apt-get clean -y

# In order to build from source, need less
RUN npm install -g 'less@<3.0'

RUN pip install invoke

RUN mkdir -p /srv/
WORKDIR /srv/

# Set commit number (Jan 1, 2015)
#ENV IPYTHON_COMMIT 4694a6690adfc9981514b748bceed6175334aa4e

#RUN git clone --recursive https://github.com/ipython/ipython.git
#WORKDIR /srv/ipython/
#RUN git checkout $IPYTHON_COMMIT
#RUN chmod -R +rX /srv/ipython

# .[all] only works with -e, so use file://path#egg
# Can't use -e because ipython2 and ipython3 will clobber each other
#RUN pip2 install file:///srv/ipython#egg=ipython[all]
#RUN pip3 install file:///srv/ipython#egg=ipython[all]

RUN pip2 install pyzmq
RUN pip3 install pyzmq
RUN pip2 install --upgrade ipython
RUN pip3 install --upgrade ipython

# install kernels
RUN python2 -m IPython kernelspec install-self
RUN python3 -m IPython kernelspec install-self


# install js dependencies
RUN npm install -g bower less
RUN npm install -g jupyter/configurable-http-proxy

RUN mkdir -p /srv/

WORKDIR /srv/

# Set commit number (Jan 9, 2015)
ENV JUPYTERHUB_COMMIT f994ecdacb09d038ebee75019bc07ed49133c2e5
RUN git clone https://github.com/jupyter/jupyterhub.git
WORKDIR /srv/jupyterhub/
#RUN git checkout $JUPYTERHUB_COMMIT
RUN pip3 install .

#RUN pip3 install git+https://github.com/jupyter/jupyterhub.git


EXPOSE 8000

# Install dockerspawner and oauthenticator
RUN pip3 install docker-py

# Fixing pip3
RUN curl https://bootstrap.pypa.io/get-pip.py | python3

# dockerspawner commit number (Jan 8, 2015)
ENV DOCKERSPAWNER_COMMIT a0aefa192e7ad7e5650a38545af4aa9042839d3a
# oauthenticator commit number (Nov 25, 2014)
ENV OAUTHENTICATOR_COMMIT 98837269f6ca0f5ba9b638c0d3f5b48fd392a9ff

RUN pip3 install git+https://github.com/jupyter/dockerspawner.git
#@$DOCKERSPAWNER_COMMIT
RUN pip3 install git+https://github.com/jupyter/oauthenticator.git
#@$OAUTHENTICATOR_COMMIT

# Add variable to allow connecting to the docker host
ENV DOCKER_HOST unix://docker.sock


ADD jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py
CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
