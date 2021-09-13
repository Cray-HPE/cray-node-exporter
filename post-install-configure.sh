#!/bin/bash
 
sed -e "s/10.252.0.7/$(hostname -i)/" >/etc/systemd/system/cray-node-exporter.service <<'EOF'

[Unit]
Description=Node Exporter

[Service]
Type=simple
ExecStart=/usr/bin/node_exporter \
--web.listen-address=10.252.0.7:9100 \
--collector.buddyinfo \
--collector.drbd \
--collector.interrupts \
--collector.ksmd \
--collector.logind \
--collector.meminfo_numa \
--collector.mountstats \
--collector.processes \
--collector.qdisc \
--collector.systemd \
--collector.tcpstat
SyslogIdentifier=cray-node-exporter
Restart=always
RestartSec=1

[Install]
WantedBy=multi-user.target
EOF

chown root:root /etc/systemd/system/cray-node-exporter.service

chmod 644 /etc/systemd/system/cray-node-exporter.service

systemctl start cray-node-exporter

systemctl status cray-node-exporter
