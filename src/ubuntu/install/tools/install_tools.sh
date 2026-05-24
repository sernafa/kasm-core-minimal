#!/usr/bin/env bash
set -e

echo "Install some common tools for further installation"
if [ "${DISTRO}" == "alpine" ]; then
  apk add --no-cache \
    ca-certificates \
    curl \
    gcompat \
    grep \
    iproute2-minimal \
    libgcc \
    mcookie \
    net-tools \
    openssh-client \
    openssl \
    shadow \
    sudo \
    tar \
    wget \
    zip \
    bc
else
  apt-get update
  # Update tzdata noninteractive (otherwise our script is hung on user input later).
  ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
  DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
  # Debian (KasmOS) requires a reconfigure because tzdata is already installed
  # On Ubuntu, this is a no-op
  dpkg-reconfigure --frontend noninteractive tzdata

  apt-get install -y sudo iproute2 iptables vim wget net-tools locales bzip2 wmctrl software-properties-common mesa-utils bc vulkan-tools

  echo "generate locales for en_US.UTF-8"
  locale-gen en_US.UTF-8
fi

if [ "$DISTRO" = "ubuntu" ] && ! grep -q "24.04" /etc/os-release; then
  #update mesa to latest
  add-apt-repository ppa:kisak/turtle
  apt-get update
  apt full-upgrade -y
elif [ "$DISTRO" = "ubuntu" ] && grep -q "24.04" /etc/os-release; then
  userdel ubuntu
  rm -Rf /home/ubuntu
fi
