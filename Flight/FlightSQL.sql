use FlightPerformanceDB

Go 
CREATE TABLE DateDimension(
DateKey int not null IDENTITY,
FullDate date,
Day_Of_Week nvarchar(50),
Date_Month int,
Date_Quarter char(2),
Date_Year int,
CONSTRAINT pk_dateKey PRIMARY KEY (DateKey)
)


Go


CREATE TABLE AirlineDimension(
AirlineKey int not null IDENTITY,
Airline varchar(150),
CONSTRAINT pk_airlinekey PRIMARY KEY (AirlineKey)
)



CREATE TABLE  AircraftDimension(
AircraftKey int not null IDENTITY,
TailNumber varchar(200),
CONSTRAINT pk_aircraftkey PRIMARY KEY (AircraftKey)
)

Go


CREATE TABLE  ArrivalAirportDimension(
ArrivalAirportKey int not null IDENTITY,
ArrAiport varchar(200),
ArrCityName varchar(200),
CONSTRAINT pk_arrivalairportkey PRIMARY KEY (ArrivalAirportKey)
)
Go
--Create dimension for DepartureAirportDimension

CREATE TABLE  DepartureAirportDimension(
DepartureAirportKey int not null IDENTITY,
DepAiport varchar(200),
DepCityName varchar(200),
DepTimeLabel varchar(200),
CONSTRAINT pk_departureairportkey PRIMARY KEY (DepartureAirportKey)
)


Go

CREATE TABLE FlightPerformanceFact(
DateKey int,
DepartureAirportKey int,
ArrivalAirportKey int,
AircraftKey int,
AirlineKey int,
Cancelled int,
Diverted int,
DepDelayTag int,
DepDelay int,
ArrDelay int,
FlightDuration int,
DelayCarrier int,
DelayWeather int,
DelayNas int,
DelaySecurity int,
DelayLastAircraft int,
CONSTRAINT fk1_datekey FOREIGN KEY (DateKey) REFERENCES DateDimension(DateKey),
CONSTRAINT fk2_departureairportkey FOREIGN KEY (DepartureAirportKey) REFERENCES DepartureAirportDimension(DepartureAirportKey),
CONSTRAINT fk3_arrivalairportkey FOREIGN KEY (ArrivalAirportKey) REFERENCES ArrivalAirportDimension(ArrivalAirportKey),
CONSTRAINT fk4_aircraftkey FOREIGN KEY (AircraftKey) REFERENCES AircraftDimension(AircraftKey),
CONSTRAINT fk5_airlinekey FOREIGN KEY (AirlineKey) REFERENCES AirlineDimension(AirlineKey),
CONSTRAINT pk_factKey PRIMARY KEY (DateKey,DepartureAirportKey,ArrivalAirportKey,AircraftKey,AirlineKey)
);


