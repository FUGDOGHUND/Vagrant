#!/bin/bash
sudo apt update
sudo apt install -y python3-pip python3-venv
python3 -m venv myenv
source myenv/bin/activate
pip install flask psycopg2
echo "Flask установлен."
