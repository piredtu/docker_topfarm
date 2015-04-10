
systemuser:
	docker build -t piredtu/topfarm_systemuser systemuser

hub: systemuser
	docker build -t piredtu/topfarm_hub jupyterhub

run:
	docker run -d -p 8000:8000 -v /var/run/docker.sock:/docker.sock -v /etc/passwd:/srv/jupyterhub/userlist --env-file /usr/local/etc/jupyter/env --net=host --name jupyterhub ptimof/jupyterhub
