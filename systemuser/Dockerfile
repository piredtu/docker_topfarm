# Run with the DockerSpawner in JupyterHub

FROM  piredtu/topfarm:latest

MAINTAINER Pierre-Elouan Rethore <pire@dtu.dk>

ADD https://raw.githubusercontent.com/jupyter/jupyterhub/master/jupyterhub/singleuser.py /usr/local/bin/jupyterhub-singleuser
RUN chmod 755 /usr/local/bin/jupyterhub-singleuser

EXPOSE 8888

ENV SHELL /bin/bash

RUN apt-get update \
 && apt-get install -y \
    python3-pip \
    ipython3-notebook
    zlib1g-dev \
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


RUN mkdir -p /srv/

WORKDIR /install
ADD requirements.txt /install/
RUN pip3 install -r /install/requirements.txt

RUN python3 -m IPython kernelspec install-self

ADD install_kernels.sh /install/
RUN chmod a+x /install/install_kernels.sh

ADD systemuser.sh /srv/singleuser/systemuser.sh
RUN chmod a+x /srv/singleuser/systemuser.sh
CMD ["sh", "/srv/singleuser/systemuser.sh"]
