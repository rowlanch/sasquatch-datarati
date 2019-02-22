PROC IMPORT OUT= PROJECT.MEDICAREAGG2013 
            DATAFILE= "C:\sasquatch-data\Medicare-Physician-and-Other-Su
pplier-NPI-Aggregate-CY2013.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
