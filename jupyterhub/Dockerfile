# JupyterHub Docker image built from specific commit on master GitHub branch
# docker build -t piredtu/topfarm_hub .

FROM ptimof/jupyterhub

MAINTAINER Pierre-Elouan Rethore <pire@dtu.dk>

ADD jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py
CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
