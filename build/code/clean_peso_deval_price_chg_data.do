clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"

use $build\input\cravino_levchenko-peso-deval\data_requested\clave2ubica.dta /*
	*/,clear 
	
split ubica_des, parse(",") generate(state)
drop state2 
rename state1 state

gen geo1_mx = int(ubica_geo/1000)

//See results for crosstab to see that there is not a neat mapping of region
// to state. Should ideally create a population weighted crosswalk.
tab state region_des

*municipal codes used in this data are not the IPUMS cross-time consistent codes
*hence must merge with the municipio crosswalk
preserve 
use "$build\temp\municipio_crosswalk.dta",clear
rename mx1995a_resmun mx1995a
keep state_munic_code_xwalk label mx1995a
keep if mx1995a!=.
tempfile tmp
save "`tmp'"
restore

rename ubica_geo mx1995a
merge 1:1 mx1995a using "`tmp'"
drop if _merge==2 //drop unmerged from crosswalk; only have a few municipios in
				  //this dataset.
drop _merge
rename state_munic_code_xwalk geo2_mx
replace geo2_mx = geo2_mx+484000000

merge m:1 geo2_mx using "$build\temp\muni_pop1990.dta"
drop if _merge==2
drop _merge year

replace state = "Veracruz de Ignacio de la Llave" /*
	*/if state=="Veracruz of Ignacio de la Llave"
replace state = "Distrito Federal" if state=="Federal District"

//compute share of population in each state to attribute to each region
collapse (sum) stateByRegion_pop=muni_pop,by(state region region_des)

bysort state: egen state_pop = total(stateByRegion_pop)

gen proportion_pop_in_region = stateByRegion_pop/state_pop

*merge with price change data

//make region numbers consistent with those in present data set
gen region_alt = "12" if region==1
replace region_alt = "3" if region==2 | region==3
replace region_alt="4" if region==4
replace region_alt="5" if region==5
replace region_alt="6" if region==6
replace region_alt="7" if region==7
drop region

rename region_alt region

*add in two states not in data
set obs `=_N+3'
replace state = "Oaxaca" if _n==_N-2 | _n==_N-1
replace region="5" if _n==_N-2
replace region="6" if _n==_N-1
replace proportion_pop_in_region=0.5 if state== "Oaxaca"
replace state = "Campeche" if _n==_N
replace region="6" if _n==_N
replace proportion_pop_in_region=1 if state=="Campeche"


*calculate price changes for each region
preserve
use "$build\input\cravino_levchenko-peso-deval\data_requested\figure1.dta",/*
	*/clear
keep if date=="Oct. 96" & type=="Liberal"
keep region PIX_combined1 region_name
tempfile tmp
save "`tmp'"
restore

merge m:1 region using "`tmp'"

*calculate weighted average price change for each state
collapse (mean) PIX_combined1 [aweight=proportion_pop_in_region],by(state)

*generate geo1_mx codes
replace state = strtrim(state)
gen geo1_mx = 0

sort state
egen index = group(state)
replace index = 4 if state=="Campeche"
replace index = 5 if state=="Coahuila de Zaragoza"
replace index = 6 if state=="Colima"
replace index = 7 if state=="Chiapas"
replace index = 8 if state=="Chihuahua"
duplicates report index 

replace geo1_mx = geo1_mx+index
drop state
rename geo1_mx state

save "$build\output\state_level_price_changes.dta",replace
