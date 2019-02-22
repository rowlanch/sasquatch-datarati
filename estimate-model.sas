options mstored sasmstore=project;

*ODS RTF FILE='Three_Models.rtf';

/********
* Create 3 models
********/

proc delete data=outcomeModel behaviorModel prevModel outcomePred behaviorPred prevPred;
run;

title '500 Cities Outcomes Model';

proc delete data=outcometraining outcometest; run;

data outcometraining; set training;
total_services=sqrt(total_services);
run;

data outcometest; set test;
total_services=sqrt(total_services);
run;

proc reg data=outcometraining outest=outcomeModel; 
	totalServicesHat: model total_services = population2010 TEETHLOST ARTHRITIS CANCER KIDNEY COPD CASTHMA DIABETES PHLTH STROKE MHLTH CHD
	/ SELECTION = STEPWISE; /* SLENTRY=.15 SLSTAY=.10; /*noprint; */
run;

title '500 Cities Behaviors Model';

proc reg data=training outest=behaviorModel; 
	totalServicesHat: model total_services = population2010 SLEEP OBESITY BINGE CSMOKING LPA
	/ SELECTION = STEPWISE; /* SLENTRY=.15 SLSTAY=.10; /*noprint;  */
run;

title '500 Cities Prevention Model';

proc reg data=training outest=prevModel; 
	totalServicesHat: model total_services = population2010 ACCESS2 COLON_SCREEN MAMMOUSE COREM COREW PAPTEST DENTAL CHECKUP
	/ SELECTION = STEPWISE; /* SLENTRY=.15 SLSTAY=.10; /*noprint;  /* prevention sw: .5394 all: .5362 */
run;

/********
* Score 3 models
********/

proc score data=outcometest score=outcomeModel out=outcomePred type=parms nostd predict;
   var total_services population2010 TEETHLOST ARTHRITIS CANCER KIDNEY COPD CASTHMA DIABETES PHLTH STROKE MHLTH CHD;
run;

proc score data=test score=behaviorModel out=behaviorPred type=parms nostd predict;
   var total_services population2010  population2010 SLEEP OBESITY BINGE CSMOKING LPA;
run;

proc score data=test score=prevModel out=prevPred type=parms nostd predict;
   var total_services population2010 ACCESS2 COLON_SCREEN MAMMOUSE COREM COREW PAPTEST DENTAL CHECKUP;
run;


%mae_rmse_sql(outcomePred, total_services, totalServicesHat, '500 Cities Outcomes Model Error Calcs');
%put NOTE: mae=&mae rmse=&rmse;

%mae_rmse_sql(behaviorPred, total_services, totalServicesHat, '500 Cities Behavior Model Error Calcs');
%put NOTE: mae=&mae rmse=&rmse;

%mae_rmse_sql(prevPred, total_services, totalServicesHat, '500 Cities Prevention Model Error Calcs');
%put NOTE: mae=&mae rmse=&rmse;

*ODS RTF CLOSE;

title 'The SAS System';

quit;

/*
proc print data=outcomePred(obs=10); run;

proc sql;
select mean(errPercent) as meanErrPercent, min(errPercent) as minErrPercent, max(errPercent) as maxErrPercent 
from (
	select abs(total_services-totalServicesHat)/total_services as errPercent from outcomePred
);
quit;

*/
proc sql;
create table errPercent as
select year, city, state, 100*abs(total_services-totalServicesHat)/total_services as errPercent from outcomePred;
select * from errPercent order by errPercent desc;
quit;

ods rtf file='Err_Percent_Histogram.rtf';

proc univariate data=errPercent;
   histogram errPercent;
run;

ods rtf close;

title 'Test Data Descriptive Statistics for Actuals';
proc sql;
*select min(abs(err)), max(abs(err)), mean(err) from ( select city, state, total_services-totalserviceshat as err from outcomePred);
select 
mean(total_services) as mean, 
min(total_services) as min, 
max(total_services) as max, 
std(total_services) as std, 
range(total_services) as range
from test;
quit;



