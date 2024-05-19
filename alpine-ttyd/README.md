### alpine-ttyd

This is the alpine-ttyd image. It is based on the alpine image and has the ttyd installed. It is used to run the terminal in the browser.

### Build and Run

```bash
# build
docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb:alpine3.19-term-2.0.0 .

# run
docker run --runtime=sysbox-runc -it --rm -p 40020:40020 --name=alpine3.19-term-2.0.0 alperreha/bb:alpine3.19-term-2.0.0
```

### Kubernetes Container Requirements

- Aliases:
  - TTYd changed to "bb-terminal"
  - Asciinema changed to "bb-logger"
- Add HostAliases of "cdn.bulutbilisimciler.com".
- Add HostAliases of "gitlab.bulutbilisimciler.com".
- Add dbus-uuid for resolve conflicts of IPC with cmd `mkdir -p /var/run/dbus && dbus-uuidgen > /var/lib/dbus/machine-id`.
- Add custom "CMD" that includes asciinema and s3cmd with ENV values included due to ensure user activity logger.

### Changelog

- [x] 2.0.0:
  - TTYD installed and added on port 40020.
  - Unnecessary packages removed.
- [x] 1.1.5: Webview err fix.
- [x] 1.1.4: Extensions and sidebar menus added.
