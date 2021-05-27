set more off, permanently
clear all

global build "C:\Users\bmccully\Documents\nafta-migration\build"

/*Tariffs levied by Mexico on U.S. goods*/
insheet using "$build\input\unctad_trains_industry_tariffs_mex.csv", comma clear
keep product productname tariffyear dutytype simpleaverage 
sort dutytype product tariffyear
keep if (tariffyear==1991|tariffyear==1995|tariffyear==2000|tariffyear==2005)/*
	*/ & dutytype=="AHS"

gen industry_group = 10 if product<10 //agriculture
replace industry_group = 20 if product>=10 & product<=14 //mining
replace industry_group = 30 if product==15 | product==16 //Manufacture of food & tobacco products & beverages
replace industry_group = 40 if product==17 //Manufacture of textiles
replace industry_group = 50 if product==18 //Manufacture of wearing apparel
replace industry_group = 60 if product==19 //Leather products
replace industry_group = 70 if product==36 //furniture & N.E.C. manufactures
replace industry_group = 80 if product==40 //electricity, gas, water
replace industry_group = 90 if product==24 //chemicals
replace industry_group = 100 if product==23 //coke & refined petroleum
replace industry_group = 110 if product==31 //electrical machinery
replace industry_group = 120 if product==28 //fabricated metal products
replace industry_group = 130 if product==27 //basic metals
replace industry_group = 140 if product==29 //machinery & equipment
replace industry_group = 150 if product==34|product==35 //transportation
replace industry_group = 160 if product==30|product==32 //computers, TVs, radios
replace industry_group = 170 if product==26 //non-metallic mineral products
replace industry_group = 180 if product==21 //paper & paper products
replace industry_group = 190 if product==25 //rubber & plastic products
replace industry_group = 200 if product==22 //printing & publishing
replace industry_group = 210 if product==20 //wood manufactures

collapse (mean) simpleaverage, by(industry_group tariffyear)
tsset industry_group tariffyear, yearly
do "$build\code\label_industries.do"

preserve
keep if tariffyear==1991
drop if industry_group==. //drop medical, precision, and optical instrument manufacture industry
save "$build\temp\initial_tariffs_by_ind_mex.dta",replace
restore

bysort industry_group: gen ln_tariff_rate_chg_mex91to05 = /*
	*/ln(1+simpleaverage/100)-ln(1+l14.simpleaverage/100)
by industry_group: gen ln_tariff_rate_chg_mex91to00 = /*
	*/ln(1+simpleaverage/100)-ln(1+l9.simpleaverage/100)
by industry_group: gen ln_tariff_rate_chg_mex91to95 = /*
	*/ln(1+simpleaverage/100)-ln(1+l4.simpleaverage/100)
by industry_group: gen ln_tariff_rate_chg_mex95to05 = /*
	*/ln(1+simpleaverage/100)-ln(1+l10.simpleaverage/100)


drop if tariffyear==1991
collapse (min) ln_tariff_rate_chg_mex91to05 ln_tariff_rate_chg_mex91to00 /*
	*/ln_tariff_rate_chg_mex91to95 ln_tariff_rate_chg_mex95to05,/*
	*/by(industry_group)

save "$build\temp\tariffs_by_ind_mex.dta",replace

/*Tariffs levied by U.S. on Mexican goods*/
insheet using "$build\input\unctad_trains_industry_tariffs_us.csv", comma clear
keep product productname tariffyear dutytype simpleaverage 
sort dutytype product tariffyear
keep if (tariffyear==1990|tariffyear==1995|tariffyear==2000|tariffyear==2005)/*
	*/ & dutytype=="AHS"
	

gen industry_group = 10 if product<10 //agriculture
replace industry_group = 20 if product>=10 & product<=14 //mining
replace industry_group = 30 if product==15 | product==16 //Manufacture of food & tobacco products & beverages
replace industry_group = 40 if product==17 //Manufacture of textiles
replace industry_group = 50 if product==18 //Manufacture of wearing apparel
replace industry_group = 60 if product==19 //Leather products
replace industry_group = 70 if product==36 //furniture & N.E.C. manufactures
replace industry_group = 80 if product==40 //electricity, gas, water
replace industry_group = 90 if product==24 //chemicals
replace industry_group = 100 if product==23 //coke & refined petroleum
replace industry_group = 110 if product==31 //electrical machinery
replace industry_group = 120 if product==28 //fabricated metal products
replace industry_group = 130 if product==27 //basic metals
replace industry_group = 140 if product==29 //machinery & equipment
replace industry_group = 150 if product==34|product==35 //transportation
replace industry_group = 160 if product==30|product==32 //computers, TVs, radios
replace industry_group = 170 if product==26 //non-metallic mineral products
replace industry_group = 180 if product==21 //paper & paper products
replace industry_group = 190 if product==25 //rubber & plastic products
replace industry_group = 200 if product==22 //printing & publishing
replace industry_group = 210 if product==20 //wood manufactures

collapse (mean) simpleaverage, by(industry_group tariffyear)
tsset industry_group tariffyear, yearly
//do "$build\code\label_industries.do"

preserve
keep if tariffyear==1990
drop if industry_group==. //drop medical, precision, and optical instrument manufacture industry
save "$build\temp\initial_tariffs_by_ind_us.dta",replace
restore

bysort industry_group: gen ln_tariff_rate_chg_us05 = /*
	*/ln(1+simpleaverage/100)-ln(1+l15.simpleaverage/100)
by industry_group: gen ln_tariff_rate_chg_us10yrdiff = /*
	*/ln(1+simpleaverage/100)-ln(1+l10.simpleaverage/100)
by industry_group: gen ln_tariff_rate_chg_us5yrdiff = /*
	*/ln(1+simpleaverage/100)-ln(1+l5.simpleaverage/100)
drop if tariffyear==1990
save "$build\temp\tariffs_by_ind_us_allyrs.dta",replace

keep if tariffyear==2000

save "$build\temp\tariffs_by_ind_us.dta",replace

/*Mexico tariffs on US goods, product level*/
import delimited $build\input\tariffs-WITS\MexicoTariffsOnUSprod.csv, /*
	*/clear

keep simpleaverage tariffyear product dutytype
keep if dutytype=="AHS"
reshape wide simpleaverage,i(product) j(tariffyear)
keep if simpleaverage1991!=. & simpleaverage1995!=. & /*
	*/simpleaverage1996!=. & simpleaverage1997!=. & simpleaverage1998!=./*
	*/ & simpleaverage1999!=. & simpleaverage2000!=.
reshape long simpleaverage,i(product) j(tariffyear)

collapse (mean) simpleaverage if dutytype=="AHS",by(tariffyear)
line simpleaverage tariffyear
