clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

/*STATE LEVEL*/

/*Compare international emigration rate (defined as % of households with an
international emigration) between my own calculation and what CONAPO 
computes, found at http://omi.gob.mx/es/OMI/Datos_Abiertos*/
//% of HHs w/ intl emigrant
use migmx2 geo1_mx persons perwt year intmig2 hhwt serial empstat age /*
	*/perwt using "$build\temp\mex_census_90_95_00.dta",clear

*variable only available for 1995 and 2000
drop if year==1990
gen intl_migrant = (intmig2!=99 & intmig2>0 & intmig2!=.)*hhwt

contract year geo1_mx persons serial hhwt intl_migrant
collapse (sum) num_hhs=hhwt  intl_migrant ,by(geo1_mx year)
gen intl_emig_rt = intl_migrant/num_hhs
keep if year ==2000
drop year

preserve 
import delimited $build\input\CONAPO-migration\IAIM_Entidad_2000.csv,/*
	*/clear 
rename ent geo1_mx
tempfile tmp
save "`tmp'"
restore
merge 1:1 geo1_mx using "`tmp'"

corr intl_emig_rt viv_emig



/*Compare net-migration method rates to those using Census question*/
use "$build\temp\mex_census_90_95_00.dta",clear 
//append using "$build\temp\mex_census05.dta"

keep if (age>=1 & age<=90 & year==1990) | /*
	*/(age>=6 & age<=95 & year==1995)/*
	*/ | (age>=11 & age<=100 & year==2000)

*calculate gross outflows via interstate migration by state
preserve 
gen outflow_interstate = (geo1_mx!=migmx2)*perwt if migrate5!=30
collapse (sum) outflow_interstate, by(migmx2 year)
rename migmx2 state
label variable outflow_interstate "Num. who left state between t-5 and t"
save "$build\temp\interstate_outflows_all.dta",replace
restore

*calculate gross inflows via interstate migration by state
preserve
gen inflow_interstate = (geo1_mx!=migmx2)*perwt if migrate5!=30
collapse (sum) inflow_interstate, by(geo1_mx year)
rename geo1_mx state
label variable inflow_interstate "Num. who arrived in state btwn. t-5 and t"
save "$build\temp\interstate_inflows_all.dta",replace
restore

*calculate gross inflows via international migration by state
preserve 
gen inflow_intl = (migrate5==30)*perwt
collapse (sum) inflow_intl,by(geo1_mx year)
rename geo1_mx state
label variable inflow_intl "Num. who arrived from abroad btwn. t-5 and t"
save "$build\temp\intl_inflows_all.dta",replace
restore


use "$build\temp\mex_census_90_95_00.dta",clear 

keep if (age>=1 & age<=90 & year==1990) | /*
	*/(age>=6 & age<=95 & year==1995)/*
	*/ | (age>=11 & age<=100 & year==2000)

collapse (sum) pop=perwt, by(year geo1_mx)
tsset geo1_mx year	
gen chg_labor_force = pop-l5.pop
gen prop_chg_labor_force = chg_labor_force/l5.pop
gen ln_chg_labor_force = ln(pop)-ln(l5.pop)

rename geo1_mx state
merge 1:1 year state using "$build\temp\interstate_outflows_all.dta",nogen
merge 1:1 year state using "$build\temp\interstate_inflows_all.dta",nogen
merge 1:1 year state using "$build\temp\intl_inflows_all.dta",nogen
merge 1:1 year state using "$build\temp\deaths_state_all.dta",nogen
replace deaths = deaths/100
gen intl_mig_outflows = inflow_interstate-outflow_interstate +/*
	*/inflow_intl-chg_labor_force-deaths
tsset state year

gen intl_mig_rt = intl_mig_outflows/l5.pop

merge 1:1 state year using "$build\output\intl_mig_rts_census.dta"
drop if _merge!=3
drop _merge


corr intl_mig_rt intl_mig_rt_partialhh
twoway (scatter intl_mig_rt intl_mig_rt_partialhh if year==2000) /*
	*/(lfit intl_mig_rt intl_mig_rt_partialhh if year==2000)
save "$build\temp\overall_emigration_rates_state.dta",replace

	
	
/*MUNICIPALITY LEVEL*/

/*Compare international emigration rate (defined as % of households with an
international emigration) between my own calculation and what CONAPO 
computes, found at http://omi.gob.mx/es/OMI/Datos_Abiertos*/
//% of HHs w/ intl emigrant
use migmx2 geo2_mx persons perwt year intmig2 hhwt serial empstat age /*
	*/perwt using "$build\temp\mex_census_90_95_00.dta",clear

*variable only available for 1995 and 2000
drop if year==1990
gen intl_migrant = (intmig2!=99 & intmig2>0 & intmig2!=.)*hhwt

contract year geo2_mx persons serial hhwt intl_migrant
collapse (sum) num_hhs=hhwt  intl_migrant ,by(geo2_mx year)
gen intl_emig_rt = intl_migrant/num_hhs
keep if year ==2000
drop year

preserve 
use "$build\temp\municipio_crosswalk.dta",clear
keep if mx2000a_resmun!=.
tempfile tmp
save "`tmp'"
restore

preserve 
import delimited $build\input\CONAPO-migration\IAIM_Municipio_2000.csv,/*
	*/clear 
rename mun mx2000a_resmun
merge 1:1 mx2000a_resmun using "`tmp'"

rename state_munic_code_xwalk geo2_mx
replace geo2_mx = geo2_mx+484000000

collapse (mean) viv_emig [iweight=tot_viv],by(geo2_mx)
tempfile tmp2
save "`tmp2'"
restore
merge 1:1 geo2_mx using "`tmp2'"

corr intl_emig_rt viv_emig


/*Compare net-migration method rates to those using Census question*/
use "$build\temp\mex_census_90_95_00.dta",clear 
//append using "$build\temp\mex_census05.dta"

keep if (age>=2 & age<=88 & year==1990) | /*
	*/(age>=7 & age<=93 & year==1995)/*
	*/ | (age>=12 & age<=98 & year==2000)

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
save "$build\temp\intermunic_outflows_all.dta",replace
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
save "$build\temp\intermunic_inflows_all.dta",replace
restore

*calculate gross inflows via international migration by municipality
preserve 
gen inflow_intl_munic = (migrate5==30)*perwt
collapse (sum) inflow_intl_munic,by(year geo2_mx)
rename geo2_mx munic
label variable inflow_intl_munic /*
	*/"Num. who arrived from abroad btwn. t-5 and t"
keep if year!=1990
save "$build\temp\intl_inflows_munic_all.dta",replace
restore



use "$build\temp\mex_census_90_95_00.dta",clear 

keep if (age>=2 & age<=88 & year==1990) | /*
	*/(age>=7 & age<=93 & year==1995)/*
	*/ | (age>=12 & age<=98 & year==2000)
	
collapse (sum) pop=perwt (count) N=perwt, by(year geo1_mx geo2_mx)
rename geo1_mx state
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
merge 1:1 year munic using "$build\temp\intermunic_outflows_all.dta"
//master only (1) are all in 1990
//using only (2) are municipalities people flowed out of 1990-95
//which aren't surveyed in 1995
drop _merge
merge 1:1 year munic using "$build\temp\intermunic_inflows_all.dta"
//master only (1) are all in 1990
//using only (2) are muni's not surveyed in '95 left over from
//previous merge
drop _merge
merge 1:1 year munic using "$build\temp\intl_inflows_munic_all.dta",nogen
merge 1:1 year munic using "$build\temp\deaths_munic_all.dta"
//very small muni's with potentially no deaths over period: master only
replace deaths = 0 if _merge==1 & year!=1990
replace deaths = deaths/100

/*Interpolated population for 1995*/
tsset munic year
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

keep if _merge==3
drop _merge
merge 1:1 munic year using "$build\output\intl_mig_rts_census_munic.dta"
save "$build\temp\overall_emigration_rates.dta",replace

use "$build\temp\overall_emigration_rates.dta",clear
corr intl_mig_rt2 intl_mig_rt_partialhh if year==2000 [aweight=N]
label variable intl_mig_rt2 "Net-Migration method"
label variable intl_mig_rt_partialhh "Census question"
twoway (scatter intl_mig_rt2 intl_mig_rt_partialhh if year==2000 /*
	*/[aweight=N],ms(Oh)) /*
	*/(lfit intl_mig_rt2 intl_mig_rt_partialhh if year==2000 /*
	*/ [aweight=N],ms(Oh)),legend(off) ytitle(Net-migration method)/*
	*/title(International Emigration Rate Measures) /*
	*/note("Source: Mexican Census 2000 and author's calculations." /*
	*/"Weighted by municipality population.")
graph export $analysis\output\graphs\intl_mig_rt_validation.png,replace
	

//winsorise
use "$build\temp\overall_emigration_rates.dta",clear
sum intl_mig_rt2 if year==2000,d
drop if (intl_mig_rt2<r(p1) | intl_mig_rt2>r(p99))
corr intl_mig_rt2 intl_mig_rt_partialhh if year==2000 [aweight=N]
twoway (scatter intl_mig_rt2 intl_mig_rt_partialhh if year==2000 /*
	*/[aweight=N],ms(Oh)) /*
	*/(lfit intl_mig_rt2 intl_mig_rt_partialhh if year==2000),/*
	*/legend(off) ytitle(Net-migration method) /*
	*/title("International Emigration Rate Measures, Winsorized 98%") /*
	*/note("Source: Mexican Census 2000 and author's calculations." /*
	*/"Weighted by municipality population. Top and bottom 1% of imputed emigration rates are dropped.")
graph export $analysis\output\graphs\intl_mig_rt_validation_winsor.png,/*
	*/replace
