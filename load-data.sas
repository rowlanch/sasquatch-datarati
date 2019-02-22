/******************************************
* This program will download and load data 
* from Medicare and 500 Cities
*----------------------------------------*/

resetline;
options noxwait;
/*
* Change directory and create lib folder ;
x 'cd C:\sasquatch-data\sas';
x 'mkdir C:\sasquatch-data\lib';
run;

* create project library ;
libname project 'C:\sasquatch-data\lib';
run;

%INCLUDE "download-data.sas";

*/

/*---------------------------------------*
*		Start load Medicare 2013		  
*----------------------------------------*/
%INCLUDE "load-medicare-cy2013-agg.sas";


/*---------------------------------------*
*		Start load Medicare 2014		  
*----------------------------------------*/
%INCLUDE "load-medicare-cy2014-agg.sas";

/*---------------------------------------
*		Start load Medicare 2015		
*----------------------------------------*/
%INCLUDE "load-medicare-cy2015-agg.sas";

/*---------------------------------------
*		Start load Medicare 2016		
*----------------------------------------*/
%INCLUDE "load-medicare-cy2016-agg.sas";


/*----------------------------------------
*		Start load 500 Cities           
*----------------------------------------*/

proc delete data=project.Cities2016; run;
%INCLUDE "load-500cities-2016.sas";

proc delete data=project.Cities2018; run;
%INCLUDE "load-500cities-2018.sas";

/*----------------------------------------
*		End load data
*----------------------------------------*/

run;

