import pandas as pd
import numpy as np
# Sample raw data (intentionally messy)
raw_data = {
    'EmpID': [201, 202, 203, 204, 205, 206],
    'Name': ['Aarav', 'Sanya', None, 'Karthik', 'Meera', None],  # Missing names
    'Age': [24, np.nan, 29, 22, 31, np.nan],                    # Missing ages
    'Department': ['Finance', 'Tech', 'HR', None, 'Marketing', None],  # Missing departments
    'Salary': ['52000', '73000', 'not available', '48000', '61000', None]  # Invalid and missing salary
}
df = pd.DataFrame(raw_data)
print("RAW DATA: \n",df)

# CLEANING

#FILLING MISSING NAMES TO UNKNOWN
df['Name'] = df['Name'].fillna('Unknown')

# FILLING MISSING DEPT
df['Name'] = df['Department'].fillna('Not Assigned')

#SALARY TO NUMERIC
df['Salary'] = pd.to_numeric(df['Salary'],errors='coerce')

# FILLING AGE AND SALARY
df['Age'] = df['Age'].fillna(df['Age'].mean())
df['Salary'] = df['Salary'].fillna(df['Salary'].mean())

print("\n CLEANED DATA: \n",df)