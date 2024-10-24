import mysql.connector
from mysql.connector import Error

with open('../account.info', 'r') as file: 
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
        cursor.execute("""
            ALTER TABLE KATZENJAMMER_instruments
            MODIFY COLUMN Instrument VARCHAR(256);
            """)

        update_bass = """
            UPDATE KATZENJAMMER_instruments
            SET Instrument = 'awesome bass balalaika'
            Where Instrument = 'bass balalaika'
            """
        cursor.execute(update_bass)
    
        update_guitar = """
            UPDATE KATZENJAMMER_instruments
            SET Instrument = 'acoustic guitar'
            Where Instrument = 'guitar'
            """
        cursor.execute(update_guitar)
        
        # 2.
        filter_instruments = """
            DELETE FROM KATZENJAMMER_instruments
            WHERE Instrument != 'awesome bass balalaika'
            AND BandmateId != 3;
            """
        cursor.execute(filter_instruments)

        # link.rollback()
        # 3.
        cursor.execute("""
            SELECT * FROM KATZENJAMMER_instruments
            ORDER BY SongId, BandmateId;""")
        table = cursor.fetchall()
        for row in table:
            print(row)
            
        # 4.    
        cursor.execute("""
            ALTER TABLE KATZENJAMMER_album
            ADD COLUMN TotalSongs INT;
            """)
        # 5.
        update_album_table = """
            UPDATE KATZENJAMMER_album a
            SET a.TotalSongs = (
                SELECT COUNT(*)
                FROM KATZENJAMMER_tracklist t
                WHERE t.AlbumId = a.AId
            );
            """
        cursor.execute(update_album_table)
        # 6.
        cursor.execute("""
            SELECT * FROM KATZENJAMMER_album
            ORDER BY Year;""")
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