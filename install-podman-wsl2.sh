#!/usr/bin/env bash

# https://www.redhat.com/sysadmin/podman-windows-wsl2
. /etc/os-release
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${NAME}_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/x${NAME}_${VERSION_ID}/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update -qq
sudo apt-get -qq -y install podman
sudo mkdir -p /etc/containers
echo "[registries.search]\nregistries = ['docker.io', 'quay.io']" | sudo tee /etc/containers/registries.conf

# Run podman as a privileged user
sudo cat /usr/share/containers/containers.conf | grep -n cgroup_manager | cut -d: -f1 | xargs -I{} sudo sed -i '{}s/.*/cgroup_manager = "cgroupfs"/' /usr/share/containers/containers.conf
sudo cat /usr/share/containers/containers.conf | grep -n events_logger | cut -d: -f1 | xargs -I{} sudo sed -i '{}s/.*/events_logger = "file"/' /usr/share/containers/containers.conf