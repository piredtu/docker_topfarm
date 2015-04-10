
systemuser:
	docker build -t piredtu/topfarm_systemuser systemuser

hub: systemuser
	docker build -t piredtu/topfarm_hub jupyterhub

run:
	docker run
