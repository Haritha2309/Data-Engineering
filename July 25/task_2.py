# BMI CALCULATION:
import math
def bmi(weight,height):
    result = weight/math.pow(height,2)
    if result < 18.5:
        print("UNDERWEIGHT")
    elif result >= 18.5 and result <= 24.9:
        print("NORMAL WEIGHT")
    elif result >=25.0 and result <=29.9:
        print("OVER WEIGHT")
    else:
        print("OBESE")
weight = float(input("ENTER YOUR WEIGHT(IN KG): "))
height = float(input("ENTER YOUR HEIGHT(IN M): "))
bmi(weight,height)

#PASSWORD CHECK:
def pwd_check(password):
    upper = any(c.isupper() for c in password)
    digit = any(c.isdigit() for c in password)
    spl = any (c in "@!#$%&" for c in password)
    return upper and digit and spl

while True:
    password = input("ENTER A PASSWORD: ")
    if pwd_check(password):
        print("STRONG PASSWORD!")
        break
    else:
        print("TRY A STRONG PASSWORD")

# EXPENSE CALCULATOR:
n = 7
exp =[]
for i in range(n):
    exp.append(float(input("ENTER NUMBER: ")))

print(f"TOTAL SPENT: {sum(exp)}")
print(f"AVERAGE SPENT : {sum(exp)/n}")
print(f"HIGHEST SPENT: {max(exp)}")

#RANDOM NUMBER:
import random
secret = random.randint(1,50)
print(secret)
attempts = 5
for i in range(attempts):
    guess= int(input("GUESS A NUMBER: "))
    if guess == secret:
        print("CORRECT..")
        break
    elif guess > secret:
        print("TOO HIGH")
    else:
        print("TOO LOW")
    if i == attempts:
        print(f"5 CHANCES COMPLETED. THE NUMBER IS {secret}")

# STUDENT REPORT CARD:
import datetime
def grade(marks):
    total = sum(marks)
    avg = total/3
    print(f"AVERAGE: {avg}")
    if avg>=90:
        print("GRAde: A")
    elif avg>=70:
        print("GRAde: B")
    else:
        print("GRAde: C")
date = datetime.date.today()
print(date)
name = input("NETER YOUR NAME: ")
marks =[]
for i in range(3):
    marks.append(int(input("ENTER MARKS: ")))
grade(marks)

#CONTACTS:
contacts = {}
while True:
    print("MENU:")
    print("1. Add Contact")
    print("2. View Contacts")
    print("3. Save & Exit")
    choice = input("Enter your choice (1/2/3): ")
    if choice == "1":
        name = input("Enter name: ")
        phone = input("Enter phone number: ")
        contacts[name] = phone
        print(f"Contact '{name}' added.")
    elif choice == "2":
        if contacts:
            print("Saved Contacts:")
            for name, phone in contacts.items():
                print(f"{name} : {phone}")
        else:
            print("No contacts to display.")
    elif choice == "3":
        with open("contacts.txt", "w") as file:
            for name, phone in contacts.items():
                file.write(f"{name} : {phone}\n")
        print("Contacts saved to 'contacts.txt'. Goodbye!")
        break

    else:
        print("Invalid choice.")
