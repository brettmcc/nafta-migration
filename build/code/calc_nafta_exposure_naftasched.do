clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"

/**********************************************************************
 * 		STATE LEVEL													 *
**********************************************************************/

/**CALCULATE STATE WEIGHTS**/

/*Calculate lambda_ri, share of region r's labor force employed in */
/*industry i.													   */

use if year==1990 using "$build\temp\mex_census_90_95_00.dta",clear

*keep just those of working age and employed
keep if age>=17 & age<=47 & empstat==1

gen labor_payments_ri = perwt*incearn

collapse (sum) employment_ri=perwt labor_payments_ri, by(ind geo1_mx)

*merge with crosswalk between ISICr2 codes and Mexican 1990 census industry
*codes for tradeable industries

save "$build\temp\premerge_rtc_state.dta",replace

//merge m:m doesn't work well so doing this instead to avoid that.
forvalues s = 1/32 {
	use "$build\temp\premerge_rtc_state.dta",clear
	keep if geo1_mx==`s'
	merge 1:m ind using "$build\temp\isicr2-mex90ind-crosswalk.dta"
	drop if _merge==1 //drop non-tradeable and unmatched sectors
	//add in zeros for industries with no employment in the state
	replace geo1_mx=`s' if geo1_mx==. & _merge==2
	replace labor_payments_ri = 0 if labor_payments_ri==. & _merge==2
	replace employment = 0 if employment==. & _merge==2
	drop _merge description
	
	*Because merging from 1 ind to multiple ISICr2, will overstate 
	*labor payments per industry when I sum. I choose to evenly divide 
	*labor payments across industries.
	replace labor_payments_ri=labor_payments_ri/6 if ind==32500
	replace labor_payments_ri=labor_payments_ri/4 if ind==32432
	replace labor_payments_ri=labor_payments_ri/2 if ind==32423
	replace labor_payments_ri=labor_payments_ri/3 if ind==32411
	replace labor_payments_ri=labor_payments_ri/2 if ind==32404
	replace labor_payments_ri=labor_payments_ri/2 if ind==32222
	replace labor_payments_ri=labor_payments_ri/2 if ind==32141
	replace labor_payments_ri=labor_payments_ri/2 if ind==32001
	replace labor_payments_ri=labor_payments_ri/2 if ind==31201
	replace labor_payments_ri=labor_payments_ri/2 if ind==31031
	replace labor_payments_ri=labor_payments_ri/2 if ind==31012
	replace labor_payments_ri=labor_payments_ri/3 if ind==20999
	replace labor_payments_ri=labor_payments_ri/3 if ind==20399
	replace labor_payments_ri=labor_payments_ri/3 if ind==20302
	replace labor_payments_ri=labor_payments_ri/4 if ind==20301
	replace labor_payments_ri=labor_payments_ri/2 if ind==10200
	replace labor_payments_ri=labor_payments_ri/2 if ind==10199
	replace labor_payments_ri=labor_payments_ri/2 if ind==10102
	replace labor_payments_ri=labor_payments_ri/2 if ind==10101
	
	replace employment_ri=employment_ri/6 if ind==32500
	replace employment_ri=employment_ri/4 if ind==32432
	replace employment_ri=employment_ri/2 if ind==32423
	replace employment_ri=employment_ri/3 if ind==32411
	replace employment_ri=employment_ri/2 if ind==32404
	replace employment_ri=employment_ri/2 if ind==32222
	replace employment_ri=employment_ri/2 if ind==32141
	replace employment_ri=employment_ri/2 if ind==32001
	replace employment_ri=employment_ri/2 if ind==31201
	replace employment_ri=employment_ri/2 if ind==31031
	replace employment_ri=employment_ri/2 if ind==31012
	replace employment_ri=employment_ri/3 if ind==20999
	replace employment_ri=employment_ri/3 if ind==20399
	replace employment_ri=employment_ri/3 if ind==20302
	replace employment_ri=employment_ri/4 if ind==20301
	replace employment_ri=employment_ri/2 if ind==10200
	replace employment_ri=employment_ri/2 if ind==10199
	replace employment_ri=employment_ri/2 if ind==10102
	replace employment_ri=employment_ri/2 if ind==10101
	
	save "$build\temp\postmerge_rtc_state`s'.dta",replace
}
use "$build\temp\postmerge_rtc_state1.dta",clear
forvalues s=2/32{
	append using "$build\temp\postmerge_rtc_state`s'.dta"
}
collapse (sum) employment_ri labor_payments_ri,by(geo1_mx isicr2)

bysort geo1_mx: egen labor_payments_r = total(labor_payments_ri) 
gen lambda_ri = labor_payments_ri/labor_payments_r

bysort geo1_mx: egen employment_r = total(employment_ri)
gen emp_share_ri = employment_ri/employment_r

*merge with non-labor cost share (theta_i)
merge m:1 isicr2 using "$build\temp\theta_i.dta"
drop _merge

gen lambda_divided_theta = lambda_ri/theta_i


*denominator for beta_ri
bysort geo1_mx: egen sum_lambda_div_theta = total(lambda_divided_theta)
gen beta_ri = (lambda_ri/theta_i)/sum_lambda_div_theta

keep geo1_mx isicr2 lambda_ri beta_ri labor_payments_r emp_share_ri/*
	*/ employment_r labor_payments_ri employment_ri

save "$build\temp\nafta_exposure.dta",replace 


/*10-year interval*/
use "$build\temp\nafta_exposure.dta",clear 

merge m:1 isicr2 using "$build\temp\nafta_tariffs_10yrdiff.dta"
keep if _merge==3 //drop industries for which I couldn't identify a 
				  //reasonable equivalent in the Mexican 1990 industry 
				  //classification
drop _merge
merge m:1 isicr2 using "$build\temp\us_tariffs_10yrdiff.dta"
keep if _merge==3
drop _merge

*MEXICO tariffs on US goods
gen beta_times_lntariffchg_mex00 = beta_ri*ln_tariff_rate_chg_mex91to00
bysort geo1_mx: egen RTC_mex00 = total(beta_times_lntariffchg_mex00)

gen empshr_times_lntariffchg_mex00=emp_share_ri*ln_tariff_rate_chg_mex91to00
bysort geo1_mx: egen RTC2_mex00 = total(empshr_times_lntariffchg_mex00)

*US tariffs on MEXICAN goods, 2000
gen beta_times_lntariffchg_us00 = beta_ri*ln_tariff_rate_chg_us10yrdiff
bysort geo1_mx: egen RTC_us00 = total(beta_times_lntariffchg_us00)

gen empshr_times_lntariffchg_us00=emp_share_ri*ln_tariff_rate_chg_us10yrdiff
bysort geo1_mx: egen RTC2_us00 = total(empshr_times_lntariffchg_us00)

*Hakobyan-McLaren US tariffs, empshares only
gen empshr_times_lntariffchg2_us00=/*
	*/emp_share_ri*ln_tariff_chg_HM16_us90to00
bysort geo1_mx: egen RTC_HM16_us00 = total(empshr_times_lntariffchg2_us00)


collapse (max) RTC_mex00 RTC_us00 RTC2_mex00 RTC2_us00 RTC_HM16_us00, /*
	*/by(geo1_mx)
drop if geo1_mx==.
label variable RTC_mex00 "Import RTC"
label variable RTC_us00 "Export RTC (U.S.)"

label variable RTC2_mex00 "$ RTC_{r,t}^M$"
label variable RTC2_us00 "$ RTC_{r,t}^X$"

rename geo1_mx state

save "$build\output\nafta_exposure.dta",replace

/*5-year intervals*/
use "$build\output\nafta_exposure.dta",clear

*merge with tariff data
//can't do a direct merge with m:m merges don't work well, so this instead.
forvalues st = 1/32 {
	use "$build\temp\nafta_exposure.dta",clear
	
	keep if geo1_mx==`st'
	merge 1:m isicr2 using "$build\temp\nafta_tariffs_5yrdiff.dta"
	drop _merge
	merge 1:1 isicr2 year using "$build\temp\us_tariffs_5yrdiff.dta"
	drop if _merge!=3 //isicr2 industries with no Mexican '90 census ind.
	drop _merge
	save "$build\temp\postmerge_rtc_state`st'.dta",replace
}
use "$build\temp\postmerge_rtc_state1.dta",clear
forvalues s = 2/32{
	append using $build\temp\postmerge_rtc_state`s'.dta
}


gen beta_times_lntariffchg_mex5y = beta_ri*ln_tariff_rate_chg_mex5yrdiff
gen beta_times_lntariffchg_us5y = beta_ri*ln_tariff_rate_chg_us5yrdiff

gen empshr_times_lntariffchg_mex5y=emp_share_ri*ln_tariff_rate_chg_mex5yrdiff
gen empshr_times_lntariffchg_us5y=emp_share_ri*ln_tariff_rate_chg_us5yrdiff

*Hakobyan-McLaren US tariffs, empshares only
gen empshr_times_lntariffchg2_us5y=/*
	*/emp_share_ri*ln_tariff_chg_HM16_us5yrdiff


collapse (sum) RTC_mex5yr=beta_times_lntariffchg_mex5y /*
	*/RTC_us5yr=beta_times_lntariffchg_us5y /*
	*/RTC2_us5yr=empshr_times_lntariffchg_us5y /*
	*/RTC2_mex5yr=empshr_times_lntariffchg_mex5y /*
	*/RTC_HM16_us5yr=empshr_times_lntariffchg2_us5y,by(geo1_mx year)
	
rename geo1_mx state

label variable RTC_mex5yr "Import RTC"
label variable RTC_us5yr "Export RTC (U.S.)"

label variable RTC2_mex5yr "$ RTC_{r,t}^M$"
label variable RTC2_us5yr "$ RTC_{r,t}^X$"

save "$build\output\nafta_exposure_5yr.dta",replace

*prepare for use in ArcGIS
drop if year==1995
replace state = state+484000
export delimited $build\output\nafta_exposure_5yr.csv,replace nolabel
	
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

save "$build\temp\premerge_rtc_muni.dta",replace

//merge m:m doesn't work well so doing this instead to avoid that.
use "$build\temp\premerge_rtc_muni.dta",clear
contract geo2_mx
format geo2_mx %12.0f
set matsize 3000
mkmat geo2_mx 

forvalues muni = 1/2328 {
	local s = geo2_mx[`muni',1]
	use "$build\temp\premerge_rtc_muni.dta",clear
	keep if geo2_mx==`s'
	merge 1:m ind using "$build\temp\isicr2-mex90ind-crosswalk.dta"
	drop if _merge==1 //drop non-tradeable and sectors with no Mex. ind.
					  //'90 equivalent.
	//add in zeros for industries with no employment in the state
	replace geo2_mx=`s' if geo2_mx==. & _merge==2
	replace labor_payments_ri = 0 if labor_payments_ri==. & _merge==2
	replace employment = 0 if employment==. & _merge==2

	*Because merging from 1 ind to multiple ISICr2, will overstate 
	*labor payments per industry when I sum. I choose to evenly divide 
	*labor payments across industries.
	replace labor_payments_ri=labor_payments_ri/6 if ind==32500
	replace labor_payments_ri=labor_payments_ri/4 if ind==32432
	replace labor_payments_ri=labor_payments_ri/2 if ind==32423
	replace labor_payments_ri=labor_payments_ri/3 if ind==32411
	replace labor_payments_ri=labor_payments_ri/2 if ind==32404
	replace labor_payments_ri=labor_payments_ri/2 if ind==32222
	replace labor_payments_ri=labor_payments_ri/2 if ind==32141
	replace labor_payments_ri=labor_payments_ri/2 if ind==32001
	replace labor_payments_ri=labor_payments_ri/2 if ind==31201
	replace labor_payments_ri=labor_payments_ri/2 if ind==31031
	replace labor_payments_ri=labor_payments_ri/2 if ind==31012
	replace labor_payments_ri=labor_payments_ri/3 if ind==20999
	replace labor_payments_ri=labor_payments_ri/3 if ind==20399
	replace labor_payments_ri=labor_payments_ri/3 if ind==20302
	replace labor_payments_ri=labor_payments_ri/4 if ind==20301
	replace labor_payments_ri=labor_payments_ri/2 if ind==10200
	replace labor_payments_ri=labor_payments_ri/2 if ind==10199
	replace labor_payments_ri=labor_payments_ri/2 if ind==10102
	replace labor_payments_ri=labor_payments_ri/2 if ind==10101
	
	replace employment_ri=employment_ri/6 if ind==32500
	replace employment_ri=employment_ri/4 if ind==32432
	replace employment_ri=employment_ri/2 if ind==32423
	replace employment_ri=employment_ri/3 if ind==32411
	replace employment_ri=employment_ri/2 if ind==32404
	replace employment_ri=employment_ri/2 if ind==32222
	replace employment_ri=employment_ri/2 if ind==32141
	replace employment_ri=employment_ri/2 if ind==32001
	replace employment_ri=employment_ri/2 if ind==31201
	replace employment_ri=employment_ri/2 if ind==31031
	replace employment_ri=employment_ri/2 if ind==31012
	replace employment_ri=employment_ri/3 if ind==20999
	replace employment_ri=employment_ri/3 if ind==20399
	replace employment_ri=employment_ri/3 if ind==20302
	replace employment_ri=employment_ri/4 if ind==20301
	replace employment_ri=employment_ri/2 if ind==10200
	replace employment_ri=employment_ri/2 if ind==10199
	replace employment_ri=employment_ri/2 if ind==10102
	replace employment_ri=employment_ri/2 if ind==10101
	
	drop _merge
	save "$build\temp\postmerge_rtc_muni`s'.dta",replace
}
local muni = geo2_mx[1,1]
use "$build\temp\postmerge_rtc_muni`muni'.dta",clear
forvalues muni=2/2328{
	local s = geo2_mx[`muni',1]	
	append using "$build\temp\postmerge_rtc_muni`s'.dta"
}
collapse (sum) employment_ri labor_payments_ri,by(geo2_mx isicr2)

bysort geo2_mx: egen labor_payments_r = total(labor_payments_ri) 
gen lambda_ri = labor_payments_ri/labor_payments_r

bysort geo2_mx: egen employment_r = total(employment_ri)
gen emp_share_ri = employment_ri/employment_r

*merge with non-labor cost share (theta_i)
merge m:1 isicr2 using "$build\temp\theta_i.dta"
drop _merge

gen lambda_divided_theta = lambda_ri/theta_i


*denominator for beta_ri
bysort geo2_mx: egen sum_lambda_div_theta = total(lambda_divided_theta)
gen beta_ri = (lambda_ri/theta_i)/sum_lambda_div_theta

keep geo2_mx isicr2 beta_ri lambda_ri employment_ri /*
	*/labor_payments_ri emp_share_ri

save "$build\temp\nafta_exposure_munic.dta",replace 


/*10-year interval*/
use "$build\temp\nafta_exposure_munic.dta",clear 

merge m:1 isicr2 using "$build\temp\nafta_tariffs_10yrdiff.dta"
keep if _merge==3 //drop industries for which I couldn't identify a reasonable
				  //equivalent in the Mexican 1990 industry classification
drop _merge
merge m:1 isicr2 using "$build\temp\us_tariffs_10yrdiff.dta"
keep if _merge==3
drop _merge

*MEXICO tariffs on US goods
gen beta_times_lntariffchg_mex00 = beta_ri*ln_tariff_rate_chg_mex91to00
gen empshr_times_lntariffchg_mex00=emp_share_ri*ln_tariff_rate_chg_mex91to00

*US tariffs on MEXICAN goods, 2000
gen beta_times_lntariffchg_us00 = beta_ri*ln_tariff_rate_chg_us10yrdiff
gen empshr_times_lntariffchg_us00=emp_share_ri*ln_tariff_rate_chg_us10yrdiff

*Hakobyan-McLaren US tariffs, empshares only
gen empshr_times_lntariffchg2_us00=/*
	*/emp_share_ri*ln_tariff_chg_HM16_us90to00

collapse (sum) RTC_mex00=beta_times_lntariffchg_mex00 /*
	*/RTC_us00=beta_times_lntariffchg_us00 /*
	*/RTC2_mex00=empshr_times_lntariffchg_mex00 /*
	*/RTC2_us00=empshr_times_lntariffchg_us00 /*
	*/RTC_HM16_us00=empshr_times_lntariffchg2_us00,by(geo2_mx)

collapse (max) RTC_mex00 RTC_us00 RTC2_mex00 RTC2_us00 RTC_HM16_us00,/*
	*/by(geo2_mx)
drop if geo2_mx==.
label variable RTC_mex00 "Import RTC"
label variable RTC_us00 "Export RTC (U.S.)"

label variable RTC2_mex00 "$ RTC_{r,t}^M$"
label variable RTC2_us00 "$ RTC_{r,t}^X$"

rename geo2_mx munic

save "$build\output\nafta_exposure_munic.dta",replace
export delimited "$build\output\nafta_exposure_munic.csv",replace nolab

/*5-year intervals*/
use "$build\output\nafta_exposure_munic.dta",clear

contract munic
mkmat munic

//can't do a direct merge with m:m merges don't work well, so this instead.
forvalues muni = 1/2328 {
	use "$build\temp\nafta_exposure_munic.dta",clear
	local s = munic[`muni',1]
	keep if geo2_mx==`s'
	merge 1:m isicr2 using "$build\temp\nafta_tariffs_5yrdiff.dta"
	drop _merge
	merge 1:1 isicr2 year using "$build\temp\us_tariffs_5yrdiff.dta"
	drop if _merge!=3
	drop _merge
	save "$build\temp\postmerge_rtc_muni`s'.dta",replace
}
local muni = munic[1,1]
use "$build\temp\postmerge_rtc_muni`muni'.dta",clear
forvalues muni=2/2328{
	local s = munic[`muni',1]	
	append using $build\temp\postmerge_rtc_muni`s'.dta
}


gen beta_times_lntariffchg_mex5y = beta_ri*ln_tariff_rate_chg_mex5yrdiff
gen beta_times_lntariffchg_us5y = beta_ri*ln_tariff_rate_chg_us5yrdiff

gen empshr_times_lntariffchg_mex00=emp_share_ri*ln_tariff_rate_chg_mex5yrdiff
gen empshr_times_lntariffchg_us00=emp_share_ri*ln_tariff_rate_chg_us5yrdiff

*Hakobyan-McLaren US tariffs, empshares only
gen empshr_times_lntariffchg2_us5y=/*
	*/emp_share_ri*ln_tariff_chg_HM16_us5yrdiff

collapse (sum) RTC_mex5yr=beta_times_lntariffchg_mex5y /*
	*/RTC_us5yr=beta_times_lntariffchg_us5y /*
	*/RTC2_us5yr=empshr_times_lntariffchg_us00 /*
	*/RTC2_mex5yr=empshr_times_lntariffchg_mex00 /*
	*/RTC_HM16_us5yr=empshr_times_lntariffchg2_us5y,by(geo2_mx year)
	
rename geo2_mx munic

label variable RTC_mex5yr "Import RTC"
label variable RTC_us5yr "Export RTC (U.S.)"

label variable RTC2_mex5yr "$ RTC_{r,t}^M$"
label variable RTC2_us5yr "$ RTC_{r,t}^X$"
	
save "$build\output\nafta_exposure_5yr_munic.dta",replace
