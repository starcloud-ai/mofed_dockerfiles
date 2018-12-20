FROM centos:centos7.5.1804
RUN yum install -y perl numactl-libs gtk2 atk cairo gcc-gfortran tcsh libnl3 tcl tk python-devel pciutils make lsof redhat-rpm-config rpm-build libxml2-python ethtool iproute net-tools openssh-clients git openssh-server wget libfabric traceroute iperf3

WORKDIR /tmp/

ENV MOFED_VER 4.4-2.0.7.0
ENV OS_VER rhel7.5
ENV PLATFORM x86_64

RUN wget http://content.mellanox.com/ofed/MLNX_OFED-${MOFED_VER}/MLNX_OFED_LINUX-${MOFED_VER}-${OS_VER}-${PLATFORM}.tgz && \
        tar -xvf MLNX_OFED_LINUX-${MOFED_VER}-${OS_VER}-${PLATFORM}.tgz
RUN sed -i 's/centos-release-7-5.\*el7.centos.a\*/centos-release-7-5.*el7.centos.a(.*)/g' MLNX_OFED_LINUX-${MOFED_VER}-${OS_VER}-${PLATFORM}/mlnxofedinstall
RUN MLNX_OFED_LINUX-${MOFED_VER}-${OS_VER}-${PLATFORM}/mlnxofedinstall --user-space-only --without-fw-update --all --force

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
