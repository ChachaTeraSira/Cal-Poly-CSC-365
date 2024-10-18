import csv
import sys
import pandas as pd
from datetime import datetime
def convert_date_format(date_str):
    # Strip leading/trailing spaces and single quotes, then convert to datetime object
    cleaned_date_str = date_str.strip().strip("'")  # Remove spaces and quotes
    # Convert the cleaned date string into a datetime object
    date_obj = datetime.strptime(cleaned_date_str, '%d-%b-%Y')
    # Return the date in 'YYYY-MM-DD' format
    return date_obj.strftime('%Y-%m-%d')
def generate_sql_from_csv(csv_file, sql_file, table_name):
    # Open the CSV file
    with open(csv_file, 'r') as csvfile:
        csvreader = csv.reader(csvfile)
        # Extract the header to use as column names
        #data = pd.read_csv(csv_file)
        header = next(csvreader)  # Skipping the header in CSV file
        # Open the SQL file to write the generated SQL statements
        with open(sql_file, 'w') as sqlfile:
            # for index, row in data.iterrows():
            #     row = row.apply(lambda x: str(x).strip().replace("'", "") if isinstance(x, str) else x)
            #     sql_insert = f"INSERT INTO {table_name} ({', '.join(data.columns)}) VALUES ({', '.join([repr(val) for val in row])});\n"
            #     sql_file.write(sql_insert)
            # ===================
            # Start generating SQL Insert statements
            for row in csvreader:
                Code = row[0].strip()
                Room = row[1].strip()
                CheckIn = convert_date_format(row[2])  # Convert the date format
                CheckOut = convert_date_format(row[3])  # Convert the date format
                Rate = row[4].strip()
                LastName = row[5].strip()
                FirstName = row[6].strip()
                Adults = row[7].strip()
                Kids = row[8].strip()
                # Constructing the SQL Insert statement
                sql_insert_statement = (
                    f"INSERT INTO {table_name} (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) "
                    f"VALUES ({Code}, '{Room}', {CheckIn}, {CheckOut}, '{Rate}', {LastName}, {FirstName}, '{Adults}', {Kids});\n"
                )
                # Write the SQL insert statement into the file
                sqlfile.write(sql_insert_statement)
if __name__ == "__main__":
    # Check if correct number of arguments are provided
    if len(sys.argv) != 2:
        print("Usage: python script_name.py <csv_file_path>")
        sys.exit(1)
    # File paths
    csv_file = sys.argv[1] # Path to the CSV file provided as an argument
    # csv_file = 'BAKERY/receipts.csv'
    sql_file = 'INN-build-reservations.sql'    # Output SQL file
    table_name = 'INN_reservations'               # Your actual table name
    # Call the function to generate the SQL file
    generate_sql_from_csv(csv_file, sql_file, table_name)
    print(f"SQL script has been generated and saved to {sql_file}")