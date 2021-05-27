*Calculate region-specific wage premia

clear all
set more off,permanently

global build "C:\Users\bmccully\Documents\nafta-migration\build"

/*MUNICPALITY LEVEL*/
* Normalize 1990 regional wage premia from Mincer-style regression
use "$build\temp\mex_census_90_95_00.dta" if year==1990,clear
collapse (sum) population,by(geo2_mx)




reg ln_wage urban_dummy homeowner i.sizemx age age2 /*
	*/female married primary_school_only /*
	*/secondary_school_only college_grad i.indgen /*
	*/i.geo2_mx if year==1990 [aweight=perwt], robust
	
reg ln_wage urban_dummy homeowner i.sizemx age age2 /*
	*/female married primary_school_only /*
	*/secondary_school_only college_grad i.indgen /*
	*/i.geo2_mx if year==2000 [aweight=perwt], robust
