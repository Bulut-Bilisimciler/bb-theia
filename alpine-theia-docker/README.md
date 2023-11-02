#### Commands

docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-theia:alpine-node-rev-1-1-4 .

docker run --runtime=sysbox-runc -it --rm -P -p 3030:3030 --name=alpine-theia alperreha/bb-theia:alpine-node-rev-1-1-4  


### Version Upgrades


- [x] 1.1.4: Extensions and sidebar menus added.
- [x] 1.1.5: Webview err fix.