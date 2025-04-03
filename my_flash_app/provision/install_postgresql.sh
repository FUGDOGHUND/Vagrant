#!/bin/bash

# Установка PostgreSQL
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

# Настройка PostgreSQL
sudo -u postgres psql -c "CREATE DATABASE flaskdb;"
sudo -u postgres psql -c "CREATE USER flaskuser WITH PASSWORD 'password';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE flaskdb TO flaskuser;"

echo "host    flaskdb       flaskuser      0.0.0.0/0               md5" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf
echo "listen_addresses = '*'" | sudo tee -a /etc/postgresql/*/main/postgresql.conf

# Перезапуск PostgreSQL
sudo service postgresql restart