import pandas as pd

def process_sales():
    df_raw = pd.read_csv("raw_sales_data.csv")

    df_clean = df_raw.dropna()

    df_clean.columns = [col.lower() for col in df_clean.columns]

    df_clean["date"] = pd.to_datetime(df_clean["date"]).dt.strftime("%Y-%m-%d")

    df_clean.to_csv("clean_sales_data.csv", index=False)
    print("Cleaned sales data CSV created: clean_sales_data.csv")

if __name__ == "__main__":
    process_sales()
