
* proc datasets library=WORK kill; run; quit;


/*

TODO: need to clean up city names:

BOISE CITY -> BOISE
SAN BUENAVENTURA (VENTURA) -> VENTURA
proc sql;
select distinct city, state from med2014Summary where city like 'BOISE%' or city like '%VENTURA%';
*select count(distinct cityname) from project.cities2016 where year = 2014;
*select city, state from cities2014 c
where not exists (
	select city, state
	from med2014Summary m
	where c.city = m.city and c.state = m.state
);
quit;

*/

/*************
* Create 500 Cities dataset with 2014 data
*************/

proc delete data=cities; run;
data cities;
	set project.cities2016(
		keep = year stateabbr cityname population2010 measureid DataValueTypeID data_value 
		rename=(stateabbr=state cityname=city)
		where=(DataValueTypeID='AgeAdjPrv' and year=2014)
	);
	*project.cities2018(
		keep = year stateabbr cityname populationCount measureid DataValueTypeID data_value 
		rename=(stateabbr=state cityname=city populationCount=population2010)
		where=(DataValueTypeID='AgeAdjPrv')
	);
	state=upcase(state);
	city=upcase(city);
run;

/* proc sql; select distinct year from cities; */

/*************
* Pivot measures from rows to columns
*************/
proc sort data=cities; by year city state;
proc transpose data=cities out=cities(drop=_name_);
	by notsorted year notsorted state notsorted city notsorted population2010;
	var data_value;
	id measureid;
run;

proc sql noprint;
select count(*) into :count from (
select distinct city, state from cities
);
quit;
%put &count;


/*************
* Create Medicare dataset with 2014 data
************
proc delete data=med2014; run;
data med2014;
	set project.MedicareAgg2014(
		keep = nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt 
		rename=(nppes_provider_city=city nppes_provider_state=state)
		year=2014
		
	)
	project.MedicareAgg2015(
		keep = nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt 
		rename=(nppes_provider_city=city nppes_provider_state=state)
		year=2015
		
	)
	project.MedicareAgg2016(
		keep = nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt 
		rename=(nppes_provider_city=city nppes_provider_state=state)
		where=(state not in ('CA', 'NC', 'NY', 'IL', 'TX'))	
		year=2016
	) 
	;
	* where=(state='CA') --> put this in set options above to filter by state ... ; 
	*year=2014 <<<<<<<<<<----  what?? ;
run;

*/
proc delete data=med2013; run;
data med2013;
	length city $ 50 state $ 2 provider_type $ 55 total_services 8 total_medicare_payment_amt 8 year 8;
	set project.MedicareAgg2013(
		keep = nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt 
		rename=(nppes_provider_city=city nppes_provider_state=state)
	);
	year=2013;
run;


proc delete data=med2014; run;
data med2014;
	length city $ 50 state $ 2 provider_type $ 55 total_services 8 total_medicare_payment_amt 8 year 8;
	set project.MedicareAgg2014(
		keep = nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt 
		rename=(nppes_provider_city=city nppes_provider_state=state)
	);
	year=2014;
run;

proc delete data=med2015; run;
data med2015;
	length city $ 50 state $ 2 provider_type $ 55 total_services 8 total_medicare_payment_amt 8 year 8;
	set project.MedicareAgg2015(
		keep = nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt 
		rename=(nppes_provider_city=city nppes_provider_state=state)	
	);
	year=2015;
run;

proc delete data=med2016; run;
data med2016;
	length city $ 50 state $ 2 provider_type $ 55 total_services 8 total_medicare_payment_amt 8 year 8;
	set project.MedicareAgg2016(
		keep = nppes_provider_city nppes_provider_state provider_type total_services total_medicare_payment_amt 
		rename=(nppes_provider_city=city nppes_provider_state=state)
	);
	year=2016;
run;

proc delete data=medAll;
data medAll;
set med2013 med2014 med2015 med2016;
run;

/*************
* Summarize Medicare data by year, city, and state
*************/

proc delete data=medSummary; run;
proc summary data=medAll nway ;
  class year city state; 
  var total_medicare_payment_amt total_services;
  where provider_type like 'Cardi%'; * -->  use this to filter by provider_type ... ;
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

proc print data=medcitiescombined(obs=100);
run;

proc delete data=split training test; run;

proc surveyselect 
	data=medCitiesCombined(where=(city not in ('NEW YORK', 'TAMPA', 'BIRMINGHAM', 'LOS ANGELES', 'BALTIMORE', 'CHICAGO', 'HONOLULU', 'DETROIT')))
	out=split samprate=.2 outall;
run;

data training test;
set split;
if selected = 1 then
output test;
else output training;
run;



/*
proc print data=training(obs=100);
run;
*/

/*
* Verify data after joining ... ;
proc sql;
select * from medCitiesCombined where city = 'ANTIOCH' and state = 'CA';
select * from cities where city = 'ANTIOCH' and state = 'CA';
select * from medSummary where city = 'ANTIOCH' and state = 'CA';
quit;
*/
/*
proc sql noprint;
select count(*) into :count from training;
quit;
%put &count;
*/
