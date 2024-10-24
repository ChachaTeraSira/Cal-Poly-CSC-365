CREATE TABLE AIRLINES_airlines (
    Id INT PRIMARY KEY,
    Airline VARCHAR(128),
    Abbreviation VARCHAR(64),
    Country VARCHAR(32)
);

CREATE TABLE AIRLINES_airports (
    City VARCHAR(128),
    AirportCode CHAR(3) PRIMARY KEY,
    AirportName VARCHAR(256),
    Country VARCHAR(32),
    CountryAbbrev VARCHAR(16)
);

CREATE TABLE AIRLINES_flights (
    Airline INT,
    FlightNo INT,
    SourceAirport CHAR(3),
    DestAirport CHAR (3),
    CONSTRAINT air_pair PRIMARY KEY (Airline, FlightNo),
    FOREIGN KEY (Airline) REFERENCES AIRLINES_airlines(Id),
    FOREIGN KEY (SourceAirport) REFERENCES AIRLINES_airports(AirportCode),
    FOREIGN KEY (DestAirport) REFERENCES AIRLINES_airports(AirportCode)
);