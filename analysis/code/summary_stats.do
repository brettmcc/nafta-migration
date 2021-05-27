clear all
set more off,permanently

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

/*STATE LEVEL*/
use $analysis\input\merged_state


gen varname = ""
label variable varname ""
replace varname = "\% Chg. in Pop." if _n==1
replace varname = "Interstate Inflow Rate" if _n==3
replace varname = "Interstate Outflow Rate" if _n==5
replace varname = "Intl. Inflow Rate" if _n==7
replace varname = "Intl. Outflow Rate" if _n==9
replace varname = "$ RTC^M_{r,t}$" if _n==11
replace varname = "$ RTC^X_{r,t}$" if _n==13
replace varname = "\% Pop. Activated--Land Reform" if _n==15
replace varname = "Beg. pd. \% in secondary school+" if _n==17
replace varname = "Beg. pd. \% urban" if _n==19
replace varname = "Beg. pd. \% homeowner" if _n==21
replace varname = "Beg. pd. \% women employed" if _n==23
replace varname = "Chg. LFP" if _n==25
replace varname = "Chg. \% Manufacturing" if _n==27

gen pd90_95 = .
label variable pd90_95 "1990-1995"
gen pd95_00 = .
label variable pd95_00 "1995-2000"

program define sumstats 
 args var n
 sum `var' if year==1995
 replace pd90_95 = r(mean) if _n==`n'
 replace pd90_95 = r(sd) if _n==`n'+1
 sum `var' if year==2000
 replace pd95_00 = r(mean) if _n==`n'
 replace pd95_00 = r(sd) if _n==`n'+1
end

local variables = "prop_chg_labor_force interst_mig_infl_rt interst_mig_outfl_rt intl_return_mig_rt intl_mig_rt RTC2_mex5yr RTC2_us5yr prop_ejido_activated_normalized secondary_school_plus_lag urban_dummy_lag homeowner_lag employed_female_lag chg_lfp chg_pct_manufacturing"
local num = 1
foreach var of varlist `variables' {
	sumstats `var' `num'
	local num = `num'+2
}

replace pd90_95 = round(pd90_95,.001)
replace pd95_00 = round(pd95_00,.001)

outsheet varname pd* using "$analysis\output\tables\sumstats_state.csv"/*
	*/,comma replace
	
/*MUNICIPAL LEVEL*/
use "$build\output\chg_labor_force_constcohort_munic.dta",clear
merge 1:1 geo2_mx using "$build\output\nafta_exposure_munic.dta"
drop _merge

gen varname = ""
label variable varname ""
replace varname = "% Chg. in Pop." if _n==1
replace varname = "RTC^M_r" if _n==2
replace varname = "RTC^X_r" if _n==3
replace varname = "Population 2000" if _n==4
replace varname = "Observations 2000" if _n==5

gen mean = .
gen sd = .
gen min = .
gen max = .

program define mun_sumstats
 args var n
 sum `var' 
 replace mean = r(mean) if _n==`n'
 replace sd = r(sd) if _n==`n'
 replace min = r(min) if _n==`n'
 replace max = r(max) if _n==`n'
 end
 
 local variables = "pct_chg_labor_force RTC_mex05 RTC_us00 population N"
 local num = 1
 foreach var of varlist `variables' {
	mun_sumstats `var' `num'
	local num = `num'+1
}

replace mean = round(mean,.001)
replace sd = round(sd,.001)
replace min = round(min,.001)
replace max = round(max,.001)

outsheet varname mean sd min max using /*
	*/"$analysis\output\tables\sumstats_munic.csv",comma replace

	
*compare municipalities samples in 1995 vs. others
//1990
use "$build\temp\mex_census_90_95_00.dta",clear 
contract geo2_mx if year==1995
gen in95 = 1
save "$build\temp\munis_95.dta",replace

use "$build\temp\mex_census_90_95_00.dta",clear 
merge m:1 geo2_mx using "$build\temp\munis_95.dta"
replace in95 = 0 if in95==.

collapse (count) pop=perwt (mean) age ln_wage urban_dummy homeowner /*
	*/electric_dummy female married lt_primary_school /*
	*/primary_school_only secondary_school_only college_grad /*
	*/(sd) sd_age=age sd_ln_wage=ln_wage sd_urban_dummy=urban_dummy /*
	*/sd_homeowner=homeowner sd_electric_dummy=electric_dummy /*
	*/sd_female=female sd_married=married /*
	*/sd_lt_primary_school=lt_primary_school /*
	*/sd_primary_school_only=primary_school_only /*
	*/sd_secondary_school_only=secondary_school_only /*
	*/sd_college_grad=college_grad if year!=1995 [iweight=perwt],/*
	*/by(year in95)
	
save "$build\temp\muni_control_vars.dta",replace
	
export excel using /*
	*/"$analysis\output\tables\sumstats_munic_95sample_comp.xlsx",/*
	*/ replace firstrow(varlabels)
	
use "$build\output\ejido_activation_pop_weighted_muni.dta",clear
rename munic geo2_mx
merge m:1 geo2_mx using "$build\temp\munis_95.dta"
gen pct_pop_in_ejido = total_ejido_pop/muni_pop
collapse (mean) mean_pct_pop_in_ejido=pct_pop_in_ejido (sd) /*
	*/sd_pct_pop_in_ejido=pct_pop_in_ejido,by(year in95)
