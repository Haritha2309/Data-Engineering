import pandas as pd

data = [
    {"order_id": 1, "customer": "Alice", "region": "East", "revenue": 120000, "cost": 80000},
    {"order_id": 2, "customer": "Bob", "region": "West", "revenue": 60000, "cost": 40000},
    {"order_id": 3, "customer": "Charlie", "region": None, "revenue": None, "cost": 20000},
    {"order_id": 4, "customer": "David", "region": "South", "revenue": 40000, "cost": 25000},
    {"order_id": 2, "customer": "Bob", "region": "West", "revenue": 60000, "cost": 40000},  
]

df = pd.DataFrame(data)
df.to_csv("raw_sales_data.csv", index=False)
print("raw_sales_data.csv created")
