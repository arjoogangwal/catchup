import flask
from flask import Flask, render_template, jsonify, request
from flask_cors import CORS
from flask.ext.mysql import MySQL
import pickle
import numpy as np

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})
 
# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Ankurjain13'
app.config['MYSQL_DATABASE_DB'] = 'CATCH_UP'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql = MySQL(app)

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


@app.route("/questions", methods=['GET'])
def questions():
    if request.method == 'GET':
        try:
            category = request.args.get('category')
            sql_select_Query = "SELECT Q.QUESTION_ID, Q.Q_DESCRIPTION, U.FIRST_NAME, U.LAST_NAME FROM CATCH_UP.QUESTION Q INNER JOIN CATCH_UP.USERS U ON  Q.USER_ID = U.USER_ID WHERE Q_CATEGORY =" ;
            sql_select_Query += '"' + category + '"'
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            questionsData = { "data":[]}
            for row in records:
                question = {}
                question["question_id"] = row[0]
                question["question_description"] = row[1]
                question["full_name"] = row[2] + " " + row[3]
                questionsData["data"].append(question)
            cursor.close()
            
        except Error as e :
            print ("Error while connecting to MySQL", e)
        finally:
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return jsonify(questionsData)


@app.route("/replies", methods=['GET'])
def replies():
    if request.method == 'GET':
        try:
            questionId = request.args.get('questionId')
            sql_select_Query = "SELECT QR.Q_RESPONSE_ID, QR.Q_R_DESCRIPTION, U.FIRST_NAME, U.LAST_NAME FROM CATCH_UP.Q_RESPONSE QR INNER JOIN CATCH_UP.USERS U ON QR.USER_ID = U.USER_ID WHERE QR.QUESTION_ID =";
            sql_select_Query += '"' + questionId + '"'
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            responseData = { "data":[]}
            for row in records:
                response = {}
                response["response_id"] = row[0]
                response["response_description"] = row[1]
                response["full_name"] = row[2] + " " + row[3]
                responseData["data"].append(response)
            cursor.close()
            
        except Error as e :
            print ("Error while connecting to MySQL", e)
        finally:
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return jsonify(responseData)


@app.route("/accomodations", methods=['GET'])
def accomodations():
    if request.method == 'GET':
        try:
            sql_select_Query = "SELECT ACC_POST_ID, ACC_TYPE, ACC_DESCRIPTION, ACC_PRICE, BED, BATH, OCCUPANCY, HOME_TYPE, STREET_ADDRESS, ACC_CITY, ACC_STATE, ACC_ZIP, FIRST_NAME, LAST_NAME FROM ACC_POST A INNER JOIN USERS U ON A.USER_ID = U.USER_ID;"
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            accomData = { "data":[]}
            for row in records:
                accom = {}
                accom["id"] = row[0]
                accom["type"] = row[1]
                accom["description"] = row[2]
                accom["price"] = row[3]
                accom["bed"] = row[4]
                accom["bath"] = row[5]
                accom["occupancy"] = row[6]
                accom["home_type"] = row[7]
                accom["street_address"] = row[8]
                accom["city"] = row[9]
                accom["state"] = row[10]
                accom["zip"] = row[11]
                accom["full_name"] = row[12] + " " + row[13]
                accomData["data"].append(accom)
            cursor.close()
            
        except Error as e :
            print ("Error while connecting to MySQL", e)
        finally:
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return jsonify(accomData)


@app.route("/accomodationReplies", methods=['GET'])
def accomodationReplies():
    if request.method == 'GET':
        try:
            accomodationId = request.args.get('accomodationId')
            sql_select_Query = "SELECT ACC_RESPONSE_ID, FIRST_NAME, LAST_NAME, A_RESPONSE_MESSAGE FROM ACC_RESPONSE AR INNER JOIN USERS U ON AR.USER_ID = U.USER_ID WHERE ACC_POST_ID = ";
            sql_select_Query += '"' + accomodationId + '"'
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            responseData = { "data":[]}
            for row in records:
                response = {}
                response["id"] = row[0]
                response["response_description"] = row[3]
                response["full_name"] = row[1] + " " + row[2]
                responseData["data"].append(response)
            cursor.close()
            
        except Error as e :
            print ("Error while connecting to MySQL", e)
        finally:
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return jsonify(responseData)


@app.route("/market", methods=['GET'])
def market():
    if request.method == 'GET':
        try:
            sql_select_Query = "SELECT MARKET_POST_ID, FIRST_NAME, LAST_NAME,MARKET_POST_TITLE,MARKET_POST_TYPE,MARKET_ADDRESS,MARKET_CITY,MARKET_STATE,MARKET_ZIP,OBJECT_DESCRIPTION,OBJECT_PRICE,OBJECT_CONDITION,MARKET_STATUS FROM MARKET_POST M INNER JOIN USERS U ON M.USER_ID = U.USER_ID;"
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            marketData = { "data":[]}
            for row in records:
                market = {}
                market["id"] = row[0]
                market["title"] = row[3]
                market["type"] = row[4]
                market["address"] = row[5]
                market["city"] = row[6]
                market["state"] = row[7]
                market["zip"] = row[8]
                market["description"] = row[9]
                market["price"] = row[10]
                market["condition"] = row[11]
                market["status"] = row[12]
                market["full_name"] = row[1] + " " + row[2]
                marketData["data"].append(market)
            cursor.close()
            
        except Error as e :
            print ("Error while connecting to MySQL", e)
        finally:
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return jsonify(marketData)

@app.route("/marketResponse", methods=['GET'])
def marketResponse():
    if request.method == 'GET':
        try:
            marketId = request.args.get('marketId')
            sql_select_Query = "SELECT MARKET_RESPONSE_ID,M_RESPONSE_MESSAGE, FIRST_NAME, LAST_NAME FROM MARKET_RESPONSE MR INNER JOIN USERS U ON MR.USER_ID = U.USER_ID WHERE MARKET_POST_ID = ";
            sql_select_Query += '"' + marketId + '"'
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            responseData = { "data":[]}
            for row in records:
                response = {}
                response["id"] = row[0]
                response["response_description"] = row[1]
                response["full_name"] = row[2] + " " + row[3]
                responseData["data"].append(response)
            cursor.close()
            
        except Error as e :
            print ("Error while connecting to MySQL", e)
        finally:
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return jsonify(responseData)

@app.route("/events", methods=['GET'])
def events():
    if request.method == 'GET':
        try:
            sql_select_Query = "SELECT EVENT_ID, EVENT_TITLE, EVENT_TYPE, EVENT_ADDRESS, EVENT_CITY, EVENT_STATE, EVENT_ZIP, EVENT_DESCRIPTION, EVENT_PRICE, EVENT_CATEGORY, EVENT_URL, EVENT_DATE FROM CATCH_UP.ALL_EVENTS"
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            eventsData = { "data":[]}
            for row in records:
                event = {}
                event["id"] = row[0]
                event["title"] = row[1]
                event["type"] = row[2]
                event["address"] = row[3]
                event["city"] = row[4]
                event["state"] = row[5]
                event["zip"] = row[6]
                event["description"] = row[7]
                event["price"] = row[8]
                event["category"] = row[9]
                event["url"] = row[10]
                event["date"] = row[11]
                eventsData["data"].append(event)
            cursor.close()
            
        except Error as e :
            print ("Error while connecting to MySQL", e)
        finally:
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return jsonify(eventsData)


@app.route("/industry", methods=['GET'])
def industry():
    if request.method == 'GET':
        try:
            sql_select_Query = "SELECT JOB_POST_ID, COMPANY_NAME, POSITION, JOB_DESCRIPTION, LOCATION, EXPERIENCE_REQ FROM CATCH_UP.JOB_POST;"
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            industryData = { "data":[]}
            for row in records:
                industry = {}
                industry["id"] = row[0]
                industry["company_name"] = row[1]
                industry["position"] = row[2]
                industry["job_description"] = row[3]
                industry["location"] = row[4] 
                industry["experience"] = row[5]
                industryData["data"].append(industry)
            
        except Error as e :
            print ("Error while connecting to MySQL", e)
        finally:
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return jsonify(industryData)


@app.route("/postQuestions", methods=['POST', 'OPTIONS'])
def postQuestion():
    if request.method == 'POST':
        details = request.form
        q_description = details['q_description']
        q_category = details['q_category']
        sql_insert_Query = "INSERT INTO CATCH_UP.QUESTION(USER_ID,Q_DESCRIPTION,Q_CATEGORY) VALUES (2, %s, %s)"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_insert_Query, (q_description, q_category))
        conn.commit()
        cursor.close()
    return jsonify({'categor_id' : "row1",'name' : "row2",'last_updated' : "row3"})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4000, debug=True)




























