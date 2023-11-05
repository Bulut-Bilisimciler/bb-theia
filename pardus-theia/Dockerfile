# STAGE 1 - Build Theia
FROM pardus/yirmibir

# Update and install
RUN apt-get update && \
    apt-get install -y make pkg-config gcc g++ python3 libx11-dev libxkbfile-dev libsecret-1-dev

# Install Node.js, Yarn and required dependencies
RUN apt-get update
RUN apt-get -y install curl gnupg ca-certificates
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
ENV NODE_MAJOR=18
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get -y install nodejs


# Build Theia
RUN apt-get update
RUN npm install -g yarn
RUN yarn global add node-gyp
WORKDIR /home/ide
ADD package.json ./package.json
ENV NODE_OPTIONS="--max_old_space_size=4096"
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
FROM pardus/yirmibir

# Env variables
ENV HOME=/root \
    SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/ide/plugins \
    USE_LOCAL_GIT=true

# Install Node.js, Yarn and required dependencies
RUN apt-get update
RUN apt-get -y install curl gnupg ca-certificates
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
ENV NODE_MAJOR=18
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get -y install nodejs
RUN npm install -g yarn


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
    echo '{"recentRoots":["file:///root/workspace"]}' > /root/.theia/recentworkspace.json


# Copy files from previous stage
COPY --from=0 /home/ide /root/ide

# ! ADD CUSTOM IMPLEMENTATION

# Systemd installation
RUN apt-get update &&                            \
    apt-get install -y --no-install-recommends   \
            systemd                              \
            systemd-sysv                         \
            libsystemd0                          \
            ca-certificates                      \
            dbus                                 \
            man-db                                 \
            man                                 \
            procps                                  \
            manpages-tr                                 \
            file                             \
            pciutils                            \
            neofetch                                \
            usbutils                             \
            nano                                    \
            sl                                     \
            tree                                   \
            locate                              \
            lsb-release                         \
            htop                                   \
            iputils-ping                        \
            bc                                      \
            iptables                             \
            iproute2                             \
            kmod                                 \
            locales                              \
            plocate                                 \
            sudo                                 \
            udev &&                              \
    # Prevents journald from reading kernel messages from /dev/kmsg
    echo "ReadKMsg=no" >> /etc/systemd/journald.conf &&               \
    # Housekeeping
    apt-get clean -y &&                                               \
    rm -rf                                                            \
    /var/cache/debconf/*                                           \
    /var/lib/apt/lists/*                                           \
    /tmp/*                                                         \
    /var/tmp/*                                                     \
    /usr/share/local/* &&                                          \
    # Create default 'admin/admin' user
    useradd --create-home --shell /bin/bash admin && echo "admin:admin" | chpasswd && adduser admin sudo

# Disable systemd services/units that are unnecessary within a container.
RUN systemctl mask systemd-udevd.service \
    systemd-udevd-kernel.socket \
    systemd-udevd-control.socket \
    systemd-modules-load.service \
    sys-kernel-debug.mount \
    sys-kernel-tracing.mount

# Whenever possible, install tools using the distro package manager
RUN apt-get update && \
    apt-get install -y git openssh-client bash libsecret-1-0 jq curl socat wget git vim tmux man gcc acl

# Prepare environment
ADD ovsx-router-config.json /root/.theia/ovsx-router-config.json
ADD settings.json /root/.theia/settings.json
ADD motd /root/workspace/motd
WORKDIR /root/ide
USER root

# Example of a systemd service created to showcase a custom entry-point.
EXPOSE 3030

# Example of a systemd service created to showcase a custom entry-point.
COPY script.sh /usr/bin/
COPY bb.service /lib/systemd/system/
RUN chmod +x /usr/bin/script.sh && \
    ln -sf /lib/systemd/system/bb.service \
    /etc/systemd/system/multi-user.target.wants/bb.service

# Make use of stopsignal (instead of sigterm) to stop systemd containers.
STOPSIGNAL SIGRTMIN+3

# Set systemd as entrypoint.
ENTRYPOINT [ "/sbin/init", "--log-level=err" ]