#!/usr/bin/env python
# coding: utf-8

# ## Python Application - University Healthcare Database - Group 14
# 
# ### Group Members:
# 1. Aniket Sakharkar
# 2. Aarushi Sharma

# In[1]:


import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import plotly.express as px


# Connecting to the database created on MySQL Workbench

# In[2]:


mydb = mysql.connector.connect(host = "localhost", user = "root",
passwd = "root", database = "university_healthcare_db")
mycursor = mydb.cursor(buffered = True)


# Exploratory Data Analysis using Visualizations and executing the SQL Query through the application

# In[3]:


mycursor.execute(
    '''
    select count(S.studentID), U.universityName 
    from student S 
    join University U 
    on S.universityID = U.universityID 
    group by U.universityID
    '''
)

for i in mycursor:
    print(i)


# The below graph is a representation of the number of Students in each University which has been registered on the 
# Database. When you hover over the area we can see the exact number of students and the corresponding University's name.

# In[5]:


mycursor.execute(
    '''
    select count(S.studentID), 
    U.universityName from student S join University U on 
    S.universityID = U.universityID group by U.universityID
    ''')


result = mycursor.fetchall


count_id = [] 
uniname = []

for i in mycursor: 
    count_id.append(i[0])
    uniname.append(i[1])
    
print("Number of Students =", count_id) 
print("University =", uniname) 

# f, ax = plt.subplots(figsize = (35, 20))
# plt.bar(uniname, count_id, color = 'grey') 
# plt.xlabel(" University Name", fontsize = 22)
# plt.ylabel(" Number of Students", fontsize = 22)
# plt.title("Number of Employees under each Reviewer", fontsize = 22) 
# ax.tick_params(axis = 'x', labelsize = 20)
# ax.tick_params(axis = 'y', labelsize = 20)
# ax.set_xticklabels(uniname, rotation = 90)
# plt.show()


# fig = px.bar(mycursor, x = uniname, y = count_id)

fig = px.pie(mycursor, values = count_id, names = uniname, title = 'Count of Students in each University registered on Database')


fig.show()


# The below bar graph shows the Insurance Companies which have more than average Coverage Amount to offer to Universities as well as Students. We can see the exact amount in Millions if we hover over the bars.

# In[6]:


mycursor.execute(
    '''
        select InsuranceName, CoverageAmount from Insurance
        where coverageamount > (
        select avg(coverageamount) from insurance );
    ''')


result = mycursor.fetchall


covamt = [] 
insname = []

for i in mycursor: 
    insname.append(i[0])
    covamt.append(i[1])
    
print("Coverage Amount =", covamt) 
print("Insurance Name =", insname) 
# f, ax = plt.subplots(figsize = (45, 30))
# plt.bar(insname, covamt, color = 'grey') 
# plt.xlabel("Insurance Name", fontsize = 32)
# plt.ylabel("Coverage Amount", fontsize = 32)
# plt.title("Insurers having Coverage Amount greater than Average Coverage Amount", fontsize = 32) 
# ax.tick_params(axis = 'x', labelsize = 30)
# ax.tick_params(axis = 'y', labelsize = 30)
# ax.set_xticklabels(insname, rotation = 90)
# plt.show()


fig = px.bar(mycursor, x = insname, y = covamt)
fig.show()


# In[8]:


The below scatter plot shows the average amount of Coverage a University has to offer to its Students.


# In[7]:


mycursor.execute(
    '''
        select U.universityName, avg(SMR.coverageamount) as avg_cov
        from student S
        join University U
        on S.universityID = U.universityID
        join StudentMedicalRecords SMR
        on S.studentID = SMR.studentID
        group by U.universityID
    ''')

result = mycursor.fetchall 

uniname = []
avgcov = []

for i in mycursor:
    uniname.append(i[0])
    avgcov.append(i[1]) 
# plt.scatter(uniname, avgcov,color='r')
# plt.xlabel("Work Title")
# plt.ylabel("Performance Score")
# plt.title('Scatter plot of Work Titles with the Scores')


fig = px.scatter(mycursor, x = uniname, y = avgcov)
fig.show()


# In[ ]:




