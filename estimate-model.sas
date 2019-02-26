options mstored sasmstore=project;

/******************************************
* This program builds three different regression
* models based on the three categores of 500 Cities
* Survey data.  It uses the PROC REG and its STEPWISE
* selection method to optimize the models.   The 
* models are scored using PROC score and then MAE
* and RMSE values are calculated to compare the three
* models.  Finally, it performs some analysis of the 
* error rates of the OUTCOME model.
*----------------------------------------*/

ODS RTF FILE='Three_Models_20190224.rtf';

/********
* Create datasets in the WORK lib to run the models against 
********/
proc delete data=training test; run;

data training; 
set project.training;
run;

data test; 
set project.test;
run;

/********
* Create 3 models based on 500 Cities measure categories using STEPWISE selection
********/

proc delete data=outcomeModel behaviorModel prevModel outcomePred behaviorPred prevPred;
run;

title '500 Cities Outcomes Model';

proc reg data=training outest=outcomeModel noprint; 
	totalServicesHat: model total_services = population2010 TEETHLOST ARTHRITIS CANCER KIDNEY COPD CASTHMA DIABETES PHLTH STROKE MHLTH CHD
	/ SELECTION = STEPWISE; /* SLENTRY=.15 SLSTAY=.10; /* noprint; */
run;


title '500 Cities Behaviors Model';

proc reg data=training outest=behaviorModel noprint;  
	totalServicesHat: model total_services = population2010 SLEEP OBESITY BINGE CSMOKING LPA
	/ SELECTION = STEPWISE; /* SLENTRY=.15 SLSTAY=.10; /* noprint;  */
run;

title '500 Cities Prevention Model';

proc reg data=training outest=prevModel noprint;  
	totalServicesHat: model total_services = population2010 ACCESS2 COLON_SCREEN MAMMOUSE COREM COREW PAPTEST DENTAL CHECKUP
	/ SELECTION = STEPWISE; /* SLENTRY=.15 SLSTAY=.10; /* noprint; */
run;

/********
* Score 3 models
********/

proc score data=test score=outcomeModel out=outcomePred type=parms nostd predict;
   var total_services population2010 TEETHLOST ARTHRITIS CANCER KIDNEY COPD CASTHMA DIABETES PHLTH STROKE MHLTH CHD;
run;

proc score data=test score=behaviorModel out=behaviorPred type=parms nostd predict;
   var total_services population2010  population2010 SLEEP OBESITY BINGE CSMOKING LPA;
run;

proc score data=test score=prevModel out=prevPred type=parms nostd predict;
   var total_services population2010 ACCESS2 COLON_SCREEN MAMMOUSE COREM COREW PAPTEST DENTAL CHECKUP;
run;

/********
* Calculate Mean Absolute Error and Root Mean Square Error
********/

%mae_rmse_sql(outcomePred, total_services, totalServicesHat, '500 Cities Outcomes Model Error Calcs');

%mae_rmse_sql(behaviorPred, total_services, totalServicesHat, '500 Cities Behavior Model Error Calcs');

%mae_rmse_sql(prevPred, total_services, totalServicesHat, '500 Cities Prevention Model Error Calcs');

* reset title ;
title 'The SAS System';


/**************
* Create table with the error percentages of the individual
* predicted results
**************/
proc sql noprint;
create table errPercent as
select year, city, state, population2010, 100*abs(total_services-totalServicesHat)/total_services as errPercent from outcomePred;
quit;


/**************
* Analyze the frequencies of the %error of predicted values
**************/
proc iml;
use errPercent;
read all var {errPercent} into x;
close errPercent;

cutpts = {.M 20 40 60 80 100 .I};
r = bin(x, cutpts);

call tabulate(BinNumber, Freq, r);
lbls = {"<20%", "20-40%", "40-60%", "60-80%", "80-100%", ">100%"};

title 'Frequency of Error% Values';
print Freq[colname=lbls];

title'The SAS System';

run;


ODS RTF CLOSE;


quit;

