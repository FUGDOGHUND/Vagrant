#!/bin/bash
# Обновление системы
sudo apt update && sudo apt upgrade -y

# Установка PostgreSQL
sudo apt install -y postgresql postgresql-contrib
sudo -u postgres psql <<EOF
CREATE DATABASE mydb;
CREATE USER myuser WITH ENCRYPTED PASSWORD 'mypassword';
GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;
ALTER DATABASE mydb OWNER TO myuser;
EOF

# Настройка PostgreSQL для внешних подключений
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf
sudo echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/*/main/pg_hba.conf
sudo systemctl restart postgresql

# Установка Python, виртуального окружения и Flask
sudo apt install -y python3-pip python3-venv
cd /vagrant
python3 -m venv myenv
source myenv/bin/activate
pip install flask psycopg2-binary

# Создание службы для автоматического запуска Flask
sudo bash -c 'cat > /etc/systemd/system/flaskapp.service <<EOF
[Unit]
Description=Flask App
After=network.target

[Service]
User=vagrant
WorkingDirectory=/vagrant
Environment="PATH=/vagrant/myenv/bin"
ExecStart=/vagrant/myenv/bin/python /vagrant/app.py

[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl daemon-reload
sudo systemctl enable flaskapp.service
sudo systemctl start flaskapp.service