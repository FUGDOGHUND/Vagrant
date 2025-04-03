#!/bin/bash

# Копирование приложения в домашнюю директорию
cp -r /vagrant/app /home/vagrant/

# Создание таблицы в базе данных
sudo -u postgres psql -d flaskdb -c "CREATE TABLE IF NOT EXISTS messages (id SERIAL PRIMARY KEY, content TEXT);"
sudo -u postgres psql -d flaskdb -c "INSERT INTO messages (content) VALUES ('Hello from PostgreSQL!');"