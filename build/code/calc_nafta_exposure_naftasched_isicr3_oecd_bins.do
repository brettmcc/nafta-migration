*This program caluclates regional INPUT tariff changes using the 
*OECD 1995 IO table for Mexico

clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"

/**********************************************************************
 * 		MUNICIPALITY LEVEL											 *
**********************************************************************/

/**CALCULATE MUNICIPALITY WEIGHTS**/

/*Calculate lambda_ri, share of region r's labor force employed in */
/*industry i.													   */

use if year==1990 using "$build\temp\mex_census_90_95_00.dta",clear

*keep just those of working age and employed
keep if age>=17 & age<=47 & empstat==1

gen labor_payments_ri = perwt*incearn

collapse (sum) employment_ri=perwt labor_payments_ri, by(ind geo2_mx)

*drop non-traded industries consistent with Kovak, 2013
drop if ind>41999

merge m:1 ind using /*
	*/"$build\temp\isicr3_oecd_bins-mex90ind-crosswalk.dta"
//these are industries I couldn't place into an ISICr3 OECD bin. 
drop if _merge==1 

collapse (sum) employment_ri labor_payments_ri,/*
	*/by(geo2_mx isicr3_oecd_bins)

bysort geo2_mx: egen labor_payments_r = total(labor_payments_ri) 
gen lambda_ri = labor_payments_ri/labor_payments_r

bysort geo2_mx: egen employment_r = total(employment_ri)
gen emp_share_ri = employment_ri/employment_r

/////////ADD IN THETA_i AT LATER DATE\\\\\\\\\\

keep geo2_mx isicr3_oecd_bins lambda_ri employment_ri /*
	*/labor_payments_ri emp_share_ri

save "$build\temp\nafta_exposure_munic_IO.dta",replace 


*merge with tariffs
use "$build\temp\nafta_exposure_munic_IO.dta",clear
merge m:1 isicr3_oecd_bins using $build\temp\input_tariff_chgs
drop if _merge!=3

gen empshr_times_lntariffchg_mex00=/*
	*/emp_share_ri*ln_tariff_rate_chg_mex91to00

collapse (sum) RTC2_IO_mex00=empshr_times_lntariffchg_mex00 /*
	*/,by(geo2_mx)
	
rename geo2_mx munic
label variable RTC2_IO_mex00 "$ RTC_{r,t}^{M,input}$"

save $build\output\nafta_exposure_munic_IO, replace
