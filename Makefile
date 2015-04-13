
user:
	docker build -t piredtu/topfarm_systemuser systemuser

hub: user
	docker build -t piredtu/topfarm_hub jupyterhub

run:
	docker run -d -p 8000:8000 -v /var/run/docker.sock:/docker.sock -v /etc/passwd:/srv/jupyterhub/userlist --env-file /root/env --net=host --name topfarm_hub piredtu/topfarm_hub

