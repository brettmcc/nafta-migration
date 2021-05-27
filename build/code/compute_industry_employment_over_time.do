clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"

use if year==2000 using "$build\temp\mex_census_90_95_00.dta",clear

*keep just those of working age and employed
keep if age>=15 & age<=45 & empstat==1

gen labor_payments_ri = population*incearn

collapse (sum) employment=perwt (sum) labor_payments_ri, /*
	*/by(geo2_mx ind)

*compute lambda_ri
bysort geo2_mx: egen tot_labor_payments = total(labor_payments_ri)
gen lambda_ri = labor_payments_ri/tot_labor_payments
drop tot_labor_payments
	
gen year=2000	

save "$build\temp\premerge_rtc_muni00.dta",replace
	
append using "$build\temp\nafta_exposure_munic.dta"
replace year=1990 if year==.

sort geo2_mx year


*pick out the most textiles (non-clothing) dependent municipios
sort year isicr2  ind

preserve 
use "$build\output\intl_mig_rt_munic.dta",clear
keep year munic intl_mig_rt2
reshape wide intl_mig_rt2,i(munic) j(year)
tempfile tmp
save "`tmp'"
restore

rename geo2_mx munic
merge m:1 munic using "`tmp'"

bro if munic==484024046 & (isicr2==3211|isicr2==3213|isicr2==3231|/*
	*/ind==312|ind==313|ind==315)
