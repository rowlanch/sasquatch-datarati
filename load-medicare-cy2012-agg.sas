PROC IMPORT OUT= PROJECT.MEDICAREAGG2012 
            DATAFILE= "C:\sasquatch-data\Medicare-Physician-and-Other-Su
pplier-NPI-Aggregate-CY2012.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
