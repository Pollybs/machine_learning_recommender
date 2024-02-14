import json
import math
from collections import defaultdict, OrderedDict
from flask import Flask, abort, request , jsonify
from flask_basicauth import BasicAuth
from flask_swagger_ui import get_swaggerui_blueprint
import pymysql
import os
import requests


app = Flask(__name__)
app.config.from_file("flask_config.json", load=json.load)
auth = BasicAuth(app)

MAX_PAGE_SIZE = 100

def remove_null_fields(obj):
    return {k:v for k, v in obj.items() if v is not None}

swaggerui_blueprint = get_swaggerui_blueprint(
    base_url='/information',
    api_url='/openapi.yaml',
)
app.register_blueprint(swaggerui_blueprint)

#-------------

@app.route("/websites/")

def websites():
    db_conn = pymysql.connect(host="localhost", user="root", password=os.getenv("myslqp"), database="recipes",
                              cursorclass=pymysql.cursors.DictCursor)
    with db_conn.cursor() as cursor:
        cursor.execute("""SELECT website_id, name
        FROM websites
        WHERE website_id != 3
        order by website_id """)
        websites = cursor.fetchall()
    db_conn.close()
    return websites
    


@app.route("/recipes")

def m_recipes():
    page = int(request.args.get('page', 0))
    page_size = int(request.args.get('page_size', MAX_PAGE_SIZE))
    page_size = min(page_size, MAX_PAGE_SIZE)
    websiteid = int(request.args.get('website_id', 0))

    db_conn = pymysql.connect(host="localhost", user="root", password=os.getenv("myslqp"), database="recipes",
                              cursorclass=pymysql.cursors.DictCursor)
    
    if websiteid > 0:
        with db_conn.cursor() as cursor:
            cursor.execute("""SELECT *
            FROM recipes_all
            WHERE website_id = %s
            order by recipe_id 
            LIMIT %s
            OFFSET %s""", (websiteid, page_size, page * page_size ) )
            recipes = cursor.fetchall()
            recipes = [remove_null_fields(n) for n in recipes]
        
        with db_conn.cursor() as cursor:
                cursor.execute("""SELECT COUNT(*) AS total FROM recipes_all
                            WHERE website_id = %s
                            order by recipe_id """, (websiteid, ) )
                total = cursor.fetchone()
                last_page = math.ceil(total['total'] / page_size)

    else:
        with db_conn.cursor() as cursor:
            cursor.execute("""SELECT *
            FROM recipes_all
            order by recipe_id
            LIMIT %s
            OFFSET %s""", (page_size, page * page_size ) )
            recipes = cursor.fetchall()
            recipes = [remove_null_fields(n) for n in recipes]
        
        with db_conn.cursor() as cursor:
                cursor.execute("SELECT COUNT(*) AS total FROM recipes_all")
                total = cursor.fetchone()
                last_page = math.ceil(total['total'] / page_size)

    db_conn.close()
    return {
        'Recipes': recipes,
        'next_page': f'/recipes?page={page+1}&page_size={page_size}',
        'last_page': f'/recipes?page={last_page}&page_size={page_size}'
    }



     

@app.route("/recipes/<recipe_id>")

def workart_info(recipe_id):
    db_conn = pymysql.connect(host="localhost", user="root", password=os.getenv("myslqp"), database="recipes", cursorclass=pymysql.cursors.DictCursor)
    
    with db_conn.cursor() as cursor:
        cursor.execute("""SELECT *
                                    FROM recipes_all
                       where recipe_id = %s

        """, (recipe_id, ))
        recipe_info = cursor.fetchall()
        if not recipe_info:
            abort(404)
    db_conn.close()
    return recipe_info 

