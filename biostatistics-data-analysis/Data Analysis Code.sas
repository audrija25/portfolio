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
    GETNAMES=YES; /* Set to NO if the CSV does not have column headers */
RUN;
