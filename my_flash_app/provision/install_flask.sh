#!/bin/bash

# Установка Python и pip
sudo apt-get update
sudo apt-get install -y python3 python3-pip

# Установка Flask и psycopg2
sudo pip3 install flask psycopg2-binary