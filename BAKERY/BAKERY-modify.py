import mysql.connector
from mysql.connector import Error

with open('../account.info', 'r') as file: 
    # TODO: BEFORE SUBMITTING MAKE SURE TO CHANGE 'account.info to ../account.info'
    # using account.info just for testing
    
    lines = file.readlines()
    Login = lines[0].strip()
    Password = lines[1].strip()

try: 
    link = mysql.connector.connect(
        host = "mysql.labthreesixfive.com",
        port = "3306",
        database = "khgrewal",
        user = Login, # "khgrewal",
        password = Password # "K4e3UCVv5GFbpXs6"
    )

    if link.is_connected():
        print("Successfully connected to MySQL server")
        
        # DO YOU WANT US TO COMMIT THE CHANGES???  link.commit()
        cursor = link.cursor()
        # 1.
#         THE LAB SHEET SAYS LIST OF PASTRIES, BUT WE DON'T HAVE THAT TABLE, SHOULD WE DO IT ON GOODS TABLE?
#         cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")
#         items_less_than_5 = """
#         DELETE FROM BAKERY_goods
#         WHERE price < 5;
#         """
#         cursor.execute(items_less_than_5)
#         cursor.execute("SET FOREIGN_KEY_CHECKS = 1;")
        # 2.
        new_chocolate_price = """
        UPDATE BAKERY_goods
        SET Price = Price * 1.35
        WHERE Flavor = 'Chocolate';
        """
        cursor.execute(new_chocolate_price)
        # 3.
        new_lemon_price = """
        UPDATE BAKERY_goods
        SET Price = Price - 2
        WHERE Flavor = 'Lemon';
        """
        cursor.execute(new_lemon_price)
        # 4.
        new_cake_price = """
        UPDATE BAKERY_goods
        SET Price = Price - (Price * 0.1)
        WHERE Food = 'Cake' AND Flavor NOT IN ('Chocolate', 'Lemon');
        """
        cursor.execute(new_cake_price)
        # 5.
        least_expensive_cake = """
        SELECT MIN(Price)
        FROM BAKERY_goods
        WHERE Food = 'Cake';
        """
        cursor.execute(least_expensive_cake)
        least_expensive_cake = cursor.fetchone()[0]
        
        new_pie_price = """
        UPDATE BAKERY_goods
        SET Price = %s
        WHERE Food = 'Pie';
        """
        cursor.execute(new_pie_price,(least_expensive_cake,))

#        link.rollback()
        # 6.
        cursor.execute("""
        SELECT * FROM BAKERY_goods 
        ORDER BY Id;""")
        table = cursor.fetchall()
        for row in table:
            print(row)

except Error as e:
    print("MySQL Connection error:",e)
    
finally:
    if link.is_connected():
        cursor.close()
        link.close()
        print("MySQL connection closed.")