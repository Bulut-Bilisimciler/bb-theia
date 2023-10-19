# STAGE 1 - Build Theia
FROM quay.io/centos/centos:stream8

# Update and install
RUN dnf -y update && \
    dnf install -y make pkg-config gcc-c++ python3 libX11-devel libsecret-devel curl gnupg 
RUN dnf groupinstall -y "Development Tools" && \
    dnf clean all

# Install Node.js, Yarn and required dependencies
RUN curl -sL https://rpm.nodesource.com/setup_18.x | bash -
RUN dnf -y install nodejs \
    # remove useless files from the current layer
    && dnf clean all 

# Build Theia
WORKDIR /home/ide
ADD package.json ./package.json
ENV NODE_OPTIONS="--max_old_space_size=4096"
RUN npm install -g yarn
RUN yarn install
RUN yarn theia build
RUN npx theia download:plugins
RUN yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean


# STAGE 2 - Setup the final image
FROM quay.io/centos/centos:stream8

# Env variables
ENV HOME=/root \
    SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/ide/plugins \
    USE_LOCAL_GIT=true

# Install Node.js, Yarn and required dependencies
RUN dnf -y update && dnf -y install curl gnupg gcc \
    git openssh-clients bash libsecret jq curl socat git
RUN curl -sL https://rpm.nodesource.com/setup_18.x | bash -
RUN dnf -y install nodejs \
    # remove useless files from the current layer
    && dnf clean all 

RUN mkdir -p /root/workspace && \
    mkdir -p /root/ide && \
    mkdir -p /root/.theia && \
    # Configure a nice terminal
    # format-1 is: root@6f3ecd3d6a6b:~/workspace$ 
    # echo "export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /etc/bash.bashrc && \
    # format-1 is: root ~/workspace $ 
    echo "export PS1='\[\033[01;32m\]\u \[\033[01;34m\]\w\[\033[00m\] \$ '" >> /etc/bash.bashrc && \
    echo "export PS1='\[\033[01;32m\]\u \[\033[01;34m\]\w\[\033[00m\] \$ '" >> /root/.bashrc && \
    # Fake poweroff (stops the container from the inside by sending SIGHUP to PID 1)
    echo "alias poweroff='kill -1 1'" >> /etc/bash.bashrc && \
    echo "alias poweroff='kill -1 1'" >> /root/.bashrc && \
    # Setup an initial workspace
    echo '{"recentRoots":["file:///root/workspace"]}' > /root/.theia/recentworkspace.json && \
    # Setup settings (file icons theme)
    echo '{"workbench.iconTheme": "vs-seti", "editor.mouseWheelZoom": true, "editor.fontSize": 18, "terminal.integrated.fontSize": 18 }' > /root/.theia/settings.json


# Copy files from previous stage 
COPY --from=0 /home/ide /root/ide

# ! ADD CUSTOM IMPLEMENTATION  
# Systemd installation
#
RUN dnf install -y \
        iptables   \
        iproute    \
        kmod       \
        procps-ng  \
        sudo       \
        udev &&    \
    # Unmask services
    systemctl unmask                                                  \
        systemd-remount-fs.service                                    \
        dev-hugepages.mount                                           \
        sys-fs-fuse-connections.mount                                 \
        systemd-logind.service                                        \
        getty.target                                                  \
        console-getty.service &&                                      \
    # Prevents journald from reading kernel messages from /dev/kmsg
    echo "ReadKMsg=no" >> /etc/systemd/journald.conf &&               \
\
    # Housekeeping
    dnf clean all &&                                                  \
    rm -rf                                                            \
    /var/cache/dnf/*                                               \
    /var/log/*                                                     \
    /tmp/*                                                         \
    /var/tmp/*                                                     \
    /usr/share/doc/*                                               \
    /usr/share/man/* &&                                            \
\
    # Create default 'admin/admin' user
    useradd --create-home --shell /bin/bash admin -G wheel && echo "admin:admin" | chpasswd

# Make use of stopsignal (instead of sigterm) to stop systemd containers.
STOPSIGNAL SIGRTMIN+3

# Prepare environment
ADD motd /root/workspace/motd
WORKDIR /root/workspace
USER root

# Example of a systemd service created to showcase a custom entry-point.
EXPOSE 3030
COPY script.sh /usr/bin/
COPY bb.service /lib/systemd/system/
RUN chmod +x /usr/bin/script.sh && \
    ln -sf /lib/systemd/system/bb.service \
    /etc/systemd/system/multi-user.target.wants/bb.service

# Set systemd as entrypoint.
ENTRYPOINT [ "/sbin/init", "--log-level=err" ]