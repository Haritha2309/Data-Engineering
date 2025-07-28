import pandas as pd

# FROM CSV
# df = pd.read_csv('employees.csv')
# print("CSV READ :\n",df)
#
# # TO CSV
# df.to_csv('updated_employees.csv',index = False)
# print("CSV WRITTEN TO UPDATED_EMPLOYEES")

# FROM JSON

import json

#READING
with open('data.json','r') as f:
    data = json.load(f)

print("JSON READ : \n",data)

with open('otuput.json','w') as f:
    json.dump(data, f, indent=5)

print("JSON WRITTEN TO OUTPUT.JSON")