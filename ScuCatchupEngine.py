import flask
from flask import Flask, render_template, jsonify, request
from flask_cors import CORS
from flask.ext.mysql import MySQL
import pickle
import numpy as np
import re
import nltk
from nltk.corpus import stopwords
nltk.download('stopwords')
import string

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

            
            lin_reg = pickle.load(open('textmining_v1.pkl', 'rb'))
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
            sql_select_Query = "SELECT JOB_POST_ID, COMPANY_NAME, POSITION, JOB_DESCRIPTION, LOCATION, EXPERIENCE_REQ, JOB_CATEGORY FROM CATCH_UP.JOB_POST;"
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
                industry["category"] = row[6]
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

        input_ques = set(tuple(getwordsinputq(q_description)))
        sql_select_Query = "select q.question_id, q.q_description,q.q_category, group_concat(ifnull(r.q_r_description, 'None')) from question q left join q_response r on q.question_id = r.question_id group by q.question_id,q.q_description,q.q_category;"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_select_Query)
        records = list(cursor.fetchall())
        cursor.close()
        questions_list = []
        for i in records:
            i = list(i)
            questions_list.append(i)

        words_in_questions = []
        for line in questions_list:
            words_in_questions.append([line[0],no_stop_words(line[1].lower().replace('?', '').split(' ')), line[2]])

        words_in_qna = []
        for line in questions_list:
            words_in_qna.append([line[0],no_stop_words(re.sub(' +', ' ', (line[3]+line[1]).lower().replace('?', '').replace(',',' ')).split(' ')), line[2]])

        for question in words_in_qna:
            question[0] = int(question[0])
            question[1] = set(question[1])

        similar_questions = []

        for question in range(0, len(words_in_qna)):
            if (compute_jaccard_similarity(words_in_qna[question][1], input_ques) >= 0.3):
                similar_questions.append([words_in_qna[question][0]])
            
        for question in words_in_questions:
            question[0] = int(question[0])
            question[1] = set(question[1])

        for question in range(0, len(words_in_questions)):
            if (compute_jaccard_similarity(words_in_questions[question][1], input_ques) >= 0.3):
                similar_questions.append([words_in_questions[question][0]])

        print(similar_questions)

        questions_list = [item for sublist in similar_questions for item in sublist]
        sql_select_Query = "SELECT Q.QUESTION_ID, Q.Q_DESCRIPTION, U.FIRST_NAME, U.LAST_NAME FROM CATCH_UP.QUESTION Q INNER JOIN CATCH_UP.USERS U ON  Q.USER_ID = U.USER_ID WHERE QUESTION_ID IN ("
        
        for q in questions_list:
            sql_select_Query = sql_select_Query + str(q) + ","

        sql_select_Query = sql_select_Query[:-1] + ")"

        print(sql_select_Query)

        conn = mysql.connect()
        cursor = conn.cursor()
        questionsData = { "data":[]}

        if(len(questions_list) > 0):
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            for row in records:
                question = {}
                question["question_id"] = row[0]
                question["question_description"] = row[1]
                question["full_name"] = row[2] + " " + row[3]
                questionsData["data"].append(question)
        cursor.close()

        sql_insert_Query = "INSERT INTO CATCH_UP.QUESTION(USER_ID,Q_DESCRIPTION,Q_CATEGORY) VALUES (11, %s, %s)"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_insert_Query, (q_description, q_category))
        conn.commit()
        cursor.close()
        
        # result = np.array2string(result, precision=2, separator=',',suppress_small=True)
    return jsonify(questionsData)


# Compute the Jaccard Similarity of two sets
def compute_jaccard_similarity(set_1, set_2):
    return len(set_1 & set_2) / len(set_1 | set_2)


def getwordsinputq(quest):
    #words_in_input = []
    words = no_stop_words(quest.replace("?","").lower().split(" "))
    return words

def no_stop_words(question):
    no_stop_words= []
    for word in question:
        if word not in stopwords.words('english'):
            no_stop_words.append(word)
    return no_stop_words



@app.route("/postJob", methods=['POST', 'OPTIONS'])
def postJob():
    if request.method == 'POST':
        details = request.form
        company_name = details['company_name']
        position = details['position']
        description = details['description']
        location = details['location']
        experience = int(details['experience'])
        print(type(experience))
        job_category = details['job_category']
        sql_insert_Query = "INSERT INTO CATCH_UP.JOB_POST(ALUMNI_ID,COMPANY_NAME, POSITION, JOB_DESCRIPTION, LOCATION,EXPERIENCE_REQ, JOB_CATEGORY)  VALUES (2, %s, %s, %s, %s, %s, %s)"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_insert_Query, (company_name, position, description, location, experience, job_category))
        conn.commit()
        cursor.close()
        sql_select_Query = "SELECT JOB_POST_ID, COMPANY_NAME, POSITION, JOB_DESCRIPTION, LOCATION, EXPERIENCE_REQ, JOB_CATEGORY FROM CATCH_UP.JOB_POST;"
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
            industry["category"] = row[6]
            industryData["data"].append(industry)

    return jsonify(industryData)


@app.route("/jobResponse", methods=['POST', 'OPTIONS'])
def jobResponse():
    if request.method == 'POST':
        details = request.form
        job_id = details['job_id']
        message = details['message']
        sql_insert_Query = "INSERT INTO CATCH_UP.JOB_RESPONSE(JOB_POST_ID,STUDENT_ID, J_RESPONSE_MESSAGE) VALUES(%s, 9, %s);"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_insert_Query, (job_id, message))
        conn.commit()
        cursor.close()
    return jsonify({'job_id' : job_id,'message' : message})



@app.route("/messages", methods=['GET'])
def messages():
    if request.method == 'GET':
        try:
            sql_select_Query = "SELECT R.JOB_RESPONSE_ID, P.POSITION,U.FIRST_NAME, U.LAST_NAME , R.J_RESPONSE_MESSAGE FROM CATCH_UP.JOB_POST P inner join CATCH_UP.JOB_RESPONSE R ON P.JOB_POST_ID = R.JOB_POST_ID INNER JOIN STUDENT S ON R.STUDENT_ID = S.STUDENT_ID INNER JOIN USERS U ON U.USER_ID = S.USER_ID;"
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sql_select_Query)
            records = cursor.fetchall()
            messageData = { "data":[]}
            for row in records:
                industry = {}
                industry["response_id"] = row[0]
                industry["summary"] = row[1] +" - " + row[2] + " " + row[3]
                industry["detail"] = row[4]
                industry["severity"] = "error"
                industry["closeAffordance"] = "none"
                messageData["data"].append(industry)
            
        except Error as e :
            print ("Error while connecting to MySQL", e)
        finally:
            cursor.close()
            conn.close()
            print("MySQL connection is closed")
    return jsonify(messageData)


@app.route("/postAcommodation", methods=['POST', 'OPTIONS'])
def postAcommodation():
    if request.method == 'POST':
        details = request.form
        address = details['address']
        city = details['city']
        state = details['state']
        zip = details['zip']
        description = details['description']
        price = details['price']
        bed = details['bed']
        bath = details['bath']
        occupancy = details['occupancy']
        home_type = details['home_type']
        type = details['type']
        sql_insert_Query = "INSERT INTO CATCH_UP.ACC_POST(USER_ID, ACC_TYPE, STREET_ADDRESS, ACC_CITY, ACC_STATE, ACC_ZIP, ACC_DESCRIPTION, ACC_PRICE, BED, BATH, OCCUPANCY, HOME_TYPE)  VALUES (11, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_insert_Query, (type, address, city, state, zip, description, price, bed, bath, occupancy, home_type))
        conn.commit()
        cursor.close()
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

    return jsonify(accomData)


@app.route("/postMarket", methods=['POST', 'OPTIONS'])
def postMarket():
    if request.method == 'POST':
        details = request.form
        title = details['title']
        type = details['type']
        address = details['address']
        zip = details['zip']
        city = details['city']
        state = details['state']
        description = details['description']
        price = details['price']
        condition = details['condition']
        status = details['status']
        category = details['category']
        sql_insert_Query = "INSERT INTO MARKET_POST(USER_ID,MARKET_POST_TITLE,MARKET_POST_TYPE,MARKET_ADDRESS,MARKET_CITY,MARKET_STATE,MARKET_ZIP,OBJECT_DESCRIPTION,OBJECT_PRICE,OBJECT_CONDITION,MARKET_STATUS,OBJECT_CATEGORY) VALUES(11, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_insert_Query, (title, type, address, city, state, zip, description, price, condition, status, category))
        conn.commit()
        cursor.close()
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

    return jsonify(marketData)



@app.route("/questionResponse", methods=['POST', 'OPTIONS'])
def questionResponse():
    if request.method == 'POST':
        details = request.form
        question_id = details['question_id']
        reply = details['reply']
        sql_insert_Query = "INSERT INTO CATCH_UP.Q_RESPONSE(QUESTION_ID, USER_ID, Q_R_DESCRIPTION) VALUES(%s, 11, %s);"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_insert_Query, (question_id, reply))
        conn.commit()
        cursor.close()

        sql_select_Query = "SELECT QR.Q_RESPONSE_ID, QR.Q_R_DESCRIPTION, U.FIRST_NAME, U.LAST_NAME FROM CATCH_UP.Q_RESPONSE QR INNER JOIN CATCH_UP.USERS U ON QR.USER_ID = U.USER_ID WHERE QR.QUESTION_ID =";
        sql_select_Query += '"' + question_id + '"'
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
    return jsonify(responseData)


@app.route("/marketResponse", methods=['POST', 'OPTIONS'])
def postMarketResponse():
    if request.method == 'POST':
        details = request.form
        question_id = details['question_id']
        reply = details['reply']
        sql_insert_Query = "INSERT INTO CATCH_UP.MARKET_RESPONSE(MARKET_POST_ID, USER_ID, M_RESPONSE_MESSAGE) VALUES(%s, 11, %s);"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_insert_Query, (question_id, reply))
        conn.commit()
        cursor.close()

        sql_select_Query = "SELECT MARKET_RESPONSE_ID,M_RESPONSE_MESSAGE, FIRST_NAME, LAST_NAME FROM MARKET_RESPONSE MR INNER JOIN USERS U ON MR.USER_ID = U.USER_ID WHERE MARKET_POST_ID = ";
        sql_select_Query += '"' + question_id + '"'
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
    return jsonify(responseData)


@app.route("/accomodationReplies", methods=['POST', 'OPTIONS'])
def postAccomodationReply():
    if request.method == 'POST':
        details = request.form
        question_id = details['question_id']
        reply = details['reply']
        sql_insert_Query = "INSERT INTO CATCH_UP.ACC_RESPONSE(ACC_POST_ID, USER_ID, A_RESPONSE_MESSAGE) VALUES(%s, 11, %s);"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_insert_Query, (question_id, reply))
        conn.commit()
        cursor.close()

        sql_select_Query = "SELECT ACC_RESPONSE_ID, FIRST_NAME, LAST_NAME, A_RESPONSE_MESSAGE FROM ACC_RESPONSE AR INNER JOIN USERS U ON AR.USER_ID = U.USER_ID WHERE ACC_POST_ID = ";
        sql_select_Query += '"' + question_id + '"'
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
    return jsonify(responseData)


@app.route("/postEvent", methods=['POST', 'OPTIONS'])
def postEvent():
    if request.method == 'POST':
        details = request.form
        title = details['title']
        type = details['type']
        address = details['address']
        zip = details['zip']
        city = details['city']
        state = details['state']
        description = details['description']
        price = details['price']
        url = details['url']
        date = details['date']
        sql_insert_Query = "INSERT INTO CATCH_UP.ALL_EVENTS(USER_ID,EVENT_TITLE, EVENT_TYPE, EVENT_ADDRESS, EVENT_CITY, EVENT_STATE, EVENT_ZIP, EVENT_DESCRIPTION, EVENT_PRICE, EVENT_URL, EVENT_DATE) VALUES(11, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql_insert_Query, (title, type, address, city, state, zip, description, price, url, date))
        conn.commit()
        cursor.close()

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

    return jsonify(eventsData)


@app.route('/chat',methods=['GET'])
def chat():
    print("inside chat")
    # user_input=request.form['user_input']
    # bot_response=bot.get_response(user_input)
    bot_response="sample string"
    print("Friend: "+bot_response)
    return render_template('chatbot.html')



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4000, debug=True)




























