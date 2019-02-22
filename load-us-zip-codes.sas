PROC IMPORT OUT= PROJECT.uszipcodes 
     DATAFILE= "C:\sasquatch-data\uszips.csv" 
     DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
	 GUESSINGROWS=10000;
RUN;
