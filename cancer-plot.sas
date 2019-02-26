
/*******************
* This program creates a plot of 
* total_services vs population and 
* the prevalance of cancer in the population
*******************/

ODS RTF FILE="plots.rtf";


proc delete data=c;
data c; set training;
lp2010=log10(population2010);
cancerpop=cancer*population2010;
run;


PROC SGPANEL DATA=c;
 PANELBY year;
 SCATTER X = population2010 Y = total_services;
 TITLE 'Total Services by 2010 Population';
RUN;

PROC SGPANEL DATA=c;
 PANELBY year;
 SCATTER X = cancerpop Y = total_services;
 TITLE 'Total Services by Cancer * 2010 Population';
RUN;

PROC SGPANEL DATA=c;
 PANELBY year;
 SCATTER X = cancer Y = total_services;
 TITLE 'Total Services by Cancer';
RUN;


ODS RTF CLOSE;

