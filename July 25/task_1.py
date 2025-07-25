# STRING
movie = "The Lion King"
print(movie[4:8])

# LISTS
food = []
n = 4
for i in range (n):
    val = input("ENTER FOOD: ")
    food.append(val)

food.append(input("ENTER ANOTHER FOOD"))
print(food)
food.pop(1)
for foods in food:
    print(foods)

# TUPLE
names = ("haritha","haries","hari")
print(names[2])

# FizzBuzz Challenge
for i in range(1,51):
    if (i%5) ==0 and (i%3)==0:
        print("FizzBuzz")
    elif (i % 3) == 0:
        print("Fizz")
    elif (i % 5) == 0:
        print("Buzz")
    else:
        print(i)

#  LOGIN SIMULATION
attempts = 0
username = "admin"
password = "admin/1234"
while attempts<3 :
    user = input("enter user name: ")
    pwd = input("enter password: ")
    if user == username and pwd == password:
        print("LOGIN SUCCESSFUL!")
        break
    else:
        print("TRY AGAIN!")
        attempts+=1

if attempts == 3:
    print("ACCOUNT LOCKED")

# PALINDROME CHECKER:
palindrome = input("Enter a string: ")
if palindrome == palindrome[::-1]:
    print("IT IS A PALINDROME")
else:
    print("NOT A PALINDROME")

#  PRIME NUMBER CHECK:
n = int(input("ENTER RANGE: "))
for num in range(2,n):
    for i in range(2, int(num**0.5)+1):
        if num % i == 0:
            break
    else:
        print(num,end =" ")

# STAR PYRAMID:
n = int(input("ENTER NUMBER: "))
for i in range(1,n+1):
    for j in range(i):
        if j<i:
            print("*", end ="")
    print()

# SUM OF DIGITS:
num = int(input("ENTER NUMBER: "))
sum =0
while num >0:
    rem =num%10
    sum+=rem
    num//=10
print(sum)

# MULTIPLICATION TABLE :
num = int(input("ENTER A NUMBER: "))
end = 10
for i in range(1,end+1):
    print(f"{num} x {i} = {num*i} ")

# NO OF VOWELS:
string = input("ENTER A STRING: ")
count =0
vowels = "aeiouAEIOU"
for i in string:
    if i in vowels:
        count+=1
print(f"NO OF VOWELS = {count}")
