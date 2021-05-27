clear all
set more off,permanently

global build "C:\Users\bmccully\Documents\Resting-Projects\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\Resting-Projects\nafta-migration\analysis"

/*Municipality-level data*/

*1995-2000 change, only 628 municipalities sampled in 1995
use "$build\output\intl_mig_rt_munic.dta",clear
drop if year==1990

merge 1:1 munic year using "$build\output\intl_mig_rts_census_munic.dta"
drop if _merge==2
drop _merge
merge 1:1 munic year using "$build\output\nafta_exposure_5yr_munic.dta"
drop if _merge==2 //drop municipalities not sampled in 1995
drop _merge
merge 1:1 munic year using "$build\output\control_vars_munic.dta"
drop if _merge==2 //drop municipalities not sampled in 1995
drop _merge
merge m:1 state using "$build\output\state_level_price_changes.dta"/*
	*/,nogen
merge 1:1 munic year using /*
	*/"$build\output\ejido_activation_pop_weighted_muni.dta"
drop if _merge==2
drop _merge
merge 1:1 munic year using /*
	*/"$build\temp\nafta_exposure_adh5yr_muni.dta"
drop if _merge==2 //drop municipalities not sampled in 1995
drop _merge
keep if year==2000
drop year
merge 1:1 munic using /*
	*/  $build\temp\labor_mkt_munic.dta
drop if _merge!=3
drop _merge
merge m:1 state using $build\temp\historical_mig_rts.dta,nogen
replace prop_ejido_activated_normalized=0 /*
	*/if prop_ejido_activated_normalized==.
replace chg_prop_ejido_activated_norm=0 /*
	*/ if chg_prop_ejido_activated_norm==.

merge 1:1 munic using "$build\output\nafta_exposure_munic.dta"
drop if _merge!=3
drop _merge

label variable mig5559 "% Migrated 1955-59"
label variable intl_mig_rt2 "Intl. emig. rt--Net-mig. method"
label variable intl_mig_rt_partialhh "Intl. emig. rt--Census q."

save $analysis\input\merged_muni,replace

//winsorize at 1% level for 2000
use $analysis\input\merged_muni,clear
sum intl_mig_rt2,d
drop if (intl_mig_rt2<r(p1) | intl_mig_rt2>r(p99))
save $analysis\input\merged_muni_winsorized,replace

*1995-2000, all munis
use "$build\output\intl_mig_rts_census_munic.dta",clear
merge 1:1 munic year using "$build\output\intl_mig_rt_munic.dta"
drop if _merge!=3 //drop non-2000 years
drop _merge
merge 1:1 munic using "$build\output\nafta_exposure_munic.dta"
drop if _merge!=3 //drop non-2000 years
drop _merge
merge m:1 munic using "$build\output\control_vars_munic1990.dta"
drop if _merge==2 //drop municipalities not sampled in 1995
drop _merge
merge 1:1 munic year using /*
	*/"$build\output\ejido_activation_pop_weighted_muni.dta"
drop if _merge==2
drop _merge
merge 1:1 munic year using /*
	*/"$build\temp\nafta_exposure_adh5yr_muni.dta"
drop if _merge==2 //drop municipalities not sampled in 1995
drop _merge
merge 1:1 munic year using /*
	*/  $build\temp\labor_mkt_munic5yr.dta
drop if _merge!=3
drop _merge
merge m:1 munic using $build\output\nafta_exposure_munic_IO
drop if _merge!=3
drop _merge
//merge m:1 state using $build\temp\historical_mig_rts.dta,nogen
replace prop_ejido_activated_normalized=0 /*
	*/if prop_ejido_activated_normalized==.
replace chg_prop_ejido_activated_norm=0 /*
	*/ if chg_prop_ejido_activated_norm==.

sort munic year
keep if year==2000
drop year
merge 1:1 munic using "$build\output\nafta_exposure_munic.dta"
drop if _merge!=3
drop _merge

save $analysis\input\merged_muni_all,replace

//winsorize at 1% level for 2000
use $analysis\input\merged_muni_all,clear
sum intl_mig_rt2,d
drop if (intl_mig_rt2<r(p1) | intl_mig_rt2>r(p99))
save $analysis\input\merged_muni_all_winsorized,replace

*10-year long difference
use "$build\output\nafta_exposure_5yr_munic.dta",clear
keep if year==1995
drop year
merge 1:1 munic using "$build\output\intl_mig_rt_munic10yr.dta"
keep if _merge==3
drop _merge
merge 1:1 munic using "$build\output\nafta_exposure_munic.dta"
keep if _merge==3 //drop municipalities not included in 1995 sample
drop _merge
merge 1:1 munic using "$build\output\control_vars_munic1990.dta"
keep if _merge==3
drop _merge

gen state = int((munic-484000000)/1000)
merge m:1 state using $build\temp\historical_mig_rts.dta,nogen

*ADH variables
merge 1:1 munic using "$build\temp\nafta_exposure_adh_muni.dta"
drop if _merge!=3
drop _merge
merge 1:1 munic using $build\temp\labor_mkt_munic.dta
drop if _merge!=3
drop _merge

save $analysis\input\merged_muni_10yr,replace
export delimited "$analysis\input\merged_muni_10yr.csv",replace nolab

*10-year long differences, all municipalities
use "$build\output\nafta_exposure_munic.dta",clear
*ADH variables
merge 1:1 munic using "$build\temp\nafta_exposure_adh_muni.dta",nogen
merge 1:1 munic using $build\temp\labor_mkt_munic.dta,nogen
merge 1:1 munic using "$build\temp\muni_pop1990.dta",nogen
gen state = int((munic-484000000)/1000)
merge 1:1 munic using "$build\output\control_vars_munic1990.dta",nogen
merge 1:1 munic using "$build\output\intl_mig_rts_census_munic00.dta"
drop if _merge==2
drop _merge
merge m:1 state using $build\temp\historical_mig_rts.dta,nogen
merge 1:1 munic using $build\output\nafta_exposure_munic_IO
drop if _merge!=3
drop _merge

save $analysis\input\merged_allmuni_10yr,replace

/*State-level data*/
use "$build\output\intl_mig_rt_state.dta",clear
drop if year==1990

merge 1:1 state year using "$build\output\intl_mig_rts_census.dta",nogen
drop if state>=98
merge 1:1 state year using "$build\output\nafta_exposure_5yr.dta",nogen
merge 1:1 state year using "$build\output\control_vars_state.dta",nogen
merge m:1 state using "$build\output\state_level_price_changes.dta",nogen
merge 1:1 state year using /*
	*/"$build\output\ejido_activation_pop_weighted.dta",nogen
merge 1:1 state year using /*
	*/"$build\temp\nafta_exposure_adh5yr.dta",nogen
merge 1:1 state year using "$build\temp\labor_mkt_state5yr.dta",nogen
merge m:1 state using $build\temp\historical_mig_rts.dta,nogen
drop if year==1990
replace prop_ejido_activated_normalized=0 /*
	*/if prop_ejido_activated_normalized==.
replace chg_prop_ejido_activated_norm=0 /*
	*/ if chg_prop_ejido_activated_norm==.

sort state year
	
save $analysis\input\merged_state,replace

*10-year long difference
