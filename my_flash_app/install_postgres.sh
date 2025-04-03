#!/bin/bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib

# Создание пользователя и базы данных
sudo -u postgres psql <<EOF
CREATE DATABASE mydb;
CREATE USER myuser WITH ENCRYPTED PASSWORD 'mypassword';
GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;
EOF

echo "PostgreSQL установлен и настроен."
