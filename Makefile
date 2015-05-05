images: openmdao fusedwind topfarm notebook systemuser hub

# Build the minimal openmdao image
openmdao: openmdao/Dockerfile
	docker build -t piredtu/openmdao openmdao

# Build the minimal fusedwind image
fusedwind: #openmdao fusedwind/Dockerfile
	docker build -t piredtu/fusedwind fusedwind

# Build the minimal topfarm image
topfarm: #fusedwind topfarm/Dockerfile
	docker build -t piredtu/topfarm topfarm

# Build the topfarm image for running with jupyterhub notebook
systemuser: systemuser/Dockerfile
	docker build -t piredtu/topfarm_systemuser systemuser

# Build the topfarm image for running a single version of jupyter notebook
notebook:
	docker build -t piredtu/topfarm_notebook notebook

# Build the image for running jupyter hub
hub: #topfarm_systemuser jupyterhub/Dockerfile
	docker build -t piredtu/topfarm_hub jupyterhub

restuser: #Install the restuser service
	git clone https://github.com/minrk/restuser.git
	mkdir /var/run/restuser

# Makefile phony stuffs
.PHONY: openmdao fusedwind topfarm systemuser hub notebook
