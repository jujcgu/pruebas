#!/usr/bin/env python3
# -- coding: utf-8 --
"""
Created on Tue Nov 21 20:49:31 2023

@author: usco
"""


import json

# model_filename = "/home/usco/databases/pruebas.json"
model_filename = "/home/usco/gitpruebas/pruebas/pruebas2/pruebas1.json"
# Opening JSON file
f = open(model_filename)
# returns JSON object as 
# a dictionary
data = json.load(f)
 
print(data)


file1 = open("myfile.sql", "w")


app = data["app"]
db_engine = data["db_engine"]
db_host = data["db_host"]
db_port = data["db_port"]
engine_databasename = data["engine_databasename"]
dba_username = data["dba_username"]
dba_password = data["dba_password"]
app_database_name = data["app_database_name"]
app_database_owner = data["app_database_owner"]
app_database_password = data["app_database_password"]


import psycopg2
from psycopg2 import sql


conn = psycopg2.connect(
    database=engine_databasename,
    host=db_host,
    user=dba_username,
    password=dba_password,
    port=db_port)

conn.autocommit = True

cursor = conn.cursor()


sql_text = "DROP DATABASE IF EXISTS {};\n".format(app_database_name)
sql_string = sql.SQL(sql_text)
cursor.execute(sql_text)
file1.write(sql_text)


roles = data["roles"]    
    
for role in roles:
    role_username = role["username"]
    role_password = role["password"]
    
    try:
        sql_text = "DROP ROLE IF EXISTS {};\n".format(role_username)
        sql_string = sql.SQL(sql_text)
        cursor.execute(sql_text)
        # print(cursor.fetchone())
        file1.write(sql_text)
    except:
        pass
    
    sql_text = "CREATE ROLE {} WITH LOGIN ENCRYPTED PASSWORD '{}';\n"
    sql_text = sql_text.format(role_username, role_password)
    sql_string = sql.SQL(sql_text)
    cursor.execute(sql_text)
    # print(cursor.fetchone())
    file1.write(sql_text)



sql_text = "DROP DATABASE IF EXISTS {};\n".format(app_database_name)
sql_string = sql.SQL(sql_text)
cursor.execute(sql_text)
# print(cursor.fetchone())
file1.write(sql_text)


sql_text = "CREATE DATABASE {}\n"
sql_text += " WITH\n"
sql_text += " OWNER = {}\n"
sql_text += " ENCODING = 'UTF8'\n"
sql_text += " TABLESPACE = pg_default\n"
sql_text += " CONNECTION LIMIT = -1;\n"

sql_text = sql_text.format(
    app_database_name,
    app_database_owner    
    )

sql_string = sql.SQL(sql_text)
cursor.execute(sql_text)
# print(cursor.fetchone())

file1.write(sql_text)




db_postgres = {
    "int":"int",
    "string":"character varying",
    "boolean": "character",
    "date":"date",
    "timestamp":"timestamp"
    }

crud_dict = {
    "CREATE":"insert",
    "READ":"select",
    "UPDATE":"update",
    "DELETE":"delete"
    }


classes = data["classes"]

sql_text = ""
for _class in classes:
    class_name = _class["name"]
    attributes = _class["attributes"]
    
    sql_text += "CREATE TABLE {} (\n"
    sql_text = sql_text.format(class_name)
    
    for attribute in attributes:
        attribute_name = attribute["name"]            
        attribute_data_type = attribute["data_type"]   
        attribute_length = attribute["length"]   
        attribute_pk = attribute["pk"]  
        attribute_autoincrement = attribute["autoincrement"]
        
        
        sql_text += attribute_name
        
        if attribute_autoincrement == True:
            sql_text += " serial"
        else:
            sql_text += " " + db_postgres[attribute_data_type]
        
        if attribute_data_type == "string":
            sql_text += " (" + str(attribute_length) + ")"
        sql_text += ",\n"
    
    # sql_text = sql_text[:-2]
    # if attribute_pk == "true":
    sql_text += "CONSTRAINT {}_pkey PRIMARY KEY ({})"
    sql_text = sql_text.format(class_name, "id")
    
    
    # print("-"*60)
    relations = _class["relations"]
    
    if len(relations) > 0:
        sql_text += ",\n"
    else:
        sql_text += "\n"
    
    for relation in relations:
        print(relation)
        local_attribute = relation["local_attribute"]
        referenced_table = relation["referenced_table"]
        referenced_attribute = relation["referenced_attribute"]
        
        # sql_text += "CONSTRAINT {}_{}{}_fkey FOREIGN KEY ({})\n"
        # sql_text += "\tREFERENCES public.{} ({}) MATCH SIMPLE\n"
        # sql_text += "\tON UPDATE NO ACTION\n"
        # sql_text += "\tON DELETE NO ACTION\n"
        
        sql_text += "CONSTRAINT {}_{}_fkey FOREIGN KEY ({})\n"
        sql_text += "\tREFERENCES public.{} ({}) MATCH SIMPLE\n"
        sql_text += "\tON UPDATE NO ACTION\n"
        sql_text += "\tON DELETE NO ACTION\n"
   
        
        # sql_text = sql_text.format(
        #     class_name,
        #     referenced_table,
        #     referenced_attribute,
        #     referenced_attribute,
        #     referenced_table,
        #     referenced_attribute
        #     )
        sql_text = sql_text.format(
            class_name,
            referenced_table,
            referenced_attribute,
            referenced_table,
            referenced_attribute
            )
        
    
    sql_text += ")\n"
    sql_text += "WITH (\n"
    sql_text += "OIDS=FALSE\n"
    sql_text += ");\n"


    sql_text += "ALTER TABLE public.{}\n"
    sql_text += " OWNER TO {};\n"

    sql_text = sql_text.format(
        class_name,
        app_database_owner   
    )
    
    print(sql_text)
    
    
    print("-"*60)
    grants = _class["grants"]
    
        
        
        
    for grant in grants:
        username = list(grant.keys())[0]
        grant_values = list(grant.values())[0]
        
        grant_list = ", ".join(crud_dict[x] for x in grant_values)
            
        sql_text += "GRANT {} ON {} TO {};\n"
        
        sql_text = sql_text.format(
            grant_list,
            class_name,
            username
            )
        
    


# L = ["This is Delhi \n", "This is Paris \n", "This is London \n"]
 
# \n is placed to indicate EOL (End of Line)
file1.write(sql_text)






# file1.writelines(L)
file1.close()  # to change file access modes

# # Iterating through the json
# # list
# for i in data['emp_details']:
#     print(i)
 
# Closing file
f.close()


