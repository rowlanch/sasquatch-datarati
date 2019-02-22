PROC IMPORT OUT= PROJECT.MEASURES 
            DATAFILE= "C:\sasquatch-data\500CitiesMeasures.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
