import flask
from flask import Flask, render_template, jsonify, request
from flask_cors import CORS
from flask.ext.mysql import MySQL
import pickle
import numpy as np

app = Flask(__name__)
CORS(app)
 
# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Ankurjain13'
app.config['MYSQL_DATABASE_DB'] = 'sakila'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql = MySQL(app)
CORS(app)

@app.route("/")

@app.route("/index")

def index():
   return flask.render_template('index.html')

@app.route("/predict", methods=['POST'])
def predict():
    if request.method == 'POST':
    	
        try:
            data = request.form
            
            years_of_experience = int(data["yearsOfExperience"])
            location = int(data["location"])
            sector = int(data["sector"])
            company_size = int(data["company_size"])

            print(years_of_experience)
            print(location)
            print(sector)
            print(company_size)

            
            lin_reg = pickle.load(open('python_lin_reg_model.pkl', 'rb'))
        except ValueError:
            return jsonify("Please enter a number.")

        result = lin_reg.predict([[ location,years_of_experience,company_size,sector ]])
        result = np.array2string(result, precision=2, separator=',',suppress_small=True)
        return render_template("predict.html",result = result)

@app.route("/show", methods=['GET'])
def show():
    if request.method == 'GET':
        try:
            conn = mysql.connect()
            sql_select_Query = "select * from sakila.category"
            cursor = conn.cursor()
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            print("Total number of rows in python_developers is - ", cursor.rowcount)
            print ("Printing each row's column values i.e.  developer record")
            for row in records:
                print("category id = ", row[0], )
                row1 = row[0]
                print("Name = ", row[1])
                row2 = row[1]
                print("last update  = ", row[2])
                row3 = row[2]
            cursor.close()
        except Error as e :
            print ("Error while connecting to MySQL", e)
        finally:
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return jsonify({'categor_id' : row1,'name' : row2,'last_updated' : row3})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4000, debug=True)




























