#! /bin/bash

# ENV values PRELOAD_FILE_URL, PRELOAD_FILE_DIR
# We need to try to wget the file from the URL to the demanded directory.
# If env's not set skip. If file already overwrite
# If file could not fetched write "Could not load file contact administrator. https://bulutbilisimciler.com/destek"

if [ -n "$PRELOAD_FILE_URL" ] && [ -n "$PRELOAD_FILE_DIR" ]
then
    echo "Downloading file from $PRELOAD_FILE_URL to $PRELOAD_FILE_DIR"
    if wget -O $PRELOAD_FILE_DIR $PRELOAD_FILE_URL; then
        echo "Shell OK"
    else
        echo "Could not load file. Please contact administrator at https://bulutbilisimciler.com/destek"
    fi
fi

# PostgreSQL hizmetini başlat
systemctl start postgresql
sleep 5

# "test" adında bir veritabanı oluştur
su - postgres -c "psql -U postgres -c 'CREATE DATABASE bulutdb;'"
# "test" veritabanına bağlan ve init.sql dosyasını çalıştır
su - postgres -c 'psql -U postgres -d bulutdb -f /home/mock/init.sql'
echo "PostgreSQL started success"

node /root/ide/src-gen/backend/main.js --hostname=0.0.0.0 --port=3030 --plugins=local-dir:/root/ide/plugins

# echo "Docker Compose Starting..."
# docker-compose up -d
# echo "Docker Compose Started Successfully!"
