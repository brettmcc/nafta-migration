clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

import delimited "$build\input\comtrade-trade\MexImportsFromUSisic2.csv"

keep if tradeflowname=="Import"
keep tradevaluein1000usd productcode year
rename productcode isicr2

preserve
use "$build\temp\nafta_tariffs.dta",clear
rename baserate_us tariff_us1991
rename baserate_mex tariff_mex1991
reshape long tariff_us tariff_mex, i(isicr2) j(year)
tempfile tmp
save "`tmp'"
restore

merge 1:1 isicr2 year using "`tmp'"
drop if isicr2==3131 //almost no trade in distilling and spirits anyways

preserve
contract isicr2
mkmat isicr2
restore

*make graphs 
sort isicr2 year
forvalues i=1/96 {
	local ind = isicr2[`i',1]
	quietly twoway (line tariff_mex year) (line tradevaluein1000usd year,yaxis(2)) /*
	*/if isicr2==`ind', title(ISICr2 Industry `ind') xline(1994)
	
	graph export $build\temp\tariff_trade`ind'.png,replace
}

/*Net imports*/
clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

import delimited "$build\input\comtrade-trade\MexImportsFromUSisic2.csv"

drop if tradeflowname=="Gross Exp." | tradeflowname =="Gross Imp."
drop tradeflowcode
reshape wide tradevaluein1000usd, i(productcode year) j(tradeflowname) /*
	*/string

gen net_imports = tradevaluein1000usdImport - tradevaluein1000usdExport
rename productcode isicr2
keep net_imports isicr2 year

preserve
use "$build\temp\nafta_tariffs.dta",clear
rename baserate_us tariff_us1993
rename baserate_mex tariff_mex1993
reshape long tariff_us tariff_mex, i(isicr2) j(year)
tempfile tmp
save "`tmp'"
restore

merge 1:1 isicr2 year using "`tmp'"
drop if isicr2==3131 //almost no trade in distilling and spirits anyways

//get matrix of all industry codes to prepare for loop
preserve
contract isicr2
mkmat isicr2
restore


*make graphs 
sort isicr2 year
forvalues i=1/96 {
	local ind = isicr2[`i',1]
	quietly twoway (line tariff_mex year) (line net_imports year,yaxis(2)) /*
	*/if isicr2==`ind', title(ISICr2 Industry `ind') xline(1994)
	
	graph save $build\temp\tariff_trade`ind'.gph,replace

	if mod(`i',4)==0 {
		local gph1 = isicr2[`i'-3,1]
		local gph2 = isicr2[`i'-2,1]
		local gph3 = isicr2[`i'-1,1]

		graph combine $build\temp\tariff_trade`gph1'.gph /*
			*/ $build\temp\tariff_trade`gph2'.gph /*
			*/$build\temp\tariff_trade`gph3'.gph /*
			*/$build\temp\tariff_trade`ind'.gph
			
		graph export $analysis\temp\tariff_trade`i'.png,replace
	}
	
	
}



/*Mexican Trade with the U.S.*/
import delimited "$build\input\comtrade-trade\MexImportsFromUSisic2.csv"/*
	*/,clear

keep if tradeflowname=="Export" | tradeflowname=="Import"
keep productcode year tradevaluein1000usd tradeflowname
keep if inlist(year,1990,1993,1995,2000)

reshape wide tradevaluein1000usd,i(productcode tradeflowname) j(year) 
reshape wide tradevaluein1000usd*,i(productcode) j(tradeflowname) string

rename productcode isicr2

preserve
gen chg_imports90to00 = /*
	*/tradevaluein1000usd2000Import-tradevaluein1000usd1990Import
gen chg_exports90to00 = /*
	*/tradevaluein1000usd2000Export-tradevaluein1000usd1990Export
	
gen chg_net_exports = chg_exports90to00 - chg_imports90to00
	
keep isicr2 chg_imports90to00 chg_exports90to00 chg_net_exports

save "$build\temp\trade_mex2us_isicr2.dta",replace
restore

gen chg_imports1995 = /*
	*/tradevaluein1000usd1995Import-tradevaluein1000usd1990Import
gen chg_imports2000 = /*
	*/tradevaluein1000usd2000Import-tradevaluein1000usd1995Import
gen chg_exports1995 = /*
	*/tradevaluein1000usd1995Export-tradevaluein1000usd1990Export
gen chg_exports2000 = /*
	*/tradevaluein1000usd2000Export-tradevaluein1000usd1995Export
	
gen pct_chg_imports1995 = /*
	*/(tradevaluein1000usd1995Import-tradevaluein1000usd1990Import)/*
	*/ /(tradevaluein1000usd1990Import)
gen pct_chg_imports2000 = /*
	*/(tradevaluein1000usd2000Import-tradevaluein1000usd1995Import)/*
	*/ /(tradevaluein1000usd1995Import)
gen pct_chg_exports1995 = /*
	*/(tradevaluein1000usd1995Export-tradevaluein1000usd1990Export)/*
	*/ /tradevaluein1000usd1990Export
gen pct_chg_exports2000 = /*
	*/(tradevaluein1000usd2000Export-tradevaluein1000usd1995Export	)/*
	*/ /tradevaluein1000usd1995Export
	
reshape long chg_imports chg_exports pct_chg_imports pct_chg_exports,/*
	*/i(isicr2) j(year)

gen chg_net_exports = chg_exports - chg_imports

keep chg_imports chg_exports year isicr2 chg_net_exports /*
	*/pct_chg_imports pct_chg_exports

save $build\temp\trade_mex2us_isicr2_5yr,replace




/*Trade flows at the HTS6 level*/
import delimited $build\input\comtrade-trade\USTradeFromMexhts6.csv,/*
	*/clear
keep productcode year tradevaluein1000usd tradeflowname
keep if inlist(year,1991,1993,1995,2000)
	
reshape wide tradevaluein1000usd,i(productcode tradeflowname) j(year) 
reshape wide tradevaluein1000usd*,i(productcode) j(tradeflowname) string

rename productcode hts6	

gen chg_exports1995us = /*
	*/tradevaluein1000usd1995Import-tradevaluein1000usd1991Import
gen chg_exports2000us = /*
	*/tradevaluein1000usd2000Import-tradevaluein1000usd1993Import
gen chg_imports1995us = /*
	*/tradevaluein1000usd1995Export-tradevaluein1000usd1991Export
gen chg_imports2000us = /*
	*/tradevaluein1000usd2000Export-tradevaluein1000usd1993Export
	
gen pct_chgus_exports1995 = /*
	*/(tradevaluein1000usd1995Import-tradevaluein1000usd1991Import)/*
	*/ /(tradevaluein1000usd1991Import)
gen pct_chgus_exports2000 = /*
	*/(tradevaluein1000usd2000Import-tradevaluein1000usd1993Import)/*
	*/ /(tradevaluein1000usd1993Import)
gen pct_chgus_imports1995 = /*
	*/(tradevaluein1000usd1995Export-tradevaluein1000usd1991Export)/*
	*/ /tradevaluein1000usd1991Export
gen pct_chgus_imports2000 = /*
	*/(tradevaluein1000usd2000Export-tradevaluein1000usd1993Export	)/*
	*/ /tradevaluein1000usd1993Export

preserve
import delimited $build\input\comtrade-trade\MexTradeFromUShts6.csv,/*
	*/clear
keep productcode year tradevaluein1000usd tradeflowname
keep if inlist(year,1990,1993,1995,2000)
	
reshape wide tradevaluein1000usd,i(productcode tradeflowname) j(year) 
reshape wide tradevaluein1000usd*,i(productcode) j(tradeflowname) string

rename productcode hts6	


gen chg_imports1995mx = /*
	*/tradevaluein1000usd1995Import-tradevaluein1000usd1990Import
gen chg_imports2000mx = /*
	*/tradevaluein1000usd2000Import-tradevaluein1000usd1993Import
gen chg_exports1995mx = /*
	*/tradevaluein1000usd1995Export-tradevaluein1000usd1990Export
gen chg_exports2000mx = /*
	*/tradevaluein1000usd2000Export-tradevaluein1000usd1993Export
	
gen pct_chgmx_imports1995 = /*
	*/(tradevaluein1000usd1995Import-tradevaluein1000usd1990Import)/*
	*/ /(tradevaluein1000usd1990Import)
gen pct_chgmx_imports2000 = /*
	*/(tradevaluein1000usd2000Import-tradevaluein1000usd1993Import)/*
	*/ /(tradevaluein1000usd1993Import)
gen pct_chgmx_exports1995 = /*
	*/(tradevaluein1000usd1995Export-tradevaluein1000usd1990Export)/*
	*/ /tradevaluein1000usd1990Export
gen pct_chgmx_exports2000 = /*
	*/(tradevaluein1000usd2000Export-tradevaluein1000usd1993Export	)/*
	*/ /tradevaluein1000usd1993Export

tempfile tmp
save "`tmp'"
restore
merge 1:1 hts6 using "`tmp'"
drop _merge
drop if hts6=="9999AA"
destring hts6,replace

reshape long pct_chgus_exports pct_chgus_imports pct_chgmx_exports/*
	*/ pct_chgmx_imports,i(hts6) j(year)

preserve 
use "$build\output\nafta_romalis_tariffs_hs6.dta",clear
keep mexico_tariff_hakomcl hts6 year
tsset hts6 year
gen tariff_chg = mexico_tariff_hakomcl-l7.mexico_tariff_hakomcl /*
	*/if year==2000

tempfile tmp2
save "`tmp2'"
restore
	
merge 1:1 hts6 year using "`tmp2'"
drop if _merge!=3
drop tradevalue*



/*Aggregate trade flows*/
import delimited $build\input\comtrade-trade\USTradeFromMexhts6.csv,/*
	*/clear
keep productcode year tradevaluein1000usd tradeflowname
reshape wide tradevaluein1000usd, i(productcode year) j(tradeflowname) /*
	*/string 
gen country = "US"


preserve 
import delimited $build\input\comtrade-trade\MexTradeFromUShts6.csv,/*
	*/clear
keep productcode year tradevaluein1000usd tradeflowname
replace tradevaluein1000usd = tradevaluein1000usd*100 if year!=1990
reshape wide tradevaluein1000usd, i(productcode year) j(tradeflowname) /*
	*/string 
gen country = "Mex"
tempfile tmp
save "`tmp'"
restore

merge 1:1 productcode year using "`tmp'"

collapse (sum) tradevaluein1000usdExport tradevaluein1000usdImport, /*
	*/by(year country)
sort country year

save $build\output\agg_usmex_trade.dta,replace
