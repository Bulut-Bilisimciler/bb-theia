### BB Theia

This is the project of custom package.json implementation of main Theia Template that includes custom plugin called "bulutbilisimciler-bb-theia-plugin".

### Build and Tagging
Build:  
- `docker buildx build --platform linux/amd64 --memory 6 -t alperreha/bb-theia:ubuntu-node-1-0-0-rev1 .`  

Example Builds:  
- [ ] Debian Nodejs: `docker buildx build -f Dockerfile.debian-node --platform linux/amd64 --memory 6 -t alperreha/bb-theia:debian-node-1-0-0-rev1 .`
- [ ] Ubuntu Nodejs Python: `docker buildx build -f Dockerfile.ubuntu-node-python --platform linux/amd64 --memory 6 -t alperreha/bb-theia:ubuntu-node-python-1-0-0-rev1 .`

Run:  
- `docker run --rm -p 3030:3030 alperreha/bb-theia:debian-node-1-0-0-rev1 `  

### Available Images

- [x] Debian Nodejs-18 Theia
