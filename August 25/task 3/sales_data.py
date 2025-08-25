import pandas as pd

raw_file = "raw_sales_data.csv"
processed_file = "processed_sales_data.csv"

df = pd.read_csv(raw_file)

df = df.drop_duplicates(subset=["order_id"])                
df["region"].fillna("Unknown", inplace=True)                
df["revenue"].fillna(0, inplace=True)                       
df["profit_margin"] = ((df["revenue"] - df["cost"]) /       
                       df["revenue"].replace(0, 1))

df["customer_segment"] = df["revenue"].apply(
    lambda r: "Platinum" if r > 100000 else "Gold" if r > 50000 else "Standard"
)

df.to_csv(processed_file, index=False)
print("Processed sales data saved to", processed_file)
