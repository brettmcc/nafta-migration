clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

/*STATE LEVEL*/
shp2dta using "$build\input\geo1_mx1960_2015\geo1_mx1960_2015.shp", /*
	*/database("$analysis\input\mex_state_db.dta") /*
	*/coordinates("$analysis\input\mex_state_coord.dta") /*
	*/genid(stateid) replace

use "$analysis\input\mex_state_db.dta",clear
describe


/*Int'l migration, 2000*/
rename stateid geo1_mx
gen year=2000

merge 1:1 year geo1_mx using "$build\output\intl_mig_rts_census.dta"
drop if _merge!=3
drop _merge

spmap intl_mig_rt using "$analysis\input\mex_state_coord.dta" /*
	*/if year==2000, id(geo1_mx) fcolor(Blues)


*using residual method
use "$analysis\input\mex_state_db.dta",clear
rename stateid state
merge 1:m state using "$build\output\intl_mig_rt_state.dta"
drop if _merge!=3
drop _merge

spmap intl_mig_rt using "$analysis\input\mex_state_coord.dta" /*
	*/if year==1995, id(state) fcolor(Blues) legend(size(medium))/*
	*/ title("International Outflow Rate, 1995") clmethod(custom) /*
	*/clnumber(4) /*
	*/clbreaks(-.15 -.03 -.011 .025 .082)
graph export "$analysis\output\maps\intl_mig_rt95.png",replace 
spmap intl_mig_rt using "$analysis\input\mex_state_coord.dta" /*
	*/if year==2000, id(state) fcolor(Blues) legend(size(medium))/*
	*/ title("International Outflow Rate, 2000") clmethod(custom) /*
	*/clnumber(4) clbreaks(.035 .059 .069 .078 .12)
graph export "$analysis\output\maps\intl_mig_rt00.png",replace 

/*Interregional migration, 2000*/
use "$analysis\input\mex_state_db.dta",clear
rename stateid migmx2
gen year=2000

merge 1:1 year migmx2 using "$build\output\interstate_mig_rts_census.dta"
drop if _merge!=3
drop _merge

spmap interstate_mig_rt using "$analysis\input\mex_state_coord.dta" /*
	*/if year==2000, id(migmx2) fcolor(Blues)


/*Overall change in population age 10-40 in 1990*/
use "$analysis\input\mex_state_db.dta",clear

rename stateid state
merge 1:m state using "$build\output\intl_mig_rt_state.dta"
drop if _merge!=3
drop _merge

spmap prop_chg_labor_force using "$analysis\input\mex_state_coord.dta" /*
	*/if year==1995, id(state) fcolor(Blues)
spmap prop_chg_labor_force using "$analysis\input\mex_state_coord.dta" /*
	*/if year==2000, id(state) fcolor(Blues)
	
	
use "$analysis\input\mex_state_db.dta",clear
rename stateid geo1_mx
merge 1:1 geo1_mx using "$build\output\chg_labor_force_constcohort.dta"
drop if _merge!=3
drop _merge

spmap pct_chg_labor_force using "$analysis\input\mex_state_coord.dta" /*
	*/, id(geo1_mx) fcolor(Blues) note(Fixed age cohort: age 10-40 in/*
	*/1990 and 20-50 in 2000.) /*
	*/title("% Chg. in Fixed-cohort Population, 1990-2000") /*
	*/clmethod(custom) clnumber(4) clbreaks(-.283 -.210 -.132 -.075 .33)
graph export "$analysis\output\maps\chg_cohort_size_state.png",replace

/*Regional Tariff Changes*/
use "$analysis\input\mex_state_db.dta",clear
rename stateid state
merge 1:m state using "$build\output\nafta_exposure_5yr.dta"
drop if _merge!=3
drop _merge
keep if year==2000

spmap RTC2_mex5yr using "$analysis\input\mex_state_coord.dta" /*
	*/, id(state) fcolor(Blues) /*
	*/title("Regional Tariff Change (Imports), 1995-2000") /*
	*/clmethod(custom) clnumber(4) /*
	*/clbreaks(-.048 -.035 -.028 -.023 -.017) legend(size(medium))
graph export "$analysis\output\maps\rtcmex_state.png", replace
spmap RTC2_us5yr using "$analysis\input\mex_state_coord.dta" /*
	*/, id(state) fcolor(Blues) /*
	*/title("Regional Tariff Change (Exports to U.S.), 1995-2000")/*
	*/clmethod(custom) clnumber(4) /*
	*/clbreaks(-.017 -.009 -.006 -.004 -.003) legend(size(medium))
graph export "$analysis\output\maps\rtcus_state.png", replace

//1995
use "$analysis\input\mex_state_db.dta",clear
rename stateid state
merge 1:m state using "$build\output\nafta_exposure_5yr.dta"
drop if _merge!=3
drop _merge
keep if year==1995

spmap RTC2_mex5yr using "$analysis\input\mex_state_coord.dta" /*
	*/, id(state) fcolor(Blues) /*
	*/title("Regional Tariff Change (Imports), 1990-1995") /*
	*/clmethod(custom) clnumber(4) /*
	*/clbreaks(-.085 -.08 -.077 -.073 -.063) legend(size(medium))
graph export "$analysis\output\maps\rtcmex_state95.png", replace
spmap RTC2_us5yr using "$analysis\input\mex_state_coord.dta" /*
	*/, id(state) fcolor(Blues) /*
	*/title("Regional Tariff Change (Exports to U.S.), 1990-1995")/*
	*/clmethod(custom) clnumber(4) /*
	*/clbreaks(-.049 -.043 -.041 -.039 -.032) legend(size(medium))
graph export "$analysis\output\maps\rtcus_state95.png", replace


/*MUNICIPALITY LEVEL*/
shp2dta using "$build\input\geo2_mx1960_2015\geo2_mx1960_2015.shp", /*
	*/database("$analysis\input\mex_munic_db.dta") /*
	*/coordinates("$analysis\input\mex_munic_coord.dta") /*
	*/genid(municid) replace
	
use "$analysis\input\mex_munic_db.dta",clear
describe

rename GEOLEVEL2 geo2_mx
destring geo2_mx,replace

/*Change in age-fixed cohort*/
preserve
merge 1:1 geo2_mx using /*
	*/"$build\output\chg_labor_force_constcohort_munic.dta"


spmap pct_chg_labor_force using "$analysis\input\mex_munic_coord.dta", /*
	*/id(municid) fcolor(Blues) osize(vthin) ocolor(dknavy) /*
	*/polygon(data("$analysis\input\mex_state_coord.dta") osize(medthin))/*
	*/ title(% Change in Cohort Size) note(Fixed age cohort: age 10-40 in/*
	*/1990 and 20-50 in 2000.) clmethod(custom) clnumber(4) /*
	*/clbreaks(-.76 -.32 -.24 -.16 1.5) 
graph export "$analysis\output\maps\chg_cohort_size_munic.png", replace
restore
	
/*Regional tariff change - Mexican import tariffs*/
preserve
merge 1:1 geo2_mx using "$build\output\nafta_exposure_munic.dta"

spmap RTC_mex05 using "$analysis\input\mex_munic_coord.dta" /*
	*/if RTC_mex05!=0, /*
	*/id(municid) fcolor(Blues) osize(vthin) ocolor(dknavy) /*
	*/polygon(data("$analysis\input\mex_state_coord.dta") osize(medthin))/*
	*/ title(Regional Import Tariff Change) /*
	*/note(Uses difference between 1991 and 2005 tariffs) /*
	*/clmethod(custom) clnumber(4) /*
	*/clbreaks(-.162 -.131 -.128 -.127 -.08) legend(size(medium))
graph export "$analysis\output\maps\rtcmex05_munic.png", replace
restore

/*Regional tariff change - US import tariffs*/
preserve
merge 1:1 geo2_mx using "$build\output\nafta_exposure_munic.dta"

spmap RTC_us00 using "$analysis\input\mex_munic_coord.dta", /*
	*/id(municid) fcolor(Blues) osize(vthin) ocolor(dknavy) /*
	*/polygon(data("$analysis\input\mex_state_coord.dta") osize(medthin))/*
	*/ title(Regional Export-to-US Tariff Change) /*
	*/clmethod(custom) clnumber(4) /*
	*/clbreaks(-.086 -.024 -.017 -.015 0) legend(size(medium))
graph export "$analysis\output\maps\rtcus_munic.png", replace
restore


/*Export data for ArcGIS maps*/

*create datset for intl. emigration rates municipality map
use "$build\output\intl_mig_rt_munic.dta",clear
merge 1:1 munic year using "$build\output\intl_mig_rts_census_munic.dta"
keep if year==2000
drop if _merge!=3
keep munic intl_mig_rt2 intl_mig_rt_partialhh
export delimited using "$analysis\input\intlmigrt_munis.csv",/*
	*/replace nolabel
	
*export data for RTC US and Mexico maps
use "$build\output\nafta_exposure_5yr_munic.dta",clear
keep if year==2000
drop year
rename munic geo2_mx
merge 1:1 geo2_mx using "$build\temp\munis_95.dta"
export delimited using "$analysis\input\munis95_rtc.csv",/*
	*/replace nolabel
	
*export data for RTC US and Mexico maps, 1993-2000
use "$build\output\nafta_exposure_munic.dta",clear
export delimited using "$analysis\input\rtc_munis.csv",/*
	*/replace nolabel
