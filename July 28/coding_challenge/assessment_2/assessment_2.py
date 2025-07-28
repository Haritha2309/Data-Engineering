# FACTORIAL:
def factorial(n):
    result = 1
    for i in range(2,n+1):
        result*= i
    return result

n = int(input("ENTER NUMBER: "))
factorial(n)

# LISTS
students = [("Aarav", 80), ("Sanya", 65), ("Meera", 92), ("Rohan", 55)]
above75 =[]
print("students above 75")
for name,score in students:
    if score>75:
        above75.append(name)
print(above75)
scores =[]
for name,score in students:
    scores.append(score)
avg_score = sum(scores)/len(scores)
print(f"AVERAGE : {avg_score}")

# BANK ACC:
class BankAccount:
    def __init__(self,name,balance):
        self.name = name
        self.balance = balance
    def deposit(self,amt):
        self.balance += amt
        print(f"AMOUNT DEPOSITED.. AVAILABLE BALANCE {self.balance}")

    def withdraw(self,amt):
        if amt>self.balance:
            print("NO SUFFICIENT BALANCE")
        self.balance -=amt
        print(f"AVAILABLE BALANCE : {self.balance}")

# SAVINGS ACCOUNT:
class SavingsAccount(BankAccount):
    def __init__(self,name,balance,interest_rate):
        super().__init__(name,balance)
        self.interest_rate = interest_rate

    def apply_interest(self):
        interest = self.balance * (self.interest_rate /100)
        self.balance += interest
        print(f"AFTER APPLYING INTEREST.. BALANCE : {self.balance}")

acc = SavingsAccount('Arav',1000,0.5)
acc.apply_interest()

# ORDERS CLEANING:
import pandas as pd
df = pd.read_csv("orders.csv")

df["CustomerName"] = df["CustomerName"].fillna("Unknown")

df["Quantity"] = pd.to_numeric(df["Quantity"],errors="coerce")
df['Quantity'] = df['Quantity'].fillna(0)

df["Price"] = pd.to_numeric(df["Price"], errors="coerce")
df['Price'] = df['Price'].fillna(0)

df["TotalAmount"] = df["Quantity"] * df["Price"]

df.to_csv("orders_cleaned.csv",index = False)

# DATA MANIPULATION:
import json

with open("inventory.json","r") as f:
    data = json.load(f)

for item in data:
    item["Status"] = "In Stock" if item["stock"] >0 else "Out of Stock"

with open("inventory_updated.json","w") as f:
    json.dump(data,f,indent = 4)

# ENRICHMENT WITH NUMPY
import numpy as np
import  pandas as pd

scores = np.random.randint(35,101,size = 20)

above_75 = np.sum(scores>75)
mean = np.mean(scores)
std_dev = np.std(scores)

print("Scores:", scores)
print("Students scoring above 75:", above_75)
print("Mean:", mean)
print("Standard Deviation:", std_dev)

df = pd.DataFrame(scores)
df.to_csv("scores.csv",index = False)
