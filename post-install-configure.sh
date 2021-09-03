#!/bin/bash
 
sed -e "s/10.252.0.7/$(hostname -i)/" >/etc/systemd/system/cray_node_exporter.service <<'EOF'

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
--collector.ntp \
--collector.processes \
--collector.qdisc \
--collector.systemd \
--collector.tcpstat \
--collector.textfile.directory /var/lib/cray_node_exporter/textfile_collector
#--collector.filesystem.ignored-mount-points '^/(dev|proc|sys|var/lib/docker/.+)($|/)' \
#--collector.filesystem.ignored-fs-types '^(autofs|binfmt_misc|cgroup|configfs|debugfs|devpts|devtmpfs|fusectl|hugetlbfs|mqueue|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|sysfs|tracefs)$' \
SyslogIdentifier=cray_node_exporter
Restart=always
RestartSec=1

[Install]
WantedBy=multi-user.target
EOF

chown root:root /etc/systemd/system/cray_node_exporter.service

chmod 644 /etc/systemd/system/cray_node_exporter.service

systemctl start cray_node_exporter

systemctl status cray_node_exporter
