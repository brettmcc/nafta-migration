clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"

import delimited using /*
	*/"$build\input\tariffs-WITS\UStariffsOnMexicoProduct.csv",clear
keep product simpleaverage dutytype tariffyear
rename product hts6
rename tariffyear year
reshape wide simpleaverage, i(hts6 year) j(dutytype) string
egen tariff_usonmex_wits = rowfirst(simpleaverageAHS simpleaveragePRF /*
	*/simpleaverageMFN simpleaverageBND)
drop simpleaverage*
drop if year==1995
reshape wide tariff_usonmex_wits,i(hts6) j(year)
egen baserate_us = rowfirst(tariff_usonmex_wits1993 /*
	*/tariff_usonmex_wits1992 tariff_usonmex_wits1991 /*
	*/tariff_usonmex_wits1990 tariff_usonmex_wits1989)
drop tariff_usonmex_wits*
rename hts6 hs6
tostring hs6, replace
replace hs6 = "0"+hs6 if strlen(hs6)==5

merge m:1 hs6 using "$build\temp\nafta_tariffs_hs6.dta"
replace baserate_us = 0 if baserateus_equal_zero==1

keep hs6 pct_tariff_us* isicr2 baserate_us
drop if hs6==""
rename hs6 hts6
destring hts6,replace

reshape long pct_tariff_us,i(hts6 baserate_us isicr2) j(year)
gen tariff_us = pct_tariff_us*baserate_us
drop pct_tariff_us
reshape wide tariff_us,i(hts6 baserate_us isicr2) j(year)
rename baserate_us tariff_us1993
	
merge 1:1 hts6 using "$build\temp\ustariffs1990-2000_hs6_hakoMclaren16.dta"
//master only obs include many from 98+ hs2 categories which are not
//product specific but refer to duties placed on goods transferred via
//intl. travel (e.g. cruises, airlines, etc.)
drop if _merge==1
//using only obs appear to be new product lines that were added between
//NAFTA and 2000.
drop if _merge==2
drop _merge

reshape long tariff_us mexico_tariff_hakomcl,/*
	*/i(hts6) j(year)
drop if year>2000 | year<1990
replace tariff_us=tariff_us/100

save "$build\output\nafta_romalis_tariffs_hs6.dta",replace

use "$build\output\nafta_romalis_tariffs_hs6.dta",clear
collapse (mean) tariff_us mexico_tariff_hakomcl,by(year isicr2)

save "$build\output\nafta_romalis_tariffs_isicr2.dta",replace

/*Make 5-year stacked differences*/
use "$build\output\nafta_romalis_tariffs_isicr2.dta",clear
reshape wide tariff_us mexico_tariff_hakomcl,i(isicr2) j(year)

keep isicr2 tariff_us1995 tariff_us2000  mexico_tariff_hakomcl1995/*
	*/ tariff_us1993 mexico_tariff_hakomcl1990 mexico_tariff_hakomcl2000

reshape long tariff_us mexico_tariff_hakomcl, i(isicr2) j(year) 
destring isicr2,replace
tsset isicr2 year
gen ln_tariff_chg_HM16_us5yrdiff = ln(1+mexico_tariff_hakomcl)-/*
	*/ln(1+l5.mexico_tariff_hakomcl) if year==2000
replace ln_tariff_chg_HM16_us5yrdiff = ln(1+mexico_tariff_hakomcl)-/*
	*/ln(1+l5.mexico_tariff_hakomcl) if year==1995
gen ln_tariff_chg_wits_us5yrdiff = ln(1+tariff_us)-/*
	*/ln(1+l5.tariff_us) if year==2000
replace ln_tariff_chg_wits_us5yrdiff = ln(1+tariff_us)-/*
	*/ln(1+l2.tariff_us) if year==1995
keep if year==1995 | year==2000
keep isicr2 year ln_tariff_chg_HM16_us5yrdiff ln_tariff_chg_wits_us5yrdiff

save "$build\temp\us_tariffs_5yrdiff.dta",replace

/*Make 10-year long differences*/
use "$build\output\nafta_romalis_tariffs_isicr2.dta",clear
keep if year==1990 | year==1993 | year==2000
reshape wide tariff_us mexico_tariff_hakomcl,i(isicr2) j(year)

gen ln_tariff_chg_HM16_us90to00 = ln(1+mexico_tariff_hakomcl2000)-/*
	*/ln(1+mexico_tariff_hakomcl1990)
gen ln_tariff_chg_wits_us90to00 = ln(1+tariff_us2000)-ln(1+tariff_us1993)

destring isicr2,replace 
drop mexico_tariff_hakomcl* tariff_us*

save "$build\temp\us_tariffs_10yrdiff.dta",replace


