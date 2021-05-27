set more off, permanently
clear all

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

/**********************************************************************
 * 		UNCTAD-TRAINS TARIFF DATA									 *
**********************************************************************/

/*Compare USITC reported tariffs (via Romalis  et al. (2002) and then 
  Hakobyan and McLaren (2016)) to NAFTA Annex 302.2 tariff phaseouts*/
use "$build\output\nafta_romalis_tariffs_hs6.dta",clear

label variable tariff_us "NAFTA text"
label variable mexico_tariff_hakomcl "USITC"
corr tariff_us mexico_tariff_hakomcl
twoway (scatter tariff_us mexico_tariff_hakomcl) /*
	*/(lfit tariff_us mexico_tariff_hakomcl), /*
	*/title(USITC vs. NAFTA Tariff Phaseouts) /*
	*/note("Source: USITC tariffs collected by Romalis et al. (2002) and cleaned by Hakobyan and McLaren (2016)." /*
	*/ "NAFTA tariffs from UNCTAD TRAINS for pre-1994 year; reductions from agreement Annex 302.2")
graph export "$analysis\output\graphs\scatter_US_tariffs.png",replace
	
use "$build\output\nafta_romalis_tariffs_isicr2.dta",clear
corr tariff_us mexico_tariff_hakomcl

collapse (mean) tariff_us mexico_tariff_hakomcl,by(year)

label variable tariff_us "NAFTA text"
label variable mexico_tariff_hakomcl "USITC"
corr tariff_us mexico_tariff_hakomcl
twoway (line tariff_us year) (line mexico_tariff_hakomcl year),/*
	*/title(USITC vs. NAFTA Tariff Phaseouts) /*
	*/note("Source: USITC tariffs collected by Romalis et al. (2002) and cleaned by Hakobyan and McLaren (2016)." /*
	*/ "NAFTA tariffs from UNCTAD TRAINS for pre-1994 year; reductions from agreement Annex 302.2")
graph export "$analysis\output\graphs\timeseries_US_tariffs.png",replace

	
/*Mexican tariffs on US goods*/

/*time series*/
insheet using "$build\input\unctad_trains_industry_tariffs_mex.csv",/*
	*/comma clear
	
*keep only applied tariffs
keep if dutytype=="AHS"
	
twoway line simpleaverage tariffyear if /*
	*/productname=="MANUFACTURE OF CHEMICALS AND CHEMICAL PRODUCTS"
	
	
collapse (mean) simpleaverage weightedaverage, by(tariffyear)

label variable simpleaverage "Simple Avg."
label variable weightedaverage "Weighted Avg."

twoway line simpleaverage weightedaverage tariffyear, xline(1994) /*
	*/title("Avg. Tariff Rates Charged by Mex. on US Goods") /*
	*/ytitle("Avg. Tariff") /*
	*/note(Source: UNCTAD TRAINS.) xtitle("")

graph export "$analysis\output\graphs\avg_tariffs_trains_mex.png",replace

/*initial levels by industry*/
*Mexican import tariffs
use "$build\temp\nafta_tariffs.dta",clear
keep isicr2 baserate_*
label variable baserate_us "Base rate U.S. (simple Avg.)"
label variable baserate_mex "Base rate Mex. (simple Avg.)"
graph bar baserate_mex, /*
	*/title(Initial Import Tariffs by Industry) /*
	*/over(isicr2,label(angle(vertical))) /*
	*/exclude0 

*Mexican export tariffs to US
use "$build\temp\initial_tariffs_by_ind_us.dta",clear
drop tariffyear
label variable simpleaverage "Tariff Rate (simple avg.)"
label variable industry_group "Industry"
graph bar simpleaverage, /*
	*/title(Initial Export (U.S.) Tariffs by Industry) /*
	*/over(industry_group,label(angle(vertical))) /*
	*/exclude0
	
*Histograms comparing 5 and 10 year RTC_mex
//5-year state 
use "$build\output\nafta_exposure_5yr.dta",clear
twoway (histogram RTC_mex5yr if year==1995, color(green) width(.005) /*
	*/start(-0.085)) /*
	*/(histogram RTC_mex5yr if year==2000,fcolor(none) lcolor(black) /*
	*/width(.005) start(-0.085)),/*
	*/legend(order(1 "1995" 2 "2000")) title("5-year State RTC, Imports")
graph save $analysis\temp\st_5yr_rtcmx , replace	

//5-year muni
use "$build\output\nafta_exposure_5yr_munic.dta",clear
twoway (histogram RTC_mex5yr if year==1995, color(green) width(.005) /*
	*/start(-0.12)) /*
	*/(histogram RTC_mex5yr if year==2000,fcolor(none) lcolor(black) /*
	*/width(.005) start(-0.12)),/*
	*/legend(order(1 "1995" 2 "2000")) title("5-year State RTC, Imports")
graph save $analysis\temp\mn_5yr_rtcmx , replace

//10-year state
use "$build\output\nafta_exposure.dta",clear
histogram RTC_mex00, width(0.005) title("10-year State RTC, Imports")
graph save $analysis\temp\st_10yr_rtcmx , replace

//10-year muni
use "$build\output\nafta_exposure_munic.dta",clear
histogram RTC_mex00, width(0.005) title("10-year State RTC, Imports")
graph save $analysis\temp\mn_10yr_rtcmx , replace	


/*US tariffs on Mexican goods*/
insheet using "$build\input\unctad_trains_industry_tariffs_us.csv",/*
	*/comma clear

preserve
collapse (mean) simpleaverage,/*
	*/by(tariffyear)
label variable simpleaverage "Simple Avg."

tempfile tmp
save "`tmp'
restore	

collapse (mean) weightedaverage [aweight=importsvaluein1000usd],/*
	*/by(tariffyear)
label variable weightedaverage "Weighted Avg."

merge 1:1 tariffyear using "`tmp'"

twoway line simpleaverage weightedaverage tariffyear, xline(1994) /*
	*/title("Avg. Tariff Rates Charged by US on Mexican Goods") /*
	*/ytitle("Avg. Tariff") /*
	*/note(Source: UNCTAD TRAINS.) xtitle("")

graph export "$analysis\output\graphs\avg_tariffs_trains_us.png",replace

*Histograms comparing 5 and 10 year RTC_us
//5-year state
use "$build\output\nafta_exposure_5yr.dta",clear
twoway (histogram RTC_us5yr if year==1995, color(green) width(.005) /*
	*/start(-0.05)) /*
	*/(histogram RTC_us5yr if year==2000,fcolor(none) lcolor(black) /*
	*/width(.005) start(-0.05)),/*
	*/legend(order(1 "1995" 2 "2000")) /*
	*/title("5-year State RTC, Exports (U.S.)")
graph save $analysis\temp\st_5yr_rtcus, replace

//5-year muni
use "$build\output\nafta_exposure_5yr_munic.dta",clear
twoway (histogram RTC_us5yr if year==1995, color(green) width(.005) /*
	*/start(-0.065)) /*
	*/(histogram RTC_us5yr if year==2000,fcolor(none) lcolor(black) /*
	*/width(.005) start(-0.065)),/*
	*/legend(order(1 "1995" 2 "2000")) /*
	*/title("5-year Muni. RTC, Exports (U.S.)")
graph save $analysis\temp\mn_5yr_rtcus , replace

//10-year state
use "$build\output\nafta_exposure.dta",clear
histogram RTC_us00, width(0.005) /*
	*/title("10-year State RTC, Exports (U.S.)")
graph save $analysis\temp\st_10yr_rtcus , replace
//10-year muni
use "$build\output\nafta_exposure_munic.dta",clear
histogram RTC_us00, width(0.005) title("10-year Muni. RTC, Exports (U.S.)")
graph save $analysis\temp\mn_10yr_rtcus , replace

graph combine $analysis\temp\st_5yr_rtcus.gph /*
	*/$analysis\temp\st_5yr_rtcmx.gph /*
	*/$analysis\temp\st_10yr_rtcus.gph $analysis\temp\st_10yr_rtcmx.gph,/*
	*/note(Source: NAFTA Annex 302.2 for tariff changes; UNCTAD-TRAINS /*
	*/for base rate.) title(State Regional Tariff Change Histograms)

graph export "$analysis\output\graphs\st_rtc_histograms.png",replace

graph combine $analysis\temp\mn_5yr_rtcus.gph /*
	*/$analysis\temp\mn_5yr_rtcmx.gph /*
	*/$analysis\temp\mn_10yr_rtcus.gph $analysis\temp\mn_10yr_rtcmx.gph,/*
	*/note(Source: NAFTA Annex 302.2 for tariff changes; UNCTAD-TRAINS /*
	*/for base rate.) title(Municipality Regional Tariff Change Histograms)

graph export "$analysis\output\graphs\muni_rtc_histograms.png",replace
	
	
/**********************************************************************
 * 		NAFTA TARIFF SCHEDULE DATA									 *
**********************************************************************/

*show time series of simple average tariff rate
use "$build\temp\nafta_tariffs.dta",clear
rename baserate_us tariff_us1993
rename baserate_mex tariff_mex1993
reshape long tariff_us tariff_mex, i(isicr2) j(year)
collapse (mean) tariff_us tariff_mex,by(year) 

label variable year "Year"
label variable tariff_us "Export tariff (US)"
label variable tariff_mex "Import tariff"

twoway (line tariff_us year) /*
	*/(line tariff_mex year), xline(1994) /*
	*/title("Tariff Rates (Simple avg.)") /*
	*/note("Source: NAFTA Tariff Phaseout Schedule from http://tech.mit.edu/Bulletins/Nafta/ for changes in rates;" "             base rate from UNCTAD-TRAINS.") 

graph export "$analysis\output\graphs\tariff_chg.png",replace
