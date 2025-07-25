print ("Hello World!")
name ="Hello" +  input ("Enter your name: ")
print(f"Hello {name}")

# INDEXING
print("name[0]:  "+ name[0])
print("name[-1]: " + name[-1])

# SLICING
print("0 to 5: "+ name[0:5])
print("haritha: "+ name[5:])

print("uppercase: "+ name.upper() )
print("lowercase:: "+ name.lower())
print("replace: "+ name.replace("Haritha","Unique"))
print(f"{name}")

import math

#LISTS
fruits = ["banana","apple","grapes","cherry","kiwi"]

# LOOPING
for fruit in fruits:
   print(fruit)

# ADDING
fruits.append("Orange")
print(fruits)

# REMOVING
fruits.remove("banana")
print(fruits)

# SLICING
print(fruits[:2])

# USER GIVEN
games = []
while True:
    val = input("enter data:")
    if val == '':
        break
    else:
        games.append(val)
print(games)

# TUPLE
colours = ("red","balck","blue")

# ACCESS
print(colours[0])

# SLICE
print(colours[1:2])

# CONDITIONAL LOOPS
marks = int(input("ENTER YOUR MARKS: "))
if marks>=90:
    print("GOOD")

elif marks>=50:
    print("AVERAGE")

else:
    print("FAIL")

count =1
while count <=5:
    print(count)
    count+=1

for i in range (5):
    print("Number: ", i)

for i in range(5,11):
    print("Number: ",i)

for i in range(11,20):
    if i == 15:
        continue
    if i == 19:
        break
    print(i)

def greeting():
    print("HELLOO!")
greeting()

def greet(name):
    print(f"HELLO {name}")
name = input("Enter name: ")
greet(name)

def mul(a,b):
    return a*b
result = mul(5,4)
print(f"5 x 4 = {result}")

def power(a,b =2):
    return a**b
result = power(5)
print(f"5 power 2 = {result}")
result1 = power(2,4)
print(f"2 power 4 = {result1} ")

name = "haritha"
print(f"length: {len(name)}")
print("type",type(name))

age = "12"
print(f"age + 5 = {int(age)+5}")

nums = [5,3,9]
print("sum: ",sum(nums))
print("max: ",max(nums))
print("min: ",min(nums))
print("sort",sorted(nums))

names = ["HARITHA","AMNININI","ZU"]
print("names sorted",sorted(names))

print(f"absolute: {abs(-99.6)}")
print(f"ROUNDED : {round(3.50)}")
print(f"ROUNDED : {round(3.78542,2)}")

print(math.pi)
import datetime as d
today = d.datetime.today()
date = d.datetime.today().date()
print(today)
print(date)
now = d.datetime.now()
print(now.strftime("%H:%M:%S"))

import mypackage.calc as m
import mypackage.string as s
print (f"ADD(4,5): {m.add(4,5)}")
print (f"SUB(4,5): {m.sub(4,5)}")
print (f"MUL(4,5): {m.mul(4,5)}")
print (f"DIV(4,5): {m.div(4,5)}")
print (f"EXP(4,5): {m.exp(4,5)}")
print("UPPER: ",s.whisper("name"))
print("LOWER: ",s.shout("name"))