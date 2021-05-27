global build "C:\Users\bmccully\Documents\nafta-migration\build"

set more off
clear all

/*Deaths for persons age 17-47 in 1990*/
forvalues y=1990/2000 {
local y2dig = substr("`y'",3,2)

	*state-municipality to geo2_mx crosswalk
	import dbase using /*
		*/"$build\input\mortality\defunciones_base_datos_`y'_dbf\ENTMUN.dbf",/*
		*/clear
	destring CVE_ENT,gen(state)
	destring CVE_MUN,gen(munic)
	gen mx2010a = state*1000+munic
	drop if NOMBRE=="Municipio no especificado"
	drop if munic==0

	preserve
	use "$build\temp\municipio_crosswalk90to10.dta",clear
	drop if mx2010a==.
	tempfile tmp
	save "`tmp'"
	restore

	merge m:1 mx2010a using "`tmp'"
	//new muni created between 2010 and 2015 and current geostatistical 
	//framework uses 2015 municipality boundaries
	replace state_munic_code_xwalk =23001 if mx2010a==23010 
	drop if mx2010a==99999
	drop _merge //other unmerged are from Oaxaca, which groups 
				//municipalities together.


	*mortality microdata
	preserve
	import dbase using /*
		*/"$build\input\mortality\defunciones_base_datos_`y'_dbf\DEFUN`y2dig'.dbf",/*
		*/clear

	keep ENT_RESID MUN_RESID EDAD EDAD_AGRU DIS_RE_OAX MES_OCURR ANIO_OCUR

	//will need to merge state and muni with entmun.dbf
	//to identify which state & municipality they refer
	//to.
	rename ENT_RESID state
	rename MUN_RESID munic
	rename EDAD age_code
	rename EDAD_AGRU age_group
	rename DIS_RE_OAX oaxaca_muni_group
	rename MES_OCURR month_of_death
	rename ANIO_OCUR year_of_death
	gen year = `y'

	tempfile tmp
	save "`tmp'"
	restore

	merge 1:m state munic using "`tmp'"

	drop if state==33 | state==34 | state==35 //places outside Mex.
	
	//small number of master only (1) municipalities could plausibly 
	//be small enough to have experienced no deaths in 1990.
	//number of using only (2) observations all have municipality of 999,
	//but still have state code
	drop _merge

	gen age = mod(age_code,4000) if age_code>4000 & age_code!=.
	replace age = 0 if age_code<=3011

	/*State level mortality*/
	preserve
	collapse (count) deaths=age if age>=17+(`y'-1990) /*
		*/& age<=47+(`y'-1990),by(state month_of_death)
	gen year = `y'
	save "$build\temp\deaths_state`y'.dta",replace
	restore

	/*Municipality level mortality*/
	preserve
	collapse (count) deaths=age if age>=17+(`y'-1990) /*
		*/& age<=47+(`y'-1990),/*
		*/by(state_munic_code_xwalk month_of_death)
	gen year=`y'
	save "$build\temp\deaths_munic`y'.dta",replace
	restore
}

//Merge together all years
/*State level*/
use "$build\temp\deaths_state1990.dta",clear
forvalues y=1991/2000 {
	append using "$build\temp\deaths_state`y'.dta"
}
//1990 census conducted in March; 1995 in Nov.; 2000 in Febr.
gen btwn_census = "90-95" if year>1990 & year<1995 | /*
	*/(year==1995 & month_of_death<=11) | (year==1990 & month_of_death>=3)
replace btwn_census = "95-00" if (year==1995 & month_of_death>11) | /*
	*/(year>=1996 & year<=1999) | (year==2000 & month_of_death<=2)

collapse (sum) deaths, by(btwn_census state)
drop if btwn_census==""

gen year = 1995 if btwn_census=="90-95"
replace year = 2000 if btwn_census=="95-00"
drop btwn_census

save "$build\temp\deaths_state.dta",replace

/*Municipality level*/
use "$build\temp\deaths_munic1990.dta",clear
forvalues y=1991/2000 {
	append using "$build\temp\deaths_munic`y'.dta"
}
//1990 census conducted in March; 1995 in Nov.; 2000 in Febr.
gen btwn_census = "90-95" if year>1990 & year<1995 | /*
	*/(year==1995 & month_of_death<=11) | (year==1990 & month_of_death>=3)
replace btwn_census = "95-00" if (year==1995 & month_of_death>11) | /*
	*/(year>=1996 & year<=1999) | (year==2000 & month_of_death<=2)
	
collapse (sum) deaths, by(btwn_census state_munic_code_xwalk)
drop if btwn_census==""

gen year = 1995 if btwn_census=="90-95"
replace year = 2000 if btwn_census=="95-00"
drop btwn_census

rename state_munic_code_xwalk munic
replace munic = 484000000+munic

save "$build\temp\deaths_munic.dta",replace







/*Deaths for persons age 2-88 in 1990*/
forvalues y=1990/2000 {
local y2dig = substr("`y'",3,2)

	*state-municipality to geo2_mx crosswalk
	import dbase using /*
		*/"$build\input\mortality\defunciones_base_datos_`y'_dbf\ENTMUN.dbf",/*
		*/clear
	destring CVE_ENT,gen(state)
	destring CVE_MUN,gen(munic)
	gen mx2010a = state*1000+munic
	drop if NOMBRE=="Municipio no especificado"
	drop if munic==0

	preserve
	use "$build\temp\municipio_crosswalk90to10.dta",clear
	drop if mx2010a==.
	tempfile tmp
	save "`tmp'"
	restore

	merge m:1 mx2010a using "`tmp'"
	//new muni created between 2010 and 2015 and current geostatistical 
	//framework uses 2015 municipality boundaries
	replace state_munic_code_xwalk =23001 if mx2010a==23010 
	drop if mx2010a==99999
	drop _merge //other unmerged are from Oaxaca, which groups 
				//municipalities together.


	*mortality microdata
	preserve
	import dbase using /*
		*/"$build\input\mortality\defunciones_base_datos_`y'_dbf\DEFUN`y2dig'.dbf",/*
		*/clear

	keep ENT_RESID MUN_RESID EDAD EDAD_AGRU DIS_RE_OAX MES_OCURR ANIO_OCUR

	//will need to merge state and muni with entmun.dbf
	//to identify which state & municipality they refer
	//to.
	rename ENT_RESID state
	rename MUN_RESID munic
	rename EDAD age_code
	rename EDAD_AGRU age_group
	rename DIS_RE_OAX oaxaca_muni_group
	rename MES_OCURR month_of_death
	rename ANIO_OCUR year_of_death
	gen year = `y'

	tempfile tmp
	save "`tmp'"
	restore

	merge 1:m state munic using "`tmp'"

	drop if state==33 | state==34 | state==35 //places outside Mex.
	
	//small number of master only (1) municipalities could plausibly 
	//be small enough to have experienced no deaths in 1990.
	//number of using only (2) observations all have municipality of 999,
	//but still have state code
	drop _merge

	gen age = mod(age_code,4000) if age_code>4000 & age_code!=.
	replace age = 0 if age_code<=3011

	/*State level mortality*/
	preserve
	collapse (count) deaths=age if age>=2+(`y'-1990) /*
		*/& age<=88+(`y'-1990),by(state month_of_death)
	gen year = `y'
	save "$build\temp\deaths_state`y'_all.dta",replace
	restore

	/*Municipality level mortality*/
	preserve
	collapse (count) deaths=age if age>=2+(`y'-1990) /*
		*/& age<=88+(`y'-1990),/*
		*/by(state_munic_code_xwalk month_of_death)
	gen year=`y'
	save "$build\temp\deaths_munic`y'_all.dta",replace
	restore
}

//Merge together all years
/*State level*/
use "$build\temp\deaths_state1990_all.dta",clear
forvalues y=1991/2000 {
	append using "$build\temp\deaths_state`y'_all.dta"
}
//1990 census conducted in March; 1995 in Nov.; 2000 in Febr.
gen btwn_census = "90-95" if year>1990 & year<1995 | /*
	*/(year==1995 & month_of_death<=11) | (year==1990 & month_of_death>=3)
replace btwn_census = "95-00" if (year==1995 & month_of_death>11) | /*
	*/(year>=1996 & year<=1999) | (year==2000 & month_of_death<=2)

collapse (sum) deaths, by(btwn_census state)
drop if btwn_census==""

gen year = 1995 if btwn_census=="90-95"
replace year = 2000 if btwn_census=="95-00"
drop btwn_census

save "$build\temp\deaths_state_all.dta",replace

/*Municipality level*/
use "$build\temp\deaths_munic1990_all.dta",clear
forvalues y=1991/2000 {
	append using "$build\temp\deaths_munic`y'_all.dta"
}
//1990 census conducted in March; 1995 in Nov.; 2000 in Febr.
gen btwn_census = "90-95" if year>1990 & year<1995 | /*
	*/(year==1995 & month_of_death<=11) | (year==1990 & month_of_death>=3)
replace btwn_census = "95-00" if (year==1995 & month_of_death>11) | /*
	*/(year>=1996 & year<=1999) | (year==2000 & month_of_death<=2)
	
collapse (sum) deaths, by(btwn_census state_munic_code_xwalk)
drop if btwn_census==""

gen year = 1995 if btwn_census=="90-95"
replace year = 2000 if btwn_census=="95-00"
drop btwn_census

rename state_munic_code_xwalk munic
replace munic = 484000000+munic

save "$build\temp\deaths_munic_all.dta",replace
