# JupyterHub Docker image built from specific commit on master GitHub branch
# docker build -t piredtu/topfarm_hub .

FROM ipython/ipython

MAINTAINER Pierre-Elouan Rethore <pire@dtu.dk>



# install js dependencies
RUN npm install -g configurable-http-proxy

RUN mkdir -p /srv/

# install jupyterhub

WORKDIR /srv/
RUN pip3 install -e git+https://github.com/jupyter/jupyterhub.git#egg=jupyterhub
ADD . /srv/jupyterhub
WORKDIR /srv/jupyterhub/


# Derivative containers should add jupyterhub config,
# which will be used when starting the application.

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
RUN curl https://bootstrap.pypa.io/get-pip.py | python3

RUN pip3 install git+https://github.com/jupyter/oauthenticator.git
#@$OAUTHENTICATOR_COMMIT

# Add variable to allow connecting to the docker host
ENV DOCKER_HOST unix://docker.sock

ONBUILD ADD jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py
CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
