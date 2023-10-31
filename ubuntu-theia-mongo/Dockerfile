# STAGE 1 - Build Theia
FROM nestybox/ubuntu-jammy-systemd:latest

# Update and install
RUN apt-get update && \
    apt-get install -y make pkg-config gcc g++ python3 libx11-dev libxkbfile-dev libsecret-1-dev curl gnupg && \
    apt-get update

# Install Node.js, Yarn and required dependencies
RUN curl -sL https://deb.nodesource.com/setup_18.x  | bash -
RUN apt-get -y install nodejs \
    # remove useless files from the current layer
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/apt/lists.d/* \
    && apt-get autoremove \
    && apt-get clean \
    && apt-get autoclean

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
FROM nestybox/ubuntu-jammy-systemd:latest

# Env variables
ENV HOME=/root \
    SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/ide/plugins \
    USE_LOCAL_GIT=true

# Install Node.js, Yarn and required dependencies
RUN apt-get update -y && apt-get -y install curl gnupg software-properties-common gcc wget \
    git openssh-client bash libsecret-1-0 jq socat vim tmux && \
    add-apt-repository -y ppa:deadsnakes/ppa
RUN curl -sL https://deb.nodesource.com/setup_18.x  | bash -
RUN apt-get -y install nodejs \
    # remove useless files from the current layer
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/apt/lists.d/* \
    && apt-get autoremove \
    && apt-get clean \
    && apt-get autoclean


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
    echo '{"workbench.iconTheme":"vs-seti","editor.mouseWheelZoom":true,"editor.fontSize":18,"terminal.integrated.fontSize":18,"terminal.integrated.shell.linux":"\/usr\/bin\/tmux","terminal.integrated.profiles.linux":{"tmux":{"path":"\/usr\/bin\/tmux","icon":"terminal-tmux"},"bash":{"path":"\/bin\/bash","icon":"terminal-}' > /root/.theia/settings.json


# Copy files from previous stage 
COPY --from=0 /home/ide /root/ide

# ! ADD CUSTOM IMPLEMENTATION  
#Install MongoDB

ENV TZ=Europe/Istanbul \
    DEBIAN_FRONTEND=noninteractive

RUN apt update -y 
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add - 
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
RUN wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.20_amd64.deb
RUN dpkg -i ./libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
RUN export DEBIAN_FRONTEND=noninteractive 
RUN echo "Europe/Istanbul" > /etc/timezone 
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata   \
    && apt-get install -y mongodb-org && \
    apt-get clean && \
    rm -rf /var/lib/apt

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