#!/bin/sh

echo ###############################################################################
echo # DOWNLOADING RKE...
echo ###############################################################################

#sudo curl -fsSL https://github.com/rancher/rke/releases/download/v1.0.4/rke_linux-amd64 -o rke
#sudo chmod +x rke
#sudo rke --version

curl -fsSL https://github.com/rancher/rke/releases/download/v1.0.4/rke_linux-amd64 -o rke

ls -la

echo ###############################################################################
echo # RKE DOWNLOADED
echo ###############################################################################

return 0