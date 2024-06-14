import pandas as pd
from sqlalchemy import create_engine

# URL dari file CSV
base_url = "https://raw.githubusercontent.com/graphql-compose/graphql-compose-examples/master/examples/northwind/data/csv"

# Daftar file CSV yang akan diunduh
csv_files = [
    "categories.csv",
    "customers.csv",
    "employee_territories.csv",
    "employees.csv",
    "order_details.csv",
    "orders.csv",
    "products.csv",
    "regions.csv",
    "shippers.csv",
    "suppliers.csv",
    "territories.csv"
]

# Informasi koneksi database
db_type = "postgresql"
user = "postgres"
password = "admin"
host = "localhost"
port = "5432"
dbname = "postgres"
schema = "project2rev"

# Membuat string koneksi
connection_string = f"{db_type}://{user}:{password}@{host}:{port}/{dbname}"
engine = create_engine(connection_string)

for file in csv_files:
    # Mengunduh file CSV
    file_url = f"{base_url}/{file}"
    df = pd.read_csv(file_url)

    # Mengubah nama file CSV menjadi nama tabel
    table_name = file.split(".")[0]

    # Menyimpan data ke dalam PostgreSQL
    df.to_sql(table_name, engine, schema=schema,
              if_exists='replace', index=False)
    print(
        f"Data from {file} has been imported into table {schema}.{table_name}")

print("All data has been imported successfully.")
