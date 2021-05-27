clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

//twoway (line tradevaluein1000usdExport year if country=="Mex") /*
//	*/(line tradevaluein1000usdImport year if country=="US")
	
//twoway (line tradevaluein1000usdExport year if country=="US") /*
//	*/(line tradevaluein1000usdImport year if country=="Mex")

use $build\output\agg_usmex_trade.dta,clear

label variable tradevaluein1000usdExport "Mex. Imports from US"
label variable tradevaluein1000usdImport "Mex. Exports to US"
replace tradevaluein1000usdExport=tradevaluein1000usdExport/1000000
replace tradevaluein1000usdImport=tradevaluein1000usdImport/1000000
*US numbers line up with Census bureau reports so will use those
twoway (line tradevaluein1000usdExport year) /*
	*/(line tradevaluein1000usdImport year) if country=="US", /*
	*/note(Source: UN-COMTRADE) title("Trade in Goods between US and Mexico, 1990s")/*
	*/ytitle("Value (billions of USD)")
graph export "$analysis\output\graphs\agg_trade.png",replace
