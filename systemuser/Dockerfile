# Run with the DockerSpawner in JupyterHub

FROM  piredtu/topfarm:latest

MAINTAINER Pierre-Elouan Rethore <pire@dtu.dk>

ADD https://raw.githubusercontent.com/jupyter/jupyterhub/master/jupyterhub/singleuser.py /usr/local/bin/jupyterhub-singleuser
RUN chmod 755 /usr/local/bin/jupyterhub-singleuser

EXPOSE 8888

ENV SHELL /bin/bash

WORKDIR /install
ADD install_kernels.sh /install/
RUN chmod a+x /install/install_kernels.sh

ADD systemuser.sh /srv/singleuser/systemuser.sh
RUN chmod a+x /srv/singleuser/systemuser.sh
CMD ["sh", "/srv/singleuser/systemuser.sh"]
