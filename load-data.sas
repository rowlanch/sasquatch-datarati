/******************************************
* This program will download and load data 
* from Medicare and 500 Cities to initialize 
* the library and raw data sets for the project.
*----------------------------------------*/

resetline;
options noxwait;

* Change directory and create lib folder ;
x 'cd C:\sasquatch-data\sas';
x 'mkdir C:\sasquatch-data\lib';
run;

* create project library ;
libname project 'C:\sasquatch-data\lib';
run;

/*---------------------------------------*
* Call program to download data files 
* staging area on from AWS S3
*----------------------------------------*/
%INCLUDE "download-data.sas";

/*---------------------------------------*
*		Start load Medicare 2012		  
*----------------------------------------*/
%INCLUDE "load-medicare-cy2012-agg.sas";

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

%INCLUDE "load-500cities-2016.sas";

%INCLUDE "load-500cities-2018.sas";

/*----------------------------------------
*		End load data
*----------------------------------------*/

run;

