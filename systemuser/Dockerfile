# Run with the DockerSpawner in JupyterHub
# docker build -t ptimof/systemuser .

FROM  ptimof/systemuser


RUN apt-get install -y -q \
    wget \
    subversion \
    python-mysqldb

RUN pip install virtualenv
RUN pip3 install virtualenv

WORKDIR /install/
ADD install*.sh ./
RUN chmod a+x install*.sh
RUN ./install_openmdao.sh
RUN ./install_topfarm.sh
RUN ./install_windflo.sh

ADD systemuser.sh /srv/singleuser/systemuser.sh
CMD ["sh", "/srv/singleuser/systemuser.sh"]
