
filename cities 'C:\sasquatch-data\500Cities.zip';
filename med2012 'C:\sasquatch-data\Medicare-Physician-and-Other-Supplier-NPI-Aggregate-CY2012.csv';
filename med2013 'C:\sasquatch-data\Medicare_Physician_and_Other_Supplier_NPI_Aggregate_CY2013.csv';
filename med2014 'C:\sasquatch-data\Medicare_Physician_and_Other_Supplier_NPI_Aggregate_CY2014.zip';
filename med2015 'C:\sasquatch-data\Medicare_Physician_and_Other_Supplier_NPI_Aggregate_CY2015.zip';
filename med2016 'C:\sasquatch-data\Medicare-Physician-and-Other-Supplier-NPI-Aggregate_CY2016.zip';

/*----------------------------------------*/
/*		Start download 500 Cities   	  */
/*----------------------------------------*/

proc http  
	url="https://s3.amazonaws.com/sasquatch-data/500cities.zip"
	method="get"
	out=cities;

/*----------------------------------------*/
/*		Start download Medicare 2012	  */
/*----------------------------------------*/

proc http 
	url="https://s3.amazonaws.com/sasquatch-data/Medicare-Physician-and-Other-Supplier-NPI-Aggregate-CY2012.csv" 
	method="get"
	out=med2012;
	
/*----------------------------------------*/
/*		Start download Medicare 2013	  */
/*----------------------------------------*/

proc http 
	url="https://s3.amazonaws.com/sasquatch-data/Medicare-Physician-and-Other-Supplier-NPI-Aggregate-CY2013.csv" 
	method="get"
	out=med2013;

/*----------------------------------------*/
/*		Start download Medicare 2014	  */
/*----------------------------------------*/

proc http 
	url="https://s3.amazonaws.com/sasquatch-data/Medicare_Physician_and_Other_Supplier_NPI_Aggregate_CY2014.zip" 
	method="get"
	out=med2014;

/*----------------------------------------*/
/*		Start download Medicare 2015	  */
/*----------------------------------------*/

proc http 
	url="https://s3.amazonaws.com/sasquatch-data/Medicare_Physician_and_Other_Supplier_NPI_Aggregate_CY2015.zip" 
	method="get"
	out=med2015;

/*----------------------------------------*/
/*		Start download Medicare 2016	  */
/*----------------------------------------*/
proc http 
	url="https://s3.amazonaws.com/sasquatch-data/Medicare-Physician-and-Other-Supplier-NPI-Aggregate_CY2016.zip"
	method="get"
	out=med2016;

/*----------------------------------------*/
/*		End download                      */
/*----------------------------------------*/

run;

