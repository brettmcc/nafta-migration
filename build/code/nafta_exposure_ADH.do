clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"

/*compute national industry-level employment*/
*compute percent of workers in industry i that work in region j
use if year==1990 using "$build\temp\mex_census_90_95_00.dta",clear

*keep just those of working age and employed
keep if empstat==1

gen labor_payments_ri = population*incearn

collapse (sum) employment_i=perwt labor_payments_i=labor_payments_ri,/*
	*/by(ind)

*merge with crosswalk between ISICr2 codes and Mexican 1990 census industry
*codes for tradeable industries
merge 1:m ind using "$build\temp\isicr2-mex90ind-crosswalk.dta"
drop if _merge!=3
collapse (sum) employment_i labor_payments_i,by(isicr2)

save "$build\temp\adh_indempshr.dta",replace

/**********************************************************************
 * 		STATE LEVEL													 *
**********************************************************************/

/*Compute region level employment*/
use if year==1990 using "$build\temp\mex_census_90_95_00.dta",clear

*keep just those of working age and employed
keep if empstat==1

gen labor_payments_ri = population*incearn

collapse (sum) employment_ri=perwt labor_payments_ri, by(ind geo1_mx)

*merge with crosswalk between ISICr2 codes and Mexican 1990 census industry
*codes for tradeable industries

save "$build\temp\premerge_adh_state.dta",replace

//merge m:m doesn't work well so doing this instead to avoid that.
forvalues s = 1/32 {
	use "$build\temp\premerge_adh_state.dta",clear
	keep if geo1_mx==`s'
	merge 1:m ind using "$build\temp\isicr2-mex90ind-crosswalk.dta"
	drop if _merge==1 //drop non-tradeable and unmatched sectors
	
	//add in zeros for industries with no employment in the state	
	replace geo1_mx=`s' if geo1_mx==. & _merge==2
	replace labor_payments_ri = 0 if labor_payments_ri==. & _merge==2
	replace employment = 0 if employment==. & _merge==2
	drop _merge description
		
	merge m:1 isicr2 using "$build\temp\adh_indempshr.dta"
	drop _merge
	
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
	
	save "$build\temp\postmerge_adh_state`s'.dta",replace
}
use "$build\temp\postmerge_adh_state1.dta",clear
forvalues s=2/32{
	append using "$build\temp\postmerge_adh_state`s'.dta"
}
collapse (sum) employment_ri labor_payments_ri, by(geo1_mx isicr2 /*
	*/employment_i labor_payments_i) 

gen ind_emp_shr = employment_ri/employment_i

//merge in to obtain region-level employment
merge 1:1 geo1_mx isicr2 using "$build\temp\nafta_exposure.dta"
drop _merge beta_ri

merge m:1 isicr2 using "$build\temp\adh_indempshr.dta",nogen
save "$build\temp\adh_intermediate_state.dta",replace

/*10-year measure*/
use "$build\temp\adh_intermediate_state.dta",clear
merge m:1 isicr2 using "$build\temp\trade_mex2us_isicr2.dta"
drop if _merge==2 //drop those ISICr2 industries for which I couldn't find
				  //a clear 1990 Mexican census industry correspondence. 

keep geo1_mx isicr2 ind_emp_shr employment_r chg_imports90to00 /*
	*/chg_exports90to00 labor_payments_r chg_net_exports
		
collapse (sum) wgt_avg_import_chg=chg_imports90to00 /*
	*/wgt_avg_export_chg=chg_exports90to00 /*
	*/wgt_avg_chg_NX = chg_net_exports /*
	*/[iweight=ind_emp_shr],by(geo1_mx labor_payments_r employment_r)

gen opw_exports = wgt_avg_export_chg/(employment_r*100)
gen opw_imports = wgt_avg_import_chg/(employment_r*100)
gen nxpw_netexports = wgt_avg_chg_NX/(employment_r*100)

keep geo1_mx opw_*
rename geo1_mx state

save "$build\temp\nafta_exposure_adh.dta",replace

/*5-year measure*/
use if year==1995 using $build\temp\trade_mex2us_isicr2_5yr,clear
merge 1:m isicr2 using "$build\temp\adh_intermediate_state.dta" 
drop if _merge==1
drop _merge

preserve 
use if year==2000 using $build\temp\trade_mex2us_isicr2_5yr,clear
merge 1:m isicr2 using "$build\temp\adh_intermediate_state.dta" 
drop if _merge==1
drop _merge
tempfile tmp
save "`tmp'"
restore

append using "`tmp'"
rename geo1_mx state

keep state isicr2 ind_emp_shr employment_r chg_imports /*
	*/chg_exports labor_payments_r year chg_net_exports
	
collapse (sum) wgt_avg_import_chg=chg_imports /*
	*/wgt_avg_export_chg=chg_exports /*
	*/wgt_avg_NX =chg_net_exports /*
	*/[iweight=ind_emp_shr],by(state year employment_r)
	
gen opw_exports = wgt_avg_export_chg/(employment_r*100)
gen opw_imports = wgt_avg_import_chg/(employment_r*100)
gen opw_netexports = wgt_avg_NX/(employment_r*100)

save "$build\temp\nafta_exposure_adh5yr.dta",replace


/**********************************************************************
 * 		MUNICIPALITY LEVEL													 *
**********************************************************************/

/*Compute region level employment*/
use if year==1990 using "$build\temp\mex_census_90_95_00.dta",clear

*keep just those of working age and employed
keep if empstat==1

gen labor_payments_ri = population*incearn

collapse (sum) employment_ri=perwt labor_payments_ri, by(ind geo2_mx)

*merge with crosswalk between ISICr2 codes and Mexican 1990 census industry
*codes for tradeable industries

save "$build\temp\premerge_adh_munio.dta",replace

//merge m:m doesn't work well so doing this instead to avoid that.
use "$build\temp\premerge_rtc_muni.dta",clear
contract geo2_mx
format geo2_mx %12.0f
set matsize 3000
mkmat geo2_mx 

forvalues muni = 1/2328 {
	local s = geo2_mx[`muni',1]
	
	use "$build\temp\premerge_adh_munio.dta",clear
	keep if geo2_mx==`s'
	merge 1:m ind using "$build\temp\isicr2-mex90ind-crosswalk.dta"
	drop if _merge==1 //drop non-tradeable and unmatched sectors
	
	//add in zeros for industries with no employment in the state	
	replace geo2_mx=`s' if geo2_mx==. & _merge==2
	replace labor_payments_ri = 0 if labor_payments_ri==. & _merge==2
	replace employment = 0 if employment==. & _merge==2
	drop _merge description
		
	merge m:1 isicr2 using "$build\temp\adh_indempshr.dta"
	drop _merge
	
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
	
	save "$build\temp\postmerge_adh_muni`s'.dta",replace
}
local muni = geo2_mx[1,1]
use "$build\temp\postmerge_adh_muni`muni'.dta",clear
forvalues muni=2/2328{
	local s = geo2_mx[`muni',1]	
	append using "$build\temp\postmerge_adh_muni`s'.dta"
}
collapse (sum) employment_ri labor_payments_ri, by(geo2_mx isicr2 /*
	*/employment_i labor_payments_i) 

gen ind_emp_shr = employment_ri/employment_i
bysort geo2_mx: egen employment_r = total(employment_ri)
bysort geo2_mx: egen labor_payments_r = total(labor_payments_ri)

merge m:1 isicr2 using "$build\temp\adh_indempshr_state.dta",nogen
save "$build\temp\adh_intermediate_muni.dta",replace


/*10-year measure*/
use "$build\temp\adh_intermediate_muni.dta",clear
merge m:1 isicr2 using "$build\temp\trade_mex2us_isicr2.dta"
drop if _merge==2 //drop those ISICr2 industries for which I couldn't find
				  //a clear 1990 Mexican census industry correspondence. 

keep geo2_mx isicr2 ind_emp_shr employment_r chg_imports90to00 /*
	*/chg_exports90to00 labor_payments_r chg_net_exports
		
collapse (sum) wgt_avg_import_chg=chg_imports90to00 /*
	*/wgt_avg_export_chg=chg_exports90to00 /*
	*/wgt_avg_NX =chg_net_exports /*
	*/[iweight=ind_emp_shr],by(geo2_mx labor_payments_r employment_r)

gen opw_exports = wgt_avg_export_chg/(employment_r*100)
gen opw_imports = wgt_avg_import_chg/(employment_r*100)
gen opw_netexports = wgt_avg_NX/(employment_r*100)

keep geo2_mx opw_*
rename geo2_mx munic

save "$build\temp\nafta_exposure_adh_muni.dta",replace

/*5-year measure*/
use if year==1995 using $build\temp\trade_mex2us_isicr2_5yr,clear
merge 1:m isicr2 using "$build\temp\adh_intermediate_muni.dta" 
drop if _merge==1
drop _merge

preserve 
use if year==2000 using $build\temp\trade_mex2us_isicr2_5yr,clear
merge 1:m isicr2 using "$build\temp\adh_intermediate_muni.dta" 
drop if _merge==1
drop _merge
tempfile tmp
save "`tmp'"
restore

append using "`tmp'"
rename geo2_mx munic

keep munic isicr2 ind_emp_shr employment_r chg_imports /*
	*/chg_exports labor_payments_r year chg_net_exports
	
collapse (sum) wgt_avg_import_chg=chg_imports /*
	*/wgt_avg_export_chg=chg_exports /*
	*/wgt_avg_NX =chg_net_exports /*
	*/[iweight=ind_emp_shr],by(munic year employment_r)
	
gen opw_exports = wgt_avg_export_chg/(employment_r*100)
gen opw_imports = wgt_avg_import_chg/(employment_r*100)
gen opw_netexports = wgt_avg_NX/(employment_r*100)


save "$build\temp\nafta_exposure_adh5yr_muni.dta",replace

