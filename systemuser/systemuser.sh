#!/bin/sh

# create user in new container
echo "Creating user $USER ($USER_ID)"
useradd -u $USER_ID -o -s $SHELL $USER

# Copying topfarm directory, and installing it in develop mode
if [ ! -d $HOME/topfarm ]; then
    sudo -E -u $USER /install/install_topfarm_develop.sh
fi

chown -R $USER /install
ln -s /install $HOME/install
sudo -E -u $USER /install/install_kernels.sh

exec sudo -E -u $USER jupyterhub-singleuser \
  --port=8888 \
  --ip=0.0.0.0 \
  --user=$JPY_USER \
  --cookie-name=$JPY_COOKIE_NAME \
  --base-url=$JPY_BASE_URL \
  --hub-prefix=$JPY_HUB_PREFIX \
  --hub-api-url=$JPY_HUB_API_URL
