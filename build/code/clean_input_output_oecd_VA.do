set more off, permanently
clear all

global build "C:\Users\bmccully\Documents\nafta-migration\build"

insheet using "$build\input\Input-Output\oecd-input-output-mexico.csv",/*
	*/comma clear

drop cou country flagcodes flags referenceperiod referenceperiodcode /*
	*/powercode

keep var variable row columnsectorto time value col
keep if var=="VAL" | row=="LABR"

keep if time==1995
drop time
reshape wide value, i(columnsectorto) j(row) string

gen theta_i = 1-(valueLABR/valueVALU)

preserve
import delimited "$build\input\isicr2-isicoecd-crosswalk.csv",clear
rename isic_2dig_oecd col
tempfile tmp
save "`tmp'"
restore
merge 1:m col using "`tmp'"
drop if _merge==1 //drop non-tradeables
drop _merge

/*OECD uses ISIC 2 digit industry codes*
//generate codes
gen isic_2dig1 = ""
replace isic_2dig1 = substr(col,2,2) if strlen(col)==3
keep isic_2dig1 col theta_i
gen isic_2dig2=""
gen isic_2dig3=""
gen isic_2dig4=""
gen isic_2dig5=""
replace isic_2dig1 = substr(col,2,2) if strlen(col)>3
replace isic_2dig2 = substr(col,5,2) if strlen(col)>3
destring isic_2dig?,replace
replace isic_2dig3 = isic_2dig1+1 if isic_2dig1<isic_2dig2 & isic_2dig2!=.
replace isic_2dig4 = isic_2dig1+2 if isic_2dig1+1<isic_2dig2 & isic_2dig2!=. /*
	*/& isic_2dig1+2!=isic_2dig2
replace isic_2dig5 = isic_2dig1+3 if isic_2dig1+2<isic_2dig2 & isic_2dig2!=. /*
	*/& isic_2dig1+3!=isic_2dig2
	
reshape long isic_2dig , i(col theta_i) j(num)
drop num
drop if isic_2dig==.*/


//merge with crosswalk to Mexican 1990 industry codes
preserve
import delimited "$build\input\isicr2-mex90ind-crosswalk.csv",clear
reshape long mex90ind, i(isicr2) j(index)
gen isic_2dig = int(isicr2/100)
drop index
drop if mex90ind==.
rename mex90ind ind
tempfile tmp
save "`tmp'"
restore
merge 1:m isicr2 using "`tmp'" //only matches tradeable industries
drop if _merge==1 //Mexican '90 industries that for which I couldn't
				  //figure out which ISICr2 industry they belonged.
drop _merge

keep ind isicr2 theta_i

duplicates drop 

//make isicr2 the unique ID of observations by taking the simple average
//in theta_i across industries
collapse (mean) theta_i,by(isic)

save "$build\temp\theta_i.dta",replace


/*Crosswalk between ISIC 3.1 codes used on OECD website and ISIC r.2 codes 
used for tariffs*
set more off, permanently
clear all

global build "C:\Users\bmccully\Documents\nafta-migration\build"

insheet using "$build\input\oecd-input-output-mexico.csv",comma clear

drop cou country flagcodes flags referenceperiod referenceperiodcode /*
	*/powercode

keep var variable row col columnsectorto time value
keep if var=="VAL" | row=="LABR"

keep if time==1995
drop time
reshape wide value, i(columnsectorto) j(row) string

gen theta_i = 1-(valueLABR/valueVALU)

gen isic_2dig = .
replace isic_2dig =

