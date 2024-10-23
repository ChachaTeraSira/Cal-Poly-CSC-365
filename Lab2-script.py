import pandas as pd
from datetime import datetime

def convert_date(date_str):
    try:
        # Remove single quotes if they exist
        date_str = date_str.replace("'", "").strip()
        # Convert the date to a datetime object
        date_obj = datetime.strptime(date_str, '%d-%b-%y')
        # Convert the datetime object to SQL date format (YYYY-MM-DD)
        return date_obj.strftime('%Y-%m-%d')
    except ValueError:
        # If there's an issue with date parsing, return the original value
        print("Date don't work")
        return date_str

def generate_insert_statements(csv_file, table_name, output_sql_file):
    # Read the CSV file into a DataFrame
    data = pd.read_csv(csv_file)


    # Convert date fields in the DataFrame, assuming the date column is named 'CheckIn'
    if 'CheckIn' in data.columns:
        data['CheckIn'] = data['CheckIn'].apply(convert_date)
    
    # Convert date fields in the DataFrame, assuming the date column is named 'CheckOut'
    if 'CheckOut' in data.columns:
        data['CheckOut'] = data['CheckOut'].apply(convert_date)
    
    # Open the output SQL file for writing
    with open(output_sql_file, 'w') as sql_file:
        # Iterate over each row in the DataFrame
        for index, row in data.iterrows():
            # Process the row to remove single quotes from string fields
            row = row.apply(lambda x: str(x).strip().replace("'", "") if isinstance(x, str) else x)

            #v2
            # Ensure string values are properly quoted for SQL
            #row_values = [f"'{val}'" if isinstance(val, str) else str(val) for val in row]

            # Create an insert statement without quotes around the column names
            #sql_insert = f"INSERT INTO {table_name} ({', '.join(data.columns)}) VALUES ({', '.join(row_values)});\n"

            #v1
            # Create an insert statement
            sql_insert = f"INSERT INTO {table_name} ({', '.join(data.columns)}) VALUES ({', '.join([repr(val) for val in row])});\n"
            
            #v3
            # Ensure string values are properly quoted for SQL
            # row_values = [f"'{val}'" if isinstance(val, str) else ('NULL' if pd.isnull(val) else str(val)) for val in row]

            # Remove quotation marks from column names and create the INSERT statement
            # sql_insert = f"INSERT INTO {table_name} ({', '.join(data.columns)}) VALUES ({', '.join(row_values)});\n"

            # Write the insert statement to the SQL file
            sql_file.write(sql_insert)
    
    print(f"SQL script {output_sql_file} generated successfully.")

# Example usage
csv_file = 'INN/Reservations.csv'  # Path to the CSV file
table_name = 'INN_reservations'    # Name of the table in the database
output_sql_file = 'INN/INN-build-Reservations.sql'  # Output SQL file

# Call the function to generate the script
generate_insert_statements(csv_file, table_name, output_sql_file)