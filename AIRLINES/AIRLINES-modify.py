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
        
        cursor.execute("""SELECT Id FROM AIRLINES_airlines WHERE Airline = 'Continental Airlines';""")
        Continental_id = cursor.fetchone()[0]

        cursor.execute("""SELECT Id FROM AIRLINES_airlines WHERE Airline = 'AirTran Airways';""")
        AirTran_id = cursor.fetchone()[0]

        cursor.execute("""SELECT Id FROM AIRLINES_airlines WHERE Airline = 'Virgin America';""")
        Virgin_id = cursor.fetchone()[0]

        print("Id's:",Continental_id,AirTran_id,Virgin_id)
        
        # 1.
        remove_non_AKI_flights = """
            DELETE FROM AIRLINES_flights
            WHERE SourceAirport != 'AKI' AND DestAirport != 'AKI';
        """
        cursor.execute(remove_non_AKI_flights)
        print(cursor.rowcount, "flights removed (not to/from AKI).")
        
        # 2.
        updated_flight_number = """
            UPDATE AIRLINES_flights
            SET FlightNo = FlightNo + 2000
            WHERE Airline != %s AND Airline != %s AND Airline != %s;
        """
        cursor.execute(updated_flight_number,(Continental_id,AirTran_id,Virgin_id))
        
        # 3.
#         flip_flight_number = """
#             UPDATE AIRLINES_flights trip1
#             JOIN AIRLINES_flights AS trip2 ON
#             trip1.SourceAirport = trip2.DestAirport
#             AND trip1.DestAirport = trip2.SourceAirport
#             AND ABS(trip1.FlightNo - trip2.FlightNo) = 1
#             SET trip1.FlightNo = trip1.FlightNo + MOD(trip1.FlightNo, 2) * 2 - 1,
#                 trip2.FlightNo = trip2.FlightNo + MOD(trip2.FlightNo, 2) * 2 - 1
#             WHERE (trip1.SourceAirport != 'AKI' AND trip1.DestAirport != 'AKI') AND
#                   (trip1.Airline != %s AND trip1.Airline != %s AND trip1.Airline != %s);
#         """
#         cursor.execute("""ALTER TABLE AIRLINES_flights DISABLE KEYS;""")
#         temp_even_flight_number = """
#             UPDATE AIRLINES_flights
#             SET FlightNo = FlightNo + 4
#             WHERE MOD(FlightNo, 2) = 0
#             AND (SourceAirport = 'AKI' OR DestAirport = 'AKI')
#             AND Airline != %s AND Airline != %s AND Airline != %s;
#         """
#         cursor.execute(temp_even_flight_number,(Continental_id,AirTran_id,Virgin_id))
        
#         odd_flight_number = """
#             UPDATE AIRLINES_flights
#             SET FlightNo = FlightNo - 1
#             WHERE MOD(FlightNo, 2) = 1
#             AND (SourceAirport = 'AKI' OR DestAirport = 'AKI')
#             AND Airline != %s AND Airline != %s AND Airline != %s;
#         """
#         cursor.execute(odd_flight_number,(Continental_id,AirTran_id,Virgin_id))
        
#         even_flight_number = """
#             UPDATE AIRLINES_flights
#             SET FlightNo = FlightNo - 2
#             WHERE MOD(FlightNo, 2) = 0
#             AND (SourceAirport = 'AKI' OR DestAirport = 'AKI')
#             AND Airline != %s AND Airline != %s AND Airline != %s;
#         """
#         cursor.execute(even_flight_number,(Continental_id,AirTran_id,Virgin_id))
        
#         cursor.execute("""ALTER TABLE AIRLINES_flights ENABLE KEYS;""")
        
        # 4.
        complete_corporate_takeover = """
            UPDATE AIRLINES_flights
            SET Airline = %s 
            WHERE Airline NOT IN (%s, %s) 
            AND (SourceAirport = 'AKI' OR DestAirport = 'AKI');
        """
        cursor.execute(complete_corporate_takeover, (Continental_id,AirTran_id,Virgin_id))
        print(cursor.rowcount,"flights updated to Continental.")
        # 5.
        cursor.execute("""
        SELECT * FROM AIRLINES_flights 
        ORDER BY Airline, FlightNo;""")
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