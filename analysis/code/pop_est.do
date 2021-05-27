*estimate Mexico's population
*Brett McCully, January 2018

global build "C:\Users\bmccully\Documents\nafta-migration\build"

/*National level*/
use "$build\temp\mex_census_90_95_00.dta",clear 

collapse (sum) perwt,by(year)

/*State level*/
use "$build\temp\mex_census_90_95_00.dta",clear 

*calculate 1990 population
collapse (sum) perwt,by(year geo1_mx)
drop if year==.
//keep if year==1990
replace perwt = perwt*100
format perwt %12.0fc

save "$build\temp\state_pop90.dta",replace

/*Municipality level*/
use "$build\temp\mex_census_90_95_00.dta",clear 

bysort geo1_mx year: egen state_pop = sum(perwt)
recast double state_pop 

collapse (sum) perwt (max) state_pop, by(year geo2_mx)

*subset to only those municipalities that show up in 1995
tsset geo2_mx year
drop if year==1990 & f5.perwt==.
drop if year==2000 & l5.perwt==.

gen close = (state_pop>=perwt-1 & state_pop<=perwt+1)

gen pop_interpolated = (l5.perwt+f5.perwt)/2

*municipality level population in 1990
use if year==1990 using "$build\temp\mex_census_90_95_00.dta",clear 
replace perwt = perwt*100
collapse (sum) muni_pop=perwt,by(year geo2_mx)
rename geo2_mx munic

save "$build\temp\muni_pop1990.dta",replace
