clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"

/*Fraction of ejidos activated by state -- not population weighted*/
use $build\temp\ejido_activation,clear

sort state
egen index = group(state)
gen geo1_mx = index
replace geo1_mx = 5 if index==7 //Coahuila
replace geo1_mx = 7 if index==5 //Chiapas
replace geo1_mx = 8 if index==6 //Chihuahua
replace geo1_mx = 6 if index==8 //Colima
replace geo1_mx = index+1 if index>=9
drop index

keep if year==1993 | year==1995 | year==2000
tsset geo1_mx year
gen chg_ejido_activation = fraction_activated - l5.fraction_activated
replace chg_ejido_activation = fraction_activated if year==1995
drop if year==1993

drop state
rename geo1_mx state

save "$build\output\ejido_activation.dta",replace


/*Fraction of ejidos activated by state -- population weighted*/

//probably want to also weight by how important ejido sector is to 
//state by, e.g. dividing total ejido pop by total state pop for
//each state.

use "$build\input\ejido_AER2015\procede_mun_dates_emaild.dta",clear
format procededat %td
gen procede_activation_year = year(procededat)
drop if ejidatario==0

*total state ejido population
preserve
contract estado
drop if estado==""
egen index = group(estado)
gen geo1_mx = index
replace geo1_mx = 5 if index==7 //Coahuila
replace geo1_mx = 7 if index==5 //Chiapas
replace geo1_mx = 8 if index==6 //Chihuahua
replace geo1_mx = 6 if index==8 //Colima
replace geo1_mx = index+1 if index>=9
drop index 
tempfile tmp
save "`tmp'"
restore

collapse (sum) ejidatario,by(estado procede_activation_year)
bysort estado: egen total_ejido_pop = total(ejidatario)

merge m:1 estado using "`tmp'"
drop _freq _merge
gen pop_activated=ejidatario/total_ejido_pop

gen year = 1995 if procede_activation_year<=1995
replace year = 2000 if procede_activation_year>1995 & /*
	*/procede_activation_year<=2000
replace year = 2005 if procede_activation_year>2000 & /*
	*/procede_activation_year<=2005
collapse (sum) ejidatario (max) total_ejido_pop,by(geo1_mx year)

gen cumul_pop_activated = ejidatario if year==1995
tsset geo1_mx year
replace cumul_pop_activated = ejidatario+l5.ejidatario if year==2000
replace cumul_pop_activated = ejidatario+l5.ejidatario+l10.ejidatario/*
	*/ if year==2005
	
gen proportion_ejido_activated = cumul_pop_activated/total_ejido_pop
keep if year==1995 | year==2000

*adjust for relative importance of ejidos in each given state by dividing
*the total ejido population by the total state population

merge m:1 geo1_mx using "$build\temp\state_pop90.dta"
drop _merge
gen prop_ejido_activated_normalized = cumul_pop_activated/perwt

sort geo1_mx year
gen chg_prop_ejido_activated = proportion_ejido_activated-l5.proportion_ejido_activated
replace chg_prop_ejido_activated = proportion_ejido_activated if year==1995
gen chg_prop_ejido_activated_norm=prop_ejido_activated_normalized-l5.prop_ejido_activated_normalized
replace chg_prop_ejido_activated_norm = prop_ejido_activated_normalized if year==1995

rename geo1_mx state

label variable chg_prop_ejido_activated_norm /*
	*/"Chg. in total region pop. in activated ejido"
	
save "$build\output\ejido_activation_pop_weighted.dta",replace


/*Fraction of ejidos by municipality, population weighted*/
import delimited "$build\input\ipums_mex_geo2_codes_to_names.csv",clear /*
	*/varnames(1)
drop mx
drop if code=="" | code=="Code"
split label, parse(",")
gen municipio = strupper(strtrim(label2+" "+label1))
drop label*

*generate state variable
gen state_code = substr(code,1,2) if strlen(code)==5
replace state_code = substr(code,1,1) if strlen(code)==4
destring state_code,replace
gen estado = "Aguascalientes" if state_code==1
replace estado = "Baja California" if state_code==	2
replace estado = "Baja California Sur" if state_code==	3
replace estado = "Campeche" if state_code==	4
replace estado = "Coahuila" if state_code==	5
replace estado = "Colima" if state_code==	6
replace estado = "Chiapas" if state_code==	7
replace estado = "Chihuahua" if state_code==	8
replace estado = "Distrito Federal" if state_code==	9
replace estado = "Durango" if state_code==	10
replace estado = "Guanajuato" if state_code==	11
replace estado = "Guerrero" if state_code==	12
replace estado = "Hidalgo" if state_code==	13
replace estado = "Jalisco" if state_code==	14
replace estado = "Mexico" if state_code==	15
replace estado = "Michoacan" if state_code==	16
replace estado = "Morelos" if state_code==	17
replace estado = "Nayarit" if state_code==	18
replace estado = "Nuevo Leon" if state_code==	19
replace estado = "Oaxaca" if state_code==	20
replace estado = "Puebla" if state_code==	21
replace estado = "Queretaro" if state_code==	22
replace estado = "Quintana Roo" if state_code==	23
replace estado = "San Luis Potosi" if state_code==	24
replace estado = "Sinaloa" if state_code==	25
replace estado = "Sonora" if state_code==	26
replace estado = "Tabasco" if state_code==	27
replace estado = "Tamaulipas" if state_code==	28
replace estado = "Tlaxcala" if state_code==	29
replace estado = "Veracruz" if state_code==	30
replace estado = "Yucatan" if state_code==	31
replace estado = "Zacatecas" if state_code==	32
replace estado = strupper(estado)

keep estado municipio code

*make changes to slight differences in spelling
replace municipio = "MONTECRISTO DE GUERRERO" /*
	*/if municipio==strupper("Monte Cristo de Guerrero") & estado=="CHIAPAS"
replace municipio = "COYAME" if municipio==strupper("Coyame del Sotol")/*
	*/ & estado=="CHIHUAHUA"
replace municipio = "DOCTOR BELISARIO DOMINGUEZ" if municipio==/*
	*/strupper("Dr. Belisario Dominguez") & estado=="CHIHUAHUA"
replace municipio = "SAN PEDRO DE LAS COLONIAS" if municipio==/*
	*/strupper("San Pedro") & estado=="COAHUILA"
replace municipio = "SAN LUIS DE CORDERO" if municipio==/*
	*/"SAN LUIS DEL CORDERO" & estado=="DURANGO"
replace municipio = "SAN LUIS DE CORDERO" if municipio==/*
	*/"SAN LUIS DEL CORDERO" & estado=="DURANGO"
replace municipio = "ARENAL" if municipio==/*
	*/"EL ARENAL" & estado=="JALISCO"
replace municipio = "CA�ADAS DE OBREGON" if municipio==/*
	*/"CANADAS DE OBREGON" & estado=="JALISCO"
replace municipio = "SAN MARTIN HIDALGO" if municipio==/*
	*/"SAN MARTIN DE HIDALGO" & estado=="JALISCO"
replace municipio = "COACALCO" if municipio==/*
	*/"COACALCO DE BERRIOZABAL" & estado=="MEXICO" 
replace municipio = "ECATEPEC" if municipio==/*
	*/"ECATEPEC DE MORELOS" & estado=="MEXICO" 
replace municipio = "NAUCALPAN" if municipio==/*
	*/"NAUCALPAN DE JUAREZ" & estado=="MEXICO" 
replace municipio = "SANTO TOMAS DE LOS PLATANOS" if municipio==/*
	*/"SANTO TOMAS" & estado=="MEXICO" 
replace municipio = "SOYANIQUILPAN" if municipio==/*
	*/"SOYANIQUILPAN DE JUAREZ" & estado=="MEXICO" 
replace municipio = "TLALNEPANTLA" if municipio==/*
	*/"TLALNEPANTLA DE BAZ" & estado=="MEXICO"
replace municipio = "TING_INDIN" if municipio==/*
	*/"TINGUINDIN" & estado=="MICHOACAN"
replace municipio = "ZACATEPEC" if municipio==/*
	*/"ZACATEPEC DE HIDALGO" & estado=="MORELOS"
replace municipio = "ZACUALPAN" if municipio==/*
	*/"ZACUALPAN DE AMILPAS" & estado=="MORELOS"
replace municipio = "EL NAYAR" if municipio==/*
	*/"DEL NAYAR" & estado=="NAYARIT"
replace municipio = "CIUDAD DE HUAJUAPAM DE LEON" if municipio==/*
	*/"HEROICA CIUDAD DE HUAJUAPAM DE LEON" & estado=="OAXACA"
replace municipio = "LA  PE" if municipio==/*
	*/"LA PE" & estado=="OAXACA"
replace municipio = "SAN JUAN YAE" if municipio==/*
	*/"SAN JUAN YAEE" & estado=="OAXACA"
replace municipio = "SAN JUAN �UMI" if municipio==/*
	*/"SAN JUAN NUMI" & estado=="OAXACA"	
replace municipio = "SAN MATEO PE�ASCO" if municipio==/*
	*/"SAN MATEO PENASCO" & estado=="OAXACA"	
replace municipio = "SAN MIGUEL TALEA DE CASTRO" if municipio==/*
	*/"VILLA TALEA DE CASTRO" & estado=="OAXACA"	
replace municipio = "SAN MIGUEL TEQUISTEPEC" if municipio==/*
	*/"SAN MIGUEL TEQUIXTEPEC" & estado=="OAXACA"
replace municipio = "SAN VICENTE NU�U" if municipio==/*
	*/"SAN VICENTE NUNU" & estado=="OAXACA"
replace municipio = "SANTA  MARIA GUIENAGATI" if municipio==/*
	*/"SANTA MARIA GUIENAGATI" & estado=="OAXACA"
replace municipio = "SANTA  MARIA JALTIANGUIS" if municipio==/*
	*/"SANTA MARIA JALTIANGUIS" & estado=="OAXACA"
replace municipio = "SANTA MARIA CHILAPA DE DIAZ" if municipio==/*
	*/"VILLA DE CHILAPA DE DIAZ" & estado=="OAXACA"
replace municipio = "TLALIXTAC  DE CABRERA" if municipio==/*
	*/"TLALIXTAC DE CABRERA" & estado=="OAXACA"
replace municipio = "VILLA  DIAZ ORDAZ" if municipio==/*
	*/"VILLA DIAZ ORDAZ" & estado=="OAXACA"
replace municipio = "SAN ANTONIO CA�ADA" if municipio==/*
	*/"SAN ANTONIO CANADA" & estado=="PUEBLA"
replace municipio = "TIERRANUEVA" if municipio==/*
	*/"TIERRA NUEVA" & estado=="SAN LUIS POTOSI"
replace municipio = "XALOSTOC" if municipio==/*
	*/"XALOZTOC" & estado=="TLAXCALA"
replace municipio = "CAZONES DE HERRERA" if municipio==/*
	*/"CAZONES" & estado=="VERACRUZ"
replace municipio = "HUILOAPAN DE CUAUHTEMOC" if municipio==/*
	*/"HUILOAPAN" & estado=="VERACRUZ"
replace municipio = "NARANJOS-AMATLAN" if municipio==/*
	*/"NARANJOS AMATLAN" & estado=="VERACRUZ"
replace municipio = "GENERAL JOAQUIN AMARO" if municipio==/*
	*/"EL PLATEADO DE JOAQUIN AMARO" & estado=="ZACATECAS"
	
merge 1:m estado municipio using /*
	*/"$build\input\ejido_AER2015\procede_mun_dates_emaild.dta"
drop if _merge!=3
drop _merge 
format procededat %td
gen procede_activation_year = year(procededat)
drop if ejidatario==0

//merge with crosswalk to over-time consistent municipality codes
rename code mx2000a_resmun
destring mx2000a_resmun,replace

preserve
use "$build\temp\municipio_crosswalk.dta",clear
drop if mx2000a_resmun==.
tempfile tmp
save "`tmp'"
restore
merge m:1 mx2000a_resmun using "`tmp'"
drop if _merge==2 //not all municipalities have an ejido
drop _merge mx1990a mx1995a procededat

*compute proportion of population in activated ejidos
gen year = 1995 if procede_activation_year<=1995
replace year = 2000 if procede_activation_year>1995 & /*
	*/procede_activation_year<=2000

collapse (sum) ejidatario,by(state_munic_code_xwalk year)
bysort state_munic_code_xwalk: egen total_ejido_pop = total(ejidatario)
drop if year==. //drop rows containing population activated after 2000

//some municipalities had no activations prior to 1995; add a zero for them
//same for those with no activation 1995-2000
reshape wide ejidatario, i(state_munic_code_xwalk) j(year)
replace ejidatario1995=0 if ejidatario1995==.
replace ejidatario2000=0 if ejidatario2000==.
reshape long ejidatario, i(state_munic_code_xwalk) j(year)

gen cumul_pop_activated = ejidatario if year==1995
tsset state_munic_code_xwalk year
replace cumul_pop_activated = ejidatario+l5.ejidatario if year==2000
	
gen proportion_ejido_activated = cumul_pop_activated/total_ejido_pop

*add in 1990 municipality population to normalize proportion
rename state_munic_code_xwalk geo2_mx
replace geo2_mx = 484000000+geo2_mx
merge m:1 geo2_mx using "$build\temp\muni_pop1990.dta"
drop if _merge==2
drop _merge

gen prop_ejido_activated_normalized = cumul_pop_activated/muni_pop

sort geo2_mx year
gen chg_prop_ejido_activated = proportion_ejido_activated-l5.proportion_ejido_activated
replace chg_prop_ejido_activated = proportion_ejido_activated if year==1995
gen chg_prop_ejido_activated_norm=prop_ejido_activated_normalized-l5.prop_ejido_activated_normalized
replace chg_prop_ejido_activated_norm = prop_ejido_activated_normalized if year==1995

rename geo2_mx munic
label variable chg_prop_ejido_activated_norm /*
	*/"Chg. in total region pop. in activated ejido"

save "$build\output\ejido_activation_pop_weighted_muni.dta",replace
