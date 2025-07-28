# Prime number:
def isprime(n):
    if n<=1:
        print("Not a prime number")
        return
    if n ==2 or n==3 :
        print("Prime Number ")
        return
    if (n%2 == 0) or (n%3 ==0):
        print("Not a prime Number")
        return
    for i in range (5,int(n ** 0.5)+1):
        if n%i ==0:
            print("Not a prime number")
            return
    print("Prime Number")
n = int(input("Enter a number: "))
isprime(n)

# check palindrome:
string = input("Enter a string: ")
check = string[::-1]
if check == string:
    print("Its a palindrome")
else:
    print("Not a palindrome")

# remove duplicates and sort:
def sec_largest(num):
    removed = list(set(num))
    removed.sort()
    if len(removed)>=2:
        print("SECOND LARGEST: ",removed[-2])
    else:
        print("Not enough numbers")

num = []
while True:
    n = input("ENTER NUMBERS: ")
    if n =='':
        break
    num.append(int(n))
sec_largest(num)

# #CLASS:
class Person:
    def __init__(self,name,age):
        self.name = name
        self.age = age
    def display(self):
        print(f"NAME : {self.name}, AGE : {self.age}")

class Employee(Person):
    def __init__(self,name,age,employee_id,employee_dept):
        super().__init__(name,age)
        self.employee_id = employee_id
        self.employee_dept = employee_dept

    def display(self):
        print(f"Name: {self.name}, Age: {self.age}, Employee ID: {self.employee_id}, Department: {self.employee_dept}")

e = Employee('John',55,105,'HR')
e.display()

# CAR VEHICLE
class Vehicle:
    def drive(self):
        print("Hello from Vehicle")
class Car(Vehicle):
    def drive(self):
        print("Hello from car")

v = Vehicle()
v.drive()
c = Car()
c.drive()

#   STUDENT DETAILS:
import  pandas as pd

df = pd.read_csv("students.csv")

df['Age'] = pd.to_numeric(df['Age'],errors="coerce")
avg_age = df['Age'].mean()
df['Age'] = df['Age'].fillna(avg_age)

df['Score'] = pd.to_numeric(df['Score'],errors="coerce")
df['Score']= df['Score'].fillna(0)

df.to_csv("students_cleaned.csv",index = False)

 # INTO JSON:
df = pd.read_csv("students_cleaned.csv")
df.to_json("students.json",indent = 4)

#CLEANING AND TRANSFORMATION:
import pandas as pd
import  numpy as np
df = pd.read_csv("students_cleaned.csv")

def get_status(score):
    if score>=85:
        return 'Distinction'
    elif score >= 60:
        return 'Passed'
    else:
        return 'Failed'
df['Status'] = df["Score"].apply(get_status)

df['Tax_ID'] = df["ID"].apply(lambda x: f"TAX - {x}")

df.to_csv("students_cleaned.csv",index = False)

# READ AND WRITE ON JSON:
import json

with open("products.json","r") as f:
    products = json.load(f)

for item in products:
    item["price"] = item["price"]*1.10

with open("products_updated.json","w") as f:
    json.dump(products,f , indent=4)