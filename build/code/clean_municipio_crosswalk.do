clear all
set more off,permanently

global build "C:\Users\bmccully\Documents\nafta-migration\build"

import excel using "$build\input\geo2_mx_tt.xlsx",firstrow clear
drop if _n>=1 & _n<=13
keep code label mx1990a mx1995a mx2000a
drop if mx1995a=="" & mx2000a==""

rename code state_munic_code_xwalk
destring state_munic_code_xwalk mx1990a mx1995a mx2000a,replace
replace state_munic_code_xwalk = mod(state_munic_code_xwalk,1000000)
order state_munic_code_xwalk label mx1990a mx1995a mx2000a
rename mx1995a mx1995a_resmun 
rename mx2000a mx2000a_resmun

save "$build\temp\municipio_crosswalk.dta",replace


import excel using "$build\input\geo2_mx_tt.xlsx",firstrow clear
drop if _n>=1 & _n<=13 //drop header
drop if mx1995a=="" & mx2000a=="" & mx2000a=="" & mx2005a=="" /*
	*/& mx2010a=="" & mx1990a==""
keep code label mx1990a mx1995a mx2000a mx2005a mx2010a
rename code state_munic_code_xwalk
destring state_munic_code_xwalk mx1990a mx1995a mx2000a /*
	*/mx2005a mx2010a,replace
replace state_munic_code_xwalk = mod(state_munic_code_xwalk,1000000)

save "$build\temp\municipio_crosswalk90to10.dta",replace
