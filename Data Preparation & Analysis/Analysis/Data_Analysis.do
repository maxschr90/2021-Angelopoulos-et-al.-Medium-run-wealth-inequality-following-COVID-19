/*****************************************************************************************
* ANALYSIS OF HOUSEHOLD PANEL										 *
*****************************************************************************************/
clear 
cls

** change current file location
cd 

** create global variable referring to your data, analysis and output folders
global data "C:\Users\maxsc\Documents\GitHub\Medium-run wealth inequality following COVID-19 (Angelopoulos et al. 2021)\Data Preparation & Analysis\Data"
global analysis "C:\Users\maxsc\Documents\GitHub\Medium-run wealth inequality following COVID-19 (Angelopoulos et al. 2021)\Data Preparation & Analysis\Analysis"
global output "C:\Users\maxsc\Documents\GitHub\Medium-run wealth inequality following COVID-19 (Angelopoulos et al. 2021)\Data Preparation & Analysis\Outputs"

** Load Cleaned Data
use "$data\Use\HH_Panel.dta", clear

** set panel dimensions
xtset pidp wave

** Generate Observables
gen age = HH_age
gen age_sq = HH_age^2
gen age_qu = HH_age^3
tabulate intdaty_dv, generate(d_year)
replace sex =sex-1
gen d_sex = 1
replace d_sex =0 if sex==0
gen log_hhsize =log(hhsize)

** Generate Table I
egen temp = mean(HH_netincome)
gen yy = HH_netincome/temp
drop temp
tabstat yy, by(HH_class) save
tabstatmat C_1

qui: ineqdeco HH_netincome, by(HH_class)
mat C_2 =J(5,1,.)
mat C_2[1,1] = r(gini_1)
mat C_2[2,1] = r(gini_2)
mat C_2[3,1] = r(gini_3)
mat C_2[4,1] = r(gini_4)
mat C_2[5,1] = r(gini)
mat def C = [C_1, C_2]
mat rownames C = Professionals Intermediate Routine Inactive Total
mat colnames C = "Relative Mean Gross Income" "Gini Gross Income"

** Trim sample
drop if HH_netincome<=0
gen W = HH_netincome
egen pcth_W  = pctile(W) if W>0,  p(99.5) by(wave)
egen pctl_W  = pctile(W) if W>0,  p(0.5) by(wave)
drop if W   > pcth_W  
drop if W   < pctl_W		
drop pcth_W pctl_W
gen lw =log(HH_netincome)

** Run Mincerian Regression & Predict Residuals
reg lw i.HH_class i.d_sex c.age c.age_sq c.age_qu d_year* i.gor_dv  log_hhsize
predict res ,r
sort HH_class
by HH_class: egen mean_lw_h =mean(lw) 
gen wage_resid = (mean_lw_h+res)
drop if  wage_resid==.

** Assign within social class rankings
egen group_h = xtile(wage_resid ) , by(HH_class wave) p(30 (40) 70)
gsort HH_class -group_h, generate(panelid)
gen y = exp(wage_resid) 
egen temp = mean(y)
drop temp
tabstat y, by(panelid) save
tabstatmat wage_resid, nototal

** Estimate Transition Matrices
xttrans2 panelid if panelid[_n+1] !=. , matcell(Trans_Pre) prob
xttrans2 HH_class if HH_class[_n+1] !=. , matcell(Trans_Class) prob



** Save Outputs
putexcel set   "$output\ExogenousProcesses.xlsx", sheet("Earnings") modify
putexcel A1=matrix(wage_resid)
putexcel set   "$output\ExogenousProcesses.xlsx", sheet("Transition") modify
putexcel A1=matrix(Trans_Pre)
putexcel set   "$output\ExogenousProcesses.xlsx", sheet("Transition Class") modify
putexcel A1=matrix(Trans_Class)
putexcel set   "$output\Table_I.xlsx",modify
putexcel A1=matrix(C)
