import pandas as pd

def generate_insert_statements(csv_file, table_name, output_sql_file):
    # Read the CSV file into a DataFrame
    data = pd.read_csv(csv_file)
    
    # Open the output SQL file for writing
    with open(output_sql_file, 'w') as sql_file:
        # Iterate over each row in the DataFrame
        for index, row in data.iterrows():
            # Process the row to remove single quotes from string fields
            row = row.apply(lambda x: str(x).replace("'", "") if isinstance(x, str) else x)

            # Create an insert statement
            sql_insert = f"INSERT INTO {table_name} ({', '.join(data.columns)}) VALUES ({', '.join([repr(val) for val in row])});\n"
            
            # Write the insert statement to the SQL file
            sql_file.write(sql_insert)
    
    print(f"SQL script {output_sql_file} generated successfully.")

# Example usage
csv_file = 'CSU/degrees.csv'  # Path to the CSV file
table_name = 'CSU_Degrees'    # Name of the table in the database
output_sql_file = 'CSU/CSU-build-degrees.sql'  # Output SQL file

# Call the function to generate the script
generate_insert_statements(csv_file, table_name, output_sql_file)