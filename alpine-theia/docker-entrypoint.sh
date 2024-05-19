#!/bin/sh
dbus-uuidgen > /var/lib/dbus/machine-id
cd /root/ide

THEIA_WEBVIEW_EXTERNAL_ENDPOINT="{{hostname}}" node /root/ide/src-gen/backend/main.js --hostname=0.0.0.0 --port=3030 --plugins=local-dir:/root/ide/plugins