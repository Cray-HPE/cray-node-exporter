# This spec file generates an RPM that installs the node_exporter binary
# scripts into the /opt/cray/cray-node-exporter directory.
# Copyright 2020-2021 Hewlett Packard Enterprise Development LP

%define bin_dir /usr/bin
%define script_dir /opt/cray/cray-node-exporter

Name: cray-node-exporter
Vendor: Hewlett Packard Enterprise Company
License: HPE Proprietary 
Summary: Install and configuration of node_exporter
Version: %(cat .version) 
Release: %(echo ${BUILD_METADATA})
Source: %{name}-%{version}.tar.bz2

# Compiling not currently required:
# BuildArchitectures: noarch

Requires: jq
Requires: python3-boto3

%description
This RPM when installed will install and configure the /usr/bin/node_exporter
binary and corresponding service.

%files
%defattr(755, root, root)
%dir %{bin_dir}
%dir %{script_dir}
%{bin_dir}/node_exporter
%{script_dir}/post-install-configure.sh

%prep
%setup -q

%build

%install
install -m 755 -d %{buildroot}%{bin_dir}/
install -m 755 node_exporter %{buildroot}%{bin_dir}
install -m 755 post-install-configure.sh %{buildroot}%{script_dir}

%post
%{script_dir}/post-install-configure.sh
