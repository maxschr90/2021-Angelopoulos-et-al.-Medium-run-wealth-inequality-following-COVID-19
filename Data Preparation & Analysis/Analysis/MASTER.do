/*****************************************************************************************
* MASTER FILE
*****************************************************************************************/
clear 
cls

** change current file location
cd 

** create global variable referring to your analysis folder
global analysis "C:\Users\maxsc\Documents\GitHub\Medium-run wealth inequality following COVID-19 (Angelopoulos et al. 2021)\Data Preparation & Analysis\Analysis"


** Execute DO-Files

** This do-file merges all separate waves of the UnSoc data
do "$analysis\Generate_Panel"

** This do-file cleans the data
do "$analysis\Data_Cleaning"

** This do-file performs the analysis
do "$analysis\Data_Analysis"

