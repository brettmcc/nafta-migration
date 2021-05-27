*analyze selection using net-migration method
*Brett McCully, January 2018

clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

use "$build\temp\mex_census_90_95_00.dta",clear 

keep if (year==1990 & age>=25 & age<=45) | /*
	*/(year==1995 & age>=30 & age<=50) | (year==2000 & age>=35 & age<=55)

/*Nationally*/
*years of education
preserve 
collapse (sum) perwt, by(year yrschool)
reshape wide perwt, i(yrschool) j(year)
drop if yrschool==.
egen sum90 = total(perwt1990)
egen sum95 = total(perwt1995)
egen sum00 = total(perwt2000)

gen pop_frac90 = perwt1990/sum90
gen pop_frac95 = perwt1995/sum95
gen pop_frac00 = perwt2000/sum00
drop sum* perwt*

graph bar pop_frac*,over(yrschool)
restore

*literacy rate
preserve
collapse (sum) perwt, by(year lit)
reshape wide perwt, i(lit) j(year)
drop if lit==. | lit==9
egen sum90 = total(perwt1990)
egen sum95 = total(perwt1995)
egen sum00 = total(perwt2000)

gen pop_frac90 = perwt1990/sum90
gen pop_frac95 = perwt1995/sum95
gen pop_frac00 = perwt2000/sum00
drop sum* perwt*

graph bar pop_frac*,over(lit)
restore

*sex
bysort year: tab sex [aweight=perwt]
	
*binned years of education	
gen yrschool_binned = .
replace yrschool_binned = 1 if yrschool>=0 & yrschool<=6
replace yrschool_binned = 2 if yrschool>=7 & yrschool<=9
replace yrschool_binned = 3 if yrschool>=10 & yrschool<=12
replace yrschool_binned = 4 if yrschool>=13 & yrschool<=16
replace yrschool_binned = 5 if yrschool>=17 & yrschool!=.

label define yrschlbin 1 "0-6 yrs" 2 "7-9 yrs" 3 "10-12 yrs" 4 "13-16 yrs" /*
	*/5 "17+ yrs"
label values yrschool_binned yrschlbin

preserve
collapse (sum) perwt, by(year yrschool_binned)
reshape wide perwt, i(yrschool_binned) j(year)
drop if yrschool_binned==. 
egen sum90 = total(perwt1990)
egen sum95 = total(perwt1995)
egen sum00 = total(perwt2000)

gen pop_frac90 = perwt1990/sum90
gen pop_frac95 = perwt1995/sum95
gen pop_frac00 = perwt2000/sum00
drop sum* perwt*

label variable pop_frac90 "1990"
label variable pop_frac95 "1995"
label variable pop_frac00 "2000"

graph bar pop_frac*,over(yrschool_binned)
restore


/*State level*/
use "$build\temp\mex_census_90_95_00.dta",clear 
append using "$build\temp\mex_census05.dta"

keep if (year==1990 & age>=25 & age<=45) | /*
	*/(year==1995 & age>=30 & age<=50) | /*
	*/ (year==2000 & age>=35 & age<=55)/*
	*/ | (year==2005 & age>=40 & age<=60)
	
*binned years of education	
gen yrschool_binned = .
replace yrschool_binned = 1 if yrschool>=0 & yrschool<=6
replace yrschool_binned = 2 if yrschool>=7 & yrschool<=9
replace yrschool_binned = 3 if yrschool>=10 & yrschool<=12
replace yrschool_binned = 4 if yrschool>=13 & yrschool<=16
replace yrschool_binned = 5 if yrschool>=17 & yrschool!=.

label define yrschlbin 1 "0-6 yrs" 2 "7-9 yrs" 3 "10-12 yrs" 4 "13-16 yrs" /*
	*/5 "17+ yrs"
label values yrschool_binned yrschlbin

*distribution of education for everyone, t-5
preserve
collapse (sum) totpop=perwt, by(year yrschool_binned geo1_mx)
rename geo1_mx state
save "$build\temp\tmp_all.dta",replace
restore

*distribution of education for stayers, t
preserve
collapse (sum) stayers=perwt if (geo1_mx==migmx2 & migrate5!=30), /*
	*/by(year yrschool_binned geo1_mx)
rename geo1_mx state
save "$build\temp\tmp_stayers.dta",replace
restore

*distribution of education for interstate outflowers
preserve
collapse (sum) state_outfl=perwt if (geo1_mx!=migmx2 & migrate5!=30), /*
	*/by(year yrschool_binned migmx2)
rename migmx2 state
save "$build\temp\tmp_state_outfl.dta",replace
restore

*distribution of education for interstate inflowers
preserve
collapse (sum) state_infl=perwt if (geo1_mx!=migmx2 & migrate5!=30), /*
	*/by(year yrschool_binned geo1_mx)
rename geo1_mx state
save "$build\temp\tmp_state_infl.dta",replace
restore

*distribution of education for international inflowers
preserve
collapse (sum) intl_infl=perwt if (migrate5==30), by(year yrschool_binned geo1_mx)
rename geo1_mx state
save "$build\temp\tmp_intl_infl.dta",replace
restore

*merge together
use "$build\temp\tmp_all.dta",clear 
rename totpop all_tminus5
replace year = year+5
drop if year==2010 

merge 1:1 year state yrschool_binned using /*
	*/"$build\temp\tmp_stayers.dta", nogenerate
merge 1:1 year state yrschool_binned using /*
	*/"$build\temp\tmp_state_outfl.dta", nogenerate
merge 1:1 year state yrschool_binned using /*
	*/"$build\temp\tmp_state_infl.dta", nogenerate
merge 1:1 year state yrschool_binned using /*
	*/"$build\temp\tmp_intl_infl.dta", nogenerate
merge 1:1 year state yrschool_binned using /*
	*/"$build\temp\tmp_all.dta", nogenerate

drop if year==1990
drop if yrschool_binned==.
drop if state==99

//replace all_tminus5 = 0 if all_tminus5==.
replace stayers = 0 if stayers==.
replace state_outfl = 0 if state_outfl==.
replace state_infl = 0 if state_infl==.
replace intl_infl = 0 if intl_infl==.

gen intl_outfl = all_tminus5-stayers-state_outfl
gen intl_outfl_rate = intl_outfl/all_tminus5


/*State level, coarse education measure*/
use "$build\temp\mex_census_90_95_00.dta",clear 
append using "$build\temp\mex_census05.dta"

local lowerbd = 22
local upperbd = `lowerbd'+20
keep if (year==1990 & age>=`lowerbd' & age<=`upperbd') | /*
	*/(year==1995 & age>=`lowerbd'+5 & age<=`upperbd'+5) | /*
	*/ (year==2000 & age>=`lowerbd'+10 & age<=`upperbd'+10)/*
	*/ | (year==2005 & age>=`lowerbd'+15 & age<=`upperbd'+15)
bysort year: sum yrschool [aweight=perwt]
	
*binned years of education	
gen yrschool_binned = .
replace yrschool_binned = 1 if yrschool>=0 & yrschool<=4
replace yrschool_binned = 2 if yrschool>=5 & yrschool<=8
replace yrschool_binned = 3 if yrschool>=9 & yrschool!=.

label define yrschlbin 1 "0-4 yrs" 2 "5-8 yrs" 3 "9+ yrs" 
label values yrschool_binned yrschlbin

*distribution of education for everyone, t-5
preserve
collapse (sum) totpop=perwt, by(year yrschool_binned geo1_mx)
rename geo1_mx state
save "$build\temp\tmp_all.dta",replace
restore

*distribution of education for stayers, t
preserve
collapse (sum) stayers=perwt if (geo1_mx==migmx2 & migrate5!=30), /*
	*/by(year yrschool_binned geo1_mx)
rename geo1_mx state
save "$build\temp\tmp_stayers.dta",replace
restore

*distribution of education for interstate outflowers
preserve
collapse (sum) state_outfl=perwt if (geo1_mx!=migmx2 & migrate5!=30), /*
	*/by(year yrschool_binned migmx2)
rename migmx2 state
save "$build\temp\tmp_state_outfl.dta",replace
restore

*distribution of education for interstate inflowers
preserve
collapse (sum) state_infl=perwt if (geo1_mx!=migmx2 & migrate5!=30), /*
	*/by(year yrschool_binned geo1_mx)
rename geo1_mx state
save "$build\temp\tmp_state_infl.dta",replace
restore

*distribution of education for international inflowers
preserve
collapse (sum) intl_infl=perwt if (migrate5==30), by(year yrschool_binned/*
	*/ geo1_mx)
rename geo1_mx state
save "$build\temp\tmp_intl_infl.dta",replace
restore

*merge together
use "$build\temp\tmp_all.dta",clear 
rename totpop all_tminus5
replace year = year+5
drop if year==2010 

merge 1:1 year state yrschool_binned using /*
	*/"$build\temp\tmp_stayers.dta", nogenerate
merge 1:1 year state yrschool_binned using /*
	*/"$build\temp\tmp_state_outfl.dta", nogenerate
merge 1:1 year state yrschool_binned using /*
	*/"$build\temp\tmp_state_infl.dta", nogenerate
merge 1:1 year state yrschool_binned using /*
	*/"$build\temp\tmp_intl_infl.dta", nogenerate
merge 1:1 year state yrschool_binned using /*
	*/"$build\temp\tmp_all.dta", nogenerate

drop if year==1990
drop if yrschool_binned==.
drop if state==99

//replace all_tminus5 = 0 if all_tminus5==.
replace stayers = 0 if stayers==.
replace state_outfl = 0 if state_outfl==.
replace state_infl = 0 if state_infl==.
replace intl_infl = 0 if intl_infl==.

gen intl_outfl = all_tminus5-stayers-state_outfl
gen intl_outfl_rate = intl_outfl/all_tminus5

save "$build\output\state_selection.dta",replace


/*state level - no bins*/
use "$build\temp\mex_census_90_95_00.dta",clear 
append using "$build\temp\mex_census05.dta"

local lowerbd = 22
local upperbd = `lowerbd'+20
keep if (year==1990 & age>=`lowerbd' & age<=`upperbd') | /*
	*/(year==1995 & age>=`lowerbd'+5 & age<=`upperbd'+5) | /*
	*/ (year==2000 & age>=`lowerbd'+10 & age<=`upperbd'+10)/*
	*/ | (year==2005 & age>=`lowerbd'+15 & age<=`upperbd'+15)

*distribution of education for stayers, t
preserve
collapse (sum) stayers=perwt (count) N=perwt if (geo1_mx==migmx2 & migrate5!=30), /*
	*/by(year yrschool geo1_mx)
rename geo1_mx state
save "$build\temp\tmp_stayers2.dta",replace
restore

*distribution of education for interstate outflowers
preserve
collapse (sum) state_outfl=perwt (count) N=perwt if (geo1_mx!=migmx2 & migrate5!=30), /*
	*/by(year yrschool migmx2)
rename migmx2 state
save "$build\temp\tmp_state_outfl2.dta",replace
restore

*merge together
collapse (sum) totpop=perwt (count) N=perwt, by(year yrschool geo1_mx)
rename geo1_mx state
rename totpop all_tminus5
replace year = year+5
drop if year==2010 

merge 1:1 year state yrschool using /*
	*/"$build\temp\tmp_stayers2.dta", nogenerate
merge 1:1 year state yrschool using /*
	*/"$build\temp\tmp_state_outfl2.dta", nogenerate

replace stayers = 0 if stayers==.
replace state_outfl = 0 if state_outfl==.

gen intl_outfl_rt = (all_tminus5-stayers-state_outfl)/all_tminus5
