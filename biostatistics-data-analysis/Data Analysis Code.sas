proc printto log='/home/u64056990/BIOS 500H/Programs/takehomefinal.log' new; run;
/******************************
*
* take home final data analysis
*
******************************/

/*assigning librefs*/
libname shared "/home/u64056990/my_shared_file_links/jmonaco/Data";
libname mydata "/home/u64056990/BIOS 500H/Data";

/*transforming nc births csv to data*/
PROC IMPORT DATAFILE="/home/u64056990/my_shared_file_links/jmonaco/Data/2025 Final Exam NC births data12.csv"
    OUT=mydata.ncbirths
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

/*question 1*/
proc sort data=mydata.ncbirths out=birth;
    by smoke;
run;

PROC FORMAT;
    value $smoked  "S" ="Smoked(n=47)" "NS" ="Did Not Smoke(n=253)";
RUN;

PROC UNIVARIATE data= birth noprint;
    TITLE "Distribution of Birth Weight by Smoking Status of Mother (n=300)";
    label smoke="Smoking Status" weight="Weight at Birth (lbs)";
    format smoke $smoked.;
    class smoke;
    histogram weight /vscale=count vaxis=0 to 90 by 10 vminor=1
        vaxislabel="Number of Babies (Count)" endpoints=(0 to 12 by 1);
    inset n='# of Babies' mean="Mean Birth Weight" (5.1) std='S.D. Birth Weight' (5.1);
RUN;

title "Chi Squared Test for Low Birth Weight by Smoking Status";
proc freq data = mydata.ncbirths;
    tables smoke * lowbirthweight / riskdiff (equal var=null) alpha=0.05;
    exact riskdiff;
run;

/*question 2*/
data trial;
  input grp $ severe $ count;
  datalines;
IVM Y 52
IVM N 189
CON Y 43
CON N 206
;
run;

title "Chi Squared Test for Progression to Severe Disease by Treatment Group";
proc freq data=trial order=data;
  weight count;
  tables grp*severe / chisq measures cl;
run;

proc printto; run;