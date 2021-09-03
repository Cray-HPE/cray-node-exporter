# cray-node-exporter

This repo creates an rpm for installation on storage nodes for installations prior to the csm 1.0 release.

The .version file in this repo should be updated to stay in sync with the version of the node_exporter
binary being bundled in the rpm.  The initial binary was pulled from:

https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
