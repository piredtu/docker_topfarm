PORT_HUB := 8000
PORT_NOTEBOOK := 8001
HUB_NAME := topfarm_hub
NOTEBOOK_NAME := topfarm_notebook
# The env file containing your github name and email
GITHUB_ENV := /Users/pire/github.env
# The env file containing the github app token
GITHUB_APP := /root/env
USER_IMAGE := piredtu/topfarm_systemuser

images: openmdao fusedwind topfarm topfarm_notebook topfarm_systemuser topfarm_hub

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
topfarm_systemuser: #topfarm systemuser/Dockerfile
	docker build -t piredtu/topfarm_systemuser systemuser

# Build the topfarm image for running a single version of jupyter notebook
topfarm_notebook:
	docker build -t piredtu/topfarm_notebook notebook

# Build the image for running jupyter hub
topfarm_hub: #topfarm_systemuser jupyterhub/Dockerfile
	docker build -t piredtu/topfarm_hub jupyterhub

# Running topfarm_hub
run_hub:
	docker run -d -p 8000:8000 -v /var/run/docker.sock:/docker.sock -v /etc/passwd:/srv/jupyterhub/userlist -e 'USER_IMAGE=$(USER_IMAGE)' --env-file $(GITHUB_APP) --net=host --name $(HUB_NAME) piredtu/topfarm_hub

# Stop the topfarm_hub
stop_hub:
	docker stop $(HUB_NAME)
	docker rm $(HUB_NAME)

# Run a single user version of topfarm
run_notebook:
	docker run -d -p $(PORT_NOTEBOOK):8888 -v /Users/pire:/work/pire --env-file $(GITHUB_ENV) --name $(NOTEBOOK_NAME) piredtu/topfarm_notebook
	sleep 0.5
	open http://docker:$(PORT_NOTEBOOK)
	xterm -e "docker logs -f $(NOTEBOOK_NAME)"

# Stop notebook
stop_notebook:
	docker stop $(NOTEBOOK_NAME)
	docker rm $(NOTEBOOK_NAME)

# Bash into the minimal topfarm container
bash:
	docker run -it --rm piredtu/topfarm /bin/bash

# Makefile phony stuffs
.PHONY: openmdao fusedwind topfarm topfarm_systemuser topfarm_hub run_hub stop_hub bash
