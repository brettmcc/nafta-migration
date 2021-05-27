clear all
set more off,permanently

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

/**********************************************************************
 * 		STATE LEVEL													 *
**********************************************************************/
/*10-year measures*/
use if age>=12 & age<=65 & year!=1995 /*
	*/using "$build\temp\mex_census_90_95_00.dta",clear 

gen labor_force = (empstat==1 |empstat==2)
gen manufacturing = .
replace manufacturing = 0 if empstat==1
replace manufacturing =1 if year==1990 & ind>31000 & ind<33000
replace manufacturing = 1 if year==2000 & ind>300 & ind<400

collapse (mean) lfp=labor_force pct_manufacturing=manufacturing /*
	*/ln_real_incearn [iweight=perwt],by(geo1_mx year)
	
reshape wide lfp pct_manufacturing ln_real_incearn, i(geo1_mx) j(year)
gen chg_lfp = lfp2000-lfp1990
gen chg_pct_manufacturing = pct_manufacturing2000-pct_manufacturing1990
gen chg_ln_real_incearn = ln_real_incearn2000-ln_real_incearn1990
	
rename geo1_mx state
keep state chg_lfp chg_pct_manufacturing chg_ln_real_incearn

save $build\temp\labor_mkt_state.dta,replace

/*5-year measures*/
use if age>=12 & age<=65 using "$build\temp\mex_census_90_95_00.dta",clear 

gen labor_force = (empstat==1 |empstat==2)
gen manufacturing = .
replace manufacturing = 0 if empstat==1
replace manufacturing =1 if year==1990 & ind>31000 & ind<33000
replace manufacturing = 1 if year==2000 & ind>300 & ind<400

collapse (mean) lfp=labor_force pct_manufacturing=manufacturing /*
	*/ln_real_incearn [iweight=perwt],by(geo1_mx year)
	
tsset geo1_mx year 
gen chg_lfp = lfp-l5.lfp
gen chg_pct_manufacturing = pct_manufacturing-l5.pct_manufacturing
gen chg_ln_real_incearn = ln_real_incearn-l5.ln_real_incearn

drop if year==1990
rename geo1_mx state

save $build\temp\labor_mkt_state5yr.dta,replace

/**********************************************************************
 * 		MUNICIPALITY LEVEL											 *
**********************************************************************/
/*10-year measures*/
use if age>=12 & age<=65 & year!=1995 using "$build\temp\mex_census_90_95_00.dta",clear 

gen labor_force = (empstat==1 |empstat==2)
gen manufacturing = .
replace manufacturing = 0 if empstat==1
replace manufacturing =1 if year==1990 & ind>31000 & ind<33000
replace manufacturing = 1 if year==2000 & ind>300 & ind<400

collapse (mean) lfp=labor_force pct_manufacturing=manufacturing /*
	*/ln_real_incearn [iweight=perwt],by(geo2_mx year)
	
reshape wide lfp pct_manufacturing ln_real_incearn, i(geo2_mx) j(year)
gen chg_lfp = lfp2000-lfp1990
gen chg_pct_manufacturing = pct_manufacturing2000-pct_manufacturing1990
gen chg_ln_real_incearn = ln_real_incearn2000-ln_real_incearn1990

rename geo2_mx munic
keep munic chg_lfp chg_pct_manufacturing chg_ln_real_incearn

save $build\temp\labor_mkt_munic.dta,replace


/*5-year measures*/
use if age>=12 & age<=65 using "$build\temp\mex_census_90_95_00.dta",clear 

gen labor_force = (empstat==1 |empstat==2)
gen manufacturing = .
replace manufacturing = 0 if empstat==1
replace manufacturing =1 if year==1990 & ind>31000 & ind<33000
replace manufacturing = 1 if year==2000 & ind>300 & ind<400

collapse (mean) lfp=labor_force pct_manufacturing=manufacturing /*
	*/ln_real_incearn [iweight=perwt],by(geo2_mx year)
	
tsset geo2_mx year 
gen chg_lfp = lfp-l5.lfp
gen chg_pct_manufacturing = pct_manufacturing-l5.pct_manufacturing
gen chg_ln_real_incearn = ln_real_incearn-l5.ln_real_incearn

drop if year==1990
rename geo2_mx munic

save $build\temp\labor_mkt_munic5yr.dta,replace

