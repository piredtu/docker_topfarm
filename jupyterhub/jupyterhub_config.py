# Configuration file for Jupyter Hub
# Derived from https://github.com/compmodels/jupyterhub
c = get_config()

import os
import sys

# Base configuration
c.JupyterHub.log_level = 10

# Configure the authenticator
c.JupyterHub.authenticator_class = 'oauthenticator.GitHubOAuthenticator'
c.GitHubOAuthenticator.oauth_callback_url = os.environ['OAUTH_CALLBACK_URL']
c.Authenticator.whitelist = whitelist = set()
c.JupyterHub.admin_users = admin = set('rethore')

# Configure the spawner
c.JupyterHub.spawner_class = 'dockerspawner.SystemUserSpawner'
c.SystemUserSpawner.host_homedir_format_string = '/home/{username}'
c.SystemUserSpawner.user_ids = userids = dict()
c.SystemUserSpawner.container_image = os.environ['USER_IMAGE']

# The docker instances need access to the Hub, so the default loopback port
# doesn't work:
from IPython.utils.localinterfaces import public_ips
c.JupyterHub.hub_ip = public_ips()[0]

# Add users to the whitelist and also record their user ids
# Assumes /etc/passwd format
here = os.path.dirname(__file__)
with open(os.path.join(here, 'userlist')) as f:
	for line in f:
		if not line:
			continue
		name, shadow, uid, gid, fullname, home, shell  = line.split(":")
		if int(uid) < 1000:
			continue
		whitelist.add(name)
		userids[name] = uid
