/*Cleaning NAFTA tariffs found on MIT server*/



/* 1. NAFTA tariff schedule data 			ISICr2-HS6 x-walk	WITS tariff
	HS8						-->		HS6 --> ISICr2		-->	ISICr2
						(simple avg.)
						*/

set more off, permanently
clear all
global build "C:\Users\bmccully\Documents\nafta-migration\build"


*clean NAFTA phaseout tariff schedules
import delimited /*
	*/"$build\input\nafta-phaseout-schedule-MIT\tariffs-1.csv",/*
	*/stringcols(_all) varnames(1) clear

rename v4 canada_sched
rename v6 usa_sched
rename v8 mex_sched

drop if subhead=="" & description=="" & canada=="" & canada_sched==""/*
	*/& usa=="" & usa_sched=="" & mexico=="" & mex_sched==""
	
tempfile tmp
save "`tmp'"

import delimited /*
	*/"$build\input\nafta-phaseout-schedule-MIT\tariffs-2.csv",/*
	*/stringcols(_all) varnames(1) clear

rename v4 canada_sched
rename v6 usa_sched
rename v8 mex_sched

drop if subhead=="" & description=="" & canada=="" & canada_sched=="" & /*
	*/usa=="" & usa_sched=="" & mexico=="" & mex_sched==""
	
append using "`tmp'"

*fix errors in read-in
replace canada="7219.22.00" if subhead=="7209.12"
replace canada_sched="C" if subhead=="7209.12"
replace usa = "7219.22.00" if subhead=="7209.12"
replace usa_sched="C" if subhead=="7209.12"
replace mexico="7219.22.01" if subhead=="7209.12"
replace mex_sched ="C" if subhead=="7209.12"

replace canada="7219.34.00" if subhead=="7219.33"
replace canada_sched="C" if subhead=="7219.33"
replace usa = "7219.34.00" if subhead=="7219.33"
replace usa_sched="C" if subhead=="7219.33"
replace mexico="7219.34.01" if subhead=="7219.33"
replace mex_sched ="C" if subhead=="7219.33"

replace subhead="0903.00" if subhead=="903"
replace description = "Mat," if subhead=="0903.00"
replace canada="0903.00.00" if subhead=="0903.00"
replace canada_sched="D" if subhead=="0903.00"
replace usa = "0903.00.00" if subhead=="0903.00"
replace usa_sched="D" if subhead=="0903.00"
replace mexico="0903.00.01" if subhead=="0903.00"
replace mex_sched ="a" if subhead=="0903.00"

replace canada="2007.91.00" if subhead=="2007.91"
replace canada_sched="A" if subhead=="2007.91"
replace usa = "2007.91.10" if subhead=="2007.91"
replace usa_sched="C" if subhead=="2007.91"
replace mexico="2007.91.01" if subhead=="2007.91"
replace mex_sched ="C" if subhead=="2007.91"

replace canada="2007.99.10" if subhead=="2007.99"
replace canada_sched="C" if subhead=="2007.99"
replace usa = "2007.99.05" if subhead=="2007.99"
replace usa_sched="A" if subhead=="2007.99"
replace mexico="2007.99.01" if subhead=="2007.99"
replace mex_sched ="A" if subhead=="2007.99"

replace subhead = "2101.20" if subhead=="2101.2"
replace canada="2101.20.00" if subhead=="2101.20"
replace canada_sched="D" if subhead=="2101.20"
replace usa = "2101.20.20" if subhead=="2101.20"
replace usa_sched="D" if subhead=="2101.20"
replace mexico="2101.20.01" if subhead=="2101.20"
replace mex_sched ="C" if subhead=="2101.20"

*have `q' are beginning
replace usa = subinstr(usa,"q","",1) if substr(usa,1,1)=="q"

*Have "0" for canada_sched
replace canada="4403.34.00" if subhead=="4403.34"
replace canada_sched="D" if subhead=="4403.34"
replace usa = "4403.34.00" if subhead=="4403.34"
replace usa_sched="D" if subhead=="4403.34"
replace mexico="4403.34.01" if subhead=="4403.34"
replace mex_sched="D" if subhead=="4403.34"

replace canada = "4407.22.00" if subhead=="4407.22"
replace canada_sched = "D" if subhead=="4407.22"
replace usa = "4407.22.00" if subhead=="4407.22"
replace usa_sched= "D" if subhead=="4407.22"
replace mexico = "4407.22.01" if subhead=="4407.22"
replace mex_sched = "B" if subhead=="4407.22"

replace canada ="4411.21.00" if subhead=="4411.21"
replace canada_sched="BM" if subhead=="4411.21"
replace usa = "4411.21.00" if subhead=="4411.21"
replace usa_sched = "A" if subhead=="4411.21"
replace mexico="4411.21.01" if subhead=="4411.21"
replace mex_sched="B" if subhead=="4411.21"

replace canada = "4411.29.00" if subhead=="4411.29"
replace canada_sched = "BM" if subhead=="4411.29"
replace usa ="4411.29.20" if subhead=="4411.29"
replace usa_sched=  "A" if subhead=="4411.29"
replace mexico="4411.29.99" if subhead=="4411.29"
replace mex_sched= "B" if subhead=="4411.29"

replace canada = "4411.31.00" if subhead =="4411.31"
replace canada_sched = "BM" if subhead =="4411.31"
replace usa = "4411.31.00" if subhead =="4411.31"
replace usa_sched ="D" if subhead =="4411.31"
replace mexico="4411.31.01" if subhead =="4411.31"
replace mex_sched = "B" if subhead =="4411.31"

replace canada= "4411.39.00" if subhead =="4411.39"
replace canada_sched="BM" if subhead =="4411.39"
replace usa = "4411.39.00" if subhead =="4411.39"
replace usa_sched="D" if subhead =="4411.39"
replace mexico="4411.39.99" if subhead =="4411.39"
replace mex_sched="B" if subhead =="4411.39"

*have "0 B" for canada and US
replace canada = substr(canada,-9,9) if canada_sched=="0 B"
replace canada = canada+"0" if canada_sched=="0 B"
replace usa = substr(usa,-9,9)+"0" if usa_sched=="0 B" | /*
	*/usa_sched=="0 D" | usa_sched=="12:00 AM"
replace mexico=mexico+"1" if substr(mex_sched,1,1)=="1"
replace mexico=mexico+"A" if substr(mex_sched,1,1)=="A"
replace mexico=mexico+"9" if substr(mex_sched,1,1)=="9"

replace usa_sched = "B" if canada_sched=="0 B"
replace usa_sched = "D" if usa_sched=="0 D"
replace mex_sched = "B" if mex_sched=="1 B" | mex_sched=="9 B"
replace mex_sched = "B+" if mex_sched=="9 B+" | /*
	*/mex_sched=="1 B+" | mex_sched=="A B+"
replace mex_sched = "Bp" if mex_sched=="1 Bp"
replace canada_sched="B" if canada_sched=="0 B"

*have "1 D"==canada_sched
replace canada="4810.11.11" if canada_sched=="1 D"
replace usa = "4810.11.20" if canada_sched=="1 D"
replace usa_sched = "D" if canada_sched=="1 D"
replace mexico = "4810.11.01" if canada_sched=="1 D"
replace mex_sched = "B" if canada_sched=="1 D"
replace canada_sched="D" if canada_sched=="1 D" 

*have "10"==canada_sched
replace canada = "3702.91.10" if canada_sched=="10"
replace usa = "3702.91.00" if canada_sched=="10"
replace usa_sched = "A" if canada_sched=="10"
replace mexico = "3702.91.01" if canada_sched=="10"
replace mex_sched ="C" if canada_sched=="10"
replace canada_sched = "A" if canada_sched=="10"

*have "12:00 AM"==canada_sched
replace canada = substr(canada,-9,9) if canada_sched=="12:00 AM"
replace canada = canada+"0" if canada_sched=="12:00 AM" 
replace usa = usa+"0" if canada_sched=="12:00 AM"

replace canada_sched = "A" if subhead=="3702.51"
replace usa_sched = "A" if subhead=="3702.51"
replace mex_sched = "C" if subhead=="3702.51"
replace canada_sched = "A" if subhead=="3702.52"
replace usa_sched = "A" if subhead=="3702.52"
replace mex_sched = "A" if subhead=="3702.52"
replace canada_sched = "A" if subhead=="3702.53"
replace usa_sched = "A" if subhead=="3702.53"
replace mex_sched = "C" if subhead=="3702.53"
replace canada_sched = "A" if subhead=="3702.54"
replace usa_sched = "A" if subhead=="3702.54"
replace mex_sched = "C" if subhead=="3702.54"
replace canada_sched = "A" if subhead=="3702.55"
replace usa_sched = "D" if subhead=="3702.55"
replace mex_sched = "C" if subhead=="3702.55"
replace canada_sched = "A" if subhead=="3702.92"
replace usa_sched = "A" if subhead=="3702.92"
replace mex_sched = "C" if subhead=="3702.92"
replace canada_sched = "A" if subhead=="3702.93"
replace usa_sched = "A" if subhead=="3702.93"
replace mex_sched = "C" if subhead=="3702.93"
replace canada_sched = "A" if subhead=="3702.94"
replace usa_sched = "D" if subhead=="3702.94"
replace mex_sched = "C" if subhead=="3702.94"

replace canada_sched = "A" if subhead=="4804.31"
replace usa_sched = "A" if subhead=="4804.31"
replace mex_sched = "B" if subhead=="4804.31"
replace canada_sched = "A" if subhead=="4810.31"
replace usa_sched = "D" if subhead=="4810.31"
replace mex_sched = "B" if subhead=="4810.31"

*canada_sched=="5"
replace canada="4403.35.00" if subhead=="4403.35"
replace canada_sched = "D" if subhead=="4403.35"
replace usa = "4403.35.00" if subhead=="4403.35"
replace usa_sched = "D" if subhead=="4403.35"
replace mexico = "4403.35.01" if subhead=="4403.35"
replace mex_sched = "D" if subhead=="4403.35"

*usa_sched=="C1"
replace usa_sched = "C10" if usa_sched=="C1"

*mex_sched=="a"
replace mex_sched = "A" if mex_sched=="a"

/*Take simple average of HS8 to HS6*/
rename subhead productcode

replace productcode = substr(canada,1,7) if productcode==""
replace productcode = substr(usa,1,7) if productcode==""
replace productcode = substr(mexico,1,7) if productcode==""
	
replace productcode = subinstr(productcode,".","",.)




gen baserate_us = 1
gen baserate_mex = 1
forvalues yr = 1994/2008 {
	gen pct_tariff_us`yr' = .
	replace pct_tariff_us`yr' = 0 if (usa_sched=="A" | usa_sched=="D")
	
	gen pct_tariff_mex`yr' = .
	replace pct_tariff_mex`yr' = 0 if (mex_sched=="A" | mex_sched=="D")
}
forvalues yr = 1994/2008 {
	replace pct_tariff_us`yr' = baserate_us-baserate_us/5*(`yr'-1993) /*
		*/if usa_sched=="B" & `yr'<=1998
	replace pct_tariff_us`yr' = 0 if `yr'>1998 & usa_sched=="B"
	
	replace pct_tariff_mex`yr' = baserate_mex-baserate_mex/5*(`yr'-1993) /*
		*/if mex_sched=="B" & `yr'<=1998
	replace pct_tariff_mex`yr' = 0 if `yr'>1998 & mex_sched=="B"
}
forvalues yr = 1994/2008 {
	replace pct_tariff_us`yr' = baserate_us-baserate_us/10*(`yr'-1993) /*
		*/if usa_sched=="C" & `yr'<=2003
	replace pct_tariff_us`yr' = 0 if `yr'>2003 & usa_sched=="C"
	
	replace pct_tariff_mex`yr' = baserate_mex-baserate_mex/10*(`yr'-1993) /*
		*/if mex_sched=="C" & `yr'<=2003
	replace pct_tariff_mex`yr' = 0 if `yr'>2003 & mex_sched=="C"
}
forvalues yr = 1994/2008 {
	replace pct_tariff_us`yr' = baserate_us-baserate_us/15*(`yr'-1993) /*
		*/if usa_sched=="C+" & `yr'<=2008
		
	replace pct_tariff_mex`yr' = baserate_mex-baserate_mex/15*(`yr'-1993) /*
		*/if mex_sched=="C+" & `yr'<=2008
}
forvalues yr = 1994/2008 {
	replace pct_tariff_us`yr' = 0.8*baserate_us if `yr'==1994 & usa_sched=="C10"
	replace pct_tariff_us`yr' = 0.8*baserate_us if `yr'==1995& usa_sched=="C10"
	replace pct_tariff_us`yr' = 0.8*baserate_us-(`yr'-1995)*0.8*baserate_us/8 /*
		*/if `yr'<=2003 & usa_sched=="C10"
	replace pct_tariff_us`yr' = 0 if `yr'>2003 & usa_sched=="C10"
	
	replace pct_tariff_mex`yr' = 0.8*baserate_mex /*
		*/if `yr'==1994 & mex_sched=="C10"
	replace pct_tariff_mex`yr' = 0.8*baserate_mex /*
		*/if `yr'==1995& mex_sched=="C10"
	replace pct_tariff_mex`yr' = 0.8*baserate_mex-(`yr'-1995)*0.8*baserate_mex/8 /*
		*/if `yr'<=2003 & mex_sched=="C10"
	replace pct_tariff_mex`yr' = 0 if `yr'>2003 & mex_sched=="C10"
}
*Mexico only:
//Ex -- excluded from tariff elimations. Assume to be constant.
forvalues yr = 1994/2008 {
	replace pct_tariff_mex`yr' = baserate_mex if mex_sched=="EX"
}
//B1
forvalues yr = 1994/2008 {
	replace pct_tariff_mex`yr' = baserate_mex-baserate_mex/6*(`yr'-1993) /*
		*/if mex_sched=="Bl" & `yr'<=1999
	replace pct_tariff_mex`yr' = 0 if `yr'>1999 & mex_sched=="Bl"
}
//B+
forvalues yr = 1994/2008 {
	replace pct_tariff_mex`yr' = baserate_mex*0.8 if `yr'==1994 & mex_sched=="B+"
	replace pct_tariff_mex`yr' = baserate_mex*0.8 if `yr'==1995 & mex_sched=="B+"
	replace pct_tariff_mex`yr' = baserate_mex*(0.8-(`yr'-1995)/10) /*
		*/if `yr'>=1996 & `yr'<=2000 & mex_sched=="B+"
	replace pct_tariff_mex`yr' = 0 if `yr'>2000 & mex_sched=="B+"
}
//B8
forvalues yr = 1994/2008 {
	replace pct_tariff_mex`yr' = baserate_mex if `yr'<1998 & mex_sched=="B8"
	replace pct_tariff_mex`yr' = baserate_mex*0.5 if `yr'>=1998 & `yr'<2001 /*
		*/& mex_sched=="B8"
	replace pct_tariff_mex`yr' = 0 if `yr'>=2001 & mex_sched=="B8"
}
//Ba
forvalues yr = 1994/2008 {
	replace pct_tariff_mex`yr' = baserate_mex*0.5 /*
		*/if `yr'==1994 & mex_sched=="Ba"
	replace pct_tariff_mex`yr' = baserate_mex*(0.5-(`yr'-1994)*0.5/4) /*
		*/if `yr'>=1995 & `yr'<=1998 & mex_sched=="Ba"
	replace pct_tariff_mex`yr' = 0 if `yr'>1998 & mex_sched=="Ba"
}

forvalues yr = 1994/2008 {
	//Bp
	replace pct_tariff_mex`yr'= baserate_mex if `yr'<1997 & mex_sched=="Bp"
	replace pct_tariff_mex`yr' = baserate_mex*0.8 if `yr'==1997 & mex_sched=="Bp"
	replace pct_tariff_mex`yr' = baserate_mex*0.7 if `yr'==1998 & mex_sched=="Bp"
	replace pct_tariff_mex`yr' = 0 if `yr'>=1999 & mex_sched=="Bp"

	//C+Ag
	replace pct_tariff_mex`yr' = baserate_mex*(1-(`yr'-1993)*0.04) /*
		*/if `yr'>=1994 & `yr'<=1999 & mex_sched=="C+Ag"
	replace pct_tariff_mex`yr' = baserate_mex*(0.76-(`yr'-1999)*0.76/9) /*
		*/if `yr'>1999 & mex_sched=="C+Ag"
		
	//C8
	replace pct_tariff_mex`yr' = baserate_mex*(1-(`yr'-1993)*0.1) if `yr'<=2000/*
		*/ & mex_sched=="C8"
	replace pct_tariff_mex`yr' = 0 if `yr'>2000 & mex_sched=="C8"
	
	//CAg
	replace pct_tariff_mex`yr' = baserate_mex*(1-(`yr'-1993)*0.04) /*
		*/if `yr'>=1994 & `yr'<=1999 & mex_sched=="CAg"
	replace pct_tariff_mex`yr' = baserate_mex*(0.76-(`yr'-1999)*0.76/4) /*
		*/if `yr'>1999 & `yr'<=2003 & mex_sched=="CAg"
	replace pct_tariff_mex`yr' = 0 if `yr'>2003 & mex_sched=="CAg"
	
	//Ca
	replace pct_tariff_mex`yr' = baserate_mex*0.5 if `yr'==1994 & mex_sched=="Ca"
	replace pct_tariff_mex`yr' = baserate_mex*(0.5-(`yr'-1994)*0.5/9) /*
		*/if `yr'>1994 & `yr'<=2003 & mex_sched=="Ca"
	replace pct_tariff_mex`yr' = 0 if `yr'>2003 & mex_sched=="Ca"
}

save "$build\temp\nafta_tariffs_hs8.dta",replace

*indicator for base rates all 0
gen baserateus_equal_zero = (usa_sched=="A" | usa_sched=="D")

*Simple average from HS8 to HS6
collapse (mean) pct_tariff_mex* pct_tariff_us* /*
	*/ baserateus_equal_zero, by(productcode)
order pct_tariff_us* pct_tariff_mex* 


/*merge 6-digit HS code to ISIC rev. 2 crosswalk*/
*found at https://www.macalester.edu/research/economics/PAGE/HAVEMAN/Trade.Resources/TradeConcordances.html#FromHS
rename productcode hs6

preserve 
import delimited "$build\input\HS_crosswalk\hs6_isic_crosswalk.txt", /*
	*/clear stringcols(_all)
tempfile tmp
save "`tmp'"
restore

merge m:1 hs6 using "`tmp'"
drop _merge

save "$build\temp\nafta_tariffs_hs6.dta",replace

collapse (mean) pct_tariff*,by(isicr2)

/*Merge WITS tariffs*/
/*add in base rates from UNCTAD-TRAINS tariffs via WITS*/
*US tariffs on Mexican goods
preserve
import delimited "$build\input\tariffs-WITS\UStariffsOnMexicoISICr2.csv",/*
	*/varnames(1) clear
keep product tariffyear dutytype simpleaverage //drop weightedaverage for now 
reshape wide simpleaverage, i(product dutytype) j(tariffyear)
reshape wide simpleaverage*, i(product) j(dutytype) string

*pick base year for tariffs to be 1992 since this was year agreement signed
egen baserate_us = rowfirst(simpleaverage1992AHS simpleaverage1991AHS /*
	*/simpleaverage1993AHS simpleaverage1990AHS simpleaverage1989AHS /*
	*/simpleaverage1992MFN simpleaverage1991MFN /*
	*/simpleaverage1993MFN simpleaverage1990MFN simpleaverage1989MFN /*
	*/simpleaverage1992PRF simpleaverage1991PRF /*
	*/simpleaverage1993PRF simpleaverage1990PRF simpleaverage1989PRF /*
	*/simpleaverage1992BND simpleaverage1991BND /*
	*/simpleaverage1993BND simpleaverage1990BND simpleaverage1989BND)
drop simpleaverage*

rename product isicr2
tostring isicr2,replace 
tempfile wits
save "`wits'"
restore

merge m:1 isicr2 using "`wits'"
drop _merge

*Mexican tariffs on US goods
preserve 
import delimited /*
	*/"$build\input\tariffs-WITS\ISICr2MexicoTariffsOnUS.csv", varnames(1) clear
keep product tariffyear dutytype simpleaverage
keep if dutytype=="AHS"
drop dutytype
rename simpleaverage simpleaverage_mex
reshape wide simpleaverage, i(product) j(tariffyear)

*For Mexico, only 1991 available
gen baserate_mex = simpleaverage_mex1991

rename product isicr2
tostring isicr2,replace 
tempfile wits
save "`wits'"
restore

merge m:1 isicr2 using "`wits'"
drop _merge


*generate actual tariff rates
forvalues yr = 1994/2008 {
	gen tariff_us`yr' = pct_tariff_us`yr'*baserate_us
	gen tariff_mex`yr' = pct_tariff_mex`yr'*baserate_mex
	
	drop pct_tariff_mex`yr' pct_tariff_us`yr'
}

drop simpleaverage*

*purge ISICr2 industries for which I couldn't find a Mexico 1990 class-
*ification counterpart. 
keep if isicr2!=""
destring isicr2, replace

preserve
import delimited "$build\input\isicr2-mex90ind-crosswalk.csv",clear
reshape long mex90ind, i(isicr2) j(index)
drop index
drop if mex90ind==.
rename mex90ind ind
tempfile tmp
save $build\temp\isicr2-mex90ind-crosswalk,replace
restore

preserve
merge 1:m isicr2 using $build\temp\isicr2-mex90ind-crosswalk
keep if _merge==1 //this drops the relevant ISICr2 industries.
keep isicr2
tempfile tmp2
save "`tmp2'"
restore
merge 1:1 isicr2 using "`tmp2'"
drop if _merge==3
drop _merge

save "$build\temp\nafta_tariffs.dta",replace

/*Make 5-year stacked differences*/
use "$build\temp\nafta_tariffs.dta",clear
keep isicr2 tariff_us1995 tariff_us2000 tariff_mex1995 tariff_mex2000 /*
	*/ baserate_mex baserate_us
reshape long tariff_us tariff_mex, i(isicr2) j(year) 
tsset isicr2 year
gen ln_tariff_rate_chg_mex5yrdiff = ln(1+tariff_mex/100)-ln(1+l5.tariff_mex/100) /*
	*/if year==2000
replace ln_tariff_rate_chg_mex5yrdiff = ln(1+tariff_mex/100)-ln(1+baserate_mex/100)/*
	*/ if year==1995
gen ln_tariff_rate_chg_us5yrdiff = ln(1+tariff_us/100)-ln(1+l5.tariff_us/100) /*
	*/if year==2000
replace ln_tariff_rate_chg_us5yrdiff = ln(1+tariff_us/100)-ln(1+baserate_us/100)/*
	*/ if year==1995

keep isicr2 year ln_tariff_rate_chg_mex5yrdiff ln_tariff_rate_chg_us5yrdiff

save "$build\temp\nafta_tariffs_5yrdiff.dta",replace

/*Make 10-year long differences*/
use "$build\temp\nafta_tariffs.dta",clear

keep isicr2 tariff_us2000 tariff_mex2000 baserate_mex baserate_us 
gen ln_tariff_rate_chg_mex91to00 = ln(1+tariff_mex/100)-ln(1+baserate_mex/100)
gen ln_tariff_rate_chg_us10yrdiff = ln(1+tariff_us/100)-ln(1+baserate_us/100)

save "$build\temp\nafta_tariffs_10yrdiff.dta",replace









/* 2. NAFTA tariff schedule data 				WITS tariff			
		HS6 --> 				ISICr3			-->	ISICr3
(computed above) 			ISICr3-HS6 x-walk	(simple avg.)
						*/
use "$build\temp\nafta_tariffs_hs6.dta",clear 
drop isicr2

preserve 
insheet using "$build\input\HS_crosswalk\Concordance_HS_to_IsicRev3.csv", /*
	*/clear comma
rename hscombinedproductcode hs6
tempfile tmp
save "`tmp'"
restore

destring hs6,replace
merge 1:1 hs6 using "`tmp'"
drop if _merge==1
drop if _merge==2 //these are for HS codes created after NAFTA was signed
drop _merge

*merge with WITS tariffs
rename isicrevision3productcode isicr3

preserve
insheet using $build\input\tariffs-WITS\MexTariffsOnUsIsicR3.csv, clear comma
rename product isicr3
keep if dutytype=="AHS"
drop dutytype
rename simpleaverage simpleaverage_mex
keep simpleaverage_mex isicr3 tariffyear
reshape wide simpleaverage_mex, i(isicr3) j(tariffyear)

*For Mexico, only 1991 available
gen baserate_mex = simpleaverage_mex1991

tempfile tmp
save "`tmp'"
restore
collapse (mean) pct_tariff_mex* ,by(isicr3)

merge 1:1 isicr3 using "`tmp'"
drop if _merge!=3 //isicr3==1200
drop _merge

*generate actual tariff rates
forvalues yr = 1994/2008 {
	gen tariff_mex`yr' = pct_tariff_mex`yr'*baserate_mex
	
	drop pct_tariff_mex`yr'
}

drop simpleaverage*


*merge with OECD Input-Output table
*create industry codes comparable to OECD IO table, then collapse
gen isicr3_2dig = int(isicr3/100)

gen isicr3_oecd_bins = "C01T05" if isicr3_2dig>=1 & isicr3_2dig<=5
replace isicr3_oecd_bins = "C10T14" if isicr3_2dig>=10 & isicr3_2dig<=14
replace isicr3_oecd_bins = "C15T16" if isicr3_2dig>=15 & isicr3_2dig<=16
replace isicr3_oecd_bins = "C17T19" if isicr3_2dig>=17 & isicr3_2dig<=19
replace isicr3_oecd_bins = "C20" if isicr3_2dig==20
replace isicr3_oecd_bins = "C21T22" if isicr3_2dig>=21 & isicr3_2dig<=22
replace isicr3_oecd_bins = "C23" if isicr3_2dig==23
replace isicr3_oecd_bins = "C24" if isicr3_2dig==24
replace isicr3_oecd_bins = "C25" if isicr3_2dig==25
replace isicr3_oecd_bins = "C26" if isicr3_2dig==26
replace isicr3_oecd_bins = "C27" if isicr3_2dig==27
replace isicr3_oecd_bins = "C28" if isicr3_2dig==28
replace isicr3_oecd_bins = "C29" if isicr3_2dig==29
replace isicr3_oecd_bins = "C30T33X" if isicr3_2dig>=30 & isicr3_2dig<=33
replace isicr3_oecd_bins = "C31" if isicr3_2dig==31
replace isicr3_oecd_bins = "C34" if isicr3_2dig==34
replace isicr3_oecd_bins = "C35" if isicr3_2dig==35
replace isicr3_oecd_bins = "C36T37" if isicr3_2dig>=36 & isicr3_2dig<=37
replace isicr3_oecd_bins = "C40T41" if isicr3_2dig>=40 & isicr3_2dig<=41
replace isicr3_oecd_bins = "C45" if isicr3_2dig==45
replace isicr3_oecd_bins = "C50T52" if isicr3_2dig>=50 & isicr3_2dig<=52
replace isicr3_oecd_bins = "C55" if isicr3_2dig==55
replace isicr3_oecd_bins = "C60T63" if isicr3_2dig>=60 & isicr3_2dig<=63
replace isicr3_oecd_bins = "C64" if isicr3_2dig==64
replace isicr3_oecd_bins = "C65T67" if isicr3_2dig>=65 & isicr3_2dig<=67
replace isicr3_oecd_bins = "C70" if isicr3_2dig==70
replace isicr3_oecd_bins = "C71" if isicr3_2dig==71
replace isicr3_oecd_bins = "C72" if isicr3_2dig==72
replace isicr3_oecd_bins = "C73T74" if isicr3_2dig>=73 & isicr3_2dig<=74
replace isicr3_oecd_bins = "C75" if isicr3_2dig==75
replace isicr3_oecd_bins = "C80" if isicr3_2dig==80
replace isicr3_oecd_bins = "C85" if isicr3_2dig==85
replace isicr3_oecd_bins = "C90T93" if isicr3_2dig>=90 & isicr3_2dig<=93
replace isicr3_oecd_bins = "C95" if isicr3_2dig==95
drop if isicr3_oecd_bins=="" //ISIC r3 code is 9999

collapse (mean) baserate_mex tariff_mex*,by(isicr3_oecd_bins)

*generate industry tariff differences
gen ln_tariff_rate_chg_mex91to00 = /*
	*/ln(1+tariff_mex2000/100)-ln(1+baserate_mex/100)


/*Generate Alpha_i(k) for each industry i for input industry k.*/
preserve
insheet using $build\input\Input-Output\oecd-IO-mex95-TTL.csv, clear comma
replace row = subinstr(row,"TTL_","",1)
keep if var=="TTL"
drop cou country v10 var variable referenceperiod referenceperiodcode /*
	*/flagcodes flags time unitcode unit powercodecode powercode /*
	*/columnsectorto

sort row col
reshape wide value, i(row rowsectorfrom) j(col) string

egen tot_materials_cost = rowtotal(valueC*)
rename row isicr3_oecd_bins
levelsof isicr3_oecd_bins
foreach lev in `r(levels)' {
	if substr("`lev'",1,1)=="C" & substr("`lev'",2,1)!="O" {
		gen alpha_to`lev' = value`lev'/tot_materials_cost
	}
}
keep alpha* isicr3_oecd_bins rowsectorfrom
egen alpha_sum = rowtotal(alpha_toC*)


tempfile tmp
save "`tmp'"
restore

merge 1:1 isicr3_oecd_bins using "`tmp'"
keep ln_tariff_rate_chg_mex91to00 alpha_toC* rowsectorfrom /*
	*/isicr3_oecd_bins
replace ln_tariff_rate_chg_mex91to00=0 if /*
	*/ln_tariff_rate_chg_mex91to00==.

drop if /*
	*/inlist(isicr3_oecd_bins,"INT_FNL","OUTPUT","TXS_INT_FNL","VALU")
	
mkmat ln_tariff_rate_chg_mex91to00, matrix(dLnTau_k) /*
	*/rownames(isicr3_oecd_bins)
mkmat alpha_toC*, matrix(Alphas) rownames(isicr3_oecd_bins) 
	
matrix dIT_i = Alphas*dLnTau_k

keep isicr3_oecd_bins
svmat dIT_i,names(col)
replace ln_tariff_rate_chg_mex91to00=0 /*
	*/ if ln_tariff_rate_chg_mex91to00==.
	
save $build\temp\input_tariff_chgs, replace
