clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"

/*STATE LEVEL*/

/*Calculate lambda_ri, share of region r's labor force employed in */
/*industry i.													   */

use if year==1990 using "$build\temp\mex_census_90_95_00.dta",clear

*keep just those of working age and employed
keep if age>=15 & age<=45 & empstat==1

gen labor_payments_ri = population*incearn

collapse (sum) labor_payments_ri, by(industry_group geo1_mx)
bysort geo1_mx: egen labor_payments_r = total(labor_payments) 
gen lambda_ri = labor_payments_ri/labor_payments_r

*merge with non-labor cost share (theta_i)
merge m:1 industry_group using "$build\temp\theta_i.dta"
drop _merge

gen lambda_divided_theta = lambda_ri/theta_i

*denominator for beta_ri
bysort geo1_mx: egen sum_lambda_div_theta = total(lambda_divided_theta) /*
	*/if industry_group!=.
gen beta_ri = (lambda_ri/theta_i)/sum_lambda_div_theta

save "$build\temp\nafta_exposure.dta",replace 

*merge with Mexican import tariffs on US goods
merge m:1 industry_group using "$build\temp\tariffs_by_ind_mex.dta"
drop _merge //unmerged obs are the non-traded sector
*merge with US import tariffs on Mexican goods
merge m:1 industry_group using "$build\temp\tariffs_by_ind_us.dta"
drop _merge


*MEXICO tariffs on US goods, 2000 and 2005
gen beta_times_lntariffchg_mex05 = beta_ri*ln_tariff_rate_chg_mex91to05
bysort geo1_mx: egen RTC_mex05 = total(beta_times_lntariffchg_mex05) /*
	*/if industry_group!=.

gen beta_times_lntariffchg_mex00 = beta_ri*ln_tariff_rate_chg_mex91to00
bysort geo1_mx: egen RTC_mex00 = total(beta_times_lntariffchg_mex00) /*
	*/if industry_group!=.
 
*US tariffs on MEXICAN goods, 2000
gen beta_times_lntariffchg_us00 = beta_ri*ln_tariff_rate_chg_us10yrdiff
bysort geo1_mx: egen RTC_us00 = total(beta_times_lntariffchg_us00) /*
	*/if industry_group!=.
  
collapse (max) RTC_mex00 RTC_mex05 RTC_us00 labor_payments_r, by(geo1_mx)
drop if geo1_mx==.
label variable RTC_mex00 "Import RTC (1990-2000)"
label variable RTC_mex05 "Import RTC (1990-2005)"
label variable RTC_us00 "Export RTC (U.S.)"

save "$build\output\nafta_exposure.dta",replace


*5-year intervals
//Mexican import tariffs
use "$build\temp\nafta_exposure.dta",clear 
keep geo1_mx industry_group beta_ri
merge m:1 industry_group using "$build\temp\tariffs_by_ind_mex.dta" 
drop _merge //unmerged obs are the non-traded sector
drop ln_tariff_rate_chg_mex91to05 ln_tariff_rate_chg_mex91to00
rename ln_tariff_rate_chg_mex91to95 ln_tariff_rate_chg_mex5yrdiff1
rename ln_tariff_rate_chg_mex95to05 ln_tariff_rate_chg_mex5yrdiff2
reshape long ln_tariff_rate_chg_mex5yrdiff,i(geo1_mx industry_group) /*
	*/j(tariffyear)
replace tariffyear = 1995 if tariffyear==1
replace tariffyear = 2000 if tariffyear==2

gen beta_times_lntariffchg_mex5y = beta_ri*ln_tariff_rate_chg_mex5yrdiff
bysort geo1_mx tariffyear: egen RTC_mex5yr = total(beta_times_lntariffchg_mex5y) /*
	*/if industry_group!=.

//Mexican to U.S. export tariffs
merge m:1 tariffyear industry_group using /*
	*/"$build\temp\tariffs_by_ind_us_allyrs.dta"
drop if tariffyear==2005
keep if _merge==3 //for some reason US tariff data doesn't have many years 
				  //for the electricity, gas, and water sector
drop _merge
gen beta_times_lntariffchg_us5y = beta_ri*ln_tariff_rate_chg_us5yrdiff
bysort geo1_mx tariffyear: egen RTC_us5yr = total(beta_times_lntariffchg_us5y) /*
	*/if industry_group!=.

collapse (max) RTC_mex5yr RTC_us5yr, by(geo1_mx tariffyear)
drop if geo1_mx==.
rename geo1_mx state
rename tariffyear year
label variable RTC_mex5yr "Import RTC"
label variable RTC_us5yr "Export RTC (U.S.)"

save "$build\output\nafta_exposure_5yr.dta",replace

	
/*MUNICIPAL LEVEL*/

use if year==1990 using "$build\temp\mex_census_90_95_00.dta",clear

*keep just those of working age and employed
keep if age>=15 & age<=45  & empstat==1
	
gen labor_payments_ri = population*incearn

collapse (sum) labor_payments_ri, by(industry_group geo2_mx)
bysort geo2_mx: egen labor_payments_r = total(labor_payments) 
gen lambda_ri = labor_payments_ri/labor_payments_r

*merge with non-labor cost share (theta_i)
merge m:1 industry_group using "$build\temp\theta_i.dta"
drop _merge

gen lambda_divided_theta = lambda_ri/theta_i

*denominator for beta_ri
bysort geo2_mx: egen sum_lambda_div_theta = total(lambda_divided_theta) /*
	*/if industry_group!=.
gen beta_ri = (lambda_ri/theta_i)/sum_lambda_div_theta

save "$build\temp\nafta_exposure_munic.dta",replace 

*merge with Mexican import tariffs on US goods
merge m:1 industry_group using "$build\temp\tariffs_by_ind_mex.dta"
drop _merge //unmerged obs are the non-traded sector
*merge with US import tariffs on Mexican goods
merge m:1 industry_group using "$build\temp\tariffs_by_ind_us.dta"
drop _merge

*MEXICO tariffs on US goods, 2000 and 2005
gen beta_times_lntariffchg_mex05 = beta_ri*ln_tariff_rate_chg_mex91to05
bysort geo2_mx: egen RTC_mex05 = total(beta_times_lntariffchg_mex05) /*
	*/if industry_group!=.

gen beta_times_lntariffchg_mex00 = beta_ri*ln_tariff_rate_chg_mex91to00
bysort geo2_mx: egen RTC_mex00 = total(beta_times_lntariffchg_mex00) /*
	*/if industry_group!=.
 
*US tariffs on MEXICAN goods, 2000
gen beta_times_lntariffchg_us00 = beta_ri*ln_tariff_rate_chg_us10yrdiff
bysort geo2_mx: egen RTC_us00 = total(beta_times_lntariffchg_us00) /*
	*/if industry_group!=.
 
 
collapse (max) RTC_mex00 RTC_mex05 RTC_us00 labor_payments_r, by(geo2_mx)
drop if geo2_mx==.
label variable RTC_mex00 "Import RTC (1990-2000)"
label variable RTC_mex05 "Import RTC (1990-2005)"
label variable RTC_us00 "Export RTC (U.S.)"

save "$build\output\nafta_exposure_munic.dta",replace


*5-year intervals
//Mexican import tariffs
use "$build\temp\nafta_exposure_munic.dta",clear 
keep geo2_mx industry_group beta_ri
merge m:1 industry_group using "$build\temp\tariffs_by_ind_mex.dta" 
drop _merge //unmerged obs are the non-traded sector
drop ln_tariff_rate_chg_mex91to05 ln_tariff_rate_chg_mex91to00
rename ln_tariff_rate_chg_mex91to95 ln_tariff_rate_chg_mex5yrdiff1
rename ln_tariff_rate_chg_mex95to05 ln_tariff_rate_chg_mex5yrdiff2
reshape long ln_tariff_rate_chg_mex5yrdiff,i(geo2_mx industry_group) /*
	*/j(tariffyear)
replace tariffyear = 1995 if tariffyear==1
replace tariffyear = 2000 if tariffyear==2

gen beta_times_lntariffchg_mex5y = beta_ri*ln_tariff_rate_chg_mex5yrdiff
bysort geo2_mx tariffyear: egen RTC_mex5yr = total(beta_times_lntariffchg_mex5y) /*
	*/if industry_group!=.

//Mexican to U.S. export tariffs
merge m:1 tariffyear industry_group using /*
	*/"$build\temp\tariffs_by_ind_us_allyrs.dta"
drop if tariffyear==2005
keep if _merge==3 //for some reason US tariff data doesn't have many years 
				  //for the electricity, gas, and water sector
drop _merge
gen beta_times_lntariffchg_us5y = beta_ri*ln_tariff_rate_chg_us5yrdiff
bysort geo2_mx tariffyear: egen RTC_us5yr = total(beta_times_lntariffchg_us5y) /*
	*/if industry_group!=.

collapse (max) RTC_mex5yr RTC_us5yr, by(geo2_mx tariffyear)
drop if geo2_mx==.
rename geo2_mx munic
rename tariffyear year
label variable RTC_mex5yr "Import RTC"
label variable RTC_us5yr "Export RTC (U.S.)"

tsset munic year
gen dRTC_us = RTC_us5yr-l5.RTC_us5yr
gen dRTC_mex = RTC_mex5yr-l5.RTC_mex5yr


save "$build\output\nafta_exposure_5yr_munic.dta",replace
