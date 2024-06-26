# STAGE 1 - Build Theia
FROM node:18-alpine

# Update and install
RUN apk update && \
    apk add --no-cache make gcc g++ python3 libx11-dev libxkbfile-dev libsecret-dev libc-dev libsecret curl gnupg

# Build Theia 
WORKDIR /home/ide
ADD package.json ./package.json
ENV NODE_OPTIONS="--max_old_space_size=4096"
RUN npm install -g node-pty node-gyp
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
FROM node:18-alpine

# Env variables
ENV HOME=/root \
    SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/ide/plugins \
    USE_LOCAL_GIT=true

# Update and install
RUN apk add --no-cache curl gnupg gcc git openssh-client bash libsecret-dev jq socat vim wget asciinema dbus

# rename asciinema to bblogger
RUN mv /usr/bin/asciinema /usr/bin/bblogger


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

# Prepare environment
ADD ovsx-router-config.json /root/.theia/ovsx-router-config.json
ADD settings.json /root/.theia/settings.json
ADD motd /root/workspace/motd
WORKDIR /root/ide
USER root

# Example of a systemd service created to showcase a custom entry-point.
EXPOSE 3030

# entrypoint
COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh

CMD ["THEIA_WEBVIEW_EXTERNAL_ENDPOINT=\"{{hostname}}\" node /root/ide/src-gen/backend/main.js --hostname=0.0.0.0 --port=3030 --plugins=local-dir:/root/ide/plugins"]