### BB Theia

This is the project of custom package.json implementation of main Theia Template that includes custom plugin called "bulutbilisimciler-bb-theia-plugin".

### Build and Tagging
Build:  
- `docker buildx build --platform linux/amd64 --memory 6 -t alperreha/bb-theia:ubuntu-rev1 .`  

Run:  
- `docker run --rm -it --runtime=sysbox-runc -p 3030:3030 alperreha/bb-theia:ubuntu-rev1`  

### OpenVSCode Server Versions  
- [ ] [Alpine Code Terminal](.)

### Available Images

- [ ] [Ubuntu Node](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Ubuntu Theia](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Ubuntu Docker](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Ubuntu Theia Docker](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Ubuntu Theia Postgres](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Ubuntu Theia Mongo](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Ubuntu Theia Mysql](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Ubuntu Theia JDK11](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Ubuntu Theia Kind](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Ubuntu Theia Minikube](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Pardus Theia](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Alpine Theia](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Centos Theia](https://hub.docker.com/r/alperreha/bb-theia/tags)
- [ ] [Rocky Linux 8 Theia](https://hub.docker.com/r/alperreha/bb-theia/tags)

#### Plugins

##### General
- Git [vscode.git](https://open-vsx.org/api/vscode/git/1.79.0/file/vscode.git-1.79.0.vsix) `"vscode.git": "https://open-vsx.org/api/vscode/git/1.79.0/file/vscode.git-1.79.0.vsix"`   
- Gitlens [eamodio.gitlens](https://open-vsx.org/api/eamodio/gitlens/14.4.1/file/eamodio.gitlens-14.4.1.vsix) `"eamodio.gitlens": "https://open-vsx.org/api/eamodio/gitlens/14.4.1/file/eamodio.gitlens-14.4.1.vsix"`
- Prettier [esbenp.prettier-vscode](https://open-vsx.org/api/esbenp/prettier-vscode/10.1.0/file/esbenp.prettier-vscode-10.1.0.vsix) `"esbenp.prettier-vscode": "https://open-vsx.org/api/esbenp/prettier-vscode/10.1.0/file/esbenp.prettier-vscode-10.1.0.vsix"`  
- Git Graph [mhutchie.git-graph](https://open-vsx.org/api/mhutchie/git-graph/1.30.0/file/mhutchie.git-graph-1.30.0.vsix) `"mhutchie.git-graph": "https://open-vsx.org/api/mhutchie/git-graph/1.30.0/file/mhutchie.git-graph-1.30.0.vsix"`  
- Javascript [vscode.javascript](https://open-vsx.org/api/vscode/javascript/1.79.0/file/vscode.javascript-1.79.0.vsix) `"vscode.javascript": "https://open-vsx.org/api/vscode/javascript/1.79.0/file/vscode.javascript-1.79.0.vsix"`   
- Eslint [dbaeumer.vscode-eslint](https://open-vsx.org/api/dbaeumer/vscode-eslint/2.4.2/file/dbaeumer.vscode-eslint-2.4.2.vsix) `"dbaeumer.vscode-eslint": "https://open-vsx.org/api/dbaeumer/vscode-eslint/2.4.2/file/dbaeumer.vscode-eslint-2.4.2.vsix"`   
- Thunder Client [rangav.vscode-thunder-client](https://open-vsx.org/api/rangav/vscode-thunder-client/2.15.0/file/rangav.vscode-thunder-client-2.15.0.vsix) `"rangav.vscode-thunder-client": "https://open-vsx.org/api/rangav/vscode-thunder-client/2.15.0/file/rangav.vscode-thunder-client-2.15.0.vsix"`   
- YAML [redhat.vscode-yaml](https://open-vsx.org/api/redhat/vscode-yaml/1.14.0/file/redhat.vscode-yaml-1.14.0.vsix) `"redhat.vscode-yaml": "https://open-vsx.org/api/redhat/vscode-yaml/1.14.0/file/redhat.vscode-yaml-1.14.0.vsix"`  


##### Database
- SQLTools [mtxr.sqltools](https://open-vsx.org/api/mtxr/sqltools/0.28.0/file/mtxr.sqltools-0.28.0.vsix) `"mtxr.sqltools": "https://open-vsx.org/api/mtxr/sqltools/0.28.0/file/mtxr.sqltools-0.28.0.vsix"`  
- SQLTools - Driver PG [mtxr.sqltools-driver-pg](https://open-vsx.org/api/mtxr/sqltools-driver-pg/0.5.1/file/mtxr.sqltools-driver-pg-0.5.1.vsix) `"mtxr.sqltools-driver-pg": "https://open-vsx.org/api/mtxr/sqltools-driver-pg/0.5.1/file/mtxr.sqltools-driver-pg-0.5.1.vsix"`  
- SQLTools - Driver MySQL [mtxr.sqltools-driver-mysql](https://open-vsx.org/api/mtxr/sqltools-driver-mysql/0.5.1/file/mtxr.sqltools-driver-mysql-0.5.1.vsix) `"mtxr.sqltools-driver-mysql": "https://open-vsx.org/api/mtxr/sqltools-driver-mysql/0.5.1/file/mtxr.sqltools-driver-mysql-0.5.1.vsix"`   
- Mongo [mongodb.mongodb-vscode](https://open-vsx.org/api/mongodb/mongodb-vscode/1.3.1/file/mongodb.mongodb-vscode-1.3.1.vsix) `"mongodb.mongodb-vscode": "https://open-vsx.org/api/mongodb/mongodb-vscode/1.3.1/file/mongodb.mongodb-vscode-1.3.1.vsix"`   



##### Broker
- Redis Client [cweijan.vscode-redis-client](https://open-vsx.org/api/cweijan/vscode-redis-client/1.2.5/file/cweijan.vscode-redis-client-1.2.5.vsix) `"cweijan.vscode-redis-client": "https://open-vsx.org/api/cweijan/vscode-redis-client/1.2.5/file/cweijan.vscode-redis-client-1.2.5.vsix"`  
- Kafka [jeppeandersen.vscode-kafka](https://open-vsx.org/api/jeppeandersen/vscode-kafka/0.15.0/file/jeppeandersen.vscode-kafka-0.15.0.vsix) `"jeppeandersen.vscode-kafka": "https://open-vsx.org/api/jeppeandersen/vscode-kafka/0.15.0/file/jeppeandersen.vscode-kafka-0.15.0.vsix"`  



##### Cloud
- Docker [ms-azuretools.vscode-docker](https://open-vsx.org/api/ms-azuretools/vscode-docker/1.27.0/file/ms-azuretools.vscode-docker-1.27.0.vsix) `"ms-azuretools.vscode-docker": "https://open-vsx.org/api/ms-azuretools/vscode-docker/1.27.0/file/ms-azuretools.vscode-docker-1.27.0.vsix"`   
- Kubernetes [ms-kubernetes-tools.vscode-kubernetes-tools](https://open-vsx.org/api/ms-kubernetes-tools/vscode-kubernetes-tools/1.3.15/file/ms-kubernetes-tools.vscode-kubernetes-tools-1.3.15.vsix) `"ms-kubernetes-tools.vscode-kubernetes-tools": "https://open-vsx.org/api/ms-kubernetes-tools/vscode-kubernetes-tools/1.3.15/file/ms-kubernetes-tools.vscode-kubernetes-tools-1.3.15.vsix"`   



##### Programming Languages
- Go [golang.Go](https://open-vsx.org/api/golang/Go/0.39.1/file/golang.Go-0.39.1.vsix) `"golang.Go": "https://open-vsx.org/api/golang/Go/0.39.1/file/golang.Go-0.39.1.vsix"`  
- PHP [vscode.php](https://open-vsx.org/api/vscode/php/1.79.0/file/vscode.php-1.79.0.vsix) `"vscode.php": "https://open-vsx.org/api/vscode/php/1.79.0/file/vscode.php-1.79.0.vsix"`   
- C Cpp [vscode.cpp](https://open-vsx.org/api/vscode/cpp/1.79.0/file/vscode.cpp-1.79.0.vsix) `"vscode.cpp": "https://open-vsx.org/api/vscode/cpp/1.79.0/file/vscode.cpp-1.79.0.vsix"`
- Python [vscode.python](https://open-vsx.org/api/vscode/python/1.79.0/file/vscode.python-1.79.0.vsix) `"vscode.python": "https://open-vsx.org/api/vscode/python/1.79.0/file/vscode.python-1.79.0.vsix"`   
   
