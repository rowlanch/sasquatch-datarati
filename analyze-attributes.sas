
/*******************
* This program explores the 500 Cities
* and Medicare datasets to gain insight
* into model estimation
*******************/


ods rtf file='measures.rtf';

proc sql;
select distinct category, measure, measureid, data_value_unit from project.cities2016;
quit;

ods rtf close;

ods rtf file='provider_types.rtf';

proc sql;
*select distinct provider_type from project.MedicareAgg2014;
select provider_type, c from (
select provider_type, count(*) as c
from medall
group by provider_type
)
order by c desc;
quit;

ods rtf close;


proc sql;
*select distinct data_value_type from project.cities2016;
select distinct category, measure, measureid, data_value_unit from project.cities2016;
run;

proc sql;
select count(*)
from (
	select distinct cityname, stateabbr from project.cities2016 where year eq 2014
);
quit;
