# Topfarm-Jupyterhub

Docker containers for [Jupyter](http://jupyter.org) and [Topfarm](http://github.com/DTUWindEnergy/Topfarm).
This dockers depends and are heavily inspired from the work of [@ptimof](https://github.com/ptimof/docker-jupyter).  

# Building


Alternatively, you may wish to pull these images from Docker Hub:

	docker pull piredtu/topfarm_systemuser
	docker pull piredtu/topfarm_hub

# Setup

If a GitHub application has not yet been created, it can be created
[here](https://github.com/settings/applications/new). Make sure the
callback URL is:

        http://[your_host:8000]/hub/oauth_callback

For example, `example.com:8000`.

Create a file `env` in a directory that contains the details from
the GitHub application:

        GITHUB_CLIENT_ID=<client_id>
        GITHUB_CLIENT_SECRET=<client_secret>
        OAUTH_CALLBACK_URL=http://[your_host:8000]/hub/oauth_callback

Ensure that this file is only readable by `root`:

        chmod 0440 /usr/local/etc/jupyterhub/env

# User creation

The jupyterhub is getting access to the local usernames defined in the /etc/passwd file (only the names, not the passwords!). So in order to create new users, one need to create new users locally that have the same usernames as the github usernames.

	useradd -u <github_username> -o

Don't forget to restart the topfarm_hub container after that. 

# Running

	docker run -d -p 8000:8000 -v /var/run/docker.sock:/docker.sock -v /etc/passwd:/srv/jupyterhub/userlist --env-file /usr/local/etc/jupyter/env --net=host --name topfarm_hub piredtu/topfarm_hub

# Debugging

* If a browser ends up stuck re-directing when attempting to use a server, it probably means that the 
user container needs to be removed. Have the user log out of JupyterHub, and Execute `docker rm jupyter-[user]`.
