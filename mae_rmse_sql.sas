libname project 'C:\sasquatch-data\lib';
options mstored sasmstore=project;

/******************************************
* This macro calculates the Mean Absolute Error
* and the Root Mean Square Error of a dataset
* based on the parameters provided.
*----------------------------------------*/

%macro mae_rmse_sql(
        dataset /* Data set which contains the actual and predicted values */, 
        actual /* Variable which contains the actual or observed valued */, 
        predicted /* Variable which contains the predicted value */,
		sqlTitle
) / store source des='Calculate MAE and RMSE from scoring result';
%global mae rmse; /* Make the scope of the macro variables global */
title &sqlTitle; 
proc sql;
	select 
		mean(abs(&actual-&predicted)) format 20.10 as MAE,
		sqrt(mean((&actual-&predicted)**2)) format 20.10 as RMSE
	from 
		&dataset;

quit;
%mend;
