clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"

use "C:\Users\bmccully\Documents\hakobyan_mclaren_2016\tariffs1990-2000.dta",/*
	*/clear
drop mfn_ave
rename mexico_ave mexico_tariff_hakomcl

reshape wide mexico_tariff_hakomcl, i(hts8) j(year)

gen hts6 = int(hts8/100)
tostring hts8,replace
replace hts8 = "0"+hts8 if length(hts8)<8

save "$build\temp\ustariffs1990-2000_hakoMclaren16.dta",replace


use "$build\temp\ustariffs1990-2000_hakoMclaren16.dta",clear

collapse (mean) mexico_tariff_hakomcl*, by(hts6)

save "$build\temp\ustariffs1990-2000_hs6_hakoMclaren16.dta",replace
