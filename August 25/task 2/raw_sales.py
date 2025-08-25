import csv

def create_raw_sales():
    data = [
        ["Date", "Customer", "Amount"],
        ["2025-08-01", "Alice", 200],
        ["2025-08-02", "Bob", 150],
        [None, "Charlie", None],
        ["2025-08-04", None, 300],
        ["2025-08-05", "Esha", 400],
    ]

    with open("raw_sales_data.csv", "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerows(data)

    print("Raw sales data CSV created: raw_sales_data.csv")

if __name__ == "__main__":
    create_raw_sales()
