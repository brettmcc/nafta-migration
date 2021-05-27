global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

use migmx2 geo1_mx persons perwt year intmig2 hhwt serial empstat age /*
	*/using "$build\temp\mex_census_90_95_00.dta",clear

/*****************************************************************
 * TABLE OF CONTENTS:											*
 * 1. Change in population										*
 *	  a. Overall population										*
 *	  	i. State level											*
 * 	  	ii. Municipality level									*
 *	  b. Fixed-age cohort										*
 *		i. State level											*
 *		ii. Municipality level									*
 * 2. Interstate migration rates								*
 * 3. Intermunicipality migration rates							*
 * 4. International migration rates								*
 *    a. Direct method											*
 *		i. State level											*
 *		ii. Municipality level									*
 *	  b. Residual method										*
 *		i. State level											*
 *		ii. Municipality level									*
*****************************************************************/

	
/* 1. CHANGE IN POPULATION */

/*a. Calculate change in labor force*/
use migmx2 geo1_mx persons perwt year intmig2 hhwt serial empstat age /*
	*/ population using "$build\temp\mex_census_90_95_00.dta",clear
	
/*i. STATE LEVEL*/
keep if age>=15 & age<70 & (empstat==1 | empstat==2) & year!=1995

collapse (sum) population, by(year geo1_mx)
tsset geo1_mx year

gen pct_chg_labor_force = (population-l10.population)/l10.population
gen ln_chg_labor_force = ln(population)-ln(l10.population)
drop if pct_chg_labor_force==.
drop year

save "$build\output\chg_labor_force.dta",replace

/*ii. MUNICIPAL LEVEL*/
use migmx2 persons population year intmig2 hhwt serial empstat age /*
	*/geo1_mx geo2_mx using "$build\temp\mex_census_90_95_00.dta",clear

keep if age>=15 & age<=50 & year!=1995

collapse (sum) population (max) geo1_mx, by(year geo2_mx)
tsset geo2_mx year

gen pct_chg_labor_force = (population-l10.population)/l10.population
gen ln_chg_labor_force = ln(population)-ln(l10.population)
drop if pct_chg_labor_force==.
drop year

save "$build\output\chg_labor_force_munic.dta",replace

/*b. constant-age cohort labor force*/
 
 /*i. STATE LEVEL*/
 use migmx2 geo1_mx persons population year  age /*
	*/geo2_mx using "$build\temp\mex_census_90_95_00.dta",clear
keep if (age>=15 & age<=45 & year==1990) | (age>=25 & age<=55 & year==2000)
 
collapse (sum) population, by(year geo1_mx)
tsset geo1_mx year

gen chg_labor_force = population-l10.population
gen pct_chg_labor_force = (population-l10.population)/l10.population
gen ln_chg_labor_force = ln(population)-ln(l10.population)
drop if pct_chg_labor_force==.
drop year

save "$build\output\chg_labor_force_constcohort.dta",replace

/*ii. MUNICIPAL LEVEL*/
use migmx2 geo1_mx persons population perwt year  age /*
	*/geo2_mx using "$build\temp\mex_census_90_95_00.dta",clear

keep if (age>=15 & age<=45 & year==1990) | (age>=25 & age<=55 & year==2000)

collapse (count) N=perwt (sum) population perwt (max) geo1_mx, by(year geo2_mx)
tsset geo2_mx year

gen pct_chg_labor_force = (population-l10.population)/l10.population
gen ln_chg_labor_force = ln(population)-ln(l10.population)
gen alt_pct_chg_labor_force = (perwt-l10.perwt)/l10.perwt
gen alt_ln_chg_labor_force = ln(perwt)-ln(l10.perwt)

drop if pct_chg_labor_force==.
drop year

save "$build\output\chg_labor_force_constcohort_munic.dta",replace



	
	
/*2. calculate interstate migration rate*/
use "$build\temp\mex_census_90_95_00.dta",clear

*interstate migrant = 1 if not in state of residence from 5 years ago
drop if migmx2<=0 | migmx2>32
gen interstate_migrant = (migmx2!=geo1_mx)*perwt 

collapse (sum) interstate_migrant pop=perwt, by(migmx2 year)
tsset migmx2 year,yearly
gen interstate_mig_rt = interstate_migrant/pop
gen chg_interstate_mig_rt = interstate_mig_rt-l10.interstate_mig_rt
	
save "$build\output\interstate_mig_rts_census.dta",replace


/*3. Intermunicipality migration rates*/
use "$build\temp\mex_census_90_95_00.dta",clear 

//drop persons with missing municipalities
drop if mx2000a_resmun==0 | mod(mx2000a_resmun,1000)==999 | /*
	*/ mx1995a_resmun==99998 | mx1995a_resmun==99999 | /*
	*/mod(mx1995a_resmun,1000)==999

//geo2_mx: first 3 digits are country code, next 3 state, next 3 
//municipality
gen state_munic_code = mod(geo2_mx,1000000)
gen intermunic_migrant = /*
	*/(state_munic_code!=state_munic_code_5yrs_ago)*perwt

collapse (sum) intermunic_migrant pop=perwt (count) N=perwt,/*
	*/by(state_munic_code_5yrs_ago year)
tsset state_munic_code_5yrs_ago year,yearly
gen intermunic_mig_rt = intermunic_migrant/pop
gen chg_intermunic_mig_rt = intermunic_mig_rt-l10.intermunic_mig_rt
	
replace state_munic_code_5yrs_ago=state_munic_code_5yrs_ago+484000000
	
save "$build\output\intermunic_mig_rts_census.dta",replace



/*4. calculate international migration rate*/ 

/*a. Direct Method*/

*i. STATE LEVEL
use migmx2 geo1_mx persons perwt year intmig2 hhwt serial empstat age /*
	*/perwt using "$build\temp\mex_census_90_95_00.dta",clear

*variable only available for 1995 and 2000
drop if year==1990

gen intl_migrants = intmig2*hhwt if intmig2!=99

*collapse to just household level
collapse (max) intl_migrants hhwt (sum) pop=perwt, /*
	*/by(geo1_mx year serial persons)

*collapse to state level
collapse (sum) intl_migrants pop, by(geo1_mx year)
tsset geo1_mx year, yearly
gen intl_mig_rt_partialhh = intl_migrants/pop
gen chg_intl_mig_rt_partialhh = intl_mig_rt-l5.intl_mig_rt

rename geo1_mx state
save "$build\output\intl_mig_rts_census.dta",replace


*ii. MUNICIPAL LEVEL
use migmx2 geo2_mx persons perwt year intmig2 hhwt serial empstat age /*
	*/perwt using "$build\temp\mex_census_90_95_00.dta",clear
	
*variable only available for 1995 and 2000
drop if year==1990

gen intl_migrants = intmig2*hhwt if intmig2!=99

*collapse to just household level
collapse (max) intl_migrants hhwt (sum) pop=perwt, /*
	*/by(geo2_mx year serial persons)

collapse (sum) intl_migrants pop N=persons, by(geo2_mx year)
tsset geo2_mx year,yearly
gen intl_mig_rt_partialhh = intl_migrants/pop
gen chg_intl_mig_rt_partialhh = intl_mig_rt-l5.intl_mig_rt

rename geo2_mx munic

save "$build\output\intl_mig_rts_census_munic.dta",replace
export delimited "$build\output\intl_mig_rts_census_munic.csv",replace/*
	*/ nolab
	
use "$build\output\intl_mig_rts_census_munic.dta",clear
drop if year==1995
drop year
save "$build\output\intl_mig_rts_census_munic00.dta",replace

/*b. Residual Method*/

*i. STATE LEVEL

/*Impute international emigration rate:
dL=(interstate inflows - interstate outflows)+(int'l inflows-int'l outflows)
where dL, interstate flows, and int'l inflows are observed, deaths =0, and
I solve for int'l outflows*/
use "$build\temp\mex_census_90_95_00.dta",clear 
//append using "$build\temp\mex_census05.dta"

keep if (age>=17 & age<=47 & year==1990) | /*
	*/(age>=22 & age<=52 & year==1995)/*
	*/ | (age>=27 & age<=57 & year==2000)

*calculate gross outflows via interstate migration by state
preserve 
gen outflow_interstate = (geo1_mx!=migmx2)*perwt if migrate5!=30
collapse (sum) outflow_interstate, by(migmx2 year)
rename migmx2 state
label variable outflow_interstate "Num. who left state between t-5 and t"
save "$build\temp\interstate_outflows.dta",replace
restore

*calculate gross inflows via interstate migration by state
preserve
gen inflow_interstate = (geo1_mx!=migmx2)*perwt if migrate5!=30
collapse (sum) inflow_interstate, by(geo1_mx year)
rename geo1_mx state
label variable inflow_interstate "Num. who arrived in state btwn. t-5 and t"
save "$build\temp\interstate_inflows.dta",replace
restore

*calculate gross inflows via international migration by state
preserve 
gen inflow_intl = (migrate5==30)*perwt
collapse (sum) inflow_intl,by(geo1_mx year)
rename geo1_mx state
label variable inflow_intl "Num. who arrived from abroad btwn. t-5 and t"
save "$build\temp\intl_inflows.dta",replace
restore


use "$build\temp\mex_census_90_95_00.dta",clear 

keep if (age>=17 & age<=47 & year==1990) | /*
	*/(age>=22 & age<=52 & year==1995)/*
	*/ | (age>=27 & age<=57 & year==2000)

collapse (sum) pop=perwt, by(year geo1_mx)
tsset geo1_mx year	
gen chg_labor_force = pop-l5.pop
gen prop_chg_labor_force = chg_labor_force/l5.pop
gen ln_chg_labor_force = ln(pop)-ln(l5.pop)

rename geo1_mx state
merge 1:1 year state using "$build\temp\interstate_outflows.dta",nogen
merge 1:1 year state using "$build\temp\interstate_inflows.dta",nogen
merge 1:1 year state using "$build\temp\intl_inflows.dta",nogen
merge 1:1 year state using "$build\temp\deaths_state.dta",nogen
replace deaths = deaths/100
gen intl_mig_outflows = inflow_interstate-outflow_interstate +/*
	*/inflow_intl-chg_labor_force-deaths
tsset state year

gen intl_mig_rt = intl_mig_outflows/l5.pop
gen intl_return_mig_rt = inflow_intl/l5.pop
gen netintl_mig_rt = -(inflow_intl-intl_mig_outflows)/l5.pop
gen interst_mig_outfl_rt = outflow_interstate/l5.pop
gen interst_mig_infl_rt = inflow_interstate/l5.pop
gen interst_mig_netinfl_rt = (inflow_interstate-outflow_interstate)/l5.pop
gen chg_intl_mig_rt = intl_mig_rt-l5.intl_mig_rt

label variable prop_chg_labor_force "% Chg. in Pop. (age 10-40 in 1990)"
label variable ln_chg_labor_force "Chg. in Ln Pop. (age 10-40 in 1990)"
label variable chg_intl_mig_rt "Chg. Gross Intl. Migration Rate"
label variable intl_mig_rt "Gross Intl. Emigration Rate"
label variable interst_mig_outfl_rt "Interstate Gross Outflow Rate"
label variable interst_mig_infl_rt "Interstate Gross Inflow Rate"
label variable interst_mig_netinfl_rt "Interstate Net Inflow Rate"
label variable intl_return_mig_rt "Intl. Return Migration as % of Pop."
label variable netintl_mig_rt "Net Intl. Migration Rate"

gen border_state = inlist(state,2,26,8,5,19,28)

save "$build\output\intl_mig_rt_state.dta",replace

use "$build\output\intl_mig_rt_state.dta",clear
twoway (histogram intl_mig_rt if year==1995, width(.02) start(-0.16)) /*
	*/(histogram intl_mig_rt /*
	*/if year==2000,fcolor(none) lcolor(black) width(.02) start(-0.16)), /*
	*/title(Imputed International Emigration Rate by Year) /*
	*/legend(order(1 "1995" 2 "2000"))
graph export "$analysis\output\graphs\intl_emig_rt_by_year.png",replace
	

*compute 10-year rates
use "$build\output\intl_mig_rt_state.dta",clear
gen pop90 = l5.pop if year==1995
collapse (sum) chg_labor_force outflow_interstate inflow_interstate /*
	*/inflow_intl intl_mig_outflows (max) pop90 if year!=1990, by(state)
gen intl_mig_rt10yr = intl_mig_outflows/pop90

save "$build\output\intl_mig_rt_state10yr.dta",replace

*ii. MUNICIPALITY LEVEL

/*Impute international emigration rate:
dL=(intermunic inflows - intermunic outflows)+(int'l inflows-int'l outflows)
where dL, interstate flows are observed, int'l inflows=0, and
I solve for int'l outflows*/
use "$build\temp\mex_census_90_95_00.dta",clear 

keep if (age>=17 & age<=47 & year==1990) | /*
	*/(age>=22 & age<=52 & year==1995)/*
	*/ | (age>=27 & age<=57 & year==2000)
	
*calculate gross outflows via intermunic migration by municipality
preserve 
gen outflow_intermunic = (geo2_mx!=state_munic_code_5yrs_ago)*perwt /*
	*/if state_munic_code_5yrs_ago!=.
replace outflow_intermunic=0 if outflow_intermunic==.
collapse (sum) outflow_intermunic, by(year state_munic_code_5yrs_ago)
drop if state_munic_code_5yrs_ago==.
rename state_munic_code_5yrs_ago munic
label variable outflow_intermunic "Num. who left munic. between t-5 and t"
keep if year!=1990
save "$build\temp\intermunic_outflows.dta",replace
restore

*calculate gross inflows via intermunic migration by municipality
preserve
gen inflow_intermunic = (geo2_mx!=state_munic_code_5yrs_ago)*perwt /*
	*/if year!=1990 & state_munic_code_5yrs_ago!=.
replace inflow_intermunic = 1*perwt if migmx2!=geo1_mx & migrate5!=30
collapse (sum) inflow_intermunic, by(year geo2_mx)
rename geo2_mx munic
label variable inflow_intermunic /*
	*/"Num. who arrived in munic. btwn. t-5 and t"
keep if year!=1990
save "$build\temp\intermunic_inflows.dta",replace
restore

*calculate gross inflows via international migration by municipality
preserve 
gen inflow_intl_munic = (migrate5==30)*perwt
collapse (sum) inflow_intl_munic,by(year geo2_mx)
rename geo2_mx munic
label variable inflow_intl_munic /*
	*/"Num. who arrived from abroad btwn. t-5 and t"
keep if year!=1990
save "$build\temp\intl_inflows_munic.dta",replace
restore


use "$build\temp\mex_census_90_95_00.dta",clear 

keep if (age>=17 & age<=47 & year==1990) | /*
	*/(age>=22 & age<=52 & year==1995)/*
	*/ | (age>=27 & age<=57 & year==2000)
	
collapse (sum) pop=perwt (count) N=perwt, by(year geo1_mx geo2_mx)
rename geo1_mx state
tsset geo2_mx year
tsfill, full
keep if year==1990 | year==1995 | year==2000
replace state = int((geo2_mx-484000000)/1000) if state==.

merge m:1 state year using "$build\output\intl_mig_rt_state.dta",/*
	*/keepusing(state year chg_labor_force prop_chg_labor_force)
drop if state>32
drop _merge
rename chg_labor_force chg_labor_force_state 
rename prop_chg_labor_force prop_chg_labor_force_state
tsset geo2_mx year	
gen chg_labor_force = pop-l5.pop
gen prop_chg_labor_force = chg_labor_force/l5.pop
gen ln_chg_labor_force = ln(pop)-ln(l5.pop)

rename geo2_mx munic
merge 1:1 year munic using "$build\temp\intermunic_outflows.dta"
//master only (1) are all in 1990
//using only (2) are municipalities people flowed out of 1990-95
//which aren't surveyed in 1995
drop _merge
merge 1:1 year munic using "$build\temp\intermunic_inflows.dta"
//master only (1) are all in 1990
//using only (2) are muni's not surveyed in '95 left over from
//previous merge
drop _merge
merge 1:1 year munic using "$build\temp\intl_inflows_munic.dta",nogen
merge 1:1 year munic using "$build\temp\deaths_munic.dta"
//very small muni's with potentially no deaths over period: master only
replace deaths = 0 if _merge==1 & year!=1990
replace deaths = deaths/100

gen intl_mig_outflows = inflow_intermunic-outflow_intermunic +/*
	*/inflow_intl_munic-chg_labor_force-deaths

sort munic year
gen intl_mig_rt = intl_mig_outflows/l5.pop

gen intl_return_mig_rt = inflow_intl/l5.pop
gen netintl_mig_rt = -(inflow_intl-intl_mig_outflows)/l5.pop
gen intermn_mig_outfl_rt = outflow_intermunic/l5.pop
gen intermn_mig_infl_rt = inflow_intermunic/l5.pop
gen intermn_mig_netinfl_rt = (inflow_intermunic-outflow_intermunic)/l5.pop
gen chg_intl_mig_rt = intl_mig_rt-l5.intl_mig_rt

label variable prop_chg_labor_force "% Chg. in Pop. (age 10-40 in 1990)"
label variable ln_chg_labor_force "Chg. in Ln Pop. (age 10-40 in 1990)"
label variable chg_intl_mig_rt "Chg. Gross Intl. Migration Rate"
label variable intl_mig_rt "Gross Intl. Emigration Rate"
label variable intermn_mig_outfl_rt "Interstate Gross Outflow Rate"
label variable intermn_mig_infl_rt "Interstate Gross Inflow Rate"
label variable intermn_mig_netinfl_rt "Interstate Net Inflow Rate"
label variable intl_return_mig_rt "Intl. Return Migration as % of Pop."
label variable netintl_mig_rt "Net Intl. Migration Rate"

/*Interpolated population for 1995*/
gen pop95_1 = l5.pop*(1+prop_chg_labor_force_state) if year==1995
gen pop95_2 = f5.pop*(1-prop_chg_labor_force_state) if year==1995
gen pop_interpolated95 = (pop95_1+pop95_2)/2 if year==1995
drop pop95_1 pop95_2
replace pop_interpolated95 = pop if year!=1995

gen chg_labor_force2 = pop_interpolated95-l5.pop_interpolated95
gen prop_chg_labor_force2 = chg_labor_force2/l5.pop_interpolated95
gen inflow_intermunic2 = inflow_intermunic*pop_interpolated95/pop
gen outflow_intermunic2 = outflow_intermunic*pop_interpolated95/pop
gen inflow_intl_munic2 = inflow_intl_munic*pop_interpolated95/pop
 
gen intl_mig_outflows2 = inflow_intermunic2-outflow_intermunic2 +/*
	*/inflow_intl_munic2-chg_labor_force2-deaths
gen intl_mig_rt2 = intl_mig_outflows2/l5.pop_interpolated95 
gen intl_mig_rt3 = intl_mig_outflows2/pop_interpolated95

gen intl_return_mig_rt2 = inflow_intl_munic2/l5.pop_interpolated95
gen netintl_mig_rt2 = /*
	*/-(inflow_intl_munic2-intl_mig_outflows2)/l5.pop_interpolated95
gen intermn_mig_outfl_rt2 = outflow_intermunic2/l5.pop_interpolated95
gen intermn_mig_infl_rt2 = inflow_intermunic2/l5.pop_interpolated95
gen intermn_mig_netinfl_rt2 = (inflow_intermunic2-outflow_intermunic2)/l5.pop_interpolated95
gen chg_intl_mig_rt2 = intl_mig_rt2-l5.intl_mig_rt2
gen ln_chg_intl_outflws = ln(intl_mig_outflows2)-ln(l5.intl_mig_outflows2)

label variable prop_chg_labor_force2 "% Chg. in Pop. (age 10-40 in 1990)"
label variable chg_intl_mig_rt2 "Chg. Gross Intl. Migration Rate"
label variable intl_mig_rt2 "Gross Intl. Emigration Rate"
label variable intermn_mig_outfl_rt2 "Intermuni. Outflow Rate"
label variable intermn_mig_infl_rt2 "Intermuni. Inflow Rate"
label variable intermn_mig_netinfl_rt2 "Intermuni. Net Inflow Rate"
label variable intl_return_mig_rt2 "Intl. Return Migration as % of Pop."
label variable netintl_mig_rt2 "Net Intl. Migration Rate"
/**/

/*narrow sample down to municpalities that were surveyed in 1995
drop if year==2000 & l5.pop==.
drop if year==1990 & f5.pop==.
drop if year==1995 & pop==.*/
keep if year==2000
drop _merge

save "$build\output\intl_mig_rt_munic.dta",replace

use "$build\output\intl_mig_rt_munic.dta",clear
twoway (histogram intl_mig_rt2 if year==1995, width(.03) start(-2.41)) /*
	*/(histogram intl_mig_rt2 /*
	*/if year==2000,fcolor(none) lcolor(black) width(.03) start(-2.41)), /*
	*/title(Imputed International Emigration Rate by Year) /*
	*/legend(order(1 "1995" 2 "2000"))
graph export "$analysis\output\graphs\intl_emig_rt_by_year_munic.png",/*
	*/replace
	


*compute 10-year rates
use "$build\output\intl_mig_rt_munic.dta",clear
gen pop90 = l5.pop if year==1995
collapse (sum) chg_labor_force2 outflow_intermunic2 inflow_intermunic2 /*
	*/inflow_intl_munic2 intl_mig_outflows2 (max) pop90 if year!=1990, /*
	*/by(munic)
gen intl_mig_rt10yr = intl_mig_outflows2/pop90

save "$build\output\intl_mig_rt_munic10yr.dta",replace
export delimited using "$build\output\intl_mig_rt_munic10yr.csv",/*
	*/replace nolabel

/*Flat weight for 1995*/
use "$build\temp\mex_census_90_95_00.dta",clear 

keep if (age>=17 & age<=47 & year==1990) | /*
	*/(age>=22 & age<=52 & year==1995)/*
	*/ | (age>=27 & age<=57 & year==2000)
	
gen perwt2 = perwt if year!=1995
replace perwt2 = flat_perwt95 if year==1995



