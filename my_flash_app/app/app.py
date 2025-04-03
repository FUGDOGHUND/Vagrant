from flask import Flask, render_template
import psycopg2

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
        host='localhost',
        database='flaskdb',
        user='flaskuser',
        password='password'
    )
    return conn

@app.route('/')
def index():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT content FROM messages;')
    message = cur.fetchone()[0]
    cur.close()
    conn.close()
    return render_template('index.html', message=message)

if __name__ == '__main__':
    app.run(host='0.0.0.0')