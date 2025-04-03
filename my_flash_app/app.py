from flask import Flask
import psycopg2

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
        dbname="mydb",
        user="myuser",
        password="mypassword",
        host="localhost"
    )
    return conn

@app.route("/")
def index():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT 'Привет из базы данных!' AS message")
    message = cur.fetchone()[0]
    cur.close()
    conn.close()
    return message

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)