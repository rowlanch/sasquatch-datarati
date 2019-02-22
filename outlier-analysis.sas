ods graphics on;

/* Identify outliers ... */
proc reg data=training(where=(year=2014))
	plots(label)=(CooksD RStudentByLeverage DFFITS DFBETAS);
	id city state;
	model total_services = 
	population2010 
	/*SLEEP OBESITY BINGE CSMOKING LPA /* behavior */
	/*ACCESS2 COLON_SCREEN MAMMOUSE COREM COREW PAPTEST DENTAL CHECKUP /* prevention */
	TEETHLOST ARTHRITIS CANCER KIDNEY COPD CASTHMA DIABETES PHLTH STROKE MHLTH CHD /* outcomes */
	;
run;
ods graphics off;

quit;
