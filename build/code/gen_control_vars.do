clear all
set more off,permanently

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

//state level covariates
use "$build\temp\mex_census_90_95_00.dta",clear 
keep if (age>=17 & age<=47 & year==1990) | (age>=22 & age<=52 & year==1995)/*
	*/ | (age>=27 & age<=57 & year==2000)

*% of employment among women
preserve
collapse (mean) employed_female_lag=employed if female==1 [aweight=perwt],/*
	*/by(geo1_mx year)
tempfile tmp
save "`tmp'"
restore

collapse (mean) secondary_school_plus_lag=secondary_school_plus /*
	*/urban_dummy_lag=urban_dummy /*
	*/homeowner_lag=homeowner [aweight=perwt],by(geo1_mx year)

merge 1:1 geo1_mx year using "`tmp'"
drop _merge
rename geo1_mx state
replace year=year+5
drop if year==2005

label variable employed_female_lag "% of women employed (t-5)"
label variable secondary_school_plus_lag /*
	*/"% with secondary school or more (t-5)"
label variable urban_dummy_lag "% living in urban area"
label variable homeowner_lag "% homeowners"

save "$build\output\control_vars_state.dta",replace

use "$build\output\control_vars_state.dta",clear
keep if year==1995
drop year

save "$build\output\control_vars_state1990.dta"


//municipality level covariates
//state level covariates
use "$build\temp\mex_census_90_95_00.dta",clear 
keep if (age>=17 & age<=47 & year==1990) | (age>=22 & age<=52 & year==1995)/*
	*/ | (age>=27 & age<=57 & year==2000)

*% of employment among women
preserve
collapse (mean) employed_female_lag=employed if female==1 [aweight=perwt],/*
	*/by(geo2_mx year)
tempfile tmp
save "`tmp'"
restore

collapse (mean) secondary_school_plus_lag=secondary_school_plus /*
	*/urban_dummy_lag=urban_dummy /*
	*/homeowner_lag=homeowner [aweight=perwt],by(geo2_mx year)

merge 1:1 geo2_mx year using "`tmp'"
drop _merge
rename geo2_mx munic
replace year=year+5
drop if year==2005

label variable employed_female_lag "% of women employed (t-5)"
label variable secondary_school_plus_lag /*
	*/"% with secondary school or more (t-5)"
label variable urban_dummy_lag "% living in urban area (t-5)"
label variable homeowner_lag "% homeowners (t-5)"

save "$build\output\control_vars_munic.dta",replace

use "$build\output\control_vars_munic.dta",clear
keep if year==1995
drop year

save "$build\output\control_vars_munic1990.dta",replace
