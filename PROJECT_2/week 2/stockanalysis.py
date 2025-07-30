import pandas as pd
import numpy as np

df = pd.read_csv('stockmovements.csv')

df['supplier_id'] = df['supplier_id'].fillna(203)

df['quantity'] = pd.to_numeric(df['quantity'],errors='coerce').fillna(0)

df['movement_type'] = df['movement_type'].fillna('IN').str.upper().str.strip()

df['movement_date'] = df['movement_date'].fillna('2024-07-30')

# current stock level
df['adjusted_stock'] = np.where(df['movement_type']=='IN',df['quantity'],-df['quantity'])
df = df.sort_values(by=['product_id','movement_date'])
df['current_stock'] = df.groupby('product_id')['adjusted_stock'].cumsum()
stock_summary = df.groupby('product_id')['adjusted_stock'].sum()

df = df.drop(columns='adjusted_stock')
df.to_csv('stock_analysis.csv',index=False)
low_stock = stock_summary[stock_summary < 10].reset_index()
low_stock.columns = ['product_id','quantity']
print(low_stock)
low_stock.to_csv('low_stock_analysis.csv')

