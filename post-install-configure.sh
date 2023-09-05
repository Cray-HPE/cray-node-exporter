#!/bin/bash
sed -e "s/IP/$(hostname -i)/" > /etc/systemd/system/cray-node-exporter.service <<'EOF'

[Unit]
Description=Node Exporter

[Service]
Type=simple
ExecStart=/usr/bin/node_exporter \
--web.listen-address=IP:9100 \
--web.disable-exporter-metrics \
--collector.disable-defaults \
--collector.textfile \
--collector.textfile.directory=/var/lib/node_exporter
SyslogIdentifier=cray-node-exporter
Restart=always
RestartSec=1

[Install]
WantedBy=multi-user.target

EOF

chown root:root /etc/systemd/system/cray-node-exporter.service

chmod 644 /etc/systemd/system/cray-node-exporter.service


