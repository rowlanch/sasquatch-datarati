
/*******************
* This program produces plots that analyze
* the observations that are outliers and/or
* exert leverage over the model.  Extreme
* prejudice was used in the removal of outliers
* so as to not overfit the model.
*******************/

*ods rtf file="outliers.rtf";
ods graphics on;

/* Identify outliers ... */
proc reg data=training(where=(year=2015))
	plots(label)=(CooksD RStudentByLeverage DFFITS DFBETAS);
	id city state;
	model total_services = 
	population2010 
	SLEEP OBESITY BINGE CSMOKING LPA /* behavior */
	ACCESS2 COLON_SCREEN MAMMOUSE COREM COREW PAPTEST DENTAL CHECKUP /* prevention */
	TEETHLOST ARTHRITIS CANCER KIDNEY COPD CASTHMA DIABETES PHLTH STROKE MHLTH CHD /* outcomes */
	;
run;
ods graphics off;
*ods rtf close;
quit;
