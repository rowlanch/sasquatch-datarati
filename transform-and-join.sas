/******************************************
* This program will clean, transform, and join
* datasets from Medicare and 500 Cities to prepare
* the raw data for model estimation.
*----------------------------------------*/

/*---------------------------------------*
* Delete the contents of the WORK library 
* to start fresh 
*----------------------------------------*/
/* proc datasets library=WORK kill; run; quit; */

/*************
* Create 500 Cities dataset with 2014 data
* Cleaning and transformation steps:
*  - Only include data records for the Age Adjusted Prevalence values
*  - Rename state and city variables to align with Medicare variable names
*  - Change state and city variables to UPPER CASE to align with Medicare variable names
*************/

proc delete data=cities; run;
data cities;
	set project.cities2016(
		keep = year stateabbr cityname population2010 measureid DataValueTypeID data_value 
		rename=(stateabbr=state cityname=city)
		where=(DataValueTypeID='AgeAdjPrv' and year=2014)
	);
	state=upcase(state);
	city=upcase(city);
run;

/*************
* Pivot measures key-value pairs from rows to columns
* to prepare measure values as independent variables
* in the model.
*************/
proc sort data=cities; by year city state;
proc transpose data=cities out=cities(drop=_name_);
	by notsorted year notsorted state notsorted city notsorted population2010;
	var data_value;
	id measureid;
run;


/*************
* Prepare Medicare 2012 data set
* Cleaning and transformation steps:
*  - Change data type of total_services and total_medicare_payment_amt from character to numeric
*  - Exclude variables that are not pertinent to the model
*  - Keep only city, state, provider_type, total_services, total_medicare_payment_amt
*  - Set lengths of variables to standardize across Medicare data sets
*  - Create year variable
*************/
proc delete data=medicareAgg2012;
data medicareAgg2012;
set project.MedicareAgg2012;

total_services = input(number_of_services, comma14.);
total_medicare_payment_amt = input(total_medicare_payment_amount, comma14.);

keep nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt;
run;

proc delete data=med2012; run;
data med2012;
	length city $ 50 state $ 2 provider_type $ 55 total_services 8 total_medicare_payment_amt 8 year 8;
	set medicareAgg2012(
		rename=(nppes_provider_city=city nppes_provider_state=state)
	);
	year=2012;

run;

/*************
* Prepare Medicare 2013 data set
* Cleaning and transformation steps:
*  - Change data type of total_services and total_medicare_payment_amt from character to numeric
*  - Exclude variables that are not pertinent to the model
*  - Keep only city, state, provider_type, total_services, total_medicare_payment_amt
*  - Set lengths of variables to standardize across Medicare data sets
*  - Create year variable
*************/

proc delete data=medicareAgg2013;
data medicareAgg2013;

set project.MedicareAgg2013;

total_services = input(number_of_services, comma14.);
total_medicare_payment_amt = input(total_medicare_payment_amount, comma14.);

keep nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt;
run;

proc delete data=med2013; run;
data med2013;
	length city $ 50 state $ 2 provider_type $ 55 total_services 8 total_medicare_payment_amt 8 year 8;
	set medicareAgg2013(
		rename=(nppes_provider_city=city nppes_provider_state=state)
	);
	year=2013;

run;

/*************
* Prepare Medicare 2014 data set
* Cleaning and transformation steps:
*  - Exclude variables that are not pertinent to the model
*  - Keep only city, state, provider_type, total_services, total_medicare_payment_amt
*  - Set lengths of variables to standardize across Medicare data sets
*  - Create year variable
*************/

proc delete data=med2014; run;
data med2014;
	length city $ 50 state $ 2 provider_type $ 55 total_services 8 total_medicare_payment_amt 8 year 8;
	set project.MedicareAgg2014(
		keep = nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt 
		rename=(nppes_provider_city=city nppes_provider_state=state)
	);
	year=2014;
run;

/*************
* Prepare Medicare 2015 data set
* Cleaning and transformation steps:
*  - Exclude variables that are not pertinent to the model
*  - Keep only city, state, provider_type, total_services, total_medicare_payment_amt
*  - Set lengths of variables to standardize across Medicare data sets
*  - Create year variable
*************/

proc delete data=med2015; run;
data med2015;
	length city $ 50 state $ 2 provider_type $ 55 total_services 8 total_medicare_payment_amt 8 year 8;
	set project.MedicareAgg2015(
		keep = nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt 
		rename=(nppes_provider_city=city nppes_provider_state=state)	
	);
	year=2015;
run;

/*************
* Prepare Medicare 2016 data set
* Cleaning and transformation steps:
*  - Exclude variables that are not pertinent to the model
*  - Keep only city, state, provider_type, total_services, total_medicare_payment_amt
*  - Set lengths of variables to standardize across Medicare data sets
*  - Create year variable
*************/

proc delete data=med2016; run;
data med2016;
	length city $ 50 state $ 2 provider_type $ 55 total_services 8 total_medicare_payment_amt 8 year 8;
	set project.MedicareAgg2016(
		keep = nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt 
		rename=(nppes_provider_city=city nppes_provider_state=state)
	);
	year=2016;
run;


/*************
* Combine all 5 years of Medicare data
*************/

proc delete data=medAll;
data medAll;
set med2012 med2013 med2014 med2015 med2016;
run;

/*************
* Summarize Medicare data by year, city, and state 
*************/

proc delete data=medSummary; run;
proc summary data=medAll nway ;
  class year city state; 
  var total_medicare_payment_amt total_services;
  output out=medSummary sum=total_payment total_services;
run;

/*
* Verify summary data ;
proc sql;
*select distinct city from med2014 where state = 'SC';
select * from med2014Summary where city = 'CHARLESTON' and state = 'SC';
*select year, city, state, sum(total_medicare_payment_amt), sum(total_services)
from med2014
where city = 'CHARLESTON' and state = 'SC'
group by year, city, state;
run;
*/

/*************
* Join Cities and Medicare data
*************/

proc delete data=medCitiesCombined;
proc sort data=medSummary; by city state year;
proc sort data=cities; by city state year;

data medCitiesCombined;
merge medSummary (in=inmed) cities (in=incities);
by city state;
if inmed and incities; * keep only matched records;
run;

/*
* Verify data after joining ... ;
proc sql;
select * from medCitiesCombined where city = 'ANTIOCH' and state = 'CA';
select * from cities where city = 'ANTIOCH' and state = 'CA';
select * from medSummary where city = 'ANTIOCH' and state = 'CA';
quit;
*/


/*************
* Create training and test data sets by
* taking a randome sampling of 30% of the data
* for the test data set & exclude OUTLIER cities
* from both the training and test sets
*************/

proc delete data=split project.training project.test; run;

proc surveyselect noprint
	data=medCitiesCombined(
		where=(city not in (
			'NEW YORK', 'TAMPA', 'BIRMINGHAM', 'LOS ANGELES', 'BALTIMORE', 'CHICAGO', 'HONOLULU', 
			'DETROIT', 'O''FALLON','GREENSBORO','SAN DIEGO', 'PHOENIX', 'SAN JOSE', 'NEW ORLEANS'
			'SAN DIEGO'
	)))
	out=split samprate=.2 outall;
run;

data project.training project.test;
set split;
if selected = 1 then
output project.test;
else output project.training;
run;




