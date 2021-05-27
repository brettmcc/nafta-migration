global build "C:\Users\bmccully\Documents\nafta-migration\build"

set more off
clear all

timer clear
timer on 1
insheet using "$build\input\ipumsi_mex_census90-95-00.csv",comma clear
timer off 1
timer list 1

replace hhwt       = hhwt       / 100
replace perwt      = perwt      / 100

format sample     %9.0f
format serial     %10.0f
format hhwt       %8.2f
format geo2_mx    %9.0f
format perwt      %8.2f
format incearn    %8.0f

label var country    `"Country"'
label var year       `"Year"'
label var sample     `"IPUMS sample identifier"'
label var serial     `"Household serial number"'
label var persons    `"Number of person records in the household"'
label var hhwt       `"Household weight"'
label var subsamp    `"Subsample number"'
label var gq         `"Group quarters (collective dwelling) status"'
label var urban      `"Urban-rural status"'
label var geo1_mx    `"Mexico, State 1960 - 2015 [Level 1; consistent boundaries, GIS]"'
label var geo2_mx    `"Mexico, Municipality 1960 - 2015 [Level 2; consistent boundaries, GIS]"'
label var sizemx     `"Mexico, Size of locality"'
label var ownership  `"Ownership of dwelling [general version]"'
label var ownershipd `"Ownership of dwelling [detailed version]"'
label var intmig2    `"Number of international migrants, Mexico"'
label var electric   `"Electricity"'
label var watsup     `"Water supply"'
label var sewage     `"Sewage"'
label var fuelcook   `"Cooking fuel"'
label var rooms      `"Number of rooms"'
label var bedrooms   `"Number of bedrooms"'
label var kitchen    `"Kitchen or cooking facilities"'
label var toilet     `"Toilet"'
label var floor      `"Floor material"'
label var wall       `"Wall or building material"'
label var roof       `"Roof material"'
label var hhtype     `"Household classification"'
label var nfams      `"Number of families in household"'
label var pernum     `"Person number"'
label var perwt      `"Person weight"'
label var relate     `"Relationship to household head [general version]"'
label var related    `"Relationship to household head [detailed version]"'
label var age        `"Age"'
label var sex        `"Sex"'
label var marst      `"Marital status [general version]"'
label var marstd     `"Marital status [detailed version]"'
label var consens    `"Consensual union"'
label var nativity   `"Nativity status"'
label var bplcountry `"Country of birth"'
label var bplmx      `"State of birth, Mexico"'
label var school     `"School attendance"'
label var lit        `"Literacy"'
label var edattain   `"Educational attainment, international recode [general version]"'
label var edattaind  `"Educational attainment, international recode [detailed version]"'
label var yrschool   `"Years of schooling"'
label var educmx     `"Educational attainment, Mexico"'
label var empstat    `"Activity status (employment status) [general version]"'
label var empstatd   `"Activity status (employment status) [detailed version]"'
label var occisco    `"Occupation, ISCO general"'
label var occ        `"Occupation, unrecoded"'
label var indgen     `"Industry, general recode"'
label var ind        `"Industry, unrecoded"'
label var classwk    `"Status in employment (class of worker) [general version]"'
label var classwkd   `"Status in employment (class of worker) [detailed version]"'
label var hrswork1   `"Hours worked per week"'
label var inctot     `"Total income"'
label var incearn    `"Earned income"'
label var incwel     `"Income from anti-poverty or welfare programs"'
label var incret     `"Retirement or pension income"'
label var incfmab    `"Income from family members living abroad"'
label var migrate5   `"Migration status, 5 years"'
label var migratep   `"Migration status, previous residence"'
label var migctry5   `"Country of residence 5 years ago"'
label var migyrs1    `"Years residing in current locality"'
label var migcause   `"Reason for migration"'
label var migmx1     `"State of previous residence, Mexico"'
label var migmx2     `"State of residence 5 years ago, Mexico"'
label var disemp     `"Employment disability"'

label define country_lbl 032 `"Argentina"'
label define country_lbl 051 `"Armenia"', add
label define country_lbl 040 `"Austria"', add
label define country_lbl 050 `"Bangladesh"', add
label define country_lbl 112 `"Belarus"', add
label define country_lbl 068 `"Bolivia"', add
label define country_lbl 072 `"Botswana"', add
label define country_lbl 076 `"Brazil"', add
label define country_lbl 854 `"Burkina Faso"', add
label define country_lbl 116 `"Cambodia"', add
label define country_lbl 120 `"Cameroon"', add
label define country_lbl 124 `"Canada"', add
label define country_lbl 152 `"Chile"', add
label define country_lbl 156 `"China"', add
label define country_lbl 170 `"Colombia"', add
label define country_lbl 188 `"Costa Rica"', add
label define country_lbl 192 `"Cuba"', add
label define country_lbl 214 `"Dominican Republic"', add
label define country_lbl 218 `"Ecuador"', add
label define country_lbl 818 `"Egypt"', add
label define country_lbl 222 `"El Salvador"', add
label define country_lbl 231 `"Ethiopia"', add
label define country_lbl 242 `"Fiji"', add
label define country_lbl 250 `"France"', add
label define country_lbl 276 `"Germany"', add
label define country_lbl 288 `"Ghana"', add
label define country_lbl 300 `"Greece"', add
label define country_lbl 324 `"Guinea"', add
label define country_lbl 332 `"Haiti"', add
label define country_lbl 348 `"Hungary"', add
label define country_lbl 356 `"India"', add
label define country_lbl 360 `"Indonesia"', add
label define country_lbl 364 `"Iran"', add
label define country_lbl 368 `"Iraq"', add
label define country_lbl 372 `"Ireland"', add
label define country_lbl 376 `"Israel"', add
label define country_lbl 380 `"Italy"', add
label define country_lbl 388 `"Jamaica"', add
label define country_lbl 400 `"Jordan"', add
label define country_lbl 404 `"Kenya"', add
label define country_lbl 417 `"Kyrgyz Republic"', add
label define country_lbl 430 `"Liberia"', add
label define country_lbl 454 `"Malawi"', add
label define country_lbl 458 `"Malaysia"', add
label define country_lbl 466 `"Mali"', add
label define country_lbl 484 `"Mexico"', add
label define country_lbl 496 `"Mongolia"', add
label define country_lbl 504 `"Morocco"', add
label define country_lbl 508 `"Mozambique"', add
label define country_lbl 524 `"Nepal"', add
label define country_lbl 528 `"Netherlands"', add
label define country_lbl 558 `"Nicaragua"', add
label define country_lbl 566 `"Nigeria"', add
label define country_lbl 586 `"Pakistan"', add
label define country_lbl 275 `"Palestine"', add
label define country_lbl 591 `"Panama"', add
label define country_lbl 600 `"Paraguay"', add
label define country_lbl 604 `"Peru"', add
label define country_lbl 608 `"Philippines"', add
label define country_lbl 616 `"Poland"', add
label define country_lbl 620 `"Portugal"', add
label define country_lbl 630 `"Puerto Rico"', add
label define country_lbl 642 `"Romania"', add
label define country_lbl 646 `"Rwanda"', add
label define country_lbl 662 `"Saint Lucia"', add
label define country_lbl 686 `"Senegal"', add
label define country_lbl 694 `"Sierra Leone"', add
label define country_lbl 705 `"Slovenia"', add
label define country_lbl 710 `"South Africa"', add
label define country_lbl 728 `"South Sudan"', add
label define country_lbl 724 `"Spain"', add
label define country_lbl 729 `"Sudan"', add
label define country_lbl 756 `"Switzerland"', add
label define country_lbl 834 `"Tanzania"', add
label define country_lbl 764 `"Thailand"', add
label define country_lbl 780 `"Trinidad and Tobago"', add
label define country_lbl 792 `"Turkey"', add
label define country_lbl 800 `"Uganda"', add
label define country_lbl 804 `"Ukraine"', add
label define country_lbl 826 `"United Kingdom"', add
label define country_lbl 840 `"United States"', add
label define country_lbl 858 `"Uruguay"', add
label define country_lbl 862 `"Venezuela"', add
label define country_lbl 704 `"Vietnam"', add
label define country_lbl 894 `"Zambia"', add
label values country country_lbl

label define year_lbl 1960 `"1960"'
label define year_lbl 1962 `"1962"', add
label define year_lbl 1963 `"1963"', add
label define year_lbl 1964 `"1964"', add
label define year_lbl 1966 `"1966"', add
label define year_lbl 1968 `"1968"', add
label define year_lbl 1969 `"1969"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1971 `"1971"', add
label define year_lbl 1972 `"1972"', add
label define year_lbl 1973 `"1973"', add
label define year_lbl 1974 `"1974"', add
label define year_lbl 1975 `"1975"', add
label define year_lbl 1976 `"1976"', add
label define year_lbl 1977 `"1977"', add
label define year_lbl 1978 `"1978"', add
label define year_lbl 1979 `"1979"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1981 `"1981"', add
label define year_lbl 1982 `"1982"', add
label define year_lbl 1983 `"1983"', add
label define year_lbl 1984 `"1984"', add
label define year_lbl 1985 `"1985"', add
label define year_lbl 1986 `"1986"', add
label define year_lbl 1987 `"1987"', add
label define year_lbl 1989 `"1989"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 1991 `"1991"', add
label define year_lbl 1992 `"1992"', add
label define year_lbl 1993 `"1993"', add
label define year_lbl 1994 `"1994"', add
label define year_lbl 1995 `"1995"', add
label define year_lbl 1996 `"1996"', add
label define year_lbl 1997 `"1997"', add
label define year_lbl 1998 `"1998"', add
label define year_lbl 1999 `"1999"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label define year_lbl 2012 `"2012"', add
label define year_lbl 2013 `"2013"', add
label define year_lbl 2014 `"2014"', add
label define year_lbl 2015 `"2015"', add
label values year year_lbl

label define sample_lbl 032197001 `"Argentina 1970"'
label define sample_lbl 032219801 `"Argentina 1980"', add
label define sample_lbl 032199101 `"Argentina 1991"', add
label define sample_lbl 032200101 `"Argentina 2001"', add
label define sample_lbl 032201001 `"Argentina 2010"', add
label define sample_lbl 051200101 `"Armenia 2001"', add
label define sample_lbl 051201101 `"Armenia 2011"', add
label define sample_lbl 040197101 `"Austria 1971"', add
label define sample_lbl 040198101 `"Austria 1981"', add
label define sample_lbl 040199101 `"Austria 1991"', add
label define sample_lbl 040200101 `"Austria 2001"', add
label define sample_lbl 040201101 `"Austria 2011"', add
label define sample_lbl 050199101 `"Bangladesh 1991"', add
label define sample_lbl 050200101 `"Bangladesh 2001"', add
label define sample_lbl 050201101 `"Bangladesh 2011"', add
label define sample_lbl 112199901 `"Belarus 1999"', add
label define sample_lbl 112200901 `"Belarus 2009"', add
label define sample_lbl 068197601 `"Bolivia 1976"', add
label define sample_lbl 068199201 `"Bolivia 1992"', add
label define sample_lbl 068200101 `"Bolivia 2001"', add
label define sample_lbl 072198101 `"Botswana 1981"', add
label define sample_lbl 072199101 `"Botswana 1991"', add
label define sample_lbl 072200101 `"Botswana 2001"', add
label define sample_lbl 072201101 `"Botswana 2011"', add
label define sample_lbl 076196001 `"Brazil 1960"', add
label define sample_lbl 076197001 `"Brazil 1970"', add
label define sample_lbl 076198001 `"Brazil 1980"', add
label define sample_lbl 076199101 `"Brazil 1991"', add
label define sample_lbl 076200001 `"Brazil 2000"', add
label define sample_lbl 076201001 `"Brazil 2010"', add
label define sample_lbl 854198501 `"Burkina Faso 1985"', add
label define sample_lbl 854199601 `"Burkina Faso 1996"', add
label define sample_lbl 854200601 `"Burkina Faso 2006"', add
label define sample_lbl 116199801 `"Cambodia 1998"', add
label define sample_lbl 116200801 `"Cambodia 2008"', add
label define sample_lbl 120197601 `"Cameroon 1976"', add
label define sample_lbl 120198701 `"Cameroon 1987"', add
label define sample_lbl 120200501 `"Cameroon 2005"', add
label define sample_lbl 124197101 `"Canada 1971"', add
label define sample_lbl 124198101 `"Canada 1981"', add
label define sample_lbl 124199101 `"Canada 1991"', add
label define sample_lbl 124200101 `"Canada 2001"', add
label define sample_lbl 124201101 `"Canada 2011"', add
label define sample_lbl 152196001 `"Chile 1960"', add
label define sample_lbl 152197001 `"Chile 1970"', add
label define sample_lbl 152198201 `"Chile 1982"', add
label define sample_lbl 152199201 `"Chile 1992"', add
label define sample_lbl 152200201 `"Chile 2002"', add
label define sample_lbl 156198201 `"China 1982"', add
label define sample_lbl 156199001 `"China 1990"', add
label define sample_lbl 156200001 `"China 2000"', add
label define sample_lbl 170196401 `"Colombia 1964"', add
label define sample_lbl 170197301 `"Colombia 1973"', add
label define sample_lbl 170198501 `"Colombia 1985"', add
label define sample_lbl 170199301 `"Colombia 1993"', add
label define sample_lbl 170200501 `"Colombia 2005"', add
label define sample_lbl 188196301 `"Costa Rica 1963"', add
label define sample_lbl 188197301 `"Costa Rica 1973"', add
label define sample_lbl 188198401 `"Costa Rica 1984"', add
label define sample_lbl 188200001 `"Costa Rica 2000"', add
label define sample_lbl 188201101 `"Costa Rica 2011"', add
label define sample_lbl 192200201 `"Cuba 2002"', add
label define sample_lbl 214196001 `"Dominican Republic 1960"', add
label define sample_lbl 214197001 `"Dominican Republic 1970"', add
label define sample_lbl 214198101 `"Dominican Republic 1981"', add
label define sample_lbl 214200201 `"Dominican Republic 2002"', add
label define sample_lbl 214201001 `"Dominican Republic 2010"', add
label define sample_lbl 218196201 `"Ecuador 1962"', add
label define sample_lbl 218197401 `"Ecuador 1974"', add
label define sample_lbl 218198201 `"Ecuador 1982"', add
label define sample_lbl 218199001 `"Ecuador 1990"', add
label define sample_lbl 218200101 `"Ecuador 2001"', add
label define sample_lbl 218201001 `"Ecuador 2010"', add
label define sample_lbl 818198601 `"Egypt 1986"', add
label define sample_lbl 818199601 `"Egypt 1996"', add
label define sample_lbl 818200601 `"Egypt 2006"', add
label define sample_lbl 222199201 `"El Salvador 1992"', add
label define sample_lbl 222200701 `"El Salvador 2007"', add
label define sample_lbl 231198401 `"Ethiopia 1984"', add
label define sample_lbl 231199401 `"Ethiopia 1994"', add
label define sample_lbl 231200701 `"Ethiopia 2007"', add
label define sample_lbl 242196601 `"Fiji 1966"', add
label define sample_lbl 242197601 `"Fiji 1976"', add
label define sample_lbl 242198601 `"Fiji 1986"', add
label define sample_lbl 242199601 `"Fiji 1996"', add
label define sample_lbl 242200701 `"Fiji 2007"', add
label define sample_lbl 250196201 `"France 1962"', add
label define sample_lbl 250196801 `"France 1968"', add
label define sample_lbl 250197501 `"France 1975"', add
label define sample_lbl 250198201 `"France 1982"', add
label define sample_lbl 250199001 `"France 1990"', add
label define sample_lbl 250199901 `"France 1999"', add
label define sample_lbl 250200601 `"France 2006"', add
label define sample_lbl 250201101 `"France 2011"', add
label define sample_lbl 276197001 `"Germany 1970 (West)"', add
label define sample_lbl 276197101 `"Germany 1971 (East)"', add
label define sample_lbl 276198101 `"Germany 1981 (East)"', add
label define sample_lbl 276198701 `"Germany 1987 (West)"', add
label define sample_lbl 288198401 `"Ghana 1984"', add
label define sample_lbl 288200001 `"Ghana 2000"', add
label define sample_lbl 288201001 `"Ghana 2010"', add
label define sample_lbl 300197101 `"Greece 1971"', add
label define sample_lbl 300198101 `"Greece 1981"', add
label define sample_lbl 300199101 `"Greece 1991"', add
label define sample_lbl 300200101 `"Greece 2001"', add
label define sample_lbl 300201101 `"Greece 2011"', add
label define sample_lbl 324198301 `"Guinea 1983"', add
label define sample_lbl 324199601 `"Guinea 1996"', add
label define sample_lbl 332197101 `"Haiti 1971"', add
label define sample_lbl 332198201 `"Haiti 1982"', add
label define sample_lbl 332200301 `"Haiti 2003"', add
label define sample_lbl 348197001 `"Hungary 1970"', add
label define sample_lbl 348198001 `"Hungary 1980"', add
label define sample_lbl 348199001 `"Hungary 1990"', add
label define sample_lbl 348200101 `"Hungary 2001"', add
label define sample_lbl 348201101 `"Hungary 2011"', add
label define sample_lbl 356198341 `"India 1983"', add
label define sample_lbl 356198741 `"India 1987"', add
label define sample_lbl 356199341 `"India 1993"', add
label define sample_lbl 356199941 `"India 1999"', add
label define sample_lbl 356200441 `"India 2004"', add
label define sample_lbl 356200941 `"India 2009"', add
label define sample_lbl 360197101 `"Indonesia 1971"', add
label define sample_lbl 360197601 `"Indonesia 1976"', add
label define sample_lbl 360198001 `"Indonesia 1980"', add
label define sample_lbl 360198501 `"Indonesia 1985"', add
label define sample_lbl 360199001 `"Indonesia 1990"', add
label define sample_lbl 360199501 `"Indonesia 1995"', add
label define sample_lbl 360200001 `"Indonesia 2000"', add
label define sample_lbl 360200501 `"Indonesia 2005"', add
label define sample_lbl 360201001 `"Indonesia 2010"', add
label define sample_lbl 364200601 `"Iran 2006"', add
label define sample_lbl 364201101 `"Iran 2011"', add
label define sample_lbl 368199701 `"Iraq 1997"', add
label define sample_lbl 372197101 `"Ireland 1971"', add
label define sample_lbl 372197901 `"Ireland 1979"', add
label define sample_lbl 372198101 `"Ireland 1981"', add
label define sample_lbl 372198601 `"Ireland 1986"', add
label define sample_lbl 372199101 `"Ireland 1991"', add
label define sample_lbl 372199601 `"Ireland 1996"', add
label define sample_lbl 372200201 `"Ireland 2002"', add
label define sample_lbl 372200601 `"Ireland 2006"', add
label define sample_lbl 372201101 `"Ireland 2011"', add
label define sample_lbl 376197201 `"Israel 1972"', add
label define sample_lbl 376198301 `"Israel 1983"', add
label define sample_lbl 376199501 `"Israel 1995"', add
label define sample_lbl 380200101 `"Italy 2001"', add
label define sample_lbl 388198201 `"Jamaica 1982"', add
label define sample_lbl 388199101 `"Jamaica 1991"', add
label define sample_lbl 388200101 `"Jamaica 2001"', add
label define sample_lbl 400200401 `"Jordan 2004"', add
label define sample_lbl 404196901 `"Kenya 1969"', add
label define sample_lbl 404197901 `"Kenya 1979"', add
label define sample_lbl 404198901 `"Kenya 1989"', add
label define sample_lbl 404199901 `"Kenya 1999"', add
label define sample_lbl 404200901 `"Kenya 2009"', add
label define sample_lbl 417199901 `"Kyrgyz Republic 1999"', add
label define sample_lbl 417200901 `"Kyrgyz Republic 2009"', add
label define sample_lbl 430197401 `"Liberia 1974"', add
label define sample_lbl 430200801 `"Liberia 2008"', add
label define sample_lbl 454198701 `"Malawi 1987"', add
label define sample_lbl 454199801 `"Malawi 1998"', add
label define sample_lbl 454200801 `"Malawi 2008"', add
label define sample_lbl 458197001 `"Malaysia 1970"', add
label define sample_lbl 458198001 `"Malaysia 1980"', add
label define sample_lbl 458199101 `"Malaysia 1991"', add
label define sample_lbl 458200001 `"Malaysia 2000"', add
label define sample_lbl 466198701 `"Mali 1987"', add
label define sample_lbl 466199801 `"Mali 1998"', add
label define sample_lbl 466200901 `"Mali 2009"', add
label define sample_lbl 484196001 `"Mexico 1960"', add
label define sample_lbl 484197001 `"Mexico 1970"', add
label define sample_lbl 484199001 `"Mexico 1990"', add
label define sample_lbl 484199501 `"Mexico 1995"', add
label define sample_lbl 484200001 `"Mexico 2000"', add
label define sample_lbl 484200501 `"Mexico 2005"', add
label define sample_lbl 484201001 `"Mexico 2010"', add
label define sample_lbl 484201501 `"Mexico 2015"', add
label define sample_lbl 496198901 `"Mongolia 1989"', add
label define sample_lbl 496200001 `"Mongolia 2000"', add
label define sample_lbl 504198201 `"Morocco 1982"', add
label define sample_lbl 504199401 `"Morocco 1994"', add
label define sample_lbl 504200401 `"Morocco 2004"', add
label define sample_lbl 508199701 `"Mozambique 1997"', add
label define sample_lbl 508200701 `"Mozambique 2007"', add
label define sample_lbl 524200101 `"Nepal 2001"', add
label define sample_lbl 528196001 `"Netherlands 1960"', add
label define sample_lbl 528197101 `"Netherlands 1971"', add
label define sample_lbl 528200101 `"Netherlands 2001"', add
label define sample_lbl 558197101 `"Nicaragua 1971"', add
label define sample_lbl 558199501 `"Nicaragua 1995"', add
label define sample_lbl 558200501 `"Nicaragua 2005"', add
label define sample_lbl 566200621 `"Nigeria 2006"', add
label define sample_lbl 566200721 `"Nigeria 2007"', add
label define sample_lbl 566200821 `"Nigeria 2008"', add
label define sample_lbl 566200921 `"Nigeria 2009"', add
label define sample_lbl 566201021 `"Nigeria 2010"', add
label define sample_lbl 586197301 `"Pakistan 1973"', add
label define sample_lbl 586198101 `"Pakistan 1981"', add
label define sample_lbl 586199801 `"Pakistan 1998"', add
label define sample_lbl 275199701 `"Palestine 1997"', add
label define sample_lbl 275200701 `"Palestine 2007"', add
label define sample_lbl 591196001 `"Panama 1960"', add
label define sample_lbl 591197001 `"Panama 1970"', add
label define sample_lbl 591198001 `"Panama 1980"', add
label define sample_lbl 591199001 `"Panama 1990"', add
label define sample_lbl 591200001 `"Panama 2000"', add
label define sample_lbl 591201001 `"Panama 2010"', add
label define sample_lbl 600196201 `"Paraguay 1962"', add
label define sample_lbl 600197201 `"Paraguay 1972"', add
label define sample_lbl 600198201 `"Paraguay 1982"', add
label define sample_lbl 600199201 `"Paraguay 1992"', add
label define sample_lbl 600200201 `"Paraguay 2002"', add
label define sample_lbl 604199301 `"Peru 1993"', add
label define sample_lbl 604200701 `"Peru 2007"', add
label define sample_lbl 608199001 `"Philippines 1990"', add
label define sample_lbl 608199501 `"Philippines 1995"', add
label define sample_lbl 608200001 `"Philippines 2000"', add
label define sample_lbl 616197801 `"Poland 1978"', add
label define sample_lbl 616198801 `"Poland 1988"', add
label define sample_lbl 616200201 `"Poland 2002"', add
label define sample_lbl 616201101 `"Poland 2011"', add
label define sample_lbl 620198101 `"Portugal 1981"', add
label define sample_lbl 620199101 `"Portugal 1991"', add
label define sample_lbl 620200101 `"Portugal 2001"', add
label define sample_lbl 620201101 `"Portugal 2011"', add
label define sample_lbl 630197001 `"Puerto Rico 1970"', add
label define sample_lbl 630198001 `"Puerto Rico 1980"', add
label define sample_lbl 630199001 `"Puerto Rico 1990"', add
label define sample_lbl 630200001 `"Puerto Rico 2000"', add
label define sample_lbl 630200501 `"Puerto Rico 2005"', add
label define sample_lbl 630201001 `"Puerto Rico 2010"', add
label define sample_lbl 642197701 `"Romania 1977"', add
label define sample_lbl 642199201 `"Romania 1992"', add
label define sample_lbl 642200201 `"Romania 2002"', add
label define sample_lbl 642201101 `"Romania 2011"', add
label define sample_lbl 646199101 `"Rwanda 1991"', add
label define sample_lbl 646200201 `"Rwanda 2002"', add
label define sample_lbl 662198001 `"Saint Lucia 1980"', add
label define sample_lbl 662199101 `"Saint Lucia 1991"', add
label define sample_lbl 686198801 `"Senegal 1988"', add
label define sample_lbl 686200201 `"Senegal 2002"', add
label define sample_lbl 694200401 `"Sierra Leone 2004"', add
label define sample_lbl 705200201 `"Slovenia 2002"', add
label define sample_lbl 710199601 `"South Africa 1996"', add
label define sample_lbl 710200101 `"South Africa 2001"', add
label define sample_lbl 710200701 `"South Africa 2007"', add
label define sample_lbl 710201101 `"South Africa 2011"', add
label define sample_lbl 728200801 `"South Sudan 2008"', add
label define sample_lbl 724198101 `"Spain 1981"', add
label define sample_lbl 724199101 `"Spain 1991"', add
label define sample_lbl 724200101 `"Spain 2001"', add
label define sample_lbl 724201101 `"Spain 2011"', add
label define sample_lbl 729200801 `"Sudan 2008"', add
label define sample_lbl 756197001 `"Switzerland 1970"', add
label define sample_lbl 756198001 `"Switzerland 1980"', add
label define sample_lbl 756199001 `"Switzerland 1990"', add
label define sample_lbl 756200001 `"Switzerland 2000"', add
label define sample_lbl 834198801 `"Tanzania 1988"', add
label define sample_lbl 834200201 `"Tanzania 2002"', add
label define sample_lbl 834201201 `"Tanzania 2012"', add
label define sample_lbl 764197001 `"Thailand 1970"', add
label define sample_lbl 764198001 `"Thailand 1980"', add
label define sample_lbl 764199001 `"Thailand 1990"', add
label define sample_lbl 764200001 `"Thailand 2000"', add
label define sample_lbl 780197001 `"Trinidad and Tobago 1970"', add
label define sample_lbl 780198001 `"Trinidad and Tobago 1980"', add
label define sample_lbl 780199001 `"Trinidad and Tobago 1990"', add
label define sample_lbl 780200001 `"Trinidad and Tobago 2000"', add
label define sample_lbl 780201101 `"Trinidad and Tobago 2011"', add
label define sample_lbl 792198501 `"Turkey 1985"', add
label define sample_lbl 792199001 `"Turkey 1990"', add
label define sample_lbl 792200001 `"Turkey 2000"', add
label define sample_lbl 800199101 `"Uganda 1991"', add
label define sample_lbl 800200201 `"Uganda 2002"', add
label define sample_lbl 804200101 `"Ukraine 2001"', add
label define sample_lbl 826199101 `"United Kingdom 1991"', add
label define sample_lbl 826200101 `"United Kingdom 2001"', add
label define sample_lbl 840196001 `"United States 1960"', add
label define sample_lbl 840197001 `"United States 1970"', add
label define sample_lbl 840198001 `"United States 1980"', add
label define sample_lbl 840199001 `"United States 1990"', add
label define sample_lbl 840200001 `"United States 2000"', add
label define sample_lbl 840200501 `"United States 2005"', add
label define sample_lbl 840201001 `"United States 2010"', add
label define sample_lbl 858196301 `"Uruguay 1963"', add
label define sample_lbl 858197501 `"Uruguay 1975"', add
label define sample_lbl 858198501 `"Uruguay 1985"', add
label define sample_lbl 858199601 `"Uruguay 1996"', add
label define sample_lbl 858200621 `"Uruguay 2006"', add
label define sample_lbl 858201101 `"Uruguay 2011"', add
label define sample_lbl 862197101 `"Venezuela 1971"', add
label define sample_lbl 862198101 `"Venezuela 1981"', add
label define sample_lbl 862199001 `"Venezuela 1990"', add
label define sample_lbl 862200101 `"Venezuela 2001"', add
label define sample_lbl 704198901 `"Vietnam 1989"', add
label define sample_lbl 704199901 `"Vietnam 1999"', add
label define sample_lbl 704200901 `"Vietnam 2009"', add
label define sample_lbl 894199001 `"Zambia 1990"', add
label define sample_lbl 894200001 `"Zambia 2000"', add
label define sample_lbl 894201001 `"Zambia 2010"', add
label values sample sample_lbl

label define subsamp_lbl 00 `"1st 1% subsample"'
label define subsamp_lbl 01 `"2nd 1% subsample"', add
label define subsamp_lbl 02 `"3rd 1% subsample"', add
label define subsamp_lbl 03 `"4th 1% subsample"', add
label define subsamp_lbl 04 `"5th 1% subsample"', add
label define subsamp_lbl 05 `"6th 1% subsample"', add
label define subsamp_lbl 06 `"7th 1% subsample"', add
label define subsamp_lbl 07 `"8th 1% subsample"', add
label define subsamp_lbl 08 `"9th 1% subsample"', add
label define subsamp_lbl 09 `"10th 1% subsample"', add
label define subsamp_lbl 10 `"11th 1% subsample"', add
label define subsamp_lbl 11 `"12th 1% subsample"', add
label define subsamp_lbl 12 `"13th 1% subsample"', add
label define subsamp_lbl 13 `"14th 1% subsample"', add
label define subsamp_lbl 14 `"15th 1% subsample"', add
label define subsamp_lbl 15 `"16th 1% subsample"', add
label define subsamp_lbl 16 `"17th 1% subsample"', add
label define subsamp_lbl 17 `"18th 1% subsample"', add
label define subsamp_lbl 18 `"19th 1% subsample"', add
label define subsamp_lbl 19 `"20th 1% subsample"', add
label define subsamp_lbl 20 `"21st 1% subsample"', add
label define subsamp_lbl 21 `"22nd 1% subsample"', add
label define subsamp_lbl 22 `"23rd 1% subsample"', add
label define subsamp_lbl 23 `"24th 1% subsample"', add
label define subsamp_lbl 24 `"25th 1% subsample"', add
label define subsamp_lbl 25 `"26th 1% subsample"', add
label define subsamp_lbl 26 `"27th 1% subsample"', add
label define subsamp_lbl 27 `"28th 1% subsample"', add
label define subsamp_lbl 28 `"29th 1% subsample"', add
label define subsamp_lbl 29 `"30th 1% subsample"', add
label define subsamp_lbl 30 `"31st 1% subsample"', add
label define subsamp_lbl 31 `"32nd 1% subsample"', add
label define subsamp_lbl 32 `"33rd 1% subsample"', add
label define subsamp_lbl 33 `"34th 1% subsample"', add
label define subsamp_lbl 34 `"35th 1% subsample"', add
label define subsamp_lbl 35 `"36th 1% subsample"', add
label define subsamp_lbl 36 `"37th 1% subsample"', add
label define subsamp_lbl 37 `"38th 1% subsample"', add
label define subsamp_lbl 38 `"39th 1% subsample"', add
label define subsamp_lbl 39 `"40th 1% subsample"', add
label define subsamp_lbl 40 `"41st 1% subsample"', add
label define subsamp_lbl 41 `"42nd 1% subsample"', add
label define subsamp_lbl 42 `"43rd 1% subsample"', add
label define subsamp_lbl 43 `"44th 1% subsample"', add
label define subsamp_lbl 44 `"45th 1% subsample"', add
label define subsamp_lbl 45 `"46th 1% subsample"', add
label define subsamp_lbl 46 `"47th 1% subsample"', add
label define subsamp_lbl 47 `"48th 1% subsample"', add
label define subsamp_lbl 48 `"49th 1% subsample"', add
label define subsamp_lbl 49 `"50th 1% subsample"', add
label define subsamp_lbl 50 `"51st 1% subsample"', add
label define subsamp_lbl 51 `"52nd 1% subsample"', add
label define subsamp_lbl 52 `"53rd 1% subsample"', add
label define subsamp_lbl 53 `"54th 1% subsample"', add
label define subsamp_lbl 54 `"55th 1% subsample"', add
label define subsamp_lbl 55 `"56th 1% subsample"', add
label define subsamp_lbl 56 `"57th 1% subsample"', add
label define subsamp_lbl 57 `"58th 1% subsample"', add
label define subsamp_lbl 58 `"59th 1% subsample"', add
label define subsamp_lbl 59 `"60th 1% subsample"', add
label define subsamp_lbl 60 `"61st 1% subsample"', add
label define subsamp_lbl 61 `"62nd 1% subsample"', add
label define subsamp_lbl 62 `"63rd 1% subsample"', add
label define subsamp_lbl 63 `"64th 1% subsample"', add
label define subsamp_lbl 64 `"65th 1% subsample"', add
label define subsamp_lbl 65 `"66th 1% subsample"', add
label define subsamp_lbl 66 `"67th 1% subsample"', add
label define subsamp_lbl 67 `"68th 1% subsample"', add
label define subsamp_lbl 68 `"69th 1% subsample"', add
label define subsamp_lbl 69 `"70th 1% subsample"', add
label define subsamp_lbl 70 `"71st 1% subsample"', add
label define subsamp_lbl 71 `"72nd 1% subsample"', add
label define subsamp_lbl 72 `"73rd 1% subsample"', add
label define subsamp_lbl 73 `"74th 1% subsample"', add
label define subsamp_lbl 74 `"75th 1% subsample"', add
label define subsamp_lbl 75 `"76th 1% subsample"', add
label define subsamp_lbl 76 `"77th 1% subsample"', add
label define subsamp_lbl 77 `"78th 1% subsample"', add
label define subsamp_lbl 78 `"79th 1% subsample"', add
label define subsamp_lbl 79 `"80th 1% subsample"', add
label define subsamp_lbl 80 `"81st 1% subsample"', add
label define subsamp_lbl 81 `"82nd 1% subsample"', add
label define subsamp_lbl 82 `"83rd 1% subsample"', add
label define subsamp_lbl 83 `"84th 1% subsample"', add
label define subsamp_lbl 84 `"85th 1% subsample"', add
label define subsamp_lbl 85 `"86th 1% subsample"', add
label define subsamp_lbl 86 `"87th 1% subsample"', add
label define subsamp_lbl 87 `"88th 1% subsample"', add
label define subsamp_lbl 88 `"89th 1% subsample"', add
label define subsamp_lbl 89 `"90th 1% subsample"', add
label define subsamp_lbl 90 `"91st 1% subsample"', add
label define subsamp_lbl 91 `"92nd 1% subsample"', add
label define subsamp_lbl 92 `"93rd 1% subsample"', add
label define subsamp_lbl 93 `"94th 1% subsample"', add
label define subsamp_lbl 94 `"95th 1% subsample"', add
label define subsamp_lbl 95 `"96th 1% subsample"', add
label define subsamp_lbl 96 `"97th 1% subsample"', add
label define subsamp_lbl 97 `"98th 1% subsample"', add
label define subsamp_lbl 98 `"99th 1% subsample"', add
label define subsamp_lbl 99 `"100th 1% subsample"', add
label values subsamp subsamp_lbl

label define gq_lbl 00 `"Vacant"'
label define gq_lbl 10 `"Households"', add
label define gq_lbl 20 `"Group quarters, n.s."', add
label define gq_lbl 21 `"Institutions"', add
label define gq_lbl 22 `"Other group quarters"', add
label define gq_lbl 29 `"1-person unit created by splitting large household"', add
label define gq_lbl 99 `"Unknown/group quarters not identified"', add
label values gq gq_lbl

label define urban_lbl 1 `"Rural"'
label define urban_lbl 2 `"Urban"', add
label define urban_lbl 9 `"Unknown"', add
label values urban urban_lbl

label define geo1_mx_lbl 484001 `"Aguascalientes"'
label define geo1_mx_lbl 484002 `"Baja California"', add
label define geo1_mx_lbl 484003 `"Baja California Sur"', add
label define geo1_mx_lbl 484004 `"Campeche"', add
label define geo1_mx_lbl 484005 `"Coahuila de Zaragoza"', add
label define geo1_mx_lbl 484006 `"Colima"', add
label define geo1_mx_lbl 484007 `"Chiapas"', add
label define geo1_mx_lbl 484008 `"Chihuahua"', add
label define geo1_mx_lbl 484009 `"Distrito Federal"', add
label define geo1_mx_lbl 484010 `"Durango"', add
label define geo1_mx_lbl 484011 `"Guanajuato"', add
label define geo1_mx_lbl 484012 `"Guerrero"', add
label define geo1_mx_lbl 484013 `"Hidalgo"', add
label define geo1_mx_lbl 484014 `"Jalisco"', add
label define geo1_mx_lbl 484015 `"México"', add
label define geo1_mx_lbl 484016 `"Michoacán de Ocampo"', add
label define geo1_mx_lbl 484017 `"Morelos"', add
label define geo1_mx_lbl 484018 `"Nayarit"', add
label define geo1_mx_lbl 484019 `"Nuevo León"', add
label define geo1_mx_lbl 484020 `"Oaxaca"', add
label define geo1_mx_lbl 484021 `"Puebla"', add
label define geo1_mx_lbl 484022 `"Querétaro"', add
label define geo1_mx_lbl 484023 `"Quintana Roo"', add
label define geo1_mx_lbl 484024 `"San Luis Potosí"', add
label define geo1_mx_lbl 484025 `"Sinaloa"', add
label define geo1_mx_lbl 484026 `"Sonora"', add
label define geo1_mx_lbl 484027 `"Tabasco"', add
label define geo1_mx_lbl 484028 `"Tamaulipas"', add
label define geo1_mx_lbl 484029 `"Tlaxcala"', add
label define geo1_mx_lbl 484030 `"Veracruz de Ignacio de la Llave"', add
label define geo1_mx_lbl 484031 `"Yucatán"', add
label define geo1_mx_lbl 484032 `"Zacatecas"', add
label values geo1_mx geo1_mx_lbl

label define geo2_mx_lbl 484001001 `"Aguascalientes, Llano, El, San Francisco de los Romo"'
label define geo2_mx_lbl 484001002 `"Asientos"', add
label define geo2_mx_lbl 484001003 `"Calvillo"', add
label define geo2_mx_lbl 484001004 `"Cosío"', add
label define geo2_mx_lbl 484001005 `"Jesús María"', add
label define geo2_mx_lbl 484001006 `"Pabellón de Arteaga, Rincón de Romos"', add
label define geo2_mx_lbl 484001007 `"San José de Gracia"', add
label define geo2_mx_lbl 484001008 `"Tepezalá"', add
label define geo2_mx_lbl 484001999 `"Aguascalientes [municipality unknown]"', add
label define geo2_mx_lbl 484002001 `"Ensenada"', add
label define geo2_mx_lbl 484002002 `"Mexicali"', add
label define geo2_mx_lbl 484002003 `"Tecate"', add
label define geo2_mx_lbl 484002004 `"Tijuana, Playas de Rosarito"', add
label define geo2_mx_lbl 484003001 `"Comondú, Mulegé, Paz, La, Cabos, Los, Loreto"', add
label define geo2_mx_lbl 484004001 `"Calkiní"', add
label define geo2_mx_lbl 484004002 `"Campeche"', add
label define geo2_mx_lbl 484004003 `"Carmen, Champotón, Hopelchén, Escárcega, Calakmul, Candelaria"', add
label define geo2_mx_lbl 484004004 `"Hecelchakán"', add
label define geo2_mx_lbl 484004005 `"Palizada"', add
label define geo2_mx_lbl 484004006 `"Tenabo"', add
label define geo2_mx_lbl 484004999 `"Campeche [municipality unknown]"', add
label define geo2_mx_lbl 484005001 `"Abasolo"', add
label define geo2_mx_lbl 484005002 `"Acuña"', add
label define geo2_mx_lbl 484005003 `"Allende"', add
label define geo2_mx_lbl 484005004 `"Arteaga"', add
label define geo2_mx_lbl 484005005 `"Candela"', add
label define geo2_mx_lbl 484005006 `"Castaños"', add
label define geo2_mx_lbl 484005007 `"Cuatro Ciénegas"', add
label define geo2_mx_lbl 484005008 `"Escobedo"', add
label define geo2_mx_lbl 484005009 `"Francisco I. Madero"', add
label define geo2_mx_lbl 484005010 `"Frontera"', add
label define geo2_mx_lbl 484005011 `"General Cepeda"', add
label define geo2_mx_lbl 484005012 `"Guerrero"', add
label define geo2_mx_lbl 484005013 `"Hidalgo"', add
label define geo2_mx_lbl 484005014 `"Jiménez"', add
label define geo2_mx_lbl 484005015 `"Juárez"', add
label define geo2_mx_lbl 484005016 `"Lamadrid"', add
label define geo2_mx_lbl 484005017 `"Matamoros"', add
label define geo2_mx_lbl 484005018 `"Monclova"', add
label define geo2_mx_lbl 484005019 `"Morelos"', add
label define geo2_mx_lbl 484005020 `"Múzquiz"', add
label define geo2_mx_lbl 484005021 `"Nadadores"', add
label define geo2_mx_lbl 484005022 `"Nava"', add
label define geo2_mx_lbl 484005023 `"Ocampo"', add
label define geo2_mx_lbl 484005024 `"Parras"', add
label define geo2_mx_lbl 484005025 `"Piedras Negras"', add
label define geo2_mx_lbl 484005026 `"Progreso"', add
label define geo2_mx_lbl 484005027 `"Ramos Arizpe"', add
label define geo2_mx_lbl 484005028 `"Sabinas"', add
label define geo2_mx_lbl 484005029 `"Sacramento"', add
label define geo2_mx_lbl 484005030 `"Saltillo"', add
label define geo2_mx_lbl 484005031 `"San Buenaventura"', add
label define geo2_mx_lbl 484005032 `"San Juan de Sabinas"', add
label define geo2_mx_lbl 484005033 `"San Pedro"', add
label define geo2_mx_lbl 484005034 `"Sierra Mojada"', add
label define geo2_mx_lbl 484005035 `"Torreón"', add
label define geo2_mx_lbl 484005036 `"Viesca"', add
label define geo2_mx_lbl 484005037 `"Villa Unión"', add
label define geo2_mx_lbl 484005038 `"Zaragoza"', add
label define geo2_mx_lbl 484005999 `"Coahuila [municipality unknown]"', add
label define geo2_mx_lbl 484006001 `"Armería, Manzanillo"', add
label define geo2_mx_lbl 484006002 `"Colima"', add
label define geo2_mx_lbl 484006003 `"Comala"', add
label define geo2_mx_lbl 484006004 `"Coquimatlán"', add
label define geo2_mx_lbl 484006005 `"Cuauhtémoc"', add
label define geo2_mx_lbl 484006006 `"Ixtlahuacán"', add
label define geo2_mx_lbl 484006007 `"Minatitlán"', add
label define geo2_mx_lbl 484006008 `"Tecomán"', add
label define geo2_mx_lbl 484006009 `"Villa de Álvarez"', add
label define geo2_mx_lbl 484006999 `"Colima [municipality unknown]"', add
label define geo2_mx_lbl 484007001 `"Acacoyagua"', add
label define geo2_mx_lbl 484007002 `"Acala"', add
label define geo2_mx_lbl 484007003 `"Acapetahua"', add
label define geo2_mx_lbl 484007004 `"Altamirano"', add
label define geo2_mx_lbl 484007005 `"Amatán"', add
label define geo2_mx_lbl 484007006 `"Amatenango de la Frontera"', add
label define geo2_mx_lbl 484007007 `"Amatenango del Valle"', add
label define geo2_mx_lbl 484007008 `"Angel Albino Corzo, Monte Cristo de Guerrero"', add
label define geo2_mx_lbl 484007009 `"Arriaga"', add
label define geo2_mx_lbl 484007010 `"Bejucal de Ocampo"', add
label define geo2_mx_lbl 484007011 `"Bella Vista"', add
label define geo2_mx_lbl 484007012 `"Berriozábal"', add
label define geo2_mx_lbl 484007013 `"Bochil"', add
label define geo2_mx_lbl 484007014 `"Bosque, El"', add
label define geo2_mx_lbl 484007015 `"Cacahoatán"', add
label define geo2_mx_lbl 484007016 `"Catazajá"', add
label define geo2_mx_lbl 484007017 `"Cintalapa"', add
label define geo2_mx_lbl 484007018 `"Coapilla"', add
label define geo2_mx_lbl 484007019 `"Comitán de Domínguez"', add
label define geo2_mx_lbl 484007020 `"Concordia, La"', add
label define geo2_mx_lbl 484007021 `"Copainalá"', add
label define geo2_mx_lbl 484007022 `"Chalchihuitán"', add
label define geo2_mx_lbl 484007023 `"Chamula"', add
label define geo2_mx_lbl 484007024 `"Chanal"', add
label define geo2_mx_lbl 484007025 `"Chapultenango"', add
label define geo2_mx_lbl 484007026 `"Chenalhó, Aldama"', add
label define geo2_mx_lbl 484007027 `"Chiapa de Corzo"', add
label define geo2_mx_lbl 484007028 `"Chiapilla"', add
label define geo2_mx_lbl 484007029 `"Chicoasén"', add
label define geo2_mx_lbl 484007030 `"Chicomuselo"', add
label define geo2_mx_lbl 484007031 `"Chilón"', add
label define geo2_mx_lbl 484007032 `"Escuintla"', add
label define geo2_mx_lbl 484007033 `"Francisco León"', add
label define geo2_mx_lbl 484007034 `"Frontera Comalapa"', add
label define geo2_mx_lbl 484007035 `"Frontera Hidalgo"', add
label define geo2_mx_lbl 484007036 `"Grandeza, La"', add
label define geo2_mx_lbl 484007037 `"Huehuetán"', add
label define geo2_mx_lbl 484007038 `"Huixtán"', add
label define geo2_mx_lbl 484007039 `"Huitiupán"', add
label define geo2_mx_lbl 484007040 `"Huixtla"', add
label define geo2_mx_lbl 484007041 `"Independencia, La"', add
label define geo2_mx_lbl 484007042 `"Ixhuatán"', add
label define geo2_mx_lbl 484007043 `"Ixtacomitán"', add
label define geo2_mx_lbl 484007044 `"Ixtapa"', add
label define geo2_mx_lbl 484007045 `"Ixtapangajoya"', add
label define geo2_mx_lbl 484007046 `"Jiquipilas"', add
label define geo2_mx_lbl 484007047 `"Jitotol"', add
label define geo2_mx_lbl 484007048 `"Juárez"', add
label define geo2_mx_lbl 484007049 `"Larráinzar, Santiago el Pinar"', add
label define geo2_mx_lbl 484007050 `"Libertad, La"', add
label define geo2_mx_lbl 484007051 `"Mapastepec"', add
label define geo2_mx_lbl 484007052 `"Margaritas, Las, Maravilla Tenejapa"', add
label define geo2_mx_lbl 484007053 `"Mazapa de Madero"', add
label define geo2_mx_lbl 484007054 `"Mazatán"', add
label define geo2_mx_lbl 484007055 `"Metapa"', add
label define geo2_mx_lbl 484007056 `"Mitontic"', add
label define geo2_mx_lbl 484007057 `"Motozintla"', add
label define geo2_mx_lbl 484007058 `"Nicolás Ruíz"', add
label define geo2_mx_lbl 484007059 `"Ocosingo, San Juan Cancuc, Benemérito de las Américas, Marqués de Comillas"', add
label define geo2_mx_lbl 484007060 `"Ocotepec"', add
label define geo2_mx_lbl 484007061 `"Ocozocoautla de Espinosa"', add
label define geo2_mx_lbl 484007062 `"Ostuacán"', add
label define geo2_mx_lbl 484007063 `"Osumacinta"', add
label define geo2_mx_lbl 484007064 `"Oxchuc"', add
label define geo2_mx_lbl 484007065 `"Palenque"', add
label define geo2_mx_lbl 484007066 `"Pantelhó"', add
label define geo2_mx_lbl 484007067 `"Pantepec"', add
label define geo2_mx_lbl 484007068 `"Pichucalco"', add
label define geo2_mx_lbl 484007069 `"Pijijiapan"', add
label define geo2_mx_lbl 484007070 `"Porvenir, El"', add
label define geo2_mx_lbl 484007071 `"Villa Comaltitlán"', add
label define geo2_mx_lbl 484007072 `"Pueblo Nuevo Solistahuacán"', add
label define geo2_mx_lbl 484007073 `"Rayón"', add
label define geo2_mx_lbl 484007074 `"Reforma"', add
label define geo2_mx_lbl 484007075 `"Rosas, Las"', add
label define geo2_mx_lbl 484007076 `"Sabanilla"', add
label define geo2_mx_lbl 484007077 `"Salto de Agua"', add
label define geo2_mx_lbl 484007078 `"San Cristóbal de las Casas"', add
label define geo2_mx_lbl 484007079 `"San Fernando"', add
label define geo2_mx_lbl 484007080 `"Siltepec"', add
label define geo2_mx_lbl 484007081 `"Simojovel, San Andrés Duraznal"', add
label define geo2_mx_lbl 484007082 `"Sitalá"', add
label define geo2_mx_lbl 484007083 `"Socoltenango"', add
label define geo2_mx_lbl 484007084 `"Solosuchiapa"', add
label define geo2_mx_lbl 484007085 `"Soyaló"', add
label define geo2_mx_lbl 484007086 `"Suchiapa"', add
label define geo2_mx_lbl 484007087 `"Suchiate"', add
label define geo2_mx_lbl 484007088 `"Sunuapa"', add
label define geo2_mx_lbl 484007089 `"Tapachula"', add
label define geo2_mx_lbl 484007090 `"Tapalapa"', add
label define geo2_mx_lbl 484007091 `"Tapilula"', add
label define geo2_mx_lbl 484007092 `"Tecpatán"', add
label define geo2_mx_lbl 484007093 `"Tenejapa"', add
label define geo2_mx_lbl 484007094 `"Teopisca"', add
label define geo2_mx_lbl 484007095 `"Tila"', add
label define geo2_mx_lbl 484007096 `"Tonalá"', add
label define geo2_mx_lbl 484007097 `"Totolapa"', add
label define geo2_mx_lbl 484007098 `"Trinitaria, La"', add
label define geo2_mx_lbl 484007099 `"Tumbalá"', add
label define geo2_mx_lbl 484007100 `"Tuxtla Gutiérrez"', add
label define geo2_mx_lbl 484007101 `"Tuxtla Chico"', add
label define geo2_mx_lbl 484007102 `"Tuzantán"', add
label define geo2_mx_lbl 484007103 `"Tzimol"', add
label define geo2_mx_lbl 484007104 `"Unión Juárez"', add
label define geo2_mx_lbl 484007105 `"Venustiano Carranza"', add
label define geo2_mx_lbl 484007106 `"Villa Corzo"', add
label define geo2_mx_lbl 484007107 `"Villaflores"', add
label define geo2_mx_lbl 484007108 `"Yajalón"', add
label define geo2_mx_lbl 484007109 `"San Lucas"', add
label define geo2_mx_lbl 484007110 `"Zinacantán"', add
label define geo2_mx_lbl 484007999 `"Chiapas [municipality unknown]"', add
label define geo2_mx_lbl 484008001 `"Ahumada"', add
label define geo2_mx_lbl 484008002 `"Aldama"', add
label define geo2_mx_lbl 484008003 `"Allende"', add
label define geo2_mx_lbl 484008004 `"Aquiles Serdán"', add
label define geo2_mx_lbl 484008005 `"Ascensión"', add
label define geo2_mx_lbl 484008006 `"Bachíniva"', add
label define geo2_mx_lbl 484008007 `"Balleza, Batopilas, Guachochi"', add
label define geo2_mx_lbl 484008008 `"Bocoyna"', add
label define geo2_mx_lbl 484008009 `"Buenaventura"', add
label define geo2_mx_lbl 484008010 `"Camargo"', add
label define geo2_mx_lbl 484008011 `"Carichí"', add
label define geo2_mx_lbl 484008012 `"Casas Grandes"', add
label define geo2_mx_lbl 484008013 `"Coronado"', add
label define geo2_mx_lbl 484008014 `"Coyame del Sotol"', add
label define geo2_mx_lbl 484008015 `"Cruz, La"', add
label define geo2_mx_lbl 484008016 `"Cuauhtémoc"', add
label define geo2_mx_lbl 484008017 `"Cusihuiriachi"', add
label define geo2_mx_lbl 484008018 `"Chihuahua"', add
label define geo2_mx_lbl 484008019 `"Chínipas"', add
label define geo2_mx_lbl 484008020 `"Delicias"', add
label define geo2_mx_lbl 484008021 `"Dr. Belisario Domínguez"', add
label define geo2_mx_lbl 484008022 `"Galeana"', add
label define geo2_mx_lbl 484008023 `"Santa Isabel"', add
label define geo2_mx_lbl 484008024 `"Gómez Farías"', add
label define geo2_mx_lbl 484008025 `"Gran Morelos"', add
label define geo2_mx_lbl 484008026 `"Guadalupe"', add
label define geo2_mx_lbl 484008027 `"Guadalupe y Calvo"', add
label define geo2_mx_lbl 484008028 `"Guazapares"', add
label define geo2_mx_lbl 484008029 `"Guerrero"', add
label define geo2_mx_lbl 484008030 `"Hidalgo del Parral"', add
label define geo2_mx_lbl 484008031 `"Huejotitán"', add
label define geo2_mx_lbl 484008032 `"Ignacio Zaragoza"', add
label define geo2_mx_lbl 484008033 `"Janos"', add
label define geo2_mx_lbl 484008034 `"Jiménez"', add
label define geo2_mx_lbl 484008035 `"Juárez"', add
label define geo2_mx_lbl 484008036 `"Julimes"', add
label define geo2_mx_lbl 484008037 `"López"', add
label define geo2_mx_lbl 484008038 `"Madera"', add
label define geo2_mx_lbl 484008039 `"Maguarichi"', add
label define geo2_mx_lbl 484008040 `"Manuel Benavides"', add
label define geo2_mx_lbl 484008041 `"Matachí"', add
label define geo2_mx_lbl 484008042 `"Matamoros"', add
label define geo2_mx_lbl 484008043 `"Meoqui"', add
label define geo2_mx_lbl 484008044 `"Morelos"', add
label define geo2_mx_lbl 484008045 `"Moris"', add
label define geo2_mx_lbl 484008046 `"Namiquipa"', add
label define geo2_mx_lbl 484008047 `"Nonoava"', add
label define geo2_mx_lbl 484008048 `"Nuevo Casas Grandes"', add
label define geo2_mx_lbl 484008049 `"Ocampo"', add
label define geo2_mx_lbl 484008050 `"Ojinaga"', add
label define geo2_mx_lbl 484008051 `"Praxedis G. Guerrero"', add
label define geo2_mx_lbl 484008052 `"Riva Palacio"', add
label define geo2_mx_lbl 484008053 `"Rosales"', add
label define geo2_mx_lbl 484008054 `"Rosario"', add
label define geo2_mx_lbl 484008055 `"San Francisco de Borja"', add
label define geo2_mx_lbl 484008056 `"San Francisco de Conchos"', add
label define geo2_mx_lbl 484008057 `"San Francisco del Oro"', add
label define geo2_mx_lbl 484008058 `"Santa Bárbara"', add
label define geo2_mx_lbl 484008059 `"Satevó"', add
label define geo2_mx_lbl 484008060 `"Saucillo"', add
label define geo2_mx_lbl 484008061 `"Temósachic"', add
label define geo2_mx_lbl 484008062 `"Tule, El"', add
label define geo2_mx_lbl 484008063 `"Urique"', add
label define geo2_mx_lbl 484008064 `"Uruachi"', add
label define geo2_mx_lbl 484008065 `"Valle de Zaragoza"', add
label define geo2_mx_lbl 484008999 `"Chihuahua [municipality unknown]"', add
label define geo2_mx_lbl 484009001 `"Azcapotzalco, Coyoacán, Cuajimalpa de Morelos, Gustavo A. Madero, Iztacalco, Álvaro Obregón, Benito Juárez, Cuauhtémoc, Miguel Hidalgo, Venustiano Carranza"', add
label define geo2_mx_lbl 484009002 `"Iztapalapa, Xochimilco"', add
label define geo2_mx_lbl 484009003 `"Magdalena Contreras, La"', add
label define geo2_mx_lbl 484009004 `"Milpa Alta"', add
label define geo2_mx_lbl 484009005 `"Tláhuac"', add
label define geo2_mx_lbl 484009006 `"Tlalpan"', add
label define geo2_mx_lbl 484009999 `"Distrito Federal [municipality unknown]"', add
label define geo2_mx_lbl 484010001 `"Canatlán, Nuevo Ideal"', add
label define geo2_mx_lbl 484010002 `"Canelas"', add
label define geo2_mx_lbl 484010003 `"Coneto de Comonfort"', add
label define geo2_mx_lbl 484010004 `"Cuencamé"', add
label define geo2_mx_lbl 484010005 `"Durango"', add
label define geo2_mx_lbl 484010006 `"General Simón Bolívar"', add
label define geo2_mx_lbl 484010007 `"Gómez Palacio"', add
label define geo2_mx_lbl 484010008 `"Guadalupe Victoria"', add
label define geo2_mx_lbl 484010009 `"Guanaceví"', add
label define geo2_mx_lbl 484010010 `"Hidalgo"', add
label define geo2_mx_lbl 484010011 `"Indé"', add
label define geo2_mx_lbl 484010012 `"Lerdo"', add
label define geo2_mx_lbl 484010013 `"Mapimí"', add
label define geo2_mx_lbl 484010014 `"Mezquital"', add
label define geo2_mx_lbl 484010015 `"Nazas"', add
label define geo2_mx_lbl 484010016 `"Nombre de Dios"', add
label define geo2_mx_lbl 484010017 `"Ocampo"', add
label define geo2_mx_lbl 484010018 `"Oro, El"', add
label define geo2_mx_lbl 484010019 `"Otáez"', add
label define geo2_mx_lbl 484010020 `"Pánuco de Coronado"', add
label define geo2_mx_lbl 484010021 `"Peñón Blanco"', add
label define geo2_mx_lbl 484010022 `"Poanas"', add
label define geo2_mx_lbl 484010023 `"Pueblo Nuevo"', add
label define geo2_mx_lbl 484010024 `"Rodeo"', add
label define geo2_mx_lbl 484010025 `"San Bernardo"', add
label define geo2_mx_lbl 484010026 `"San dimas"', add
label define geo2_mx_lbl 484010027 `"San Juan de Guadalupe"', add
label define geo2_mx_lbl 484010028 `"San Juan del Río"', add
label define geo2_mx_lbl 484010029 `"San Luis del Cordero"', add
label define geo2_mx_lbl 484010030 `"San Pedro del Gallo"', add
label define geo2_mx_lbl 484010031 `"Santa Clara"', add
label define geo2_mx_lbl 484010032 `"Santiago Papasquiaro"', add
label define geo2_mx_lbl 484010033 `"Súchil"', add
label define geo2_mx_lbl 484010034 `"Tamazula"', add
label define geo2_mx_lbl 484010035 `"Tepehuanes"', add
label define geo2_mx_lbl 484010036 `"Tlahualilo"', add
label define geo2_mx_lbl 484010037 `"Topia"', add
label define geo2_mx_lbl 484010038 `"Vicente Guerrero"', add
label define geo2_mx_lbl 484010999 `"Durango [municipality unknown]"', add
label define geo2_mx_lbl 484011001 `"Abasolo"', add
label define geo2_mx_lbl 484011002 `"Acámbaro"', add
label define geo2_mx_lbl 484011003 `"Allende"', add
label define geo2_mx_lbl 484011004 `"Apaseo el Alto"', add
label define geo2_mx_lbl 484011005 `"Apaseo el Grande"', add
label define geo2_mx_lbl 484011006 `"Atarjea"', add
label define geo2_mx_lbl 484011007 `"Celaya"', add
label define geo2_mx_lbl 484011008 `"Manuel Doblado"', add
label define geo2_mx_lbl 484011009 `"Comonfort"', add
label define geo2_mx_lbl 484011010 `"Coroneo"', add
label define geo2_mx_lbl 484011011 `"Cortazar"', add
label define geo2_mx_lbl 484011012 `"Cuerámaro"', add
label define geo2_mx_lbl 484011013 `"Doctor Mora"', add
label define geo2_mx_lbl 484011014 `"Dolores Hidalgo Cuna de la Independencia Nacional"', add
label define geo2_mx_lbl 484011015 `"Guanajuato"', add
label define geo2_mx_lbl 484011016 `"Huanímaro"', add
label define geo2_mx_lbl 484011017 `"Irapuato"', add
label define geo2_mx_lbl 484011018 `"Jaral del Progreso"', add
label define geo2_mx_lbl 484011019 `"Jerécuaro"', add
label define geo2_mx_lbl 484011020 `"León"', add
label define geo2_mx_lbl 484011021 `"Moroleón"', add
label define geo2_mx_lbl 484011022 `"Ocampo"', add
label define geo2_mx_lbl 484011023 `"Pénjamo"', add
label define geo2_mx_lbl 484011024 `"Pueblo Nuevo"', add
label define geo2_mx_lbl 484011025 `"Purísima del Rincón"', add
label define geo2_mx_lbl 484011026 `"Romita"', add
label define geo2_mx_lbl 484011027 `"Salamanca"', add
label define geo2_mx_lbl 484011028 `"Salvatierra"', add
label define geo2_mx_lbl 484011029 `"San Diego de la Unión"', add
label define geo2_mx_lbl 484011030 `"San Felipe"', add
label define geo2_mx_lbl 484011031 `"San Francisco del Rincón"', add
label define geo2_mx_lbl 484011032 `"San José Iturbide"', add
label define geo2_mx_lbl 484011033 `"San Luis de la Paz"', add
label define geo2_mx_lbl 484011034 `"Santa Catarina"', add
label define geo2_mx_lbl 484011035 `"Santa Cruz de Juventino Rosas"', add
label define geo2_mx_lbl 484011036 `"Santiago Maravatío"', add
label define geo2_mx_lbl 484011037 `"Silao de la Victoria"', add
label define geo2_mx_lbl 484011038 `"Tarandacuao"', add
label define geo2_mx_lbl 484011039 `"Tarimoro"', add
label define geo2_mx_lbl 484011040 `"Tierra Blanca"', add
label define geo2_mx_lbl 484011041 `"Uriangato"', add
label define geo2_mx_lbl 484011042 `"Valle de Santiago"', add
label define geo2_mx_lbl 484011043 `"Victoria"', add
label define geo2_mx_lbl 484011044 `"Villagrán"', add
label define geo2_mx_lbl 484011045 `"Xichú"', add
label define geo2_mx_lbl 484011046 `"Yuriria"', add
label define geo2_mx_lbl 484011999 `"Guanajuato [municipality unknown]"', add
label define geo2_mx_lbl 484012001 `"Acapulco de Juárez"', add
label define geo2_mx_lbl 484012002 `"Ahuacuotzingo"', add
label define geo2_mx_lbl 484012003 `"Ajuchitlán del Progreso"', add
label define geo2_mx_lbl 484012004 `"Alcozauca de Guerrero"', add
label define geo2_mx_lbl 484012005 `"Alpoyeca"', add
label define geo2_mx_lbl 484012006 `"Apaxtla"', add
label define geo2_mx_lbl 484012007 `"Arcelia"', add
label define geo2_mx_lbl 484012008 `"Atenango del Río"', add
label define geo2_mx_lbl 484012009 `"Atlamajalcingo del Monte"', add
label define geo2_mx_lbl 484012010 `"Atlixtac"', add
label define geo2_mx_lbl 484012011 `"Atoyac de Álvarez"', add
label define geo2_mx_lbl 484012012 `"Ayutla de los Libres"', add
label define geo2_mx_lbl 484012013 `"Azoyú, Marquelia, Juchitán"', add
label define geo2_mx_lbl 484012014 `"Benito Juárez"', add
label define geo2_mx_lbl 484012015 `"Buenavista de Cuéllar"', add
label define geo2_mx_lbl 484012016 `"Coahuayutla de José María Izazaga"', add
label define geo2_mx_lbl 484012017 `"Cocula"', add
label define geo2_mx_lbl 484012018 `"Copala"', add
label define geo2_mx_lbl 484012019 `"Copalillo"', add
label define geo2_mx_lbl 484012020 `"Copanatoyac"', add
label define geo2_mx_lbl 484012021 `"Coyuca de Benítez"', add
label define geo2_mx_lbl 484012022 `"Coyuca de Catalán"', add
label define geo2_mx_lbl 484012023 `"Cuajinicuilapa"', add
label define geo2_mx_lbl 484012024 `"Cualác"', add
label define geo2_mx_lbl 484012025 `"Cuautepec"', add
label define geo2_mx_lbl 484012026 `"Cuetzala del Progreso"', add
label define geo2_mx_lbl 484012027 `"Cutzamala de Pinzón"', add
label define geo2_mx_lbl 484012028 `"Chilapa de Álvarez, José Joaquín de Herrera"', add
label define geo2_mx_lbl 484012029 `"Chilpancingo de los Bravo"', add
label define geo2_mx_lbl 484012030 `"Florencio Villarreal"', add
label define geo2_mx_lbl 484012031 `"General Canuto A. Neri"', add
label define geo2_mx_lbl 484012032 `"General Heliodoro Castillo"', add
label define geo2_mx_lbl 484012033 `"Huamuxtitlán"', add
label define geo2_mx_lbl 484012034 `"Huitzuco de los Figueroa"', add
label define geo2_mx_lbl 484012035 `"Iguala de la Independencia"', add
label define geo2_mx_lbl 484012036 `"Igualapa"', add
label define geo2_mx_lbl 484012037 `"Ixcateopan de Cuauhtémoc"', add
label define geo2_mx_lbl 484012038 `"Jose Azueta, Union de Isidoro Montes de Oca, La"', add
label define geo2_mx_lbl 484012039 `"Juan R. Escudero"', add
label define geo2_mx_lbl 484012040 `"Leonardo Bravo"', add
label define geo2_mx_lbl 484012041 `"Malinaltepec, Iliatenco"', add
label define geo2_mx_lbl 484012042 `"Mártir de Cuilapan"', add
label define geo2_mx_lbl 484012043 `"Metlatónoc, Cochoapa el Grande"', add
label define geo2_mx_lbl 484012044 `"Mochitlán"', add
label define geo2_mx_lbl 484012045 `"Olinalá"', add
label define geo2_mx_lbl 484012046 `"Ometepec"', add
label define geo2_mx_lbl 484012047 `"Pedro Ascencio Alquisiras"', add
label define geo2_mx_lbl 484012048 `"Petatlán"', add
label define geo2_mx_lbl 484012049 `"Pilcaya"', add
label define geo2_mx_lbl 484012050 `"Pungarabato"', add
label define geo2_mx_lbl 484012051 `"Quechultenango"', add
label define geo2_mx_lbl 484012052 `"San Luis Acatlán"', add
label define geo2_mx_lbl 484012053 `"San Marcos"', add
label define geo2_mx_lbl 484012054 `"San Miguel Totolapan"', add
label define geo2_mx_lbl 484012055 `"Taxco de Alarcón"', add
label define geo2_mx_lbl 484012056 `"Tecoanapa"', add
label define geo2_mx_lbl 484012057 `"Técpan de Galeana"', add
label define geo2_mx_lbl 484012058 `"Teloloapan"', add
label define geo2_mx_lbl 484012059 `"Tepecoacuilco de Trujano"', add
label define geo2_mx_lbl 484012060 `"Tetipac"', add
label define geo2_mx_lbl 484012061 `"Tixtla de Guerrero"', add
label define geo2_mx_lbl 484012062 `"Tlacoachistlahuaca"', add
label define geo2_mx_lbl 484012063 `"Tlacoapa"', add
label define geo2_mx_lbl 484012064 `"Tlalchapa"', add
label define geo2_mx_lbl 484012065 `"Tlalixtaquilla de Maldonado"', add
label define geo2_mx_lbl 484012066 `"Tlapa de Comonfort"', add
label define geo2_mx_lbl 484012067 `"Tlapehuala"', add
label define geo2_mx_lbl 484012068 `"Xalpatláhuac"', add
label define geo2_mx_lbl 484012069 `"Xochihuehuetlán"', add
label define geo2_mx_lbl 484012070 `"Xochistlahuaca"', add
label define geo2_mx_lbl 484012071 `"Zapotitlán Tablas, Acatepec"', add
label define geo2_mx_lbl 484012072 `"Zirándaro"', add
label define geo2_mx_lbl 484012073 `"Acatlán"', add
label define geo2_mx_lbl 484012074 `"Eduardo Neri"', add
label define geo2_mx_lbl 484012999 `"Guerrero [municipality unknown]"', add
label define geo2_mx_lbl 484013001 `"Acatlán"', add
label define geo2_mx_lbl 484013002 `"Acaxochitlán"', add
label define geo2_mx_lbl 484013003 `"Actopan"', add
label define geo2_mx_lbl 484013004 `"Agua Blanca de Iturbide"', add
label define geo2_mx_lbl 484013005 `"Ajacuba"', add
label define geo2_mx_lbl 484013006 `"Alfajayucan"', add
label define geo2_mx_lbl 484013007 `"Almoloya"', add
label define geo2_mx_lbl 484013008 `"Apan"', add
label define geo2_mx_lbl 484013009 `"Arenal, El"', add
label define geo2_mx_lbl 484013010 `"Atitalaquia"', add
label define geo2_mx_lbl 484013011 `"Atlapexco"', add
label define geo2_mx_lbl 484013012 `"Atotonilco el Grande"', add
label define geo2_mx_lbl 484013013 `"Atotonilco de Tula"', add
label define geo2_mx_lbl 484013014 `"Calnali"', add
label define geo2_mx_lbl 484013015 `"Cardonal"', add
label define geo2_mx_lbl 484013016 `"Cuautepec de Hinojosa"', add
label define geo2_mx_lbl 484013017 `"Chapantongo"', add
label define geo2_mx_lbl 484013018 `"Chapulhuacán"', add
label define geo2_mx_lbl 484013019 `"Chilcuautla, Progreso de Obregón"', add
label define geo2_mx_lbl 484013020 `"Eloxochitlán"', add
label define geo2_mx_lbl 484013021 `"Emiliano Zapata"', add
label define geo2_mx_lbl 484013022 `"Epazoyucan"', add
label define geo2_mx_lbl 484013023 `"Francisco I. Madero"', add
label define geo2_mx_lbl 484013024 `"Huasca de Ocampo"', add
label define geo2_mx_lbl 484013025 `"Huautla"', add
label define geo2_mx_lbl 484013026 `"Huazalingo"', add
label define geo2_mx_lbl 484013027 `"Huehuetla"', add
label define geo2_mx_lbl 484013028 `"Huejutla de Reyes"', add
label define geo2_mx_lbl 484013029 `"Huichapan"', add
label define geo2_mx_lbl 484013030 `"Ixmiquilpan"', add
label define geo2_mx_lbl 484013031 `"Jacala de Ledezma"', add
label define geo2_mx_lbl 484013032 `"Jaltocán"', add
label define geo2_mx_lbl 484013033 `"Juárez Hidalgo"', add
label define geo2_mx_lbl 484013034 `"Lolotla"', add
label define geo2_mx_lbl 484013035 `"Metepec"', add
label define geo2_mx_lbl 484013036 `"San Agustín Metzquititlán"', add
label define geo2_mx_lbl 484013037 `"Metztitlán"', add
label define geo2_mx_lbl 484013038 `"Mineral del Chico"', add
label define geo2_mx_lbl 484013039 `"Mineral del Monte"', add
label define geo2_mx_lbl 484013040 `"Misión, La"', add
label define geo2_mx_lbl 484013041 `"Mixquiahuala de Juárez"', add
label define geo2_mx_lbl 484013042 `"Molango de Escamilla"', add
label define geo2_mx_lbl 484013043 `"Nicolás Flores"', add
label define geo2_mx_lbl 484013044 `"Nopala de Villagrán"', add
label define geo2_mx_lbl 484013045 `"Omitlán de Juárez"', add
label define geo2_mx_lbl 484013046 `"San Felipe Orizatlan"', add
label define geo2_mx_lbl 484013047 `"Pacula"', add
label define geo2_mx_lbl 484013048 `"Pachuca de Soto"', add
label define geo2_mx_lbl 484013049 `"Pisaflores"', add
label define geo2_mx_lbl 484013050 `"Mineral de La Reforma"', add
label define geo2_mx_lbl 484013051 `"San Agustín Tlaxiaca"', add
label define geo2_mx_lbl 484013052 `"San Bartolo Tutotepec"', add
label define geo2_mx_lbl 484013053 `"San Salvador"', add
label define geo2_mx_lbl 484013054 `"Santiago de Anaya"', add
label define geo2_mx_lbl 484013055 `"Santiago Tulantepec de Lugo Guerrero"', add
label define geo2_mx_lbl 484013056 `"Singuilucan"', add
label define geo2_mx_lbl 484013057 `"Tasquillo"', add
label define geo2_mx_lbl 484013058 `"Tecozautla"', add
label define geo2_mx_lbl 484013059 `"Tenango de Doria"', add
label define geo2_mx_lbl 484013060 `"Tepeapulco"', add
label define geo2_mx_lbl 484013061 `"Tepehuacán de Guerrero"', add
label define geo2_mx_lbl 484013062 `"Tepeji del Río de Ocampo"', add
label define geo2_mx_lbl 484013063 `"Tepetitlán"', add
label define geo2_mx_lbl 484013064 `"Tetepango, Tlahuelilpan"', add
label define geo2_mx_lbl 484013065 `"Villa de Tezontepec"', add
label define geo2_mx_lbl 484013066 `"Tezontepec de Aldama"', add
label define geo2_mx_lbl 484013067 `"Tianguistengo"', add
label define geo2_mx_lbl 484013068 `"Tizayuca"', add
label define geo2_mx_lbl 484013069 `"Tlahuiltepa"', add
label define geo2_mx_lbl 484013070 `"Tlanalapa"', add
label define geo2_mx_lbl 484013071 `"Tlanchinol"', add
label define geo2_mx_lbl 484013072 `"Tlaxcoapan"', add
label define geo2_mx_lbl 484013073 `"Tolcayuca"', add
label define geo2_mx_lbl 484013074 `"Tula de Allende"', add
label define geo2_mx_lbl 484013075 `"Tulancingo de Bravo"', add
label define geo2_mx_lbl 484013076 `"Xochiatipan"', add
label define geo2_mx_lbl 484013077 `"Xochicoatlán"', add
label define geo2_mx_lbl 484013078 `"Yahualica"', add
label define geo2_mx_lbl 484013079 `"Zacualtipán de Ángeles"', add
label define geo2_mx_lbl 484013080 `"Zapotlán de Juárez"', add
label define geo2_mx_lbl 484013081 `"Zempoala"', add
label define geo2_mx_lbl 484013082 `"Zimapán"', add
label define geo2_mx_lbl 484013999 `"Hidalgo [municipality unknown]"', add
label define geo2_mx_lbl 484014001 `"Acatic"', add
label define geo2_mx_lbl 484014002 `"Acatlán de Juárez"', add
label define geo2_mx_lbl 484014003 `"Ahualulco de Mercado"', add
label define geo2_mx_lbl 484014004 `"Amacueca"', add
label define geo2_mx_lbl 484014005 `"Amatitán"', add
label define geo2_mx_lbl 484014006 `"Ameca"', add
label define geo2_mx_lbl 484014007 `"San Juanito de Escobedo"', add
label define geo2_mx_lbl 484014008 `"Arandas, San Ignacio Cerro Gordo"', add
label define geo2_mx_lbl 484014009 `"Arenal, El"', add
label define geo2_mx_lbl 484014010 `"Atemajac de Brizuela"', add
label define geo2_mx_lbl 484014011 `"Atengo"', add
label define geo2_mx_lbl 484014012 `"Atenguillo"', add
label define geo2_mx_lbl 484014013 `"Atotonilco el Alto"', add
label define geo2_mx_lbl 484014014 `"Atoyac"', add
label define geo2_mx_lbl 484014015 `"Autlán de Navarro"', add
label define geo2_mx_lbl 484014016 `"Ayotlán"', add
label define geo2_mx_lbl 484014017 `"Ayutla"', add
label define geo2_mx_lbl 484014018 `"Barca, La"', add
label define geo2_mx_lbl 484014019 `"Bolaños"', add
label define geo2_mx_lbl 484014020 `"Cabo Corrientes"', add
label define geo2_mx_lbl 484014021 `"Casimiro Castillo"', add
label define geo2_mx_lbl 484014022 `"Cihuatlán"', add
label define geo2_mx_lbl 484014023 `"Zapotlán el Grande"', add
label define geo2_mx_lbl 484014024 `"Cocula"', add
label define geo2_mx_lbl 484014025 `"Colotlán"', add
label define geo2_mx_lbl 484014026 `"Concepción de Buenos Aires"', add
label define geo2_mx_lbl 484014027 `"Cuautitlán de García Barragán"', add
label define geo2_mx_lbl 484014028 `"Cuautla"', add
label define geo2_mx_lbl 484014029 `"Cuquío"', add
label define geo2_mx_lbl 484014030 `"Chapala"', add
label define geo2_mx_lbl 484014031 `"Chimaltitán"', add
label define geo2_mx_lbl 484014032 `"Chiquilistlán"', add
label define geo2_mx_lbl 484014033 `"Degollado"', add
label define geo2_mx_lbl 484014034 `"Ejutla"', add
label define geo2_mx_lbl 484014035 `"Encarnación de Díaz"', add
label define geo2_mx_lbl 484014036 `"Etzatlán"', add
label define geo2_mx_lbl 484014037 `"Grullo, El"', add
label define geo2_mx_lbl 484014038 `"Guachinango"', add
label define geo2_mx_lbl 484014039 `"Guadalajara"', add
label define geo2_mx_lbl 484014040 `"Hostotipaquillo"', add
label define geo2_mx_lbl 484014041 `"Huejúcar"', add
label define geo2_mx_lbl 484014042 `"Huejuquilla el Alto"', add
label define geo2_mx_lbl 484014043 `"Huerta, La"', add
label define geo2_mx_lbl 484014044 `"Ixtlahuacán de los Membrillos"', add
label define geo2_mx_lbl 484014045 `"Ixtlahuacán del Río"', add
label define geo2_mx_lbl 484014046 `"Jalostotitlán"', add
label define geo2_mx_lbl 484014047 `"Jamay"', add
label define geo2_mx_lbl 484014048 `"Jesús María"', add
label define geo2_mx_lbl 484014049 `"Jilotlán de los Dolores"', add
label define geo2_mx_lbl 484014050 `"Jocotepec"', add
label define geo2_mx_lbl 484014051 `"Juanacatlán"', add
label define geo2_mx_lbl 484014052 `"Juchitlán"', add
label define geo2_mx_lbl 484014053 `"Lagos de Moreno"', add
label define geo2_mx_lbl 484014054 `"Limón, El"', add
label define geo2_mx_lbl 484014055 `"Magdalena"', add
label define geo2_mx_lbl 484014056 `"Santa Maria del Oro"', add
label define geo2_mx_lbl 484014057 `"Manzanilla de la Paz, La"', add
label define geo2_mx_lbl 484014058 `"Mascota"', add
label define geo2_mx_lbl 484014059 `"Mazamitla"', add
label define geo2_mx_lbl 484014060 `"Mexticacán"', add
label define geo2_mx_lbl 484014061 `"Mezquitic"', add
label define geo2_mx_lbl 484014062 `"Mixtlán"', add
label define geo2_mx_lbl 484014063 `"Ocotlán"', add
label define geo2_mx_lbl 484014064 `"Ojuelos de Jalisco"', add
label define geo2_mx_lbl 484014065 `"Pihuamo"', add
label define geo2_mx_lbl 484014066 `"Poncitlán"', add
label define geo2_mx_lbl 484014067 `"Puerto Vallarta"', add
label define geo2_mx_lbl 484014068 `"Villa Purificación"', add
label define geo2_mx_lbl 484014069 `"Quitupan"', add
label define geo2_mx_lbl 484014070 `"Salto, El"', add
label define geo2_mx_lbl 484014071 `"San Cristóbal de la Barranca"', add
label define geo2_mx_lbl 484014072 `"San Diego de Alejandría"', add
label define geo2_mx_lbl 484014073 `"San Juan de los Lagos"', add
label define geo2_mx_lbl 484014074 `"San Julián"', add
label define geo2_mx_lbl 484014075 `"San Marcos"', add
label define geo2_mx_lbl 484014076 `"San Martín de Bolaños"', add
label define geo2_mx_lbl 484014077 `"San Martin de Hidalgo"', add
label define geo2_mx_lbl 484014078 `"San Miguel el Alto"', add
label define geo2_mx_lbl 484014079 `"Gómez Farías"', add
label define geo2_mx_lbl 484014080 `"San Sebastián del Oeste"', add
label define geo2_mx_lbl 484014081 `"Santa María de los Ángeles"', add
label define geo2_mx_lbl 484014082 `"Sayula"', add
label define geo2_mx_lbl 484014083 `"Tala"', add
label define geo2_mx_lbl 484014084 `"Talpa de Allende"', add
label define geo2_mx_lbl 484014085 `"Tamazula de Gordiano"', add
label define geo2_mx_lbl 484014086 `"Tapalpa"', add
label define geo2_mx_lbl 484014087 `"Tecalitlán"', add
label define geo2_mx_lbl 484014088 `"Tecolotlán"', add
label define geo2_mx_lbl 484014089 `"Techaluta de Montenegro"', add
label define geo2_mx_lbl 484014090 `"Tenamaxtlán"', add
label define geo2_mx_lbl 484014091 `"Teocaltiche"', add
label define geo2_mx_lbl 484014092 `"Teocuitatlán de Corona"', add
label define geo2_mx_lbl 484014093 `"Tepatitlán de Morelos"', add
label define geo2_mx_lbl 484014094 `"Tequila"', add
label define geo2_mx_lbl 484014095 `"Teuchitlán"', add
label define geo2_mx_lbl 484014096 `"Tizapán el Alto"', add
label define geo2_mx_lbl 484014097 `"Tlajomulco de Zúñiga"', add
label define geo2_mx_lbl 484014098 `"Tlaquepaque"', add
label define geo2_mx_lbl 484014099 `"Tolimán"', add
label define geo2_mx_lbl 484014100 `"Tomatlán"', add
label define geo2_mx_lbl 484014101 `"Tonalá"', add
label define geo2_mx_lbl 484014102 `"Tonaya"', add
label define geo2_mx_lbl 484014103 `"Tonila"', add
label define geo2_mx_lbl 484014104 `"Totatiche"', add
label define geo2_mx_lbl 484014105 `"Tototlán"', add
label define geo2_mx_lbl 484014106 `"Tuxcacuesco"', add
label define geo2_mx_lbl 484014107 `"Tuxcueca"', add
label define geo2_mx_lbl 484014108 `"Tuxpan"', add
label define geo2_mx_lbl 484014109 `"Unión de San Antonio"', add
label define geo2_mx_lbl 484014110 `"Unión de Tula"', add
label define geo2_mx_lbl 484014111 `"Valle de Guadalupe"', add
label define geo2_mx_lbl 484014112 `"Valle de Juárez"', add
label define geo2_mx_lbl 484014113 `"San Gabriel"', add
label define geo2_mx_lbl 484014114 `"Villa Corona"', add
label define geo2_mx_lbl 484014115 `"Villa Guerrero"', add
label define geo2_mx_lbl 484014116 `"Villa Hidalgo"', add
label define geo2_mx_lbl 484014117 `"Cañadas de Obregón"', add
label define geo2_mx_lbl 484014118 `"Yahualica de González Gallo"', add
label define geo2_mx_lbl 484014119 `"Zacoalco de Torres"', add
label define geo2_mx_lbl 484014120 `"Zapopan"', add
label define geo2_mx_lbl 484014121 `"Zapotiltic"', add
label define geo2_mx_lbl 484014122 `"Zapotitlán de Vadillo"', add
label define geo2_mx_lbl 484014123 `"Zapotlán del Rey"', add
label define geo2_mx_lbl 484014124 `"Zapotlanejo"', add
label define geo2_mx_lbl 484014999 `"Jalisco [municipality unknown]"', add
label define geo2_mx_lbl 484015001 `"Acambay de Ruíz Castañeda"', add
label define geo2_mx_lbl 484015002 `"Acolman"', add
label define geo2_mx_lbl 484015003 `"Aculco"', add
label define geo2_mx_lbl 484015004 `"Almoloya de Alquisiras"', add
label define geo2_mx_lbl 484015005 `"Almoloya de Juárez"', add
label define geo2_mx_lbl 484015006 `"Almoloya del Rio"', add
label define geo2_mx_lbl 484015007 `"Amanalco"', add
label define geo2_mx_lbl 484015008 `"Amatepec"', add
label define geo2_mx_lbl 484015009 `"Amecameca"', add
label define geo2_mx_lbl 484015010 `"Apaxco"', add
label define geo2_mx_lbl 484015011 `"Atenco, Chimalhuacán, Ecatepec de Morelos, Nezahualcóyotl, Texcoco, Tlalnepantla de Baz"', add
label define geo2_mx_lbl 484015012 `"Atizapán"', add
label define geo2_mx_lbl 484015013 `"Atizapán de Zaragoza"', add
label define geo2_mx_lbl 484015014 `"Atlacomulco"', add
label define geo2_mx_lbl 484015015 `"Atlautla"', add
label define geo2_mx_lbl 484015016 `"Axapusco"', add
label define geo2_mx_lbl 484015017 `"Ayapango"', add
label define geo2_mx_lbl 484015018 `"Calimaya"', add
label define geo2_mx_lbl 484015019 `"Capulhuac"', add
label define geo2_mx_lbl 484015020 `"Coacalco de Berriozábal"', add
label define geo2_mx_lbl 484015021 `"Coatepec Harinas"', add
label define geo2_mx_lbl 484015022 `"Cocotitlán"', add
label define geo2_mx_lbl 484015023 `"Coyotepec"', add
label define geo2_mx_lbl 484015024 `"Cuautitlán, Tepotzotlán, Tultitlán, Cuautitlán Izcalli"', add
label define geo2_mx_lbl 484015025 `"Chalco, Valle de Chalco Solidaridad"', add
label define geo2_mx_lbl 484015026 `"Chapa de Mota"', add
label define geo2_mx_lbl 484015027 `"Chapultepec"', add
label define geo2_mx_lbl 484015028 `"Chiautla"', add
label define geo2_mx_lbl 484015029 `"Chicoloapan"', add
label define geo2_mx_lbl 484015030 `"Chiconcuac"', add
label define geo2_mx_lbl 484015031 `"Donato Guerra"', add
label define geo2_mx_lbl 484015032 `"Ecatzingo"', add
label define geo2_mx_lbl 484015033 `"Huehuetoca"', add
label define geo2_mx_lbl 484015034 `"Hueypoxtla"', add
label define geo2_mx_lbl 484015035 `"Huixquilucan"', add
label define geo2_mx_lbl 484015036 `"Isidro Fabela"', add
label define geo2_mx_lbl 484015037 `"Ixtapaluca"', add
label define geo2_mx_lbl 484015038 `"Ixtapan de la Sal"', add
label define geo2_mx_lbl 484015039 `"Ixtapan del Oro"', add
label define geo2_mx_lbl 484015040 `"Ixtlahuaca"', add
label define geo2_mx_lbl 484015041 `"Xalatlaco"', add
label define geo2_mx_lbl 484015042 `"Jaltenco, Tonanitla"', add
label define geo2_mx_lbl 484015043 `"Jilotepec"', add
label define geo2_mx_lbl 484015044 `"Jilotzingo"', add
label define geo2_mx_lbl 484015045 `"Jiquipilco"', add
label define geo2_mx_lbl 484015046 `"Jocotitlán"', add
label define geo2_mx_lbl 484015047 `"Joquicingo"', add
label define geo2_mx_lbl 484015048 `"Juchitepec"', add
label define geo2_mx_lbl 484015049 `"Lerma"', add
label define geo2_mx_lbl 484015050 `"Malinalco"', add
label define geo2_mx_lbl 484015051 `"Melchor Ocampo"', add
label define geo2_mx_lbl 484015052 `"Metepec"', add
label define geo2_mx_lbl 484015053 `"Mexicaltzingo"', add
label define geo2_mx_lbl 484015054 `"Morelos"', add
label define geo2_mx_lbl 484015055 `"Naucalpan de Juárez"', add
label define geo2_mx_lbl 484015056 `"Nextlalpan"', add
label define geo2_mx_lbl 484015057 `"Nicolás Romero"', add
label define geo2_mx_lbl 484015058 `"Nopaltepec"', add
label define geo2_mx_lbl 484015059 `"Ocoyoacac"', add
label define geo2_mx_lbl 484015060 `"Ocuilan"', add
label define geo2_mx_lbl 484015061 `"Oro, El"', add
label define geo2_mx_lbl 484015062 `"Otumba"', add
label define geo2_mx_lbl 484015063 `"Otzoloapan"', add
label define geo2_mx_lbl 484015064 `"Otzolotepec"', add
label define geo2_mx_lbl 484015065 `"Ozumba"', add
label define geo2_mx_lbl 484015066 `"Papalotla"', add
label define geo2_mx_lbl 484015067 `"Paz, La"', add
label define geo2_mx_lbl 484015068 `"Polotitlán"', add
label define geo2_mx_lbl 484015069 `"Rayón"', add
label define geo2_mx_lbl 484015070 `"San Antonio la Isla"', add
label define geo2_mx_lbl 484015071 `"San Felipe del Progreso, San José del Rincón"', add
label define geo2_mx_lbl 484015072 `"San Martín de las Pirámides"', add
label define geo2_mx_lbl 484015073 `"San Mateo Atenco"', add
label define geo2_mx_lbl 484015074 `"San Simón de Guerrero"', add
label define geo2_mx_lbl 484015075 `"Santo Tomás"', add
label define geo2_mx_lbl 484015076 `"Soyaniquilpan de Juárez"', add
label define geo2_mx_lbl 484015077 `"Sultepec"', add
label define geo2_mx_lbl 484015078 `"Tecámac"', add
label define geo2_mx_lbl 484015079 `"Tejupilco, Luvianos"', add
label define geo2_mx_lbl 484015080 `"Temamatla"', add
label define geo2_mx_lbl 484015081 `"Temascalapa"', add
label define geo2_mx_lbl 484015082 `"Temascalcingo"', add
label define geo2_mx_lbl 484015083 `"Temascaltepec"', add
label define geo2_mx_lbl 484015084 `"Temoaya"', add
label define geo2_mx_lbl 484015085 `"Tenancingo"', add
label define geo2_mx_lbl 484015086 `"Tenango del Aire"', add
label define geo2_mx_lbl 484015087 `"Tenango del Valle"', add
label define geo2_mx_lbl 484015088 `"Teoloyucan"', add
label define geo2_mx_lbl 484015089 `"Teotihuacán"', add
label define geo2_mx_lbl 484015090 `"Tepetlaoxtoc"', add
label define geo2_mx_lbl 484015091 `"Tepetlixpa"', add
label define geo2_mx_lbl 484015092 `"Tequixquiac"', add
label define geo2_mx_lbl 484015093 `"Texcaltitlán"', add
label define geo2_mx_lbl 484015094 `"Texcalyacac"', add
label define geo2_mx_lbl 484015095 `"Tezoyuca"', add
label define geo2_mx_lbl 484015096 `"Tianguistenco"', add
label define geo2_mx_lbl 484015097 `"Timilpan"', add
label define geo2_mx_lbl 484015098 `"Tlalmanalco"', add
label define geo2_mx_lbl 484015099 `"Tlatlaya"', add
label define geo2_mx_lbl 484015100 `"Toluca"', add
label define geo2_mx_lbl 484015101 `"Tonatico"', add
label define geo2_mx_lbl 484015102 `"Tultepec"', add
label define geo2_mx_lbl 484015103 `"Valle de Bravo"', add
label define geo2_mx_lbl 484015104 `"Villa de Allende"', add
label define geo2_mx_lbl 484015105 `"Villa del Carbón"', add
label define geo2_mx_lbl 484015106 `"Villa Guerrero"', add
label define geo2_mx_lbl 484015107 `"Villa Victoria"', add
label define geo2_mx_lbl 484015108 `"Xonacatlán"', add
label define geo2_mx_lbl 484015109 `"Zacazonapan"', add
label define geo2_mx_lbl 484015110 `"Zacualpan"', add
label define geo2_mx_lbl 484015111 `"Zinacantepec"', add
label define geo2_mx_lbl 484015112 `"Zumpahuacan"', add
label define geo2_mx_lbl 484015113 `"Zumpango"', add
label define geo2_mx_lbl 484015999 `"Mexico [municipality unknown]"', add
label define geo2_mx_lbl 484016001 `"Acuitzio"', add
label define geo2_mx_lbl 484016002 `"Aguililla"', add
label define geo2_mx_lbl 484016003 `"Álvaro Obregón"', add
label define geo2_mx_lbl 484016004 `"Angamacutiro, Puruándiro, José Sixto Verduzco"', add
label define geo2_mx_lbl 484016005 `"Angangueo"', add
label define geo2_mx_lbl 484016006 `"Apatzingán"', add
label define geo2_mx_lbl 484016007 `"Aporo"', add
label define geo2_mx_lbl 484016008 `"Aquila"', add
label define geo2_mx_lbl 484016009 `"Ario"', add
label define geo2_mx_lbl 484016010 `"Arteaga"', add
label define geo2_mx_lbl 484016011 `"Briseñas"', add
label define geo2_mx_lbl 484016012 `"Buenavista"', add
label define geo2_mx_lbl 484016013 `"Carácuaro"', add
label define geo2_mx_lbl 484016014 `"Coahuayana"', add
label define geo2_mx_lbl 484016015 `"Coalcomán de Vázquez Pallares"', add
label define geo2_mx_lbl 484016016 `"Coeneo"', add
label define geo2_mx_lbl 484016017 `"Contepec, Epitacio Huerta"', add
label define geo2_mx_lbl 484016018 `"Copándaro"', add
label define geo2_mx_lbl 484016019 `"Cotija"', add
label define geo2_mx_lbl 484016020 `"Cuitzeo"', add
label define geo2_mx_lbl 484016021 `"Charapan"', add
label define geo2_mx_lbl 484016022 `"Charo"', add
label define geo2_mx_lbl 484016023 `"Chavinda"', add
label define geo2_mx_lbl 484016024 `"Cherán"', add
label define geo2_mx_lbl 484016025 `"Chilchota"', add
label define geo2_mx_lbl 484016026 `"Chinicuila"', add
label define geo2_mx_lbl 484016027 `"Chucándiro"', add
label define geo2_mx_lbl 484016028 `"Churintzio"', add
label define geo2_mx_lbl 484016029 `"Churumuco"', add
label define geo2_mx_lbl 484016030 `"Ecuandureo"', add
label define geo2_mx_lbl 484016031 `"Erongarícuaro"', add
label define geo2_mx_lbl 484016032 `"Gabriel Zamora"', add
label define geo2_mx_lbl 484016033 `"Hidalgo"', add
label define geo2_mx_lbl 484016034 `"Huacana, La"', add
label define geo2_mx_lbl 484016035 `"Huandacareo"', add
label define geo2_mx_lbl 484016036 `"Huaniqueo"', add
label define geo2_mx_lbl 484016037 `"Huetamo"', add
label define geo2_mx_lbl 484016038 `"Huiramba"', add
label define geo2_mx_lbl 484016039 `"Indaparapeo"', add
label define geo2_mx_lbl 484016040 `"Irimbo"', add
label define geo2_mx_lbl 484016041 `"Ixtlán"', add
label define geo2_mx_lbl 484016042 `"Jacona"', add
label define geo2_mx_lbl 484016043 `"Jiménez"', add
label define geo2_mx_lbl 484016044 `"Jiquilpan, Marcos Castellanos"', add
label define geo2_mx_lbl 484016045 `"Juárez"', add
label define geo2_mx_lbl 484016046 `"Jungapeo"', add
label define geo2_mx_lbl 484016047 `"Lagunillas"', add
label define geo2_mx_lbl 484016048 `"Madero"', add
label define geo2_mx_lbl 484016049 `"Maravatío"', add
label define geo2_mx_lbl 484016050 `"Lázaro Cárdenas"', add
label define geo2_mx_lbl 484016051 `"Morelia"', add
label define geo2_mx_lbl 484016052 `"Morelos"', add
label define geo2_mx_lbl 484016053 `"Múgica"', add
label define geo2_mx_lbl 484016054 `"Nahuatzen"', add
label define geo2_mx_lbl 484016055 `"Nocupétaro"', add
label define geo2_mx_lbl 484016056 `"Nuevo Parangaricutiro"', add
label define geo2_mx_lbl 484016057 `"Nuevo Urecho"', add
label define geo2_mx_lbl 484016058 `"Numarán"', add
label define geo2_mx_lbl 484016059 `"Ocampo"', add
label define geo2_mx_lbl 484016060 `"Pajacuarán"', add
label define geo2_mx_lbl 484016061 `"Panindícuaro"', add
label define geo2_mx_lbl 484016062 `"Parácuaro"', add
label define geo2_mx_lbl 484016063 `"Paracho"', add
label define geo2_mx_lbl 484016064 `"Pátzcuaro"', add
label define geo2_mx_lbl 484016065 `"Penjamillo"', add
label define geo2_mx_lbl 484016066 `"Peribán"', add
label define geo2_mx_lbl 484016067 `"Piedad, La"', add
label define geo2_mx_lbl 484016068 `"Purépero"', add
label define geo2_mx_lbl 484016069 `"Queréndaro"', add
label define geo2_mx_lbl 484016070 `"Quiroga"', add
label define geo2_mx_lbl 484016071 `"Cojumatlán de Régules"', add
label define geo2_mx_lbl 484016072 `"Reyes, Los"', add
label define geo2_mx_lbl 484016073 `"Sahuayo"', add
label define geo2_mx_lbl 484016074 `"San Lucas"', add
label define geo2_mx_lbl 484016075 `"Santa Ana Maya"', add
label define geo2_mx_lbl 484016076 `"Salvador Escalante"', add
label define geo2_mx_lbl 484016077 `"Senguio"', add
label define geo2_mx_lbl 484016078 `"Susupuato"', add
label define geo2_mx_lbl 484016079 `"Tacámbaro"', add
label define geo2_mx_lbl 484016080 `"Tancítaro"', add
label define geo2_mx_lbl 484016081 `"Tangamandapio"', add
label define geo2_mx_lbl 484016082 `"Tangancícuaro"', add
label define geo2_mx_lbl 484016083 `"Tanhuato"', add
label define geo2_mx_lbl 484016084 `"Taretan"', add
label define geo2_mx_lbl 484016085 `"Tarimbaro"', add
label define geo2_mx_lbl 484016086 `"Tepalcatepec"', add
label define geo2_mx_lbl 484016087 `"Tingambato"', add
label define geo2_mx_lbl 484016088 `"Tingüindín"', add
label define geo2_mx_lbl 484016089 `"Tiquicheo de Nicolás Romero"', add
label define geo2_mx_lbl 484016090 `"Tlalpujahua"', add
label define geo2_mx_lbl 484016091 `"Tlazazalca"', add
label define geo2_mx_lbl 484016092 `"Tocumbo"', add
label define geo2_mx_lbl 484016093 `"Tumbiscatío"', add
label define geo2_mx_lbl 484016094 `"Turicato"', add
label define geo2_mx_lbl 484016095 `"Tuxpan"', add
label define geo2_mx_lbl 484016096 `"Tuzantla"', add
label define geo2_mx_lbl 484016097 `"Tzintzuntzan"', add
label define geo2_mx_lbl 484016098 `"Tzitzio"', add
label define geo2_mx_lbl 484016099 `"Uruapan"', add
label define geo2_mx_lbl 484016100 `"Venustiano Carranza"', add
label define geo2_mx_lbl 484016101 `"Villamar"', add
label define geo2_mx_lbl 484016102 `"Vista Hermosa"', add
label define geo2_mx_lbl 484016103 `"Yurécuaro"', add
label define geo2_mx_lbl 484016104 `"Zacapu"', add
label define geo2_mx_lbl 484016105 `"Zamora"', add
label define geo2_mx_lbl 484016106 `"Zináparo"', add
label define geo2_mx_lbl 484016107 `"Zinapécuaro"', add
label define geo2_mx_lbl 484016108 `"Ziracuaretiro"', add
label define geo2_mx_lbl 484016109 `"Zitácuaro"', add
label define geo2_mx_lbl 484016999 `"Michaocan [municipality unknown]"', add
label define geo2_mx_lbl 484017001 `"Amacuzac"', add
label define geo2_mx_lbl 484017002 `"Atlatlahucan"', add
label define geo2_mx_lbl 484017003 `"Axochiapan"', add
label define geo2_mx_lbl 484017004 `"Ayala"', add
label define geo2_mx_lbl 484017005 `"Coatlán del Río"', add
label define geo2_mx_lbl 484017006 `"Cuautla"', add
label define geo2_mx_lbl 484017007 `"Cuernavaca"', add
label define geo2_mx_lbl 484017008 `"Emiliano Zapata"', add
label define geo2_mx_lbl 484017009 `"Huitzilac"', add
label define geo2_mx_lbl 484017010 `"Jantetelco"', add
label define geo2_mx_lbl 484017011 `"Jiutepec"', add
label define geo2_mx_lbl 484017012 `"Jojutla"', add
label define geo2_mx_lbl 484017013 `"Jonacatepec"', add
label define geo2_mx_lbl 484017014 `"Mazatepec"', add
label define geo2_mx_lbl 484017015 `"Miacatlán"', add
label define geo2_mx_lbl 484017016 `"Ocuituco"', add
label define geo2_mx_lbl 484017017 `"Puente de Ixtla"', add
label define geo2_mx_lbl 484017018 `"Temixco"', add
label define geo2_mx_lbl 484017019 `"Tepalcingo"', add
label define geo2_mx_lbl 484017020 `"Tepoztlán"', add
label define geo2_mx_lbl 484017021 `"Tetecala"', add
label define geo2_mx_lbl 484017022 `"Tetela del Volcán"', add
label define geo2_mx_lbl 484017023 `"Tlalnepantla"', add
label define geo2_mx_lbl 484017024 `"Tlaltizapán de Zapata"', add
label define geo2_mx_lbl 484017025 `"Tlaquiltenango"', add
label define geo2_mx_lbl 484017026 `"Tlayacapan"', add
label define geo2_mx_lbl 484017027 `"Totolapan"', add
label define geo2_mx_lbl 484017028 `"Xochitepec"', add
label define geo2_mx_lbl 484017029 `"Yautepec"', add
label define geo2_mx_lbl 484017030 `"Yecapixtla"', add
label define geo2_mx_lbl 484017031 `"Zacatepec de Hidalgo"', add
label define geo2_mx_lbl 484017032 `"Zacualpan de Amilpas, Temoac"', add
label define geo2_mx_lbl 484017999 `"Morelos [municipality unknown]"', add
label define geo2_mx_lbl 484018001 `"Acaponeta"', add
label define geo2_mx_lbl 484018002 `"Ahuacatlán"', add
label define geo2_mx_lbl 484018003 `"Amatlán de Cañas"', add
label define geo2_mx_lbl 484018004 `"Compostela, Bahía de Banderas"', add
label define geo2_mx_lbl 484018005 `"Huajicori"', add
label define geo2_mx_lbl 484018006 `"Ixtlán del Río"', add
label define geo2_mx_lbl 484018007 `"Jala"', add
label define geo2_mx_lbl 484018008 `"Xalisco"', add
label define geo2_mx_lbl 484018009 `"Del Nayar"', add
label define geo2_mx_lbl 484018010 `"Rosamorada"', add
label define geo2_mx_lbl 484018011 `"Ruíz"', add
label define geo2_mx_lbl 484018012 `"San Blas"', add
label define geo2_mx_lbl 484018013 `"San Pedro Lagunillas"', add
label define geo2_mx_lbl 484018014 `"Santa María del Oro"', add
label define geo2_mx_lbl 484018015 `"Santiago Ixcuintla"', add
label define geo2_mx_lbl 484018016 `"Tecuala"', add
label define geo2_mx_lbl 484018017 `"Tepic"', add
label define geo2_mx_lbl 484018018 `"Tuxpan"', add
label define geo2_mx_lbl 484018019 `"Yesca, La"', add
label define geo2_mx_lbl 484019001 `"Abasolo"', add
label define geo2_mx_lbl 484019002 `"Agualeguas"', add
label define geo2_mx_lbl 484019003 `"Aldamas, Los"', add
label define geo2_mx_lbl 484019004 `"Allende"', add
label define geo2_mx_lbl 484019005 `"Anáhuac"', add
label define geo2_mx_lbl 484019006 `"Apodaca"', add
label define geo2_mx_lbl 484019007 `"Aramberri"', add
label define geo2_mx_lbl 484019008 `"Bustamante"', add
label define geo2_mx_lbl 484019009 `"Cadereyta Jiménez"', add
label define geo2_mx_lbl 484019010 `"Carmen"', add
label define geo2_mx_lbl 484019011 `"Cerralvo"', add
label define geo2_mx_lbl 484019012 `"Ciénega de Flores"', add
label define geo2_mx_lbl 484019013 `"China"', add
label define geo2_mx_lbl 484019014 `"Doctor Arroyo"', add
label define geo2_mx_lbl 484019015 `"Doctor Coss"', add
label define geo2_mx_lbl 484019016 `"Doctor González"', add
label define geo2_mx_lbl 484019017 `"Galeana"', add
label define geo2_mx_lbl 484019018 `"García"', add
label define geo2_mx_lbl 484019019 `"San Pedro Garza García"', add
label define geo2_mx_lbl 484019020 `"General Bravo"', add
label define geo2_mx_lbl 484019021 `"General Escobedo"', add
label define geo2_mx_lbl 484019022 `"General Terán"', add
label define geo2_mx_lbl 484019023 `"General Treviño"', add
label define geo2_mx_lbl 484019024 `"General Zaragoza"', add
label define geo2_mx_lbl 484019025 `"General Zuazua"', add
label define geo2_mx_lbl 484019026 `"Guadalupe"', add
label define geo2_mx_lbl 484019027 `"Herreras, Los"', add
label define geo2_mx_lbl 484019028 `"Higueras"', add
label define geo2_mx_lbl 484019029 `"Hualahuises"', add
label define geo2_mx_lbl 484019030 `"Iturbide"', add
label define geo2_mx_lbl 484019031 `"Juárez"', add
label define geo2_mx_lbl 484019032 `"Lampazos de Naranjo"', add
label define geo2_mx_lbl 484019033 `"Linares"', add
label define geo2_mx_lbl 484019034 `"Marín"', add
label define geo2_mx_lbl 484019035 `"Melchor Ocampo"', add
label define geo2_mx_lbl 484019036 `"Mier y Noriega"', add
label define geo2_mx_lbl 484019037 `"Mina"', add
label define geo2_mx_lbl 484019038 `"Montemorelos"', add
label define geo2_mx_lbl 484019039 `"Monterrey"', add
label define geo2_mx_lbl 484019040 `"Parás"', add
label define geo2_mx_lbl 484019041 `"Pesquería"', add
label define geo2_mx_lbl 484019042 `"Ramones, Los"', add
label define geo2_mx_lbl 484019043 `"Rayones"', add
label define geo2_mx_lbl 484019044 `"Sabinas Hidalgo"', add
label define geo2_mx_lbl 484019045 `"Salinas Victoria"', add
label define geo2_mx_lbl 484019046 `"San Nicolás de los Garza"', add
label define geo2_mx_lbl 484019047 `"Hidalgo"', add
label define geo2_mx_lbl 484019048 `"Santa Catarina"', add
label define geo2_mx_lbl 484019049 `"Santiago"', add
label define geo2_mx_lbl 484019050 `"Vallecillo"', add
label define geo2_mx_lbl 484019051 `"Villaldama"', add
label define geo2_mx_lbl 484019999 `"Nuevo Leon"', add
label define geo2_mx_lbl 484020001 `"Abejones"', add
label define geo2_mx_lbl 484020002 `"Acatlán de Pérez Figueroa"', add
label define geo2_mx_lbl 484020003 `"Asunción Cacalotepec"', add
label define geo2_mx_lbl 484020004 `"Asunción Cuyotepeji"', add
label define geo2_mx_lbl 484020005 `"Asunción Ixtaltepec"', add
label define geo2_mx_lbl 484020006 `"Asunción Nochixtlán"', add
label define geo2_mx_lbl 484020007 `"Asunción Ocotlán"', add
label define geo2_mx_lbl 484020008 `"Asunción Tlacolulita"', add
label define geo2_mx_lbl 484020009 `"Ayotzintepec"', add
label define geo2_mx_lbl 484020010 `"Barrio de la Soledad, El"', add
label define geo2_mx_lbl 484020011 `"Calihualá"', add
label define geo2_mx_lbl 484020012 `"Candelaria Loxicha"', add
label define geo2_mx_lbl 484020013 `"Ciénega de Zimatlán"', add
label define geo2_mx_lbl 484020014 `"Ciudad Ixtepec"', add
label define geo2_mx_lbl 484020015 `"Coatecas Altas"', add
label define geo2_mx_lbl 484020016 `"Coicoyán de las Flores"', add
label define geo2_mx_lbl 484020017 `"Compañía, La"', add
label define geo2_mx_lbl 484020018 `"Concepción Buenavista"', add
label define geo2_mx_lbl 484020019 `"Concepción Pápalo"', add
label define geo2_mx_lbl 484020020 `"Constancia del Rosario"', add
label define geo2_mx_lbl 484020021 `"Cosolapa"', add
label define geo2_mx_lbl 484020022 `"Cosoltepec"', add
label define geo2_mx_lbl 484020023 `"Cuilápam de Guerrero"', add
label define geo2_mx_lbl 484020024 `"Cuyamecalco Villa de Zaragoza"', add
label define geo2_mx_lbl 484020025 `"Chahuites"', add
label define geo2_mx_lbl 484020026 `"Chalcatongo de Hidalgo"', add
label define geo2_mx_lbl 484020027 `"Chiquihuitlán de Benito Juárez"', add
label define geo2_mx_lbl 484020028 `"Heroica Ciudad de Ejutla de Crespo"', add
label define geo2_mx_lbl 484020029 `"Eloxochitlán de Flores Magón"', add
label define geo2_mx_lbl 484020030 `"Espinal, El"', add
label define geo2_mx_lbl 484020031 `"Tamazulápam del Espíritu Santo"', add
label define geo2_mx_lbl 484020032 `"Fresnillo de Trujano"', add
label define geo2_mx_lbl 484020033 `"Guadalupe Etla"', add
label define geo2_mx_lbl 484020034 `"Guadalupe de Ramírez"', add
label define geo2_mx_lbl 484020035 `"Guelatao de Juárez"', add
label define geo2_mx_lbl 484020036 `"Guevea de Humboldt"', add
label define geo2_mx_lbl 484020037 `"Mesones Hidalgo"', add
label define geo2_mx_lbl 484020038 `"Villa Hidalgo"', add
label define geo2_mx_lbl 484020039 `"Heroica Ciudad de Huajuapan de León"', add
label define geo2_mx_lbl 484020040 `"Huautepec"', add
label define geo2_mx_lbl 484020041 `"Huautla de Jiménez"', add
label define geo2_mx_lbl 484020042 `"Ixtlán de Juárez, San Juan Atepec"', add
label define geo2_mx_lbl 484020043 `"Heroica Ciudad de Juchitán de Zaragoza"', add
label define geo2_mx_lbl 484020044 `"Loma Bonita"', add
label define geo2_mx_lbl 484020045 `"Magdalena Apasco"', add
label define geo2_mx_lbl 484020046 `"Magdalena Jaltepec"', add
label define geo2_mx_lbl 484020047 `"Santa Magdalena Jicotlán"', add
label define geo2_mx_lbl 484020048 `"Magdalena Mixtepec"', add
label define geo2_mx_lbl 484020049 `"Magdalena Ocotlán"', add
label define geo2_mx_lbl 484020050 `"Magdalena Peñasco"', add
label define geo2_mx_lbl 484020051 `"Magdalena Teitipac"', add
label define geo2_mx_lbl 484020052 `"Magdalena Tequisistlán"', add
label define geo2_mx_lbl 484020053 `"Magdalena Tlacotepec"', add
label define geo2_mx_lbl 484020054 `"Magdalena Zahuatlán"', add
label define geo2_mx_lbl 484020055 `"Mariscala de Juárez"', add
label define geo2_mx_lbl 484020056 `"Mártires de Tacubaya"', add
label define geo2_mx_lbl 484020057 `"Matías Romero Avendaño"', add
label define geo2_mx_lbl 484020058 `"Mazatlán Villa de Flores"', add
label define geo2_mx_lbl 484020059 `"Miahuatlán de Porfirio Díaz"', add
label define geo2_mx_lbl 484020060 `"Mixistlán de la Reforma"', add
label define geo2_mx_lbl 484020061 `"Monjas"', add
label define geo2_mx_lbl 484020062 `"Natividad"', add
label define geo2_mx_lbl 484020063 `"Nazareno Etla"', add
label define geo2_mx_lbl 484020064 `"Nejapa de Madero"', add
label define geo2_mx_lbl 484020065 `"Ixpantepec Nieves"', add
label define geo2_mx_lbl 484020066 `"Santiago Niltepec"', add
label define geo2_mx_lbl 484020067 `"Oaxaca de Juárez"', add
label define geo2_mx_lbl 484020068 `"Ocotlán de Morelos"', add
label define geo2_mx_lbl 484020069 `"Pe, La"', add
label define geo2_mx_lbl 484020070 `"Pinotepa de Don Luis"', add
label define geo2_mx_lbl 484020071 `"Pluma Hidalgo"', add
label define geo2_mx_lbl 484020072 `"San José del Progreso"', add
label define geo2_mx_lbl 484020073 `"Putla Villa de Guerrero"', add
label define geo2_mx_lbl 484020074 `"Santa Catarina Quioquitani"', add
label define geo2_mx_lbl 484020075 `"Reforma de Pineda"', add
label define geo2_mx_lbl 484020076 `"Reforma, La"', add
label define geo2_mx_lbl 484020077 `"Reyes Etla"', add
label define geo2_mx_lbl 484020078 `"Rojas de Cuauhtémoc"', add
label define geo2_mx_lbl 484020079 `"Salina Cruz"', add
label define geo2_mx_lbl 484020080 `"San Agustín Amatengo"', add
label define geo2_mx_lbl 484020081 `"San Agustín Atenango"', add
label define geo2_mx_lbl 484020082 `"San Agustín Chayuco"', add
label define geo2_mx_lbl 484020083 `"San Agustín de las Juntas"', add
label define geo2_mx_lbl 484020084 `"San Agustín Etla"', add
label define geo2_mx_lbl 484020085 `"San Agustín Loxicha"', add
label define geo2_mx_lbl 484020086 `"San Agustín Tlacotepec"', add
label define geo2_mx_lbl 484020087 `"San Agustín Yatareni"', add
label define geo2_mx_lbl 484020088 `"San Andrés Cabecera Nueva"', add
label define geo2_mx_lbl 484020089 `"San Andrés Dinicuiti"', add
label define geo2_mx_lbl 484020090 `"San Andrés Huaxpaltepec"', add
label define geo2_mx_lbl 484020091 `"San Andrés Huayápam"', add
label define geo2_mx_lbl 484020092 `"San Andrés Ixtlahuaca"', add
label define geo2_mx_lbl 484020093 `"San Andrés Lagunas"', add
label define geo2_mx_lbl 484020094 `"San Andrés Nuxiño"', add
label define geo2_mx_lbl 484020095 `"San Andrés Paxtlán"', add
label define geo2_mx_lbl 484020096 `"San Andrés Sinaxtla"', add
label define geo2_mx_lbl 484020097 `"San Andrés Solaga"', add
label define geo2_mx_lbl 484020098 `"San Andrés Teotilálpam"', add
label define geo2_mx_lbl 484020099 `"San Andrés Tepetlapa"', add
label define geo2_mx_lbl 484020100 `"San Andrés Yaá"', add
label define geo2_mx_lbl 484020101 `"San Andrés Zabache"', add
label define geo2_mx_lbl 484020102 `"San Andrés Zautla"', add
label define geo2_mx_lbl 484020103 `"San Antonino Castillo Velasco"', add
label define geo2_mx_lbl 484020104 `"San Antonino el Alto"', add
label define geo2_mx_lbl 484020105 `"San Antonino Monte Verde"', add
label define geo2_mx_lbl 484020106 `"San Antonio Acutla"', add
label define geo2_mx_lbl 484020107 `"San Antonio de la Cal"', add
label define geo2_mx_lbl 484020108 `"San Antonio Huitepec"', add
label define geo2_mx_lbl 484020109 `"San Antonio Nanahuatípam, Teotitlán de Flores Magón"', add
label define geo2_mx_lbl 484020110 `"San Antonio Sinicahua"', add
label define geo2_mx_lbl 484020111 `"San Antonio Tepetlapa"', add
label define geo2_mx_lbl 484020112 `"San Baltazar Chichicápam"', add
label define geo2_mx_lbl 484020113 `"San Baltazar Loxicha"', add
label define geo2_mx_lbl 484020114 `"San Baltazar Yatzachi el Bajo"', add
label define geo2_mx_lbl 484020115 `"San Bartolo Coyotepec"', add
label define geo2_mx_lbl 484020116 `"San Bartolomé Ayautla"', add
label define geo2_mx_lbl 484020117 `"San Bartolomé Loxicha"', add
label define geo2_mx_lbl 484020118 `"San Bartolomé Quialana"', add
label define geo2_mx_lbl 484020119 `"San Bartolomé Yucuañe"', add
label define geo2_mx_lbl 484020120 `"San Bartolomé Zoogocho"', add
label define geo2_mx_lbl 484020121 `"San Bartolo Soyaltepec"', add
label define geo2_mx_lbl 484020122 `"San Bartolo Yautepec"', add
label define geo2_mx_lbl 484020123 `"San Bernardo Mixtepec"', add
label define geo2_mx_lbl 484020124 `"San Blas Atempa"', add
label define geo2_mx_lbl 484020125 `"San Carlos Yautepec"', add
label define geo2_mx_lbl 484020126 `"San Cristóbal Amatlán"', add
label define geo2_mx_lbl 484020127 `"San Cristóbal Amoltepec"', add
label define geo2_mx_lbl 484020128 `"San Cristóbal Lachirioag"', add
label define geo2_mx_lbl 484020129 `"San Cristóbal Suchixtlahuaca"', add
label define geo2_mx_lbl 484020130 `"San Dionisio del Mar"', add
label define geo2_mx_lbl 484020131 `"San Dionisio Ocotepec"', add
label define geo2_mx_lbl 484020132 `"San Dionisio Ocotlán"', add
label define geo2_mx_lbl 484020133 `"San Esteban Atatlahuca"', add
label define geo2_mx_lbl 484020134 `"San Felipe Jalapa de Díaz"', add
label define geo2_mx_lbl 484020135 `"San Felipe Tejalápam"', add
label define geo2_mx_lbl 484020136 `"San Felipe Usila"', add
label define geo2_mx_lbl 484020137 `"San Francisco Cahuacuá"', add
label define geo2_mx_lbl 484020138 `"San Francisco Cajonos"', add
label define geo2_mx_lbl 484020139 `"San Francisco Chapulapa"', add
label define geo2_mx_lbl 484020140 `"San Francisco Chindúa"', add
label define geo2_mx_lbl 484020141 `"San Francisco del Mar"', add
label define geo2_mx_lbl 484020142 `"San Francisco Huehuetlán"', add
label define geo2_mx_lbl 484020143 `"San Francisco Ixhuatán"', add
label define geo2_mx_lbl 484020144 `"San Francisco Jaltepetongo"', add
label define geo2_mx_lbl 484020145 `"San Francisco Lachigoló"', add
label define geo2_mx_lbl 484020146 `"San Francisco Logueche"', add
label define geo2_mx_lbl 484020147 `"San Francisco Nuxaño"', add
label define geo2_mx_lbl 484020148 `"San Francisco Ozolotepec"', add
label define geo2_mx_lbl 484020149 `"San Francisco Sola"', add
label define geo2_mx_lbl 484020150 `"San Francisco Telixtlahuaca"', add
label define geo2_mx_lbl 484020151 `"San Francisco Teopan"', add
label define geo2_mx_lbl 484020152 `"San Francisco Tlapancingo"', add
label define geo2_mx_lbl 484020153 `"San Gabriel Mixtepec"', add
label define geo2_mx_lbl 484020154 `"San Ildefonso Amatlán"', add
label define geo2_mx_lbl 484020155 `"San Ildefonso Sola"', add
label define geo2_mx_lbl 484020156 `"San Ildefonso Villa Alta"', add
label define geo2_mx_lbl 484020157 `"San Jacinto Amilpas"', add
label define geo2_mx_lbl 484020158 `"San Jacinto Tlacotepec"', add
label define geo2_mx_lbl 484020159 `"San Jerónimo Coatlán"', add
label define geo2_mx_lbl 484020160 `"San Jerónimo Silacayoapilla"', add
label define geo2_mx_lbl 484020161 `"San Jerónimo Sosola"', add
label define geo2_mx_lbl 484020162 `"San Jerónimo Taviche"', add
label define geo2_mx_lbl 484020163 `"San Jerónimo Tecóatl"', add
label define geo2_mx_lbl 484020164 `"San Jorge Nuchita"', add
label define geo2_mx_lbl 484020165 `"San José Ayuquila"', add
label define geo2_mx_lbl 484020166 `"San José Chiltepec"', add
label define geo2_mx_lbl 484020167 `"San José del Peñasco"', add
label define geo2_mx_lbl 484020168 `"San José Estancia Grande"', add
label define geo2_mx_lbl 484020169 `"San José Independencia"', add
label define geo2_mx_lbl 484020170 `"San José Lachiguiri"', add
label define geo2_mx_lbl 484020171 `"San José Tenango"', add
label define geo2_mx_lbl 484020172 `"San Juan Achiutla"', add
label define geo2_mx_lbl 484020173 `"Ánimas Trujano"', add
label define geo2_mx_lbl 484020174 `"San Juan Bautista Atatlahuca"', add
label define geo2_mx_lbl 484020175 `"San Juan Bautista Coixtlahuaca"', add
label define geo2_mx_lbl 484020176 `"San Juan Bautista Cuicatlán"', add
label define geo2_mx_lbl 484020177 `"San Juan Bautista Guelache"', add
label define geo2_mx_lbl 484020178 `"San Juan Bautista Jayacatlán"', add
label define geo2_mx_lbl 484020179 `"San Juan Bautista lo de Soto"', add
label define geo2_mx_lbl 484020180 `"San Juan Bautista Suchitepec"', add
label define geo2_mx_lbl 484020181 `"San Juan Bautista Tlacoatzintepec"', add
label define geo2_mx_lbl 484020182 `"San Juan Bautista Tlachichilco"', add
label define geo2_mx_lbl 484020183 `"San Juan Bautista Tuxtepec"', add
label define geo2_mx_lbl 484020184 `"San Juan Cacahuatepec"', add
label define geo2_mx_lbl 484020185 `"San Juan Cieneguilla"', add
label define geo2_mx_lbl 484020186 `"San Juan Coatzóspam"', add
label define geo2_mx_lbl 484020187 `"San Juan Colorado"', add
label define geo2_mx_lbl 484020188 `"San Juan Comaltepec"', add
label define geo2_mx_lbl 484020189 `"San Juan Cotzocón"', add
label define geo2_mx_lbl 484020190 `"San Juan Chicomezúchil"', add
label define geo2_mx_lbl 484020191 `"San Juan Chilateca"', add
label define geo2_mx_lbl 484020192 `"San Juan del Estado"', add
label define geo2_mx_lbl 484020193 `"San Juan del Río"', add
label define geo2_mx_lbl 484020194 `"San Juan Diuxi"', add
label define geo2_mx_lbl 484020195 `"San Juan Evangelista Analco"', add
label define geo2_mx_lbl 484020196 `"San Juan Guelavía"', add
label define geo2_mx_lbl 484020197 `"San Juan Guichicovi"', add
label define geo2_mx_lbl 484020198 `"San Juan Ihualtepec"', add
label define geo2_mx_lbl 484020199 `"San Juan Juquila Mixes"', add
label define geo2_mx_lbl 484020200 `"San Juan Juquila Vijanos"', add
label define geo2_mx_lbl 484020201 `"San Juan Lachao"', add
label define geo2_mx_lbl 484020202 `"San Juan Lachigalla"', add
label define geo2_mx_lbl 484020203 `"San Juan Lajarcia"', add
label define geo2_mx_lbl 484020204 `"San Juan Lalana"', add
label define geo2_mx_lbl 484020205 `"San Juan de los Cués"', add
label define geo2_mx_lbl 484020206 `"San Juan Mazatlán"', add
label define geo2_mx_lbl 484020207 `"San Juan Mixtepec Distrito 08"', add
label define geo2_mx_lbl 484020208 `"San Juan Mixtepec Distrito 26"', add
label define geo2_mx_lbl 484020209 `"San Juan Ñumí"', add
label define geo2_mx_lbl 484020210 `"San Juan Ozolotepec"', add
label define geo2_mx_lbl 484020211 `"San Juan Petlapa"', add
label define geo2_mx_lbl 484020212 `"San Juan Quiahije"', add
label define geo2_mx_lbl 484020213 `"San Juan Quiotepec"', add
label define geo2_mx_lbl 484020214 `"San Juan Sayultepec"', add
label define geo2_mx_lbl 484020215 `"San Juan Tabaá"', add
label define geo2_mx_lbl 484020216 `"San Juan Tamazola"', add
label define geo2_mx_lbl 484020217 `"San Juan Teita"', add
label define geo2_mx_lbl 484020218 `"San Juan Teitipac"', add
label define geo2_mx_lbl 484020219 `"San Juan Tepeuxila"', add
label define geo2_mx_lbl 484020220 `"San Juan Teposcolula"', add
label define geo2_mx_lbl 484020221 `"San Juan Yaeé"', add
label define geo2_mx_lbl 484020222 `"San Juan Yatzona"', add
label define geo2_mx_lbl 484020223 `"San Juan Yucuita"', add
label define geo2_mx_lbl 484020224 `"San Lorenzo"', add
label define geo2_mx_lbl 484020225 `"San Lorenzo Albarradas"', add
label define geo2_mx_lbl 484020226 `"San Lorenzo Cacaotepec"', add
label define geo2_mx_lbl 484020227 `"San Lorenzo Cuaunecuiltitla"', add
label define geo2_mx_lbl 484020228 `"San Lorenzo Texmelúcan"', add
label define geo2_mx_lbl 484020229 `"San Lorenzo Victoria"', add
label define geo2_mx_lbl 484020230 `"San Lucas Camotlán"', add
label define geo2_mx_lbl 484020231 `"San Lucas Ojitlán"', add
label define geo2_mx_lbl 484020232 `"San Lucas Quiaviní"', add
label define geo2_mx_lbl 484020233 `"San Lucas Zoquiápam"', add
label define geo2_mx_lbl 484020234 `"San Luis Amatlán"', add
label define geo2_mx_lbl 484020235 `"San Marcial Ozolotepec"', add
label define geo2_mx_lbl 484020236 `"San Marcos Arteaga"', add
label define geo2_mx_lbl 484020237 `"San Martin de los Cansecos"', add
label define geo2_mx_lbl 484020238 `"San Martín Huamelúlpam"', add
label define geo2_mx_lbl 484020239 `"San Martin Itunyoso"', add
label define geo2_mx_lbl 484020240 `"San Martín Lachilá"', add
label define geo2_mx_lbl 484020241 `"San Martin Peras"', add
label define geo2_mx_lbl 484020242 `"San Martin Tilcajete"', add
label define geo2_mx_lbl 484020243 `"San Martin Toxpalan"', add
label define geo2_mx_lbl 484020244 `"San Martin Zacatepec"', add
label define geo2_mx_lbl 484020245 `"San Mateo Cajonos"', add
label define geo2_mx_lbl 484020246 `"Capulálpam de Méndez"', add
label define geo2_mx_lbl 484020247 `"San Mateo del Mar"', add
label define geo2_mx_lbl 484020248 `"San Mateo Yoloxochitlán"', add
label define geo2_mx_lbl 484020249 `"San Mateo Etlatongo"', add
label define geo2_mx_lbl 484020250 `"San Mateo Nejápam"', add
label define geo2_mx_lbl 484020251 `"San Mateo Peñasco"', add
label define geo2_mx_lbl 484020252 `"San Mateo Piñas"', add
label define geo2_mx_lbl 484020253 `"San Mateo Río Hondo"', add
label define geo2_mx_lbl 484020254 `"San Mateo Sindihui"', add
label define geo2_mx_lbl 484020255 `"San Mateo Tlapiltepec"', add
label define geo2_mx_lbl 484020256 `"San Melchor Betaza"', add
label define geo2_mx_lbl 484020257 `"San Miguel Achiutla"', add
label define geo2_mx_lbl 484020258 `"San Miguel Ahuehuetitlán"', add
label define geo2_mx_lbl 484020259 `"San Miguel Aloápam"', add
label define geo2_mx_lbl 484020260 `"San Miguel Amatitlán"', add
label define geo2_mx_lbl 484020261 `"San Miguel Amatlán"', add
label define geo2_mx_lbl 484020262 `"San Miguel Coatlán"', add
label define geo2_mx_lbl 484020263 `"San Miguel Chicahua"', add
label define geo2_mx_lbl 484020264 `"San Miguel Chimalapa"', add
label define geo2_mx_lbl 484020265 `"San Miguel del Puerto"', add
label define geo2_mx_lbl 484020266 `"San Miguel del Río"', add
label define geo2_mx_lbl 484020267 `"San Miguel Ejutla"', add
label define geo2_mx_lbl 484020268 `"San Miguel el Grande"', add
label define geo2_mx_lbl 484020269 `"San Miguel Huautla"', add
label define geo2_mx_lbl 484020270 `"San Miguel Mixtepec"', add
label define geo2_mx_lbl 484020271 `"San Miguel Panixtlahuaca"', add
label define geo2_mx_lbl 484020272 `"San Miguel Peras"', add
label define geo2_mx_lbl 484020273 `"San Miguel Piedras"', add
label define geo2_mx_lbl 484020274 `"San Miguel Quetzaltepec"', add
label define geo2_mx_lbl 484020275 `"San Miguel Santa Flor"', add
label define geo2_mx_lbl 484020276 `"Villa Sola de Vega"', add
label define geo2_mx_lbl 484020277 `"San Miguel Soyaltepec"', add
label define geo2_mx_lbl 484020278 `"San Miguel Suchixtepec"', add
label define geo2_mx_lbl 484020279 `"Villa Talea de Castro"', add
label define geo2_mx_lbl 484020280 `"San Miguel Tecomatlán"', add
label define geo2_mx_lbl 484020281 `"San Miguel Tenango"', add
label define geo2_mx_lbl 484020282 `"San Miguel Tequixtepec"', add
label define geo2_mx_lbl 484020283 `"San Miguel Tilquiápam"', add
label define geo2_mx_lbl 484020284 `"San Miguel Tlacamama"', add
label define geo2_mx_lbl 484020285 `"San Miguel Tlacotepec"', add
label define geo2_mx_lbl 484020286 `"San Miguel Tulancingo"', add
label define geo2_mx_lbl 484020287 `"San Miguel Yotao"', add
label define geo2_mx_lbl 484020288 `"San Nicolás"', add
label define geo2_mx_lbl 484020289 `"San Nicolás Hidalgo"', add
label define geo2_mx_lbl 484020290 `"San Pablo Coatlán"', add
label define geo2_mx_lbl 484020291 `"San Pablo Cuatro Venados"', add
label define geo2_mx_lbl 484020292 `"San Pablo Etla"', add
label define geo2_mx_lbl 484020293 `"San Pablo Huitzo"', add
label define geo2_mx_lbl 484020294 `"San Pablo Huixtepec"', add
label define geo2_mx_lbl 484020295 `"San Pablo Macuiltianguis"', add
label define geo2_mx_lbl 484020296 `"San Pablo Tijaltepec"', add
label define geo2_mx_lbl 484020297 `"San Pablo Villa de Mitla"', add
label define geo2_mx_lbl 484020298 `"San Pablo Yaganiza"', add
label define geo2_mx_lbl 484020299 `"San Pedro Amuzgos"', add
label define geo2_mx_lbl 484020300 `"San Pedro Apóstol"', add
label define geo2_mx_lbl 484020301 `"San Pedro Atoyac"', add
label define geo2_mx_lbl 484020302 `"San Pedro Cajonos"', add
label define geo2_mx_lbl 484020303 `"San Pedro Coxcaltepec Cántaros"', add
label define geo2_mx_lbl 484020304 `"San Pedro Comitancillo"', add
label define geo2_mx_lbl 484020305 `"San Pedro el Alto"', add
label define geo2_mx_lbl 484020306 `"San Pedro Huamelula"', add
label define geo2_mx_lbl 484020307 `"San Pedro Huilotepec"', add
label define geo2_mx_lbl 484020308 `"San Pedro Ixcatlán"', add
label define geo2_mx_lbl 484020309 `"San Pedro Ixtlahuaca"', add
label define geo2_mx_lbl 484020310 `"San Pedro Jaltepetongo"', add
label define geo2_mx_lbl 484020311 `"San Pedro Jicayán"', add
label define geo2_mx_lbl 484020312 `"San Pedro Jocotipac"', add
label define geo2_mx_lbl 484020313 `"San Pedro Juchatengo"', add
label define geo2_mx_lbl 484020314 `"San Pedro Mártir"', add
label define geo2_mx_lbl 484020315 `"San Pedro Mártir Quiechapa"', add
label define geo2_mx_lbl 484020316 `"San Pedro Mártir Yucuxaco"', add
label define geo2_mx_lbl 484020317 `"San Pedro Mixtepec - distr. 22"', add
label define geo2_mx_lbl 484020318 `"San Pedro Mixtepec - distr. 26"', add
label define geo2_mx_lbl 484020319 `"San Pedro Molinos"', add
label define geo2_mx_lbl 484020320 `"San Pedro Nopala"', add
label define geo2_mx_lbl 484020321 `"San Pedro Ocopetatillo"', add
label define geo2_mx_lbl 484020322 `"San Pedro Ocotepec"', add
label define geo2_mx_lbl 484020323 `"San Pedro Pochutla"', add
label define geo2_mx_lbl 484020324 `"San Pedro Quiatoni"', add
label define geo2_mx_lbl 484020325 `"San Pedro Sochiápam"', add
label define geo2_mx_lbl 484020326 `"San Pedro Tapanatepec"', add
label define geo2_mx_lbl 484020327 `"San Pedro Taviche"', add
label define geo2_mx_lbl 484020328 `"San Pedro Teozacoalco"', add
label define geo2_mx_lbl 484020329 `"San Pedro Teutila"', add
label define geo2_mx_lbl 484020330 `"San Pedro Tidaá"', add
label define geo2_mx_lbl 484020331 `"San Pedro Topiltepec"', add
label define geo2_mx_lbl 484020332 `"San Pedro Totolápam"', add
label define geo2_mx_lbl 484020333 `"Villa de Tututepec de Melchor Ocampo"', add
label define geo2_mx_lbl 484020334 `"San Pedro Yaneri"', add
label define geo2_mx_lbl 484020335 `"San Pedro Yólox"', add
label define geo2_mx_lbl 484020336 `"San Pedro y San Pablo Ayutla"', add
label define geo2_mx_lbl 484020337 `"Villa de Etla"', add
label define geo2_mx_lbl 484020338 `"San Pedro y San Pablo Teposcolula"', add
label define geo2_mx_lbl 484020339 `"San Pedro y San Pablo Tequixtepec"', add
label define geo2_mx_lbl 484020340 `"San Pedro Yucunama"', add
label define geo2_mx_lbl 484020341 `"San Raymundo Jalpan"', add
label define geo2_mx_lbl 484020342 `"San Sebastián Abasolo"', add
label define geo2_mx_lbl 484020343 `"San Sebastián Coatlán"', add
label define geo2_mx_lbl 484020344 `"San Sebastián Ixcapa"', add
label define geo2_mx_lbl 484020345 `"San Sebastián Nicananduta"', add
label define geo2_mx_lbl 484020346 `"San Sebastián Río Hondo"', add
label define geo2_mx_lbl 484020347 `"San Sebastián Tecomaxtlahuaca"', add
label define geo2_mx_lbl 484020348 `"San Sebastián Teitipac"', add
label define geo2_mx_lbl 484020349 `"San Sebastián Tutla"', add
label define geo2_mx_lbl 484020350 `"San Simón Almolongas"', add
label define geo2_mx_lbl 484020351 `"San Simón Zahuatlán"', add
label define geo2_mx_lbl 484020352 `"Santa Ana"', add
label define geo2_mx_lbl 484020353 `"Santa Ana Ateixtlahuaca"', add
label define geo2_mx_lbl 484020354 `"Santa Ana Cuauhtémoc"', add
label define geo2_mx_lbl 484020355 `"Santa Ana del Valle"', add
label define geo2_mx_lbl 484020356 `"Santa Ana Tavela"', add
label define geo2_mx_lbl 484020357 `"Santa Ana Tlapacoyan"', add
label define geo2_mx_lbl 484020358 `"Santa Ana Yareni"', add
label define geo2_mx_lbl 484020359 `"Santa Ana Zegache"', add
label define geo2_mx_lbl 484020360 `"Santa Catalina Quierí"', add
label define geo2_mx_lbl 484020361 `"Santa Catarina Cuixtla"', add
label define geo2_mx_lbl 484020362 `"Santa Catarina Ixtepeji"', add
label define geo2_mx_lbl 484020363 `"Santa Catarina Juquila"', add
label define geo2_mx_lbl 484020364 `"Santa Catarina Lachatao"', add
label define geo2_mx_lbl 484020365 `"Santa Catarina Loxicha"', add
label define geo2_mx_lbl 484020366 `"Santa Catarina Mechoacán"', add
label define geo2_mx_lbl 484020367 `"Santa Catarina Minas"', add
label define geo2_mx_lbl 484020368 `"Santa Catarina Quiané"', add
label define geo2_mx_lbl 484020369 `"Santa Catarina Tayata"', add
label define geo2_mx_lbl 484020370 `"Santa Catarina Ticuá"', add
label define geo2_mx_lbl 484020371 `"Santa Catarina Yosonotú"', add
label define geo2_mx_lbl 484020372 `"Santa Catarina Zapoquila"', add
label define geo2_mx_lbl 484020373 `"Santa Cruz Acatepec"', add
label define geo2_mx_lbl 484020374 `"Santa Cruz Amilpas"', add
label define geo2_mx_lbl 484020375 `"Santa Cruz de Bravo"', add
label define geo2_mx_lbl 484020376 `"Santa Cruz Itundujia"', add
label define geo2_mx_lbl 484020377 `"Santa Cruz Mixtepec"', add
label define geo2_mx_lbl 484020378 `"Santa Cruz Nundaco"', add
label define geo2_mx_lbl 484020379 `"Santa Cruz Papalutla"', add
label define geo2_mx_lbl 484020380 `"Santa Cruz Tacache de Mina"', add
label define geo2_mx_lbl 484020381 `"Santa Cruz Tacahua"', add
label define geo2_mx_lbl 484020382 `"Santa Cruz Tayata"', add
label define geo2_mx_lbl 484020383 `"Santa Cruz Xitla"', add
label define geo2_mx_lbl 484020384 `"Santa Cruz Xoxocotlán"', add
label define geo2_mx_lbl 484020385 `"Santa Cruz Zenzontepec"', add
label define geo2_mx_lbl 484020386 `"Santa Gertrudis"', add
label define geo2_mx_lbl 484020387 `"Santa Inés del Monte"', add
label define geo2_mx_lbl 484020388 `"Santa Inés Yatzeche"', add
label define geo2_mx_lbl 484020389 `"Santa Lucía del Camino"', add
label define geo2_mx_lbl 484020390 `"Santa Lucía Miahuatlán"', add
label define geo2_mx_lbl 484020391 `"Santa Lucía Monteverde"', add
label define geo2_mx_lbl 484020392 `"Santa Lucía Ocotlán"', add
label define geo2_mx_lbl 484020393 `"Santa María Alotepec"', add
label define geo2_mx_lbl 484020394 `"Santa María Apazco"', add
label define geo2_mx_lbl 484020395 `"Santa María la Asunción"', add
label define geo2_mx_lbl 484020396 `"Heroica Ciudad de Tlaxiaco"', add
label define geo2_mx_lbl 484020397 `"Ayoquezco de Aldama"', add
label define geo2_mx_lbl 484020398 `"Santa Maria Atzompa"', add
label define geo2_mx_lbl 484020399 `"Santa María Camotlán, Santiago Huajolotitlán"', add
label define geo2_mx_lbl 484020400 `"Santa María Colotepec"', add
label define geo2_mx_lbl 484020401 `"Santa María Cortijo"', add
label define geo2_mx_lbl 484020402 `"Santa Maria Coyotepec"', add
label define geo2_mx_lbl 484020403 `"Santa María Chachoápam"', add
label define geo2_mx_lbl 484020404 `"Villa de Chilapa de Díaz"', add
label define geo2_mx_lbl 484020405 `"Santa María Chilchotla"', add
label define geo2_mx_lbl 484020406 `"Santa María Chimalapa"', add
label define geo2_mx_lbl 484020407 `"Santa María del Rosario"', add
label define geo2_mx_lbl 484020408 `"Santa María del Tule"', add
label define geo2_mx_lbl 484020409 `"Santa María Ecatepec"', add
label define geo2_mx_lbl 484020410 `"Santa María Guelacé"', add
label define geo2_mx_lbl 484020411 `"Santa María Guienagati"', add
label define geo2_mx_lbl 484020412 `"Santa María Huatulco"', add
label define geo2_mx_lbl 484020413 `"Santa María Huazolotitlán"', add
label define geo2_mx_lbl 484020414 `"Santa María Ipalapa"', add
label define geo2_mx_lbl 484020415 `"Santa María Ixcatlán"', add
label define geo2_mx_lbl 484020416 `"Santa María Jacatepec"', add
label define geo2_mx_lbl 484020417 `"Santa María Jalapa del Marqués"', add
label define geo2_mx_lbl 484020418 `"Santa María Jaltianguis"', add
label define geo2_mx_lbl 484020419 `"Santa María Lachixío"', add
label define geo2_mx_lbl 484020420 `"Santa María Mixtequilla"', add
label define geo2_mx_lbl 484020421 `"Santa María Nativitas"', add
label define geo2_mx_lbl 484020422 `"Santa María Nduayaco"', add
label define geo2_mx_lbl 484020423 `"Santa María Ozolotepec"', add
label define geo2_mx_lbl 484020424 `"Santa María Pápalo"', add
label define geo2_mx_lbl 484020425 `"Santa María Peñoles"', add
label define geo2_mx_lbl 484020426 `"Santa María Petapa"', add
label define geo2_mx_lbl 484020427 `"Santa María Quiegolani"', add
label define geo2_mx_lbl 484020428 `"Santa María Sola"', add
label define geo2_mx_lbl 484020429 `"Santa María Tataltepec"', add
label define geo2_mx_lbl 484020430 `"Santa María Tecomavaca"', add
label define geo2_mx_lbl 484020431 `"Santa María Temaxcalapa"', add
label define geo2_mx_lbl 484020432 `"Santa María Temaxcaltepec, Santos Reyes Nopala"', add
label define geo2_mx_lbl 484020433 `"Santa María Teopoxco"', add
label define geo2_mx_lbl 484020434 `"Santa María Tepantlali"', add
label define geo2_mx_lbl 484020435 `"Santa María Texcatitlán"', add
label define geo2_mx_lbl 484020436 `"Santa María Tlahuitoltepec"', add
label define geo2_mx_lbl 484020437 `"Santa María Tlalixtac"', add
label define geo2_mx_lbl 484020438 `"Santa María Tonameca"', add
label define geo2_mx_lbl 484020439 `"Santa María Totolapilla"', add
label define geo2_mx_lbl 484020440 `"Santa María Xadani"', add
label define geo2_mx_lbl 484020441 `"Santa María Yalina"', add
label define geo2_mx_lbl 484020442 `"Santa María Yavesía"', add
label define geo2_mx_lbl 484020443 `"Santa María Yolotepec"', add
label define geo2_mx_lbl 484020444 `"Santa María Yosoyúa"', add
label define geo2_mx_lbl 484020445 `"Santa María Yucuhiti"', add
label define geo2_mx_lbl 484020446 `"Santa María Zacatepec"', add
label define geo2_mx_lbl 484020447 `"Santa María Zaniza"', add
label define geo2_mx_lbl 484020448 `"Santa María Zoquitlán"', add
label define geo2_mx_lbl 484020449 `"Santiago Amoltepec"', add
label define geo2_mx_lbl 484020450 `"Santiago Apoala"', add
label define geo2_mx_lbl 484020451 `"Santiago Apóstol"', add
label define geo2_mx_lbl 484020452 `"Santiago Astata"', add
label define geo2_mx_lbl 484020453 `"Santiago Atitlán"', add
label define geo2_mx_lbl 484020454 `"Santiago Ayuquililla"', add
label define geo2_mx_lbl 484020455 `"Santiago Cacaloxtepec"', add
label define geo2_mx_lbl 484020456 `"Santiago Camotlán"', add
label define geo2_mx_lbl 484020457 `"Santiago Comaltepec"', add
label define geo2_mx_lbl 484020458 `"Santiago Chazumba"', add
label define geo2_mx_lbl 484020459 `"Santiago Choápam"', add
label define geo2_mx_lbl 484020460 `"Santiago del Río"', add
label define geo2_mx_lbl 484020461 `"Santiago Huauclilla"', add
label define geo2_mx_lbl 484020462 `"Santiago Ihuitlán Plumas"', add
label define geo2_mx_lbl 484020463 `"Santiago Ixcuintepec"', add
label define geo2_mx_lbl 484020464 `"Santiago Ixtayutla"', add
label define geo2_mx_lbl 484020465 `"Santiago Jamiltepec"', add
label define geo2_mx_lbl 484020466 `"Santiago Jocotepec"', add
label define geo2_mx_lbl 484020467 `"Santiago Juxtlahuaca"', add
label define geo2_mx_lbl 484020468 `"Santiago Lachiguiri"', add
label define geo2_mx_lbl 484020469 `"Santiago Lalopa"', add
label define geo2_mx_lbl 484020470 `"Santiago Laollaga"', add
label define geo2_mx_lbl 484020471 `"Santiago Laxopa"', add
label define geo2_mx_lbl 484020472 `"Santiago Llano Grande"', add
label define geo2_mx_lbl 484020473 `"Santiago Matatlán"', add
label define geo2_mx_lbl 484020474 `"Santiago Miltepec"', add
label define geo2_mx_lbl 484020475 `"Santiago Minas"', add
label define geo2_mx_lbl 484020476 `"Santiago Nacaltepec"', add
label define geo2_mx_lbl 484020477 `"Santiago Nejapilla"', add
label define geo2_mx_lbl 484020478 `"Santiago Nundiche"', add
label define geo2_mx_lbl 484020479 `"Santiago Nuyoó"', add
label define geo2_mx_lbl 484020480 `"Santiago Pinotepa Nacional"', add
label define geo2_mx_lbl 484020481 `"Santiago Suchilquitongo"', add
label define geo2_mx_lbl 484020482 `"Santiago Tamazola"', add
label define geo2_mx_lbl 484020483 `"Santiago Tapextla"', add
label define geo2_mx_lbl 484020484 `"Villa Tejúpam de la Unión"', add
label define geo2_mx_lbl 484020485 `"Santiago Tenango"', add
label define geo2_mx_lbl 484020486 `"Santiago Tepetlapa"', add
label define geo2_mx_lbl 484020487 `"Santiago Tetepec"', add
label define geo2_mx_lbl 484020488 `"Santiago Texcalcingo"', add
label define geo2_mx_lbl 484020489 `"Santiago Textitlán"', add
label define geo2_mx_lbl 484020490 `"Santiago Tilantongo"', add
label define geo2_mx_lbl 484020491 `"Santiago Tillo"', add
label define geo2_mx_lbl 484020492 `"Santiago Tlazoyaltepec"', add
label define geo2_mx_lbl 484020493 `"Santiago Xanica"', add
label define geo2_mx_lbl 484020494 `"Santiago Xiacuí"', add
label define geo2_mx_lbl 484020495 `"Santiago Yaitepec"', add
label define geo2_mx_lbl 484020496 `"Santiago Yaveo"', add
label define geo2_mx_lbl 484020497 `"Santiago Yolomécatl"', add
label define geo2_mx_lbl 484020498 `"Santiago Yosondúa"', add
label define geo2_mx_lbl 484020499 `"Santiago Yucuyachi"', add
label define geo2_mx_lbl 484020500 `"Santiago Zacatepec"', add
label define geo2_mx_lbl 484020501 `"Santiago Zoochila"', add
label define geo2_mx_lbl 484020502 `"Nuevo Zoquiápam"', add
label define geo2_mx_lbl 484020503 `"Santo Domingo Ingenio"', add
label define geo2_mx_lbl 484020504 `"Santo Domingo Albarradas"', add
label define geo2_mx_lbl 484020505 `"Santo Domingo Armenta"', add
label define geo2_mx_lbl 484020506 `"Santo Domingo Chihuitán"', add
label define geo2_mx_lbl 484020507 `"Santo Domingo de Morelos"', add
label define geo2_mx_lbl 484020508 `"Santo Domingo Ixcatlán"', add
label define geo2_mx_lbl 484020509 `"Santo Domingo Nuxaá"', add
label define geo2_mx_lbl 484020510 `"Santo Domingo Ozolotepec"', add
label define geo2_mx_lbl 484020511 `"Santo Domingo Petapa"', add
label define geo2_mx_lbl 484020512 `"Santo Domingo Roayaga"', add
label define geo2_mx_lbl 484020513 `"Santo Domingo Tehuantepec"', add
label define geo2_mx_lbl 484020514 `"Santo Domingo Teojomulco"', add
label define geo2_mx_lbl 484020515 `"Santo Domingo Tepuxtepec"', add
label define geo2_mx_lbl 484020516 `"Santo Domingo Tlatayápam"', add
label define geo2_mx_lbl 484020517 `"Santo Domingo Tomaltepec"', add
label define geo2_mx_lbl 484020518 `"Santo Domingo Tonalá"', add
label define geo2_mx_lbl 484020519 `"Santo Domingo Tonaltepec"', add
label define geo2_mx_lbl 484020520 `"Santo Domingo Xagacía"', add
label define geo2_mx_lbl 484020521 `"Santo Domingo Yanhuitlán"', add
label define geo2_mx_lbl 484020522 `"Santo Domingo Yodohino"', add
label define geo2_mx_lbl 484020523 `"Santo Domingo Zanatepec"', add
label define geo2_mx_lbl 484020524 `"Santos Reyes Pápalo"', add
label define geo2_mx_lbl 484020525 `"Santos Reyes Tepejillo"', add
label define geo2_mx_lbl 484020526 `"Santos Reyes Yucuná"', add
label define geo2_mx_lbl 484020527 `"Santo Tomás Jalieza"', add
label define geo2_mx_lbl 484020528 `"Santo Tomás Mazaltepec"', add
label define geo2_mx_lbl 484020529 `"Santo Tomás Ocotepec"', add
label define geo2_mx_lbl 484020530 `"Santo Tomás Tamazulapan"', add
label define geo2_mx_lbl 484020531 `"San Vicente Coatlán"', add
label define geo2_mx_lbl 484020532 `"San Vicente Lachixío"', add
label define geo2_mx_lbl 484020533 `"San Vicente Nuñú"', add
label define geo2_mx_lbl 484020534 `"Silacayoápam"', add
label define geo2_mx_lbl 484020535 `"Sitio de Xitlapehua"', add
label define geo2_mx_lbl 484020536 `"Soledad Etla"', add
label define geo2_mx_lbl 484020537 `"Villa de Tamazulápam del Progreso"', add
label define geo2_mx_lbl 484020538 `"Tanetze de Zaragoza"', add
label define geo2_mx_lbl 484020539 `"Taniche"', add
label define geo2_mx_lbl 484020540 `"Tataltepec de Valdés"', add
label define geo2_mx_lbl 484020541 `"Teococuilco de Marcos Pérez"', add
label define geo2_mx_lbl 484020542 `"Teotitlán del Valle"', add
label define geo2_mx_lbl 484020543 `"Teotongo"', add
label define geo2_mx_lbl 484020544 `"Tepelmeme Villa de Morelos"', add
label define geo2_mx_lbl 484020545 `"Villa Tezoatlán de Segura y Luna, Cuna de la Independencia de Oaxaca, Heroica"', add
label define geo2_mx_lbl 484020546 `"San Jerónimo Tlacochahuaya"', add
label define geo2_mx_lbl 484020547 `"Tlacolula de Matamoros"', add
label define geo2_mx_lbl 484020548 `"Tlacotepec Plumas"', add
label define geo2_mx_lbl 484020549 `"Tlalixtac de Cabrera"', add
label define geo2_mx_lbl 484020550 `"Totontepec Villa de Morelos"', add
label define geo2_mx_lbl 484020551 `"Trinidad Zaachila"', add
label define geo2_mx_lbl 484020552 `"Trinidad Vista Hermosa, La"', add
label define geo2_mx_lbl 484020553 `"Unión Hidalgo"', add
label define geo2_mx_lbl 484020554 `"Valerio Trujano"', add
label define geo2_mx_lbl 484020555 `"San Juan Bautista Valle Nacional"', add
label define geo2_mx_lbl 484020556 `"Villa Díaz Ordaz"', add
label define geo2_mx_lbl 484020557 `"Yaxe"', add
label define geo2_mx_lbl 484020558 `"Magdalena Yodocono de Porfirio Díaz"', add
label define geo2_mx_lbl 484020559 `"Yogana"', add
label define geo2_mx_lbl 484020560 `"Yutanduchi de Guerrero"', add
label define geo2_mx_lbl 484020561 `"Villa de Zaachila"', add
label define geo2_mx_lbl 484020562 `"San Mateo Yucutindoo"', add
label define geo2_mx_lbl 484020563 `"Zapotitlán Lagunas"', add
label define geo2_mx_lbl 484020564 `"Zapotitlán Palmas"', add
label define geo2_mx_lbl 484020565 `"Santa Inés de Zaragoza"', add
label define geo2_mx_lbl 484020566 `"Zimatlán de Álvarez"', add
label define geo2_mx_lbl 484020999 `"Oaxaca [municipality unknown]"', add
label define geo2_mx_lbl 484021001 `"Acajete"', add
label define geo2_mx_lbl 484021002 `"Acateno"', add
label define geo2_mx_lbl 484021003 `"Acatlán"', add
label define geo2_mx_lbl 484021004 `"Acatzingo"', add
label define geo2_mx_lbl 484021005 `"Acteopan"', add
label define geo2_mx_lbl 484021006 `"Ahuacatlán"', add
label define geo2_mx_lbl 484021007 `"Ahuatlán"', add
label define geo2_mx_lbl 484021008 `"Ahuazotepec"', add
label define geo2_mx_lbl 484021009 `"Ahuehuetitla"', add
label define geo2_mx_lbl 484021010 `"Ajalpan"', add
label define geo2_mx_lbl 484021011 `"Albino Zertuche"', add
label define geo2_mx_lbl 484021012 `"Aljojuca"', add
label define geo2_mx_lbl 484021013 `"Altepexi"', add
label define geo2_mx_lbl 484021014 `"Amixtlán"', add
label define geo2_mx_lbl 484021015 `"Amozoc"', add
label define geo2_mx_lbl 484021016 `"Aquixtla"', add
label define geo2_mx_lbl 484021017 `"Atempan"', add
label define geo2_mx_lbl 484021018 `"Atexcal"', add
label define geo2_mx_lbl 484021019 `"Atlixco"', add
label define geo2_mx_lbl 484021020 `"Atoyatempan"', add
label define geo2_mx_lbl 484021021 `"Atzala"', add
label define geo2_mx_lbl 484021022 `"Atzitzihuacán"', add
label define geo2_mx_lbl 484021023 `"Atzitzintla"', add
label define geo2_mx_lbl 484021024 `"Axutla"', add
label define geo2_mx_lbl 484021025 `"Ayotoxco de Guerrero"', add
label define geo2_mx_lbl 484021026 `"Calpan"', add
label define geo2_mx_lbl 484021027 `"Caltepec"', add
label define geo2_mx_lbl 484021028 `"Camocuautla"', add
label define geo2_mx_lbl 484021029 `"Caxhuacan"', add
label define geo2_mx_lbl 484021030 `"Coatepec"', add
label define geo2_mx_lbl 484021031 `"Coatzingo"', add
label define geo2_mx_lbl 484021032 `"Cohetzala"', add
label define geo2_mx_lbl 484021033 `"Cohuecan"', add
label define geo2_mx_lbl 484021034 `"Coronango"', add
label define geo2_mx_lbl 484021035 `"Coxcatlán"', add
label define geo2_mx_lbl 484021036 `"Coyomeapan"', add
label define geo2_mx_lbl 484021037 `"Coyotepec"', add
label define geo2_mx_lbl 484021038 `"Cuapiaxtla de Madero"', add
label define geo2_mx_lbl 484021039 `"Cuautempan"', add
label define geo2_mx_lbl 484021040 `"Cuautinchán"', add
label define geo2_mx_lbl 484021041 `"Cuautlancingo"', add
label define geo2_mx_lbl 484021042 `"Cuayuca de Andrade"', add
label define geo2_mx_lbl 484021043 `"Cuetzalan del Progreso"', add
label define geo2_mx_lbl 484021044 `"Cuyoaco"', add
label define geo2_mx_lbl 484021045 `"Chalchicomula de Sesma"', add
label define geo2_mx_lbl 484021046 `"Chapulco"', add
label define geo2_mx_lbl 484021047 `"Chiautla"', add
label define geo2_mx_lbl 484021048 `"Chiautzingo"', add
label define geo2_mx_lbl 484021049 `"Chiconcuautla"', add
label define geo2_mx_lbl 484021050 `"Chichiquila"', add
label define geo2_mx_lbl 484021051 `"Chietla"', add
label define geo2_mx_lbl 484021052 `"Chigmecatitlán"', add
label define geo2_mx_lbl 484021053 `"Chignahuapan"', add
label define geo2_mx_lbl 484021054 `"Chignautla"', add
label define geo2_mx_lbl 484021055 `"Chila"', add
label define geo2_mx_lbl 484021056 `"Chila de la Sal"', add
label define geo2_mx_lbl 484021057 `"Honey"', add
label define geo2_mx_lbl 484021058 `"Chilchotla"', add
label define geo2_mx_lbl 484021059 `"Chinantla"', add
label define geo2_mx_lbl 484021060 `"Domingo Arenas"', add
label define geo2_mx_lbl 484021061 `"Eloxochitlán"', add
label define geo2_mx_lbl 484021062 `"Epatlán"', add
label define geo2_mx_lbl 484021063 `"Esperanza"', add
label define geo2_mx_lbl 484021064 `"Francisco Z. Mena"', add
label define geo2_mx_lbl 484021065 `"General Felipe Ángeles"', add
label define geo2_mx_lbl 484021066 `"Guadalupe"', add
label define geo2_mx_lbl 484021067 `"Guadalupe Victoria"', add
label define geo2_mx_lbl 484021068 `"Hermenegildo Galeana"', add
label define geo2_mx_lbl 484021069 `"Huaquechula"', add
label define geo2_mx_lbl 484021070 `"Huatlatlauca"', add
label define geo2_mx_lbl 484021071 `"Huauchinango"', add
label define geo2_mx_lbl 484021072 `"Huehuetla"', add
label define geo2_mx_lbl 484021073 `"Huehuetlán el Chico"', add
label define geo2_mx_lbl 484021074 `"Huejotzingo"', add
label define geo2_mx_lbl 484021075 `"Hueyapan"', add
label define geo2_mx_lbl 484021076 `"Hueytamalco"', add
label define geo2_mx_lbl 484021077 `"Hueytlalpan"', add
label define geo2_mx_lbl 484021078 `"Huitzilan de Serdan"', add
label define geo2_mx_lbl 484021079 `"Huitziltepec"', add
label define geo2_mx_lbl 484021080 `"Atlequizayan"', add
label define geo2_mx_lbl 484021081 `"Ixcamilpa de Guerrero"', add
label define geo2_mx_lbl 484021082 `"Ixcaquixtla"', add
label define geo2_mx_lbl 484021083 `"Ixtacamaxtitlán"', add
label define geo2_mx_lbl 484021084 `"Ixtepec"', add
label define geo2_mx_lbl 484021085 `"Izúcar de Matamoros"', add
label define geo2_mx_lbl 484021086 `"Jalpan"', add
label define geo2_mx_lbl 484021087 `"Jolalpan"', add
label define geo2_mx_lbl 484021088 `"Jonotla"', add
label define geo2_mx_lbl 484021089 `"Jopala"', add
label define geo2_mx_lbl 484021090 `"Juan C. Bonilla"', add
label define geo2_mx_lbl 484021091 `"Juan Galindo"', add
label define geo2_mx_lbl 484021092 `"Juan N. Mendez"', add
label define geo2_mx_lbl 484021093 `"Lafragua"', add
label define geo2_mx_lbl 484021094 `"Libres"', add
label define geo2_mx_lbl 484021095 `"Magdalena Tlatlauquitepec, La"', add
label define geo2_mx_lbl 484021096 `"Mazapiltepec de Juárez"', add
label define geo2_mx_lbl 484021097 `"Mixtla"', add
label define geo2_mx_lbl 484021098 `"Molcaxac"', add
label define geo2_mx_lbl 484021099 `"Cañada Morelos"', add
label define geo2_mx_lbl 484021100 `"Naupan"', add
label define geo2_mx_lbl 484021101 `"Nauzontla"', add
label define geo2_mx_lbl 484021102 `"Nealtican"', add
label define geo2_mx_lbl 484021103 `"Nicolás Bravo"', add
label define geo2_mx_lbl 484021104 `"Nopalucan"', add
label define geo2_mx_lbl 484021105 `"Ocotepec"', add
label define geo2_mx_lbl 484021106 `"Ocoyucan"', add
label define geo2_mx_lbl 484021107 `"Olintla"', add
label define geo2_mx_lbl 484021108 `"Oriental"', add
label define geo2_mx_lbl 484021109 `"Pahuatlán"', add
label define geo2_mx_lbl 484021110 `"Palmar de Bravo"', add
label define geo2_mx_lbl 484021111 `"Pantepec"', add
label define geo2_mx_lbl 484021112 `"Petlalcingo"', add
label define geo2_mx_lbl 484021113 `"Piaxtla"', add
label define geo2_mx_lbl 484021114 `"Puebla"', add
label define geo2_mx_lbl 484021115 `"Quecholac"', add
label define geo2_mx_lbl 484021116 `"Quimixtlán"', add
label define geo2_mx_lbl 484021117 `"Rafael Lara Grajales"', add
label define geo2_mx_lbl 484021118 `"Reyes de Juárez, Los"', add
label define geo2_mx_lbl 484021119 `"San Andrés Cholula"', add
label define geo2_mx_lbl 484021120 `"San Antonio Cañada"', add
label define geo2_mx_lbl 484021121 `"San Diego la Mesa Tochimiltzingo"', add
label define geo2_mx_lbl 484021122 `"San Felipe Teotlalcingo"', add
label define geo2_mx_lbl 484021123 `"San Felipe Tepatlán"', add
label define geo2_mx_lbl 484021124 `"San Gabriel Chilac"', add
label define geo2_mx_lbl 484021125 `"San Gregorio Atzompa"', add
label define geo2_mx_lbl 484021126 `"San Jerónimo Tecuanipan"', add
label define geo2_mx_lbl 484021127 `"San Jerónimo Xayacatlán"', add
label define geo2_mx_lbl 484021128 `"San José Chiapa"', add
label define geo2_mx_lbl 484021129 `"San José Miahuatlán"', add
label define geo2_mx_lbl 484021130 `"San Juan Atenco"', add
label define geo2_mx_lbl 484021131 `"San Juan Atzompa"', add
label define geo2_mx_lbl 484021132 `"San Martin Texmelucan"', add
label define geo2_mx_lbl 484021133 `"San Martin Totoltepec"', add
label define geo2_mx_lbl 484021134 `"San Matias Tlalancaleca"', add
label define geo2_mx_lbl 484021135 `"San Miguel Ixitlán"', add
label define geo2_mx_lbl 484021136 `"San Miguel Xoxtla"', add
label define geo2_mx_lbl 484021137 `"San Nicolás Buenos Aires"', add
label define geo2_mx_lbl 484021138 `"San Nicolás de los Ranchos"', add
label define geo2_mx_lbl 484021139 `"San Pablo Anicano"', add
label define geo2_mx_lbl 484021140 `"San Pedro Cholula"', add
label define geo2_mx_lbl 484021141 `"San Pedro Yeloixtlahuaca"', add
label define geo2_mx_lbl 484021142 `"San Salvador el Seco"', add
label define geo2_mx_lbl 484021143 `"San Salvador el Verde"', add
label define geo2_mx_lbl 484021144 `"San Salvador Huixcolotla"', add
label define geo2_mx_lbl 484021145 `"San Sebastián Tlacotepec"', add
label define geo2_mx_lbl 484021146 `"Santa Catarina Tlaltempan"', add
label define geo2_mx_lbl 484021147 `"Santa Inés Ahuatempan"', add
label define geo2_mx_lbl 484021148 `"Santa Isabel Cholula"', add
label define geo2_mx_lbl 484021149 `"Santiago Miahuatlán"', add
label define geo2_mx_lbl 484021150 `"Huehuetlán el Grande"', add
label define geo2_mx_lbl 484021151 `"Santo Tomás Hueyotlipan"', add
label define geo2_mx_lbl 484021152 `"Soltepec"', add
label define geo2_mx_lbl 484021153 `"Tecali de Herrera"', add
label define geo2_mx_lbl 484021154 `"Tecamachalco"', add
label define geo2_mx_lbl 484021155 `"Tecomatlán"', add
label define geo2_mx_lbl 484021156 `"Tehuacán"', add
label define geo2_mx_lbl 484021157 `"Tehuitzingo"', add
label define geo2_mx_lbl 484021158 `"Tenampulco"', add
label define geo2_mx_lbl 484021159 `"Teopantlán"', add
label define geo2_mx_lbl 484021160 `"Teotlalco"', add
label define geo2_mx_lbl 484021161 `"Tepanco de López"', add
label define geo2_mx_lbl 484021162 `"Tepango de Rodríguez"', add
label define geo2_mx_lbl 484021163 `"Tepatlaxco de Hidalgo"', add
label define geo2_mx_lbl 484021164 `"Tepeaca"', add
label define geo2_mx_lbl 484021165 `"Tepemaxalco"', add
label define geo2_mx_lbl 484021166 `"Tepeojuma"', add
label define geo2_mx_lbl 484021167 `"Tepetzintla"', add
label define geo2_mx_lbl 484021168 `"Tepexco"', add
label define geo2_mx_lbl 484021169 `"Tepexi de Rodríguez"', add
label define geo2_mx_lbl 484021170 `"Tepeyahualco"', add
label define geo2_mx_lbl 484021171 `"Tepeyahualco de Cuauhtémoc"', add
label define geo2_mx_lbl 484021172 `"Tetela de Ocampo"', add
label define geo2_mx_lbl 484021173 `"Teteles de Ávila Castillo"', add
label define geo2_mx_lbl 484021174 `"Teziutlán"', add
label define geo2_mx_lbl 484021175 `"Tianguismanalco"', add
label define geo2_mx_lbl 484021176 `"Tilapa"', add
label define geo2_mx_lbl 484021177 `"Tlacotepec de Benito Juárez"', add
label define geo2_mx_lbl 484021178 `"Tlacuilotepec"', add
label define geo2_mx_lbl 484021179 `"Tlachichuca"', add
label define geo2_mx_lbl 484021180 `"Tlahuapan"', add
label define geo2_mx_lbl 484021181 `"Tlaltenango"', add
label define geo2_mx_lbl 484021182 `"Tlanepantla"', add
label define geo2_mx_lbl 484021183 `"Tlaola"', add
label define geo2_mx_lbl 484021184 `"Tlapacoya"', add
label define geo2_mx_lbl 484021185 `"Tlapanalá"', add
label define geo2_mx_lbl 484021186 `"Tlatlauquitepec"', add
label define geo2_mx_lbl 484021187 `"Tlaxco"', add
label define geo2_mx_lbl 484021188 `"Tochimilco"', add
label define geo2_mx_lbl 484021189 `"Tochtepec"', add
label define geo2_mx_lbl 484021190 `"Totoltepec de Guerrero"', add
label define geo2_mx_lbl 484021191 `"Tulcingo"', add
label define geo2_mx_lbl 484021192 `"Tuzamapan de Galeana"', add
label define geo2_mx_lbl 484021193 `"Tzicatlacoyan"', add
label define geo2_mx_lbl 484021194 `"Venustiano Carranza"', add
label define geo2_mx_lbl 484021195 `"Vicente Guerrero"', add
label define geo2_mx_lbl 484021196 `"Xayacatlán de Bravo"', add
label define geo2_mx_lbl 484021197 `"Xicotepec"', add
label define geo2_mx_lbl 484021198 `"Xicotlán"', add
label define geo2_mx_lbl 484021199 `"Xiutetelco"', add
label define geo2_mx_lbl 484021200 `"Xochiapulco"', add
label define geo2_mx_lbl 484021201 `"Xochiltepec"', add
label define geo2_mx_lbl 484021202 `"Xochitlán de Vicente Suárez"', add
label define geo2_mx_lbl 484021203 `"Xochitlán Todos Santos"', add
label define geo2_mx_lbl 484021204 `"Yaonáhuac"', add
label define geo2_mx_lbl 484021205 `"Yehualtepec"', add
label define geo2_mx_lbl 484021206 `"Zacapala"', add
label define geo2_mx_lbl 484021207 `"Zacapoaxtla"', add
label define geo2_mx_lbl 484021208 `"Zacatlán"', add
label define geo2_mx_lbl 484021209 `"Zapotitlán"', add
label define geo2_mx_lbl 484021210 `"Zapotitlán de Méndez"', add
label define geo2_mx_lbl 484021211 `"Zaragoza"', add
label define geo2_mx_lbl 484021212 `"Zautla"', add
label define geo2_mx_lbl 484021213 `"Zihuateutla"', add
label define geo2_mx_lbl 484021214 `"Zinacatepec"', add
label define geo2_mx_lbl 484021215 `"Zongozotla"', add
label define geo2_mx_lbl 484021216 `"Zoquiapan"', add
label define geo2_mx_lbl 484021217 `"Zoquitlán"', add
label define geo2_mx_lbl 484021999 `"Puebla [municipality unknown]"', add
label define geo2_mx_lbl 484022001 `"Amealco de Bonfil"', add
label define geo2_mx_lbl 484022002 `"Pinal de Amoles"', add
label define geo2_mx_lbl 484022003 `"Arroyo Seco"', add
label define geo2_mx_lbl 484022004 `"Cadereyta de Montes"', add
label define geo2_mx_lbl 484022005 `"Colón"', add
label define geo2_mx_lbl 484022006 `"Corregidora"', add
label define geo2_mx_lbl 484022007 `"Ezequiel Montes"', add
label define geo2_mx_lbl 484022008 `"Huimilpan"', add
label define geo2_mx_lbl 484022009 `"Jalpan de Serra"', add
label define geo2_mx_lbl 484022010 `"Landa de Matamoros"', add
label define geo2_mx_lbl 484022011 `"Marqués, El"', add
label define geo2_mx_lbl 484022012 `"Pedro Escobedo"', add
label define geo2_mx_lbl 484022013 `"Peñamiller"', add
label define geo2_mx_lbl 484022014 `"Querétaro"', add
label define geo2_mx_lbl 484022015 `"San Joaquín"', add
label define geo2_mx_lbl 484022016 `"San Juan del Río"', add
label define geo2_mx_lbl 484022017 `"Tequisquiapan"', add
label define geo2_mx_lbl 484022018 `"Tolimán"', add
label define geo2_mx_lbl 484022999 `"Queretaro [municipality unknown]"', add
label define geo2_mx_lbl 484023001 `"Cozumel, Felipe Carrillo Puerto, Isla Mujeres, Othón p. Blanco, Benito Juárez, José Maria Morelos, Lázaro Cardenas, Solidaridad, Tulum, Bacalar"', add
label define geo2_mx_lbl 484023999 `"Quintana Roo [municipality unknown]"', add
label define geo2_mx_lbl 484024001 `"Ahualulco"', add
label define geo2_mx_lbl 484024002 `"Alaquines"', add
label define geo2_mx_lbl 484024003 `"Aquismón"', add
label define geo2_mx_lbl 484024004 `"Armadillo de los Infante"', add
label define geo2_mx_lbl 484024005 `"Cárdenas"', add
label define geo2_mx_lbl 484024006 `"Catorce"', add
label define geo2_mx_lbl 484024007 `"Cedral"', add
label define geo2_mx_lbl 484024008 `"Cerritos"', add
label define geo2_mx_lbl 484024009 `"Cerro de San Pedro"', add
label define geo2_mx_lbl 484024010 `"Ciudad del Maíz, Naranjo, El"', add
label define geo2_mx_lbl 484024011 `"Ciudad Fernández"', add
label define geo2_mx_lbl 484024012 `"Tancanhuitz de Santos"', add
label define geo2_mx_lbl 484024013 `"Ciudad Valles"', add
label define geo2_mx_lbl 484024014 `"Coxcatlán"', add
label define geo2_mx_lbl 484024015 `"Charcas"', add
label define geo2_mx_lbl 484024016 `"Ebano, Tamuín"', add
label define geo2_mx_lbl 484024017 `"Guadalcázar"', add
label define geo2_mx_lbl 484024018 `"Huehuetlán"', add
label define geo2_mx_lbl 484024019 `"Lagunillas"', add
label define geo2_mx_lbl 484024020 `"Matehuala"', add
label define geo2_mx_lbl 484024021 `"Mexquitic de Carmona"', add
label define geo2_mx_lbl 484024022 `"Moctezuma"', add
label define geo2_mx_lbl 484024023 `"Rayón"', add
label define geo2_mx_lbl 484024024 `"Rioverde"', add
label define geo2_mx_lbl 484024025 `"Salinas"', add
label define geo2_mx_lbl 484024026 `"San Antonio"', add
label define geo2_mx_lbl 484024027 `"San Ciro de Acosta"', add
label define geo2_mx_lbl 484024028 `"San Luis Potosí"', add
label define geo2_mx_lbl 484024029 `"San Martín Chalchicuautla"', add
label define geo2_mx_lbl 484024030 `"San Nicolás Tolentino"', add
label define geo2_mx_lbl 484024031 `"Santa Catarina"', add
label define geo2_mx_lbl 484024032 `"Santa María del Río"', add
label define geo2_mx_lbl 484024033 `"Santo Domingo"', add
label define geo2_mx_lbl 484024034 `"San Vicente Tancuayalab"', add
label define geo2_mx_lbl 484024035 `"Soledad de Graciano Sánchez"', add
label define geo2_mx_lbl 484024036 `"Tamasopo"', add
label define geo2_mx_lbl 484024037 `"Tamazunchale, Matlapa"', add
label define geo2_mx_lbl 484024038 `"Tampacán"', add
label define geo2_mx_lbl 484024039 `"Tampamolón Corona"', add
label define geo2_mx_lbl 484024040 `"Tanlajás"', add
label define geo2_mx_lbl 484024041 `"Tanquián de Escobedo"', add
label define geo2_mx_lbl 484024042 `"Tierra Nueva"', add
label define geo2_mx_lbl 484024043 `"Vanegas"', add
label define geo2_mx_lbl 484024044 `"Venado"', add
label define geo2_mx_lbl 484024045 `"Villa de Arriaga"', add
label define geo2_mx_lbl 484024046 `"Villa de Guadalupe"', add
label define geo2_mx_lbl 484024047 `"Villa de la Paz"', add
label define geo2_mx_lbl 484024048 `"Villa de Ramos"', add
label define geo2_mx_lbl 484024049 `"Villa de Reyes"', add
label define geo2_mx_lbl 484024050 `"Villa Hidalgo, Villa de Arista"', add
label define geo2_mx_lbl 484024051 `"Villa Juárez"', add
label define geo2_mx_lbl 484024052 `"Axtla de Terrazas"', add
label define geo2_mx_lbl 484024053 `"Xilitla"', add
label define geo2_mx_lbl 484024054 `"Zaragoza"', add
label define geo2_mx_lbl 484024999 `"San Luis Potosi [municipality unknown]"', add
label define geo2_mx_lbl 484025001 `"Ahome"', add
label define geo2_mx_lbl 484025002 `"Angostura"', add
label define geo2_mx_lbl 484025003 `"Badiraguato"', add
label define geo2_mx_lbl 484025004 `"Concordia"', add
label define geo2_mx_lbl 484025005 `"Cosalá"', add
label define geo2_mx_lbl 484025006 `"Culiacán, Navolato"', add
label define geo2_mx_lbl 484025007 `"Choix"', add
label define geo2_mx_lbl 484025008 `"Elota"', add
label define geo2_mx_lbl 484025009 `"Escuinapa"', add
label define geo2_mx_lbl 484025010 `"Fuerte, El"', add
label define geo2_mx_lbl 484025011 `"Guasave"', add
label define geo2_mx_lbl 484025012 `"Mazatlán"', add
label define geo2_mx_lbl 484025013 `"Mocorito, Salvador Alvarado"', add
label define geo2_mx_lbl 484025014 `"Rosario"', add
label define geo2_mx_lbl 484025015 `"San Ignacio"', add
label define geo2_mx_lbl 484025016 `"Sinaloa"', add
label define geo2_mx_lbl 484025999 `"Sinaloa [municipality unknown]"', add
label define geo2_mx_lbl 484026001 `"Aconchi"', add
label define geo2_mx_lbl 484026002 `"Agua prieta"', add
label define geo2_mx_lbl 484026003 `"Alamos"', add
label define geo2_mx_lbl 484026004 `"Altar"', add
label define geo2_mx_lbl 484026005 `"Arivechi"', add
label define geo2_mx_lbl 484026006 `"Arizpe"', add
label define geo2_mx_lbl 484026007 `"Atil"', add
label define geo2_mx_lbl 484026008 `"Bacadéhuachi"', add
label define geo2_mx_lbl 484026009 `"Bacanora"', add
label define geo2_mx_lbl 484026010 `"Bacerac"', add
label define geo2_mx_lbl 484026011 `"Bacoachi"', add
label define geo2_mx_lbl 484026012 `"Bácum"', add
label define geo2_mx_lbl 484026013 `"Banámichi"', add
label define geo2_mx_lbl 484026014 `"Baviácora"', add
label define geo2_mx_lbl 484026015 `"Bavispe"', add
label define geo2_mx_lbl 484026016 `"Benjamin Hill"', add
label define geo2_mx_lbl 484026017 `"Caborca"', add
label define geo2_mx_lbl 484026018 `"Cajeme"', add
label define geo2_mx_lbl 484026019 `"Cananea"', add
label define geo2_mx_lbl 484026020 `"Carbó"', add
label define geo2_mx_lbl 484026021 `"Colorada, La"', add
label define geo2_mx_lbl 484026022 `"Cucurpe"', add
label define geo2_mx_lbl 484026023 `"Cumpas"', add
label define geo2_mx_lbl 484026024 `"Divisaderos"', add
label define geo2_mx_lbl 484026025 `"Empalme"', add
label define geo2_mx_lbl 484026026 `"Etchojoa, Benito Juárez"', add
label define geo2_mx_lbl 484026027 `"Fronteras"', add
label define geo2_mx_lbl 484026028 `"Granados"', add
label define geo2_mx_lbl 484026029 `"Guaymas, San Ignacio Río Muerto"', add
label define geo2_mx_lbl 484026030 `"Hermosillo"', add
label define geo2_mx_lbl 484026031 `"Huachinera"', add
label define geo2_mx_lbl 484026032 `"Huásabas"', add
label define geo2_mx_lbl 484026033 `"Huatabampo"', add
label define geo2_mx_lbl 484026034 `"Huépac"', add
label define geo2_mx_lbl 484026035 `"Imuris"', add
label define geo2_mx_lbl 484026036 `"Magdalena"', add
label define geo2_mx_lbl 484026037 `"Mazatán"', add
label define geo2_mx_lbl 484026038 `"Moctezuma"', add
label define geo2_mx_lbl 484026039 `"Naco"', add
label define geo2_mx_lbl 484026040 `"Nácori Chico"', add
label define geo2_mx_lbl 484026041 `"Nacozari de García"', add
label define geo2_mx_lbl 484026042 `"Navojoa"', add
label define geo2_mx_lbl 484026043 `"Nogales"', add
label define geo2_mx_lbl 484026044 `"Onavas"', add
label define geo2_mx_lbl 484026045 `"Opodepe"', add
label define geo2_mx_lbl 484026046 `"Oquitoa"', add
label define geo2_mx_lbl 484026047 `"Pitiquito"', add
label define geo2_mx_lbl 484026048 `"Puerto Peñasco, General Plutarco Elías Calles"', add
label define geo2_mx_lbl 484026049 `"Quiriego"', add
label define geo2_mx_lbl 484026050 `"Rayón"', add
label define geo2_mx_lbl 484026051 `"Rosario"', add
label define geo2_mx_lbl 484026052 `"Sahuaripa"', add
label define geo2_mx_lbl 484026053 `"San Felipe de Jesús"', add
label define geo2_mx_lbl 484026054 `"San Javier"', add
label define geo2_mx_lbl 484026055 `"San Luis Río Colorado"', add
label define geo2_mx_lbl 484026056 `"San Miguel de Horcasitas"', add
label define geo2_mx_lbl 484026057 `"San Pedro de la Cueva"', add
label define geo2_mx_lbl 484026058 `"Santa Ana"', add
label define geo2_mx_lbl 484026059 `"Santa Cruz"', add
label define geo2_mx_lbl 484026060 `"Sáric"', add
label define geo2_mx_lbl 484026061 `"Soyopa"', add
label define geo2_mx_lbl 484026062 `"Suaqui Grande"', add
label define geo2_mx_lbl 484026063 `"Tepache"', add
label define geo2_mx_lbl 484026064 `"Trincheras"', add
label define geo2_mx_lbl 484026065 `"Tubutama"', add
label define geo2_mx_lbl 484026066 `"Ures"', add
label define geo2_mx_lbl 484026067 `"Villa Hidalgo"', add
label define geo2_mx_lbl 484026068 `"Villa Pesqueira"', add
label define geo2_mx_lbl 484026069 `"Yécora"', add
label define geo2_mx_lbl 484026999 `"Sonora [municipality unknown]"', add
label define geo2_mx_lbl 484027001 `"Balancán"', add
label define geo2_mx_lbl 484027002 `"Cárdenas"', add
label define geo2_mx_lbl 484027003 `"Centla"', add
label define geo2_mx_lbl 484027004 `"Centro"', add
label define geo2_mx_lbl 484027005 `"Comalcalco"', add
label define geo2_mx_lbl 484027006 `"Cunduacán"', add
label define geo2_mx_lbl 484027007 `"Emiliano Zapata"', add
label define geo2_mx_lbl 484027008 `"Huimanguillo"', add
label define geo2_mx_lbl 484027009 `"Jalapa"', add
label define geo2_mx_lbl 484027010 `"Jalpa de Méndez"', add
label define geo2_mx_lbl 484027011 `"Jonuta"', add
label define geo2_mx_lbl 484027012 `"Macuspana"', add
label define geo2_mx_lbl 484027013 `"Nacajuca"', add
label define geo2_mx_lbl 484027014 `"Paraíso"', add
label define geo2_mx_lbl 484027015 `"Tacotalpa"', add
label define geo2_mx_lbl 484027016 `"Teapa"', add
label define geo2_mx_lbl 484027017 `"Tenosique"', add
label define geo2_mx_lbl 484027999 `"Tabasco [municipality unknown]"', add
label define geo2_mx_lbl 484028001 `"Abasolo"', add
label define geo2_mx_lbl 484028002 `"Aldama"', add
label define geo2_mx_lbl 484028003 `"Altamira"', add
label define geo2_mx_lbl 484028004 `"Antiguo Morelos"', add
label define geo2_mx_lbl 484028005 `"Burgos"', add
label define geo2_mx_lbl 484028006 `"Bustamante"', add
label define geo2_mx_lbl 484028007 `"Camargo"', add
label define geo2_mx_lbl 484028008 `"Casas"', add
label define geo2_mx_lbl 484028009 `"Ciudad Madero"', add
label define geo2_mx_lbl 484028010 `"Cruillas"', add
label define geo2_mx_lbl 484028011 `"Gómez Farías"', add
label define geo2_mx_lbl 484028012 `"González"', add
label define geo2_mx_lbl 484028013 `"Güémez"', add
label define geo2_mx_lbl 484028014 `"Guerrero"', add
label define geo2_mx_lbl 484028015 `"Gustavo Díaz Ordaz, Reynosa, Río Bravo"', add
label define geo2_mx_lbl 484028016 `"Hidalgo"', add
label define geo2_mx_lbl 484028017 `"Jaumave"', add
label define geo2_mx_lbl 484028018 `"Jiménez"', add
label define geo2_mx_lbl 484028019 `"Llera"', add
label define geo2_mx_lbl 484028020 `"Mainero"', add
label define geo2_mx_lbl 484028021 `"Mante, El"', add
label define geo2_mx_lbl 484028022 `"Matamoros"', add
label define geo2_mx_lbl 484028023 `"Méndez"', add
label define geo2_mx_lbl 484028024 `"Mier"', add
label define geo2_mx_lbl 484028025 `"Miguel Alemán"', add
label define geo2_mx_lbl 484028026 `"Miquihuana"', add
label define geo2_mx_lbl 484028027 `"Nuevo Laredo"', add
label define geo2_mx_lbl 484028028 `"Nuevo Morelos"', add
label define geo2_mx_lbl 484028029 `"Ocampo"', add
label define geo2_mx_lbl 484028030 `"Padilla"', add
label define geo2_mx_lbl 484028031 `"Palmillas"', add
label define geo2_mx_lbl 484028032 `"San Carlos"', add
label define geo2_mx_lbl 484028033 `"San Fernando"', add
label define geo2_mx_lbl 484028034 `"San Nicolás"', add
label define geo2_mx_lbl 484028035 `"Soto la Marina"', add
label define geo2_mx_lbl 484028036 `"Tampico"', add
label define geo2_mx_lbl 484028037 `"Tula"', add
label define geo2_mx_lbl 484028038 `"Valle Hermoso"', add
label define geo2_mx_lbl 484028039 `"Victoria"', add
label define geo2_mx_lbl 484028040 `"Villagrán"', add
label define geo2_mx_lbl 484028041 `"Xicoténcatl"', add
label define geo2_mx_lbl 484028999 `"Tamoulipas [municipality unknown]"', add
label define geo2_mx_lbl 484029001 `"Amaxac de Guerrero"', add
label define geo2_mx_lbl 484029002 `"Apetatitlán de Antonio Carvajal"', add
label define geo2_mx_lbl 484029003 `"Atlangatepec"', add
label define geo2_mx_lbl 484029004 `"Altzayanca"', add
label define geo2_mx_lbl 484029005 `"Apizaco"', add
label define geo2_mx_lbl 484029006 `"Calpulalpan"', add
label define geo2_mx_lbl 484029007 `"Carmen Tequexquitla, El"', add
label define geo2_mx_lbl 484029008 `"Cuapiaxtla"', add
label define geo2_mx_lbl 484029009 `"Cuaxomulco"', add
label define geo2_mx_lbl 484029010 `"Chiautempan, Tepeyanco, Magdalena Tlaltelulco, La, San Francisco Tetlanohcan, San Juan Huactzinco, Santa Isabel Xiloxoxtla"', add
label define geo2_mx_lbl 484029011 `"Muñoz de Domingo Arenas"', add
label define geo2_mx_lbl 484029012 `"Españita"', add
label define geo2_mx_lbl 484029013 `"Huamantla"', add
label define geo2_mx_lbl 484029014 `"Hueyotlipan"', add
label define geo2_mx_lbl 484029015 `"Ixtacuixtla de Mariano Matamoros, Santa Ana Nopalucan"', add
label define geo2_mx_lbl 484029016 `"Ixtenco"', add
label define geo2_mx_lbl 484029017 `"Mazatecochco de José María Morelos"', add
label define geo2_mx_lbl 484029018 `"Contla de Juan Cuamatzi"', add
label define geo2_mx_lbl 484029019 `"Tepetitla de Lardizábal"', add
label define geo2_mx_lbl 484029020 `"Sanctórum de Lázaro Cárdenas, Benito Juárez"', add
label define geo2_mx_lbl 484029021 `"Nanacamilpa de Mariano Arista"', add
label define geo2_mx_lbl 484029022 `"Acuamanala de Miguel Hidalgo, Santa Cruz Quilehtla"', add
label define geo2_mx_lbl 484029023 `"Nativitas, Santa Apolonia Teacalco"', add
label define geo2_mx_lbl 484029024 `"Panotla"', add
label define geo2_mx_lbl 484029025 `"San Pablo del Monte"', add
label define geo2_mx_lbl 484029026 `"Santa Cruz Tlaxcala"', add
label define geo2_mx_lbl 484029027 `"Tenancingo"', add
label define geo2_mx_lbl 484029028 `"Teolocholco"', add
label define geo2_mx_lbl 484029029 `"Terrenate, Emiliano Zapata, Lázaro Cárdenas"', add
label define geo2_mx_lbl 484029030 `"Tetla de la Solidaridad"', add
label define geo2_mx_lbl 484029031 `"Tetlatlahuca, San Damián Texóloc, San Jerónimo Zacualpan"', add
label define geo2_mx_lbl 484029032 `"Tlaxcala"', add
label define geo2_mx_lbl 484029033 `"Tlaxco"', add
label define geo2_mx_lbl 484029034 `"Tocatlán"', add
label define geo2_mx_lbl 484029035 `"Totolac"', add
label define geo2_mx_lbl 484029036 `"Ziltlaltépec de Trinidad Sánchez Santos"', add
label define geo2_mx_lbl 484029037 `"Tzompantepec, San José Teacalco"', add
label define geo2_mx_lbl 484029038 `"Xaloztoc"', add
label define geo2_mx_lbl 484029039 `"Xaltocan, San Lucas Tecopilco"', add
label define geo2_mx_lbl 484029040 `"Papalotla de Xicohténcatl"', add
label define geo2_mx_lbl 484029041 `"Xicohtzinco"', add
label define geo2_mx_lbl 484029042 `"Yauhquemecan"', add
label define geo2_mx_lbl 484029043 `"Zacatelco, San Lorenzo Axocomanitla, Santa Catarina Ayometla"', add
label define geo2_mx_lbl 484030001 `"Acajete"', add
label define geo2_mx_lbl 484030002 `"Acatlán"', add
label define geo2_mx_lbl 484030003 `"Acayucan"', add
label define geo2_mx_lbl 484030004 `"Actopan"', add
label define geo2_mx_lbl 484030005 `"Acula"', add
label define geo2_mx_lbl 484030006 `"Acultzingo"', add
label define geo2_mx_lbl 484030007 `"Camarón de Tejeda"', add
label define geo2_mx_lbl 484030008 `"Alpatláhuac"', add
label define geo2_mx_lbl 484030009 `"Alto Lucero de Gutiérrez Barrios"', add
label define geo2_mx_lbl 484030010 `"Altotonga"', add
label define geo2_mx_lbl 484030011 `"Alvarado"', add
label define geo2_mx_lbl 484030012 `"Amatitlán"', add
label define geo2_mx_lbl 484030013 `"Naranjos Amatlán"', add
label define geo2_mx_lbl 484030014 `"Amatlán de los Reyes"', add
label define geo2_mx_lbl 484030015 `"Angel R. Cabada"', add
label define geo2_mx_lbl 484030016 `"Antigua, La"', add
label define geo2_mx_lbl 484030017 `"Apazapan"', add
label define geo2_mx_lbl 484030018 `"Aquila"', add
label define geo2_mx_lbl 484030019 `"Astacinga"', add
label define geo2_mx_lbl 484030020 `"Atlahuilco"', add
label define geo2_mx_lbl 484030021 `"Atoyac"', add
label define geo2_mx_lbl 484030022 `"Atzacan"', add
label define geo2_mx_lbl 484030023 `"Atzalan"', add
label define geo2_mx_lbl 484030024 `"Tlaltetela"', add
label define geo2_mx_lbl 484030025 `"Ayahualulco"', add
label define geo2_mx_lbl 484030026 `"Banderilla"', add
label define geo2_mx_lbl 484030027 `"Benito Juárez"', add
label define geo2_mx_lbl 484030028 `"Boca del Río"', add
label define geo2_mx_lbl 484030029 `"Calcahualco"', add
label define geo2_mx_lbl 484030030 `"Camerino Z. Mendoza"', add
label define geo2_mx_lbl 484030031 `"Carrillo Puerto"', add
label define geo2_mx_lbl 484030032 `"Catemaco"', add
label define geo2_mx_lbl 484030033 `"Cazones"', add
label define geo2_mx_lbl 484030034 `"Cerro azul, Tepetzintla"', add
label define geo2_mx_lbl 484030035 `"Citlaltépetl"', add
label define geo2_mx_lbl 484030036 `"Coacoatzintla"', add
label define geo2_mx_lbl 484030037 `"Coahuitlán"', add
label define geo2_mx_lbl 484030038 `"Coatepec"', add
label define geo2_mx_lbl 484030039 `"Coatzacoalcos, Agua Dulce"', add
label define geo2_mx_lbl 484030040 `"Coatzintla"', add
label define geo2_mx_lbl 484030041 `"Coetzala"', add
label define geo2_mx_lbl 484030042 `"Colipa"', add
label define geo2_mx_lbl 484030043 `"Comapa"', add
label define geo2_mx_lbl 484030044 `"Córdoba"', add
label define geo2_mx_lbl 484030045 `"Cosamaloapan de Carpio, Tres Valles, Carlos A. Carrillo"', add
label define geo2_mx_lbl 484030046 `"Cosautlán de Carvajal"', add
label define geo2_mx_lbl 484030047 `"Coscomatepec"', add
label define geo2_mx_lbl 484030048 `"Cosoleacaque"', add
label define geo2_mx_lbl 484030049 `"Cotaxtla"', add
label define geo2_mx_lbl 484030050 `"Coxquihui"', add
label define geo2_mx_lbl 484030051 `"Coyutla"', add
label define geo2_mx_lbl 484030052 `"Cuichapa"', add
label define geo2_mx_lbl 484030053 `"Cuitláhuac"', add
label define geo2_mx_lbl 484030054 `"Chacaltianguis"', add
label define geo2_mx_lbl 484030055 `"Chalma"', add
label define geo2_mx_lbl 484030056 `"Chiconamel"', add
label define geo2_mx_lbl 484030057 `"Chiconquiaco"', add
label define geo2_mx_lbl 484030058 `"Chicontepec"', add
label define geo2_mx_lbl 484030059 `"Chinameca"', add
label define geo2_mx_lbl 484030060 `"Chinampa de Gorostiza"', add
label define geo2_mx_lbl 484030061 `"Choapas, Las, Hidalgotitlán, Jesus Carranza, Minatitlan, Uxpanapa"', add
label define geo2_mx_lbl 484030062 `"Chocamán"', add
label define geo2_mx_lbl 484030063 `"Chontla"', add
label define geo2_mx_lbl 484030064 `"Chumatlán"', add
label define geo2_mx_lbl 484030065 `"Emiliano Zapata"', add
label define geo2_mx_lbl 484030066 `"Espinal"', add
label define geo2_mx_lbl 484030067 `"Filomeno Mata"', add
label define geo2_mx_lbl 484030068 `"Fortin"', add
label define geo2_mx_lbl 484030069 `"Gutiérrez Zamora"', add
label define geo2_mx_lbl 484030070 `"Huatusco"', add
label define geo2_mx_lbl 484030071 `"Huayacocotla"', add
label define geo2_mx_lbl 484030072 `"Hueyapan de Ocampo"', add
label define geo2_mx_lbl 484030073 `"Huiloapan de Cuauhtémoc"', add
label define geo2_mx_lbl 484030074 `"Ignacio de la Llave"', add
label define geo2_mx_lbl 484030075 `"Ilamatlán"', add
label define geo2_mx_lbl 484030076 `"Isla, Jose Azueta"', add
label define geo2_mx_lbl 484030077 `"Ixcatepec"', add
label define geo2_mx_lbl 484030078 `"Ixhuacán de los Reyes"', add
label define geo2_mx_lbl 484030079 `"Ixhuatlán del Café"', add
label define geo2_mx_lbl 484030080 `"Ixhuatlancillo"', add
label define geo2_mx_lbl 484030081 `"Ixhuatlán del Sureste, Nanchital de Lázaro Cárdenas del Rio"', add
label define geo2_mx_lbl 484030082 `"Ixhuatlán de Madero"', add
label define geo2_mx_lbl 484030083 `"Ixmatlahuacan"', add
label define geo2_mx_lbl 484030084 `"Ixtaczoquitlán"', add
label define geo2_mx_lbl 484030085 `"Jalacingo"', add
label define geo2_mx_lbl 484030086 `"Xalapa"', add
label define geo2_mx_lbl 484030087 `"Jalcomulco"', add
label define geo2_mx_lbl 484030088 `"Jáltipan"', add
label define geo2_mx_lbl 484030089 `"Jamapa"', add
label define geo2_mx_lbl 484030090 `"Xico"', add
label define geo2_mx_lbl 484030091 `"Jilotepec"', add
label define geo2_mx_lbl 484030092 `"Juan Rodríguez Clara, San Juan Evangelista"', add
label define geo2_mx_lbl 484030093 `"Juchique de Ferrer"', add
label define geo2_mx_lbl 484030094 `"Landero y Coss"', add
label define geo2_mx_lbl 484030095 `"Lerdo de Tejada"', add
label define geo2_mx_lbl 484030096 `"Magdalena"', add
label define geo2_mx_lbl 484030097 `"Maltrata"', add
label define geo2_mx_lbl 484030098 `"Manlio Fabio Altamirano"', add
label define geo2_mx_lbl 484030099 `"Mariano Escobedo"', add
label define geo2_mx_lbl 484030100 `"Martínez de la Torre, San Rafael"', add
label define geo2_mx_lbl 484030101 `"Mecatlán"', add
label define geo2_mx_lbl 484030102 `"Mecayapan, Soteapan, Tatahuicapan de Juárez"', add
label define geo2_mx_lbl 484030103 `"Medellín"', add
label define geo2_mx_lbl 484030104 `"Miahuatlán"', add
label define geo2_mx_lbl 484030105 `"Minas, Las"', add
label define geo2_mx_lbl 484030106 `"Misantla"', add
label define geo2_mx_lbl 484030107 `"Mixtla de Altamirano"', add
label define geo2_mx_lbl 484030108 `"Moloacán"', add
label define geo2_mx_lbl 484030109 `"Naolinco"', add
label define geo2_mx_lbl 484030110 `"Naranjal"', add
label define geo2_mx_lbl 484030111 `"Nautla"', add
label define geo2_mx_lbl 484030112 `"Nogales"', add
label define geo2_mx_lbl 484030113 `"Oluta"', add
label define geo2_mx_lbl 484030114 `"Omealca"', add
label define geo2_mx_lbl 484030115 `"Orizaba"', add
label define geo2_mx_lbl 484030116 `"Otatitlán"', add
label define geo2_mx_lbl 484030117 `"Oteapan"', add
label define geo2_mx_lbl 484030118 `"Ozuluama de Mascareñas"', add
label define geo2_mx_lbl 484030119 `"Pajapan"', add
label define geo2_mx_lbl 484030120 `"Pánuco"', add
label define geo2_mx_lbl 484030121 `"Papantla"', add
label define geo2_mx_lbl 484030122 `"Paso del Macho"', add
label define geo2_mx_lbl 484030123 `"Paso de Ovejas"', add
label define geo2_mx_lbl 484030124 `"Perla, La"', add
label define geo2_mx_lbl 484030125 `"Perote"', add
label define geo2_mx_lbl 484030126 `"Platón Sánchez"', add
label define geo2_mx_lbl 484030127 `"Playa Vicente, Santiago Sochiapan"', add
label define geo2_mx_lbl 484030128 `"Poza Rica de Hidalgo"', add
label define geo2_mx_lbl 484030129 `"Vigas de Ramírez, Las"', add
label define geo2_mx_lbl 484030130 `"Pueblo Viejo"', add
label define geo2_mx_lbl 484030131 `"Puente Nacional"', add
label define geo2_mx_lbl 484030132 `"Rafael Delgado"', add
label define geo2_mx_lbl 484030133 `"Rafael lucio"', add
label define geo2_mx_lbl 484030134 `"Reyes, Los"', add
label define geo2_mx_lbl 484030135 `"Río Blanco"', add
label define geo2_mx_lbl 484030136 `"Saltabarranca"', add
label define geo2_mx_lbl 484030137 `"San Andrés Tenejapan"', add
label define geo2_mx_lbl 484030138 `"San Andrés Tuxtla"', add
label define geo2_mx_lbl 484030139 `"Santiago Tuxtla"', add
label define geo2_mx_lbl 484030140 `"Sayula de Alemán"', add
label define geo2_mx_lbl 484030141 `"Soconusco"', add
label define geo2_mx_lbl 484030142 `"Sochiapa"', add
label define geo2_mx_lbl 484030143 `"Soledad Atzompa"', add
label define geo2_mx_lbl 484030144 `"Soledad de Doblado"', add
label define geo2_mx_lbl 484030145 `"Tamalín"', add
label define geo2_mx_lbl 484030146 `"Tamiahua"', add
label define geo2_mx_lbl 484030147 `"Tampico Alto"', add
label define geo2_mx_lbl 484030148 `"Tancoco"', add
label define geo2_mx_lbl 484030149 `"Tantima"', add
label define geo2_mx_lbl 484030150 `"Tantoyuca"', add
label define geo2_mx_lbl 484030151 `"Tatatila"', add
label define geo2_mx_lbl 484030152 `"Castillo de Teayo"', add
label define geo2_mx_lbl 484030153 `"Tecolutla"', add
label define geo2_mx_lbl 484030154 `"Tehuipango"', add
label define geo2_mx_lbl 484030155 `"Álamo Temapache"', add
label define geo2_mx_lbl 484030156 `"Tempoal, Higo, El"', add
label define geo2_mx_lbl 484030157 `"Tenampa"', add
label define geo2_mx_lbl 484030158 `"Tenochtitlán"', add
label define geo2_mx_lbl 484030159 `"Teocelo"', add
label define geo2_mx_lbl 484030160 `"Tepatlaxco"', add
label define geo2_mx_lbl 484030161 `"Tepetlán"', add
label define geo2_mx_lbl 484030162 `"Tequila"', add
label define geo2_mx_lbl 484030163 `"Texcatepec"', add
label define geo2_mx_lbl 484030164 `"Texhuacán"', add
label define geo2_mx_lbl 484030165 `"Texistepec"', add
label define geo2_mx_lbl 484030166 `"Tezonapa, Zongolica"', add
label define geo2_mx_lbl 484030167 `"Tierra Blanca"', add
label define geo2_mx_lbl 484030168 `"Tihuatlán"', add
label define geo2_mx_lbl 484030169 `"Tlacojalpan"', add
label define geo2_mx_lbl 484030170 `"Tlacolulan"', add
label define geo2_mx_lbl 484030171 `"Tlacotalpan"', add
label define geo2_mx_lbl 484030172 `"Tlacotepec de Mejía"', add
label define geo2_mx_lbl 484030173 `"Tlachichilco"', add
label define geo2_mx_lbl 484030174 `"Tlalixcoyan"', add
label define geo2_mx_lbl 484030175 `"Tlalnelhuayocan"', add
label define geo2_mx_lbl 484030176 `"Tlapacoyan"', add
label define geo2_mx_lbl 484030177 `"Tlaquilpa"', add
label define geo2_mx_lbl 484030178 `"Tlilapan"', add
label define geo2_mx_lbl 484030179 `"Tomatlán"', add
label define geo2_mx_lbl 484030180 `"Tonayán"', add
label define geo2_mx_lbl 484030181 `"Totutla"', add
label define geo2_mx_lbl 484030182 `"Tuxpam"', add
label define geo2_mx_lbl 484030183 `"Tuxtilla"', add
label define geo2_mx_lbl 484030184 `"Ursulo Galván"', add
label define geo2_mx_lbl 484030185 `"Vega de Alatorre"', add
label define geo2_mx_lbl 484030186 `"Veracruz"', add
label define geo2_mx_lbl 484030187 `"Villa Aldama"', add
label define geo2_mx_lbl 484030188 `"Xoxocotla"', add
label define geo2_mx_lbl 484030189 `"Yanga"', add
label define geo2_mx_lbl 484030190 `"Yecuatla"', add
label define geo2_mx_lbl 484030191 `"Zacualpan"', add
label define geo2_mx_lbl 484030192 `"Zaragoza"', add
label define geo2_mx_lbl 484030193 `"Zentla"', add
label define geo2_mx_lbl 484030194 `"Zontecomatlan de Lopez y Fuentes"', add
label define geo2_mx_lbl 484030195 `"Zozocolco de Hidalgo"', add
label define geo2_mx_lbl 484030999 `"Veracruz [municipality unknown]"', add
label define geo2_mx_lbl 484031001 `"Abalá"', add
label define geo2_mx_lbl 484031002 `"Acanceh"', add
label define geo2_mx_lbl 484031003 `"Akil"', add
label define geo2_mx_lbl 484031004 `"Baca"', add
label define geo2_mx_lbl 484031005 `"Bokobá"', add
label define geo2_mx_lbl 484031006 `"Buctzotz"', add
label define geo2_mx_lbl 484031007 `"Cacalchén"', add
label define geo2_mx_lbl 484031008 `"Calotmul"', add
label define geo2_mx_lbl 484031009 `"Cansahcab"', add
label define geo2_mx_lbl 484031010 `"Cantamayec"', add
label define geo2_mx_lbl 484031011 `"Celestún"', add
label define geo2_mx_lbl 484031012 `"Cenotillo"', add
label define geo2_mx_lbl 484031013 `"Conkal"', add
label define geo2_mx_lbl 484031014 `"Cuncunul"', add
label define geo2_mx_lbl 484031015 `"Cuzamá"', add
label define geo2_mx_lbl 484031016 `"Chacsinkin"', add
label define geo2_mx_lbl 484031017 `"Chankom"', add
label define geo2_mx_lbl 484031018 `"Chapab"', add
label define geo2_mx_lbl 484031019 `"Chemax"', add
label define geo2_mx_lbl 484031020 `"Chicxulub Pueblo"', add
label define geo2_mx_lbl 484031021 `"Chichimilá"', add
label define geo2_mx_lbl 484031022 `"Chikindzonot"', add
label define geo2_mx_lbl 484031023 `"Chocholá"', add
label define geo2_mx_lbl 484031024 `"Chumayel"', add
label define geo2_mx_lbl 484031025 `"Dzán"', add
label define geo2_mx_lbl 484031026 `"Dzemul"', add
label define geo2_mx_lbl 484031027 `"Dzidzantún"', add
label define geo2_mx_lbl 484031028 `"Dzilam de Bravo"', add
label define geo2_mx_lbl 484031029 `"Dzilam González"', add
label define geo2_mx_lbl 484031030 `"Dzitás"', add
label define geo2_mx_lbl 484031031 `"Dzoncauich"', add
label define geo2_mx_lbl 484031032 `"Espita"', add
label define geo2_mx_lbl 484031033 `"Halachó"', add
label define geo2_mx_lbl 484031034 `"Hocabá"', add
label define geo2_mx_lbl 484031035 `"Hoctún"', add
label define geo2_mx_lbl 484031036 `"Homún"', add
label define geo2_mx_lbl 484031037 `"Huhí"', add
label define geo2_mx_lbl 484031038 `"Hunucmá"', add
label define geo2_mx_lbl 484031039 `"Ixil"', add
label define geo2_mx_lbl 484031040 `"Izamal"', add
label define geo2_mx_lbl 484031041 `"Kanasín"', add
label define geo2_mx_lbl 484031042 `"Kantunil"', add
label define geo2_mx_lbl 484031043 `"Kaua"', add
label define geo2_mx_lbl 484031044 `"Kinchil"', add
label define geo2_mx_lbl 484031045 `"Kopomá"', add
label define geo2_mx_lbl 484031046 `"Mama"', add
label define geo2_mx_lbl 484031047 `"Maní"', add
label define geo2_mx_lbl 484031048 `"Maxcanú"', add
label define geo2_mx_lbl 484031049 `"Mayapán"', add
label define geo2_mx_lbl 484031050 `"Mérida"', add
label define geo2_mx_lbl 484031051 `"Mocochá"', add
label define geo2_mx_lbl 484031052 `"Motul"', add
label define geo2_mx_lbl 484031053 `"Muna"', add
label define geo2_mx_lbl 484031054 `"Muxupip"', add
label define geo2_mx_lbl 484031055 `"Opichén"', add
label define geo2_mx_lbl 484031056 `"Oxkutzcab"', add
label define geo2_mx_lbl 484031057 `"Panabá"', add
label define geo2_mx_lbl 484031058 `"Peto"', add
label define geo2_mx_lbl 484031059 `"Progreso"', add
label define geo2_mx_lbl 484031060 `"Quintana Roo"', add
label define geo2_mx_lbl 484031061 `"Río Lagartos"', add
label define geo2_mx_lbl 484031062 `"Sacalum"', add
label define geo2_mx_lbl 484031063 `"Samahil"', add
label define geo2_mx_lbl 484031064 `"Sanahcat"', add
label define geo2_mx_lbl 484031065 `"San Felipe"', add
label define geo2_mx_lbl 484031066 `"Santa Elena"', add
label define geo2_mx_lbl 484031067 `"Seyé"', add
label define geo2_mx_lbl 484031068 `"Sinanché"', add
label define geo2_mx_lbl 484031069 `"Sotuta"', add
label define geo2_mx_lbl 484031070 `"Sucilá"', add
label define geo2_mx_lbl 484031071 `"Sudzal"', add
label define geo2_mx_lbl 484031072 `"Suma"', add
label define geo2_mx_lbl 484031073 `"Tahdziú"', add
label define geo2_mx_lbl 484031074 `"Tahmek"', add
label define geo2_mx_lbl 484031075 `"Teabo"', add
label define geo2_mx_lbl 484031076 `"Tecoh"', add
label define geo2_mx_lbl 484031077 `"Tekal de Venegas"', add
label define geo2_mx_lbl 484031078 `"Tekantó"', add
label define geo2_mx_lbl 484031079 `"Tekax"', add
label define geo2_mx_lbl 484031080 `"Tekit"', add
label define geo2_mx_lbl 484031081 `"Tekom"', add
label define geo2_mx_lbl 484031082 `"Telchac Pueblo"', add
label define geo2_mx_lbl 484031083 `"Telchac Puerto"', add
label define geo2_mx_lbl 484031084 `"Temax"', add
label define geo2_mx_lbl 484031085 `"Temozón"', add
label define geo2_mx_lbl 484031086 `"Tepakán"', add
label define geo2_mx_lbl 484031087 `"Tetiz"', add
label define geo2_mx_lbl 484031088 `"Teya"', add
label define geo2_mx_lbl 484031089 `"Ticul"', add
label define geo2_mx_lbl 484031090 `"Timucuy"', add
label define geo2_mx_lbl 484031091 `"Tinum"', add
label define geo2_mx_lbl 484031092 `"Tixcacalcupul"', add
label define geo2_mx_lbl 484031093 `"Tixkokob"', add
label define geo2_mx_lbl 484031094 `"Tixmehuac"', add
label define geo2_mx_lbl 484031095 `"Tixpéhual"', add
label define geo2_mx_lbl 484031096 `"Tizimin"', add
label define geo2_mx_lbl 484031097 `"Tunkás"', add
label define geo2_mx_lbl 484031098 `"Tzucacab"', add
label define geo2_mx_lbl 484031099 `"Uayma"', add
label define geo2_mx_lbl 484031100 `"Ucú"', add
label define geo2_mx_lbl 484031101 `"Umán"', add
label define geo2_mx_lbl 484031102 `"Valladolid"', add
label define geo2_mx_lbl 484031103 `"Xocchel"', add
label define geo2_mx_lbl 484031104 `"Yaxcabá"', add
label define geo2_mx_lbl 484031105 `"Yaxkukul"', add
label define geo2_mx_lbl 484031106 `"Yobain"', add
label define geo2_mx_lbl 484032001 `"Apozol"', add
label define geo2_mx_lbl 484032002 `"Apulco"', add
label define geo2_mx_lbl 484032003 `"Atolinga"', add
label define geo2_mx_lbl 484032004 `"Benito Juárez, Teúl de González Ortega, Santa María de la Paz"', add
label define geo2_mx_lbl 484032005 `"Calera, General Enrique Estrada"', add
label define geo2_mx_lbl 484032006 `"Cañitas de Felipe Pescador"', add
label define geo2_mx_lbl 484032007 `"Concepción del Oro, Salvador, El"', add
label define geo2_mx_lbl 484032008 `"Cuauhtémoc"', add
label define geo2_mx_lbl 484032009 `"Chalchihuites"', add
label define geo2_mx_lbl 484032010 `"Fresnillo"', add
label define geo2_mx_lbl 484032011 `"Trinidad García de la Cadena"', add
label define geo2_mx_lbl 484032012 `"Genaro codina"', add
label define geo2_mx_lbl 484032013 `"General Francisco R. Murguía"', add
label define geo2_mx_lbl 484032014 `"Plateado de Joaquín Amaro, El"', add
label define geo2_mx_lbl 484032015 `"General Pánfilo Natera"', add
label define geo2_mx_lbl 484032016 `"Guadalupe, Trancoso"', add
label define geo2_mx_lbl 484032017 `"Huanusco"', add
label define geo2_mx_lbl 484032018 `"Jalpa"', add
label define geo2_mx_lbl 484032019 `"Jerez"', add
label define geo2_mx_lbl 484032020 `"Jiménez del Teul"', add
label define geo2_mx_lbl 484032021 `"Juan aldama"', add
label define geo2_mx_lbl 484032022 `"Juchipila"', add
label define geo2_mx_lbl 484032023 `"Loreto"', add
label define geo2_mx_lbl 484032024 `"Luis Moya"', add
label define geo2_mx_lbl 484032025 `"Mazapil"', add
label define geo2_mx_lbl 484032026 `"Melchor Ocampo"', add
label define geo2_mx_lbl 484032027 `"Mezquital del Oro"', add
label define geo2_mx_lbl 484032028 `"Miguel Auza"', add
label define geo2_mx_lbl 484032029 `"Momax"', add
label define geo2_mx_lbl 484032030 `"Monte Escobedo"', add
label define geo2_mx_lbl 484032031 `"Morelos"', add
label define geo2_mx_lbl 484032032 `"Moyahua de Estrada"', add
label define geo2_mx_lbl 484032033 `"Nochistlán de Mejía"', add
label define geo2_mx_lbl 484032034 `"Noria de Ángeles"', add
label define geo2_mx_lbl 484032035 `"Ojocaliente"', add
label define geo2_mx_lbl 484032036 `"Pánuco"', add
label define geo2_mx_lbl 484032037 `"Pinos"', add
label define geo2_mx_lbl 484032038 `"Río Grande"', add
label define geo2_mx_lbl 484032039 `"Sain Alto"', add
label define geo2_mx_lbl 484032040 `"Sombrerete"', add
label define geo2_mx_lbl 484032041 `"Susticacán"', add
label define geo2_mx_lbl 484032042 `"Tabasco"', add
label define geo2_mx_lbl 484032043 `"Tepechitlán"', add
label define geo2_mx_lbl 484032044 `"Tepetongo"', add
label define geo2_mx_lbl 484032045 `"Tlaltenango de Sánchez Román"', add
label define geo2_mx_lbl 484032046 `"Valparaiso"', add
label define geo2_mx_lbl 484032047 `"Vetagrande"', add
label define geo2_mx_lbl 484032048 `"Villa de Cos"', add
label define geo2_mx_lbl 484032049 `"Villa Garcia"', add
label define geo2_mx_lbl 484032050 `"Villa González Ortega"', add
label define geo2_mx_lbl 484032051 `"Villa Hidalgo"', add
label define geo2_mx_lbl 484032052 `"Villanueva"', add
label define geo2_mx_lbl 484032053 `"Zacatecas"', add
label define geo2_mx_lbl 484032999 `"Zacatecas [municipality unknown]"', add
label values geo2_mx geo2_mx_lbl

label define sizemx_lbl 1 `"Less than 2,500 inhabitants"'
label define sizemx_lbl 2 `"2,500 to 14,999 inhabitants"', add
label define sizemx_lbl 3 `"15,000 to 99,999 inhabitants"', add
label define sizemx_lbl 4 `"100,000 or more inhabitants"', add
label values sizemx sizemx_lbl

label define ownership_lbl 0 `"NIU (not in universe)"'
label define ownership_lbl 1 `"Owned"', add
label define ownership_lbl 2 `"Not owned"', add
label define ownership_lbl 9 `"Unknown"', add
label values ownership ownership_lbl

label define ownershipd_lbl 000 `"NIU (not in universe)"'
label define ownershipd_lbl 100 `"Owned"', add
label define ownershipd_lbl 110 `"Owned, already paid"', add
label define ownershipd_lbl 120 `"Owned, still paying"', add
label define ownershipd_lbl 130 `"Owned, constructed"', add
label define ownershipd_lbl 140 `"Owned, inherited"', add
label define ownershipd_lbl 190 `"Owned, other"', add
label define ownershipd_lbl 191 `"Owned, house"', add
label define ownershipd_lbl 192 `"Owned, condominium"', add
label define ownershipd_lbl 193 `"Apartment proprietor"', add
label define ownershipd_lbl 194 `"Shared ownership"', add
label define ownershipd_lbl 200 `"Not owned"', add
label define ownershipd_lbl 210 `"Renting, not specified"', add
label define ownershipd_lbl 211 `"Renting, government"', add
label define ownershipd_lbl 212 `"Renting, local authority"', add
label define ownershipd_lbl 213 `"Renting, parastatal"', add
label define ownershipd_lbl 214 `"Renting, private"', add
label define ownershipd_lbl 215 `"Renting, private company"', add
label define ownershipd_lbl 216 `"Renting, individual"', add
label define ownershipd_lbl 217 `"Renting, collective"', add
label define ownershipd_lbl 218 `"Renting, joint state and individual"', add
label define ownershipd_lbl 219 `"Renting, public subsidized"', add
label define ownershipd_lbl 220 `"Renting, private subsidized"', add
label define ownershipd_lbl 221 `"Renting, co-tenant"', add
label define ownershipd_lbl 222 `"Renting, relative of tenant"', add
label define ownershipd_lbl 223 `"Renting, cooperative"', add
label define ownershipd_lbl 224 `"Renting, with a job or business"', add
label define ownershipd_lbl 225 `"Renting, loan-backed habitation"', add
label define ownershipd_lbl 226 `"Renting, mixed contract"', add
label define ownershipd_lbl 227 `"Furnished dwelling"', add
label define ownershipd_lbl 228 `"Sharecropping"', add
label define ownershipd_lbl 230 `"Subletting"', add
label define ownershipd_lbl 231 `"Rent to own"', add
label define ownershipd_lbl 239 `"Renting, other"', add
label define ownershipd_lbl 240 `"Occupied de facto/squatting"', add
label define ownershipd_lbl 250 `"Free/usufruct (no cash rent)"', add
label define ownershipd_lbl 251 `"Free, provided by employer"', add
label define ownershipd_lbl 252 `"Free, without work or services"', add
label define ownershipd_lbl 253 `"Free, provided by family or friend"', add
label define ownershipd_lbl 254 `"Free, private"', add
label define ownershipd_lbl 255 `"Free, public"', add
label define ownershipd_lbl 256 `"Free, condemned"', add
label define ownershipd_lbl 257 `"Free, other"', add
label define ownershipd_lbl 290 `"Not owned, other"', add
label define ownershipd_lbl 999 `"Unknown"', add
label values ownershipd ownershipd_lbl

label define intmig2_lbl 00 `"No international migrants"'
label define intmig2_lbl 01 `"1 migrant"', add
label define intmig2_lbl 02 `"2 migrants"', add
label define intmig2_lbl 03 `"3 migrants"', add
label define intmig2_lbl 04 `"4 migrants"', add
label define intmig2_lbl 05 `"5 migrants"', add
label define intmig2_lbl 06 `"6 migrants"', add
label define intmig2_lbl 07 `"7 migrants"', add
label define intmig2_lbl 08 `"8 migrants"', add
label define intmig2_lbl 09 `"9 migrants"', add
label define intmig2_lbl 10 `"10 migrants"', add
label define intmig2_lbl 11 `"11 migrants"', add
label define intmig2_lbl 12 `"12 migrants"', add
label define intmig2_lbl 13 `"13 migrants"', add
label define intmig2_lbl 15 `"15 migrants"', add
label define intmig2_lbl 99 `"Unknown/missing"', add
label values intmig2 intmig2_lbl

label define electric_lbl 0 `"NIU (not in universe)"'
label define electric_lbl 1 `"Yes"', add
label define electric_lbl 2 `"No"', add
label define electric_lbl 9 `"Unknown"', add
label values electric electric_lbl

label define watsup_lbl 00 `"NIU (not in universe)"'
label define watsup_lbl 10 `"Yes, piped water"', add
label define watsup_lbl 11 `"Piped inside dwelling"', add
label define watsup_lbl 12 `"Piped, exclusively to this household"', add
label define watsup_lbl 13 `"Piped, shared with other households"', add
label define watsup_lbl 14 `"Piped outside the dwelling"', add
label define watsup_lbl 15 `"Piped outside dwelling, in building"', add
label define watsup_lbl 16 `"Piped within the building or plot of land"', add
label define watsup_lbl 17 `"Piped outside the building or lot"', add
label define watsup_lbl 18 `"Have access to public piped water"', add
label define watsup_lbl 20 `"No piped water"', add
label define watsup_lbl 99 `"Unknown"', add
label values watsup watsup_lbl

label define sewage_lbl 00 `"NIU (not in universe)"'
label define sewage_lbl 10 `"Connected to sewage system or septic tank"', add
label define sewage_lbl 11 `"Sewage system (public sewage disposal)"', add
label define sewage_lbl 12 `"Septic tank (private sewage disposal)"', add
label define sewage_lbl 20 `"Not connected to sewage disposal system"', add
label define sewage_lbl 99 `"Unknown"', add
label values sewage sewage_lbl

label define fuelcook_lbl 00 `"NIU (not in universe)"'
label define fuelcook_lbl 10 `"None"', add
label define fuelcook_lbl 20 `"Electricity"', add
label define fuelcook_lbl 30 `"Petroleum gas, unspecified"', add
label define fuelcook_lbl 31 `"Gas -- piped/utility"', add
label define fuelcook_lbl 32 `"Gas -- tanked or bottled"', add
label define fuelcook_lbl 33 `"Propane"', add
label define fuelcook_lbl 35 `"Liquefied petroleum gas"', add
label define fuelcook_lbl 40 `"Petroleum liquid"', add
label define fuelcook_lbl 41 `"Oil, kerosene, and other liquid fuels"', add
label define fuelcook_lbl 42 `"Kerosene/paraffin"', add
label define fuelcook_lbl 43 `"Kerosene or oil"', add
label define fuelcook_lbl 44 `"Kerosene or gasoline"', add
label define fuelcook_lbl 45 `"Gasoline"', add
label define fuelcook_lbl 46 `"Cocinol"', add
label define fuelcook_lbl 47 `"Diesel"', add
label define fuelcook_lbl 50 `"Wood, coal, and other solid fuels"', add
label define fuelcook_lbl 51 `"Wood and other plant fuels"', add
label define fuelcook_lbl 52 `"Non-wood plant materials"', add
label define fuelcook_lbl 53 `"Coal or charcoal"', add
label define fuelcook_lbl 54 `"Charcoal"', add
label define fuelcook_lbl 55 `"Coal"', add
label define fuelcook_lbl 56 `"Wood or charcoal"', add
label define fuelcook_lbl 60 `"Multiple fuels"', add
label define fuelcook_lbl 61 `"Bottled gas and wood"', add
label define fuelcook_lbl 62 `"Propane and electricity"', add
label define fuelcook_lbl 63 `"Propane, kerosene, and electricity"', add
label define fuelcook_lbl 64 `"Propane and kerosene"', add
label define fuelcook_lbl 65 `"Kerosene and electrictiy"', add
label define fuelcook_lbl 66 `"Other combinations"', add
label define fuelcook_lbl 70 `"Other"', add
label define fuelcook_lbl 71 `"Alcohol"', add
label define fuelcook_lbl 72 `"Biogas"', add
label define fuelcook_lbl 73 `"Discarded or waste material"', add
label define fuelcook_lbl 74 `"Dung/manure"', add
label define fuelcook_lbl 75 `"Other combined organic waste materials"', add
label define fuelcook_lbl 76 `"Solar energy"', add
label define fuelcook_lbl 77 `"Candle"', add
label define fuelcook_lbl 99 `"Unknown/missing"', add
label values fuelcook fuelcook_lbl

label define rooms_lbl 00 `"Part of a room; no rooms"'
label define rooms_lbl 01 `"1"', add
label define rooms_lbl 02 `"2"', add
label define rooms_lbl 03 `"3"', add
label define rooms_lbl 04 `"4"', add
label define rooms_lbl 05 `"5"', add
label define rooms_lbl 06 `"6"', add
label define rooms_lbl 07 `"7"', add
label define rooms_lbl 08 `"8"', add
label define rooms_lbl 09 `"9"', add
label define rooms_lbl 10 `"10"', add
label define rooms_lbl 11 `"11"', add
label define rooms_lbl 12 `"12"', add
label define rooms_lbl 13 `"13"', add
label define rooms_lbl 14 `"14"', add
label define rooms_lbl 15 `"15"', add
label define rooms_lbl 16 `"16"', add
label define rooms_lbl 17 `"17"', add
label define rooms_lbl 18 `"18"', add
label define rooms_lbl 19 `"19"', add
label define rooms_lbl 20 `"20"', add
label define rooms_lbl 21 `"21"', add
label define rooms_lbl 22 `"22"', add
label define rooms_lbl 23 `"23"', add
label define rooms_lbl 24 `"24"', add
label define rooms_lbl 25 `"25"', add
label define rooms_lbl 26 `"26"', add
label define rooms_lbl 27 `"27"', add
label define rooms_lbl 28 `"28"', add
label define rooms_lbl 29 `"29"', add
label define rooms_lbl 30 `"30+"', add
label define rooms_lbl 98 `"Unknown"', add
label define rooms_lbl 99 `"NIU (not in universe)"', add
label values rooms rooms_lbl

label define bedrooms_lbl 00 `"No bedrooms"'
label define bedrooms_lbl 01 `"1"', add
label define bedrooms_lbl 02 `"2"', add
label define bedrooms_lbl 03 `"3"', add
label define bedrooms_lbl 04 `"4"', add
label define bedrooms_lbl 05 `"5"', add
label define bedrooms_lbl 06 `"6"', add
label define bedrooms_lbl 07 `"7"', add
label define bedrooms_lbl 08 `"8"', add
label define bedrooms_lbl 09 `"9"', add
label define bedrooms_lbl 10 `"10"', add
label define bedrooms_lbl 11 `"11"', add
label define bedrooms_lbl 12 `"12"', add
label define bedrooms_lbl 13 `"13"', add
label define bedrooms_lbl 14 `"14"', add
label define bedrooms_lbl 15 `"15"', add
label define bedrooms_lbl 16 `"16"', add
label define bedrooms_lbl 17 `"17"', add
label define bedrooms_lbl 18 `"18"', add
label define bedrooms_lbl 19 `"19"', add
label define bedrooms_lbl 20 `"20+"', add
label define bedrooms_lbl 98 `"Unknown"', add
label define bedrooms_lbl 99 `"NIU (not in universe)"', add
label values bedrooms bedrooms_lbl

label define kitchen_lbl 00 `"NIU (not in universe)"'
label define kitchen_lbl 10 `"No kitchen"', add
label define kitchen_lbl 11 `"Food is prepared in a non-kitchen room"', add
label define kitchen_lbl 13 `"Does not prepare food in the dwelling"', add
label define kitchen_lbl 20 `"Yes, have a kitchen"', add
label define kitchen_lbl 21 `"Kitchen located inside the dwelling"', add
label define kitchen_lbl 22 `"Indoor kitchen, exclusive use"', add
label define kitchen_lbl 23 `"Indoor kitchen, shared use"', add
label define kitchen_lbl 24 `"Exclusive use of kitchen (indoor/outdoor status not specified)"', add
label define kitchen_lbl 25 `"Kitchen shared with another household (indoor/outdoor status not specified)"', add
label define kitchen_lbl 26 `"Kitchen located outside the dwelling"', add
label define kitchen_lbl 27 `"Outdoor kitchen, exclusive use"', add
label define kitchen_lbl 28 `"Outdoor kitchen, shared use"', add
label define kitchen_lbl 99 `"Unknown/missing"', add
label values kitchen kitchen_lbl

label define toilet_lbl 00 `"NIU (not in universe)"'
label define toilet_lbl 10 `"No toilet"', add
label define toilet_lbl 11 `"No flush toilet"', add
label define toilet_lbl 20 `"Have toilet, type not specified"', add
label define toilet_lbl 21 `"Flush toilet"', add
label define toilet_lbl 22 `"Non-flush, latrine"', add
label define toilet_lbl 23 `"Non-flush, other and unspecified"', add
label define toilet_lbl 99 `"Unknown"', add
label values toilet toilet_lbl

label define floor_lbl 000 `"NIU (not in universe)"'
label define floor_lbl 100 `"None/unfinished (earth)"', add
label define floor_lbl 110 `"Sand"', add
label define floor_lbl 120 `"Dung"', add
label define floor_lbl 200 `"Finished"', add
label define floor_lbl 201 `"Cement, tile, or brick"', add
label define floor_lbl 202 `"Cement"', add
label define floor_lbl 203 `"Concrete"', add
label define floor_lbl 204 `"Cement screed"', add
label define floor_lbl 205 `"Ceramic tile"', add
label define floor_lbl 206 `"Paving stone, cement tile"', add
label define floor_lbl 207 `"Stone"', add
label define floor_lbl 208 `"Brick"', add
label define floor_lbl 209 `"Brick or stone"', add
label define floor_lbl 210 `"Brick or cement"', add
label define floor_lbl 211 `"Block"', add
label define floor_lbl 212 `"Terrazzo"', add
label define floor_lbl 213 `"Wood"', add
label define floor_lbl 214 `"Palm, bamboo"', add
label define floor_lbl 215 `"Parquet"', add
label define floor_lbl 216 `"Parquet, tile, vinyl"', add
label define floor_lbl 217 `"Parquet, tile, marble"', add
label define floor_lbl 218 `"Ceramic, marble, granite"', add
label define floor_lbl 219 `"Ceramic, marble, tile, or vinyl"', add
label define floor_lbl 220 `"Marble"', add
label define floor_lbl 221 `"Mosaic"', add
label define floor_lbl 222 `"Tile"', add
label define floor_lbl 223 `"Tile, linoleum, ceramic, etc"', add
label define floor_lbl 224 `"Tile, cement"', add
label define floor_lbl 225 `"Tile, stone"', add
label define floor_lbl 226 `"Tile, stone, brick"', add
label define floor_lbl 227 `"Tile, stone, vinyl, brick"', add
label define floor_lbl 228 `"Tile, vinyl, brick"', add
label define floor_lbl 229 `"Tile, vinyl"', add
label define floor_lbl 230 `"Vinyl, linoleum, etc"', add
label define floor_lbl 231 `"Asphalt sheet, vinyl, etc"', add
label define floor_lbl 232 `"Synthetic, plastic"', add
label define floor_lbl 233 `"Cane"', add
label define floor_lbl 234 `"Carpet"', add
label define floor_lbl 235 `"Scrap material"', add
label define floor_lbl 236 `"Other finished, n.e.c."', add
label define floor_lbl 999 `"Unknown/missing"', add
label values floor floor_lbl

label define wall_lbl 000 `"NIU (not in universe)"'
label define wall_lbl 100 `"No walls"', add
label define wall_lbl 200 `"Cardboard, scrap, and miscellaneous materials"', add
label define wall_lbl 201 `"Waste, scrap, or discarded material"', add
label define wall_lbl 202 `"Fabric or discarded material"', add
label define wall_lbl 203 `"Zinc, fabric, cardboard, tins, and waste material"', add
label define wall_lbl 204 `"Cardboard sheet"', add
label define wall_lbl 205 `"Plastic sheeting, cardboard"', add
label define wall_lbl 206 `"Makeshift, salvaged, or improvised materials"', add
label define wall_lbl 207 `"Reused materials"', add
label define wall_lbl 300 `"Wood"', add
label define wall_lbl 310 `"Rough wood"', add
label define wall_lbl 320 `"Wood, fibercement or plywood"', add
label define wall_lbl 330 `"Wood, formica, and other"', add
label define wall_lbl 340 `"Wood or bamboo"', add
label define wall_lbl 350 `"Wood or straw"', add
label define wall_lbl 400 `"Other plant-based materials"', add
label define wall_lbl 401 `"Plantain leaves and similar material"', add
label define wall_lbl 402 `"Bamboo or cane"', add
label define wall_lbl 403 `"Bamboo, sawali, cogon, nipa"', add
label define wall_lbl 404 `"Straw or bamboo"', add
label define wall_lbl 405 `"Grass, straw or reed"', add
label define wall_lbl 406 `"Reed, bamboo, or palm"', add
label define wall_lbl 407 `"Cane, palm leaves, logs"', add
label define wall_lbl 408 `"Palm leaves or palm planks"', add
label define wall_lbl 500 `"Masonry, stone, cement, adobe, metal, glass, and other fabricated materials (sometimes mixed with wood)"', add
label define wall_lbl 501 `"Brick, block, stone, or cement"', add
label define wall_lbl 502 `"Brick, stone, concrete"', add
label define wall_lbl 503 `"Brick, stone, or substitutes (dividing panels made of reinforced concrete)"', add
label define wall_lbl 504 `"Brick, stone, or substitutes (dividing panels made of wood)"', add
label define wall_lbl 505 `"Brick or tile"', add
label define wall_lbl 506 `"Brick or stone"', add
label define wall_lbl 507 `"Brick or cement block"', add
label define wall_lbl 508 `"Brick with plaster exterior"', add
label define wall_lbl 509 `"Brick without plaster exterior"', add
label define wall_lbl 510 `"Burnt or stabilized brick"', add
label define wall_lbl 511 `"Brick"', add
label define wall_lbl 512 `"Unburnt brick"', add
label define wall_lbl 513 `"Unburnt brick with cement"', add
label define wall_lbl 514 `"Unburnt brick with mud"', add
label define wall_lbl 515 `"Concrete"', add
label define wall_lbl 516 `"Landcrete"', add
label define wall_lbl 517 `"Cement blocks"', add
label define wall_lbl 518 `"Cement blocks or brick"', add
label define wall_lbl 519 `"Cement blocks or brick, unfinished"', add
label define wall_lbl 520 `"Cement and adobe bricks"', add
label define wall_lbl 521 `"Cement and stone block"', add
label define wall_lbl 522 `"Reinforced concrete, pre-cast concrete panels, or steel skeleton framed concrete"', add
label define wall_lbl 523 `"Concrete, reinforced concrete, blocks, panels"', add
label define wall_lbl 524 `"Adobe"', add
label define wall_lbl 525 `"Adobe walls with plaster exterior"', add
label define wall_lbl 526 `"Adobe walls without plaster exterior"', add
label define wall_lbl 527 `"Adobe with cement exterior"', add
label define wall_lbl 528 `"Adobe (tabique, quinche)"', add
label define wall_lbl 529 `"Wood and earth adobe"', add
label define wall_lbl 530 `"Wood and cement adobe"', add
label define wall_lbl 531 `"Mud or adobe"', add
label define wall_lbl 532 `"Pressed dirt"', add
label define wall_lbl 533 `"Clay"', add
label define wall_lbl 534 `"Coated clay/mud with sticks/cane"', add
label define wall_lbl 535 `"Clay or clay-covered sticks"', add
label define wall_lbl 536 `"Netted bamboo or cane with mud"', add
label define wall_lbl 537 `"Bundle of mud, straw, other materials"', add
label define wall_lbl 538 `"Mud with wood/wattle"', add
label define wall_lbl 539 `"Pole and mud"', add
label define wall_lbl 540 `"Mud with cement"', add
label define wall_lbl 541 `"Unfinished lathe and plaster, stucco, etc."', add
label define wall_lbl 542 `"Stone"', add
label define wall_lbl 543 `"Hand-laid stone"', add
label define wall_lbl 544 `"Quarried stone"', add
label define wall_lbl 545 `"Cut stone and concrete"', add
label define wall_lbl 546 `"Cemented stone"', add
label define wall_lbl 547 `"Stone with clay"', add
label define wall_lbl 548 `"Blocks of light material"', add
label define wall_lbl 549 `"Prefabricated material"', add
label define wall_lbl 550 `"Asbestos"', add
label define wall_lbl 551 `"Metal or asbestos sheet"', add
label define wall_lbl 552 `"Metal or iron sheet"', add
label define wall_lbl 553 `"Metal or fibercement sheeting"', add
label define wall_lbl 554 `"Galvanized iron or aluminum"', add
label define wall_lbl 555 `"Tin"', add
label define wall_lbl 556 `"Glass"', add
label define wall_lbl 557 `"Cloth"', add
label define wall_lbl 558 `"Covintec panels"', add
label define wall_lbl 559 `"Mixed material"', add
label define wall_lbl 560 `"Mixed material: part wood; part concrete, brick, or stone"', add
label define wall_lbl 561 `"Wood plastered with clay, adobe, other materials; wood pressed panels; rolled mud bricks; etc."', add
label define wall_lbl 562 `"Mixed material: wood or galvanized metal"', add
label define wall_lbl 570 `"Mainly permanent materials"', add
label define wall_lbl 600 `"Other material"', add
label define wall_lbl 999 `"Unknown/missing"', add
label values wall wall_lbl

label define roof_lbl 00 `"NIU (not in universe)"'
label define roof_lbl 10 `"Masonry, concrete, clay tile, or tiles of unspecified type"', add
label define roof_lbl 11 `"Concrete or cement"', add
label define roof_lbl 12 `"Reinforced concrete (slab)"', add
label define roof_lbl 13 `"Cement or sheet metal"', add
label define roof_lbl 14 `"Tile, unspecified"', add
label define roof_lbl 15 `"Clay tile"', add
label define roof_lbl 16 `"Tile or cement"', add
label define roof_lbl 17 `"Modern tiles, industrial"', add
label define roof_lbl 18 `"Traditional tiles, locally made"', add
label define roof_lbl 19 `"Tile or flat stone"', add
label define roof_lbl 20 `"Fibercement or plastic"', add
label define roof_lbl 21 `"Asphalt or laminate cover"', add
label define roof_lbl 22 `"Tile, cement, asphalt"', add
label define roof_lbl 23 `"Asphalt tile"', add
label define roof_lbl 24 `"Slate or tile"', add
label define roof_lbl 25 `"Slate or asbestos"', add
label define roof_lbl 26 `"Asbestos"', add
label define roof_lbl 27 `"Adobe"', add
label define roof_lbl 28 `"Tiles or wood planks"', add
label define roof_lbl 29 `"Roofing shingles"', add
label define roof_lbl 30 `"Metal"', add
label define roof_lbl 31 `"Sheet metal"', add
label define roof_lbl 32 `"Zinc or tin"', add
label define roof_lbl 33 `"Tin"', add
label define roof_lbl 34 `"Sheet metal or other sheet material"', add
label define roof_lbl 35 `"Sheet metal, tile, slate"', add
label define roof_lbl 40 `"Wood and other plant materials"', add
label define roof_lbl 41 `"Wood"', add
label define roof_lbl 42 `"Wood, including bamboo"', add
label define roof_lbl 43 `"Bamboo"', add
label define roof_lbl 44 `"Cogon, nipa, anahaw"', add
label define roof_lbl 45 `"Thatch (straw, grass, leaves, palm, etc.)"', add
label define roof_lbl 46 `"Cane, wood, straw"', add
label define roof_lbl 47 `"Grass"', add
label define roof_lbl 48 `"Papyrus"', add
label define roof_lbl 49 `"Banana leaves or fiber"', add
label define roof_lbl 50 `"Palm or makuti"', add
label define roof_lbl 51 `"Wood with clay"', add
label define roof_lbl 52 `"Grass and mud"', add
label define roof_lbl 53 `"Straw, bamboo, polythene"', add
label define roof_lbl 54 `"Rustic mat"', add
label define roof_lbl 60 `"Mud or earth"', add
label define roof_lbl 61 `"Clay"', add
label define roof_lbl 70 `"Cardboard, scrap, and miscellaneous materials"', add
label define roof_lbl 71 `"Discarded or scrap material"', add
label define roof_lbl 72 `"Cardboard"', add
label define roof_lbl 73 `"Plastic"', add
label define roof_lbl 80 `"Other, unspecified"', add
label define roof_lbl 90 `"No roof"', add
label define roof_lbl 99 `"Unknown/missing"', add
label values roof roof_lbl

label define hhtype_lbl 00 `"Vacant household"'
label define hhtype_lbl 01 `"One-person household"', add
label define hhtype_lbl 02 `"Married/cohab couple, no children"', add
label define hhtype_lbl 03 `"Married/cohab couple with children"', add
label define hhtype_lbl 04 `"Single-parent family"', add
label define hhtype_lbl 05 `"Polygamous family"', add
label define hhtype_lbl 06 `"Extended family, relatives only"', add
label define hhtype_lbl 07 `"Composite household, family and non-relatives"', add
label define hhtype_lbl 08 `"Non-family household"', add
label define hhtype_lbl 09 `"Unclassified subfamily"', add
label define hhtype_lbl 10 `"Other relative or non-relative household"', add
label define hhtype_lbl 11 `"Group quarters"', add
label define hhtype_lbl 99 `"Unclassifiable"', add
label values hhtype hhtype_lbl

label define nfams_lbl 0 `"Vacant household"'
label define nfams_lbl 1 `"1 family"', add
label define nfams_lbl 2 `"2 families"', add
label define nfams_lbl 3 `"3 families"', add
label define nfams_lbl 4 `"4 families"', add
label define nfams_lbl 5 `"5 families"', add
label define nfams_lbl 6 `"6 families"', add
label define nfams_lbl 7 `"7 families"', add
label define nfams_lbl 8 `"8 families"', add
label define nfams_lbl 9 `"9 or more families"', add
label values nfams nfams_lbl

label define relate_lbl 1 `"Head"'
label define relate_lbl 2 `"Spouse/partner"', add
label define relate_lbl 3 `"Child"', add
label define relate_lbl 4 `"Other relative"', add
label define relate_lbl 5 `"Non-relative"', add
label define relate_lbl 6 `"Other relative or non-relative"', add
label define relate_lbl 9 `"Unknown"', add
label values relate relate_lbl

label define related_lbl 1000 `"Head"'
label define related_lbl 2000 `"Spouse/partner"', add
label define related_lbl 2100 `"Spouse"', add
label define related_lbl 2200 `"Unmarried partner"', add
label define related_lbl 2300 `"Same-sex spouse/partner"', add
label define related_lbl 3000 `"Child"', add
label define related_lbl 3100 `"Biological child"', add
label define related_lbl 3200 `"Adopted child"', add
label define related_lbl 3300 `"Stepchild"', add
label define related_lbl 3400 `"Child/child-in-law"', add
label define related_lbl 3500 `"Child/child-in-law/grandchild"', add
label define related_lbl 3600 `"Child of unmarried partner"', add
label define related_lbl 4000 `"Other relative"', add
label define related_lbl 4100 `"Grandchild"', add
label define related_lbl 4110 `"Grandchild or great grandchild"', add
label define related_lbl 4120 `"Great grandchild"', add
label define related_lbl 4130 `"Great-great grandchild"', add
label define related_lbl 4200 `"Parent/parent-in-law"', add
label define related_lbl 4210 `"Parent"', add
label define related_lbl 4211 `"Stepparent"', add
label define related_lbl 4220 `"Parent-in-law"', add
label define related_lbl 4300 `"Child-in-law"', add
label define related_lbl 4301 `"Daughter-in-law"', add
label define related_lbl 4302 `"Spouse/partner of child"', add
label define related_lbl 4310 `"Unmarried partner of child"', add
label define related_lbl 4400 `"Sibling/sibling-in-law"', add
label define related_lbl 4410 `"Sibling"', add
label define related_lbl 4420 `"Stepsibling"', add
label define related_lbl 4430 `"Sibling-in-law"', add
label define related_lbl 4431 `"Sibling of spouse/partner"', add
label define related_lbl 4432 `"Spouse/partner of sibling"', add
label define related_lbl 4500 `"Grandparent"', add
label define related_lbl 4510 `"Great grandparent"', add
label define related_lbl 4600 `"Parent/grandparent/ascendant"', add
label define related_lbl 4700 `"Aunt/uncle"', add
label define related_lbl 4800 `"Other specified relative"', add
label define related_lbl 4810 `"Nephew/niece"', add
label define related_lbl 4820 `"Cousin"', add
label define related_lbl 4830 `"Sibling of sibling-in-law"', add
label define related_lbl 4900 `"Other relative, not elsewhere classified"', add
label define related_lbl 4910 `"Other relative with same family name"', add
label define related_lbl 4920 `"Other relative with different family name"', add
label define related_lbl 4930 `"Other relative, not specified (secondary family)"', add
label define related_lbl 5000 `"Non-relative"', add
label define related_lbl 5100 `"Friend/guest/visitor/partner"', add
label define related_lbl 5110 `"Partner/friend"', add
label define related_lbl 5111 `"Friend"', add
label define related_lbl 5112 `"Partner/roommate"', add
label define related_lbl 5113 `"Housemate/roommate"', add
label define related_lbl 5120 `"Visitor"', add
label define related_lbl 5130 `"Ex-spouse"', add
label define related_lbl 5140 `"Godparent"', add
label define related_lbl 5150 `"Godchild"', add
label define related_lbl 5200 `"Employee"', add
label define related_lbl 5210 `"Domestic employee"', add
label define related_lbl 5220 `"Relative of employee, n.s."', add
label define related_lbl 5221 `"Spouse of servant"', add
label define related_lbl 5222 `"Child of servant"', add
label define related_lbl 5223 `"Other relative of servant"', add
label define related_lbl 5300 `"Roomer/boarder/lodger/foster child"', add
label define related_lbl 5310 `"Boarder"', add
label define related_lbl 5311 `"Boarder or guest"', add
label define related_lbl 5320 `"Lodger"', add
label define related_lbl 5330 `"Foster child"', add
label define related_lbl 5340 `"Tutored/foster child"', add
label define related_lbl 5350 `"Tutored child"', add
label define related_lbl 5400 `"Employee, boarder or guest"', add
label define related_lbl 5500 `"Other specified non-relative"', add
label define related_lbl 5510 `"Agregado"', add
label define related_lbl 5520 `"Temporary resident, guest"', add
label define related_lbl 5600 `"Group quarters"', add
label define related_lbl 5610 `"Group quarters, non-inmates"', add
label define related_lbl 5620 `"Institutional inmates"', add
label define related_lbl 5900 `"Non-relative, n.e.c."', add
label define related_lbl 6000 `"Other relative or non-relative"', add
label define related_lbl 9999 `"Unknown"', add
label values related related_lbl

label define age_lbl 000 `"Less than 1 year"'
label define age_lbl 001 `"1 year"', add
label define age_lbl 002 `"2 years"', add
label define age_lbl 003 `"3"', add
label define age_lbl 004 `"4"', add
label define age_lbl 005 `"5"', add
label define age_lbl 006 `"6"', add
label define age_lbl 007 `"7"', add
label define age_lbl 008 `"8"', add
label define age_lbl 009 `"9"', add
label define age_lbl 010 `"10"', add
label define age_lbl 011 `"11"', add
label define age_lbl 012 `"12"', add
label define age_lbl 013 `"13"', add
label define age_lbl 014 `"14"', add
label define age_lbl 015 `"15"', add
label define age_lbl 016 `"16"', add
label define age_lbl 017 `"17"', add
label define age_lbl 018 `"18"', add
label define age_lbl 019 `"19"', add
label define age_lbl 020 `"20"', add
label define age_lbl 021 `"21"', add
label define age_lbl 022 `"22"', add
label define age_lbl 023 `"23"', add
label define age_lbl 024 `"24"', add
label define age_lbl 025 `"25"', add
label define age_lbl 026 `"26"', add
label define age_lbl 027 `"27"', add
label define age_lbl 028 `"28"', add
label define age_lbl 029 `"29"', add
label define age_lbl 030 `"30"', add
label define age_lbl 031 `"31"', add
label define age_lbl 032 `"32"', add
label define age_lbl 033 `"33"', add
label define age_lbl 034 `"34"', add
label define age_lbl 035 `"35"', add
label define age_lbl 036 `"36"', add
label define age_lbl 037 `"37"', add
label define age_lbl 038 `"38"', add
label define age_lbl 039 `"39"', add
label define age_lbl 040 `"40"', add
label define age_lbl 041 `"41"', add
label define age_lbl 042 `"42"', add
label define age_lbl 043 `"43"', add
label define age_lbl 044 `"44"', add
label define age_lbl 045 `"45"', add
label define age_lbl 046 `"46"', add
label define age_lbl 047 `"47"', add
label define age_lbl 048 `"48"', add
label define age_lbl 049 `"49"', add
label define age_lbl 050 `"50"', add
label define age_lbl 051 `"51"', add
label define age_lbl 052 `"52"', add
label define age_lbl 053 `"53"', add
label define age_lbl 054 `"54"', add
label define age_lbl 055 `"55"', add
label define age_lbl 056 `"56"', add
label define age_lbl 057 `"57"', add
label define age_lbl 058 `"58"', add
label define age_lbl 059 `"59"', add
label define age_lbl 060 `"60"', add
label define age_lbl 061 `"61"', add
label define age_lbl 062 `"62"', add
label define age_lbl 063 `"63"', add
label define age_lbl 064 `"64"', add
label define age_lbl 065 `"65"', add
label define age_lbl 066 `"66"', add
label define age_lbl 067 `"67"', add
label define age_lbl 068 `"68"', add
label define age_lbl 069 `"69"', add
label define age_lbl 070 `"70"', add
label define age_lbl 071 `"71"', add
label define age_lbl 072 `"72"', add
label define age_lbl 073 `"73"', add
label define age_lbl 074 `"74"', add
label define age_lbl 075 `"75"', add
label define age_lbl 076 `"76"', add
label define age_lbl 077 `"77"', add
label define age_lbl 078 `"78"', add
label define age_lbl 079 `"79"', add
label define age_lbl 080 `"80"', add
label define age_lbl 081 `"81"', add
label define age_lbl 082 `"82"', add
label define age_lbl 083 `"83"', add
label define age_lbl 084 `"84"', add
label define age_lbl 085 `"85"', add
label define age_lbl 086 `"86"', add
label define age_lbl 087 `"87"', add
label define age_lbl 088 `"88"', add
label define age_lbl 089 `"89"', add
label define age_lbl 090 `"90"', add
label define age_lbl 091 `"91"', add
label define age_lbl 092 `"92"', add
label define age_lbl 093 `"93"', add
label define age_lbl 094 `"94"', add
label define age_lbl 095 `"95"', add
label define age_lbl 096 `"96"', add
label define age_lbl 097 `"97"', add
label define age_lbl 098 `"98"', add
label define age_lbl 099 `"99"', add
label define age_lbl 100 `"100+"', add
label define age_lbl 999 `"Not reported/missing"', add
label values age age_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label define sex_lbl 9 `"Unknown"', add
label values sex sex_lbl

label define marst_lbl 0 `"NIU (not in universe)"'
label define marst_lbl 1 `"Single/never married"', add
label define marst_lbl 2 `"Married/in union"', add
label define marst_lbl 3 `"Separated/divorced/spouse absent"', add
label define marst_lbl 4 `"Widowed"', add
label define marst_lbl 9 `"Unknown/missing"', add
label values marst marst_lbl

label define marstd_lbl 000 `"NIU (not in universe)"'
label define marstd_lbl 100 `"Single/never married"', add
label define marstd_lbl 110 `"Engaged"', add
label define marstd_lbl 111 `"Never married and never cohabited"', add
label define marstd_lbl 200 `"Married or consensual union"', add
label define marstd_lbl 210 `"Married, formally"', add
label define marstd_lbl 211 `"Married, civil"', add
label define marstd_lbl 212 `"Married, religious"', add
label define marstd_lbl 213 `"Married, civil and religious"', add
label define marstd_lbl 214 `"Married, civil or religious"', add
label define marstd_lbl 215 `"Married, traditional/customary"', add
label define marstd_lbl 216 `"Married, monogamous"', add
label define marstd_lbl 217 `"Married, polygamous"', add
label define marstd_lbl 220 `"Consensual union"', add
label define marstd_lbl 300 `"Separated/divorced/spouse absent"', add
label define marstd_lbl 310 `"Separated or divorced"', add
label define marstd_lbl 320 `"Separated or annulled"', add
label define marstd_lbl 330 `"Separated"', add
label define marstd_lbl 331 `"Separated legally"', add
label define marstd_lbl 332 `"Separated de facto"', add
label define marstd_lbl 333 `"Separated from marriage"', add
label define marstd_lbl 334 `"Separated from consensual union"', add
label define marstd_lbl 335 `"Separated from consensual union or marriage"', add
label define marstd_lbl 340 `"Annulled"', add
label define marstd_lbl 350 `"Divorced"', add
label define marstd_lbl 360 `"Married, spouse absent"', add
label define marstd_lbl 400 `"Widowed"', add
label define marstd_lbl 410 `"Widowed or divorced"', add
label define marstd_lbl 411 `"Widowed from consensual union or marriage"', add
label define marstd_lbl 412 `"Widowed from marriage"', add
label define marstd_lbl 413 `"Widowed from consensual union"', add
label define marstd_lbl 420 `"Widowed, divorced, or separated"', add
label define marstd_lbl 999 `"Unknown/missing"', add
label values marstd marstd_lbl

label define consens_lbl 1 `"Yes, in consensual union"'
label define consens_lbl 2 `"No, married"', add
label define consens_lbl 8 `"Unknown"', add
label define consens_lbl 9 `"NIU (not in universe)"', add
label values consens consens_lbl

label define nativity_lbl 0 `"NIU (not universe)"'
label define nativity_lbl 1 `"Native-born"', add
label define nativity_lbl 2 `"Foreign-born"', add
label define nativity_lbl 9 `"Unknown/missing"', add
label values nativity nativity_lbl

label define bplcountry_lbl 00000 `"NIU (not in universe)"'
label define bplcountry_lbl 10000 `"Africa"', add
label define bplcountry_lbl 11000 `"Eastern Africa"', add
label define bplcountry_lbl 11010 `"Burundi"', add
label define bplcountry_lbl 11020 `"Comoros"', add
label define bplcountry_lbl 11030 `"Djibouti"', add
label define bplcountry_lbl 11040 `"Eritrea"', add
label define bplcountry_lbl 11050 `"Ethiopia"', add
label define bplcountry_lbl 11051 `"Ethiopia (including Eritrea)"', add
label define bplcountry_lbl 11060 `"Kenya"', add
label define bplcountry_lbl 11070 `"Madagascar"', add
label define bplcountry_lbl 11080 `"Malawi"', add
label define bplcountry_lbl 11090 `"Mauritius"', add
label define bplcountry_lbl 11100 `"Mozambique"', add
label define bplcountry_lbl 11110 `"Reunion"', add
label define bplcountry_lbl 11120 `"Rwanda"', add
label define bplcountry_lbl 11130 `"Seychelles"', add
label define bplcountry_lbl 11140 `"Somalia"', add
label define bplcountry_lbl 11150 `"South Sudan"', add
label define bplcountry_lbl 11160 `"Uganda"', add
label define bplcountry_lbl 11170 `"Tanzania"', add
label define bplcountry_lbl 11180 `"Zambia"', add
label define bplcountry_lbl 11190 `"Zimbabwe"', add
label define bplcountry_lbl 11990 `"Eastern Africa, n.s."', add
label define bplcountry_lbl 12000 `"Middle Africa"', add
label define bplcountry_lbl 12010 `"Angola"', add
label define bplcountry_lbl 12020 `"Cameroon"', add
label define bplcountry_lbl 12030 `"Central African Republic"', add
label define bplcountry_lbl 12040 `"Chad"', add
label define bplcountry_lbl 12050 `"Congo"', add
label define bplcountry_lbl 12060 `"Democratic Republic of Congo"', add
label define bplcountry_lbl 12070 `"Equatorial Guinea"', add
label define bplcountry_lbl 12080 `"Gabon"', add
label define bplcountry_lbl 12090 `"Sao Tome and Principe"', add
label define bplcountry_lbl 12990 `"Middle Africa, n.s."', add
label define bplcountry_lbl 13000 `"Northern Africa"', add
label define bplcountry_lbl 13010 `"Algeria"', add
label define bplcountry_lbl 13011 `"Algeria/Tunisia"', add
label define bplcountry_lbl 13020 `"Egypt"', add
label define bplcountry_lbl 13021 `"Egypt/Sudan"', add
label define bplcountry_lbl 13030 `"Libya"', add
label define bplcountry_lbl 13040 `"Morocco"', add
label define bplcountry_lbl 13050 `"Sudan"', add
label define bplcountry_lbl 13060 `"Tunisia"', add
label define bplcountry_lbl 13070 `"Western Sahara"', add
label define bplcountry_lbl 13990 `"Northern Africa, n.s."', add
label define bplcountry_lbl 14000 `"Southern Africa"', add
label define bplcountry_lbl 14010 `"Botswana"', add
label define bplcountry_lbl 14020 `"Lesotho"', add
label define bplcountry_lbl 14030 `"Namibia"', add
label define bplcountry_lbl 14040 `"South Africa"', add
label define bplcountry_lbl 14050 `"Swaziland"', add
label define bplcountry_lbl 14990 `"Southern Africa, n.s."', add
label define bplcountry_lbl 15000 `"Western Africa"', add
label define bplcountry_lbl 15010 `"Benin"', add
label define bplcountry_lbl 15020 `"Burkina Faso"', add
label define bplcountry_lbl 15021 `"Upper Volta"', add
label define bplcountry_lbl 15030 `"Cape Verde"', add
label define bplcountry_lbl 15040 `"Ivory Coast"', add
label define bplcountry_lbl 15050 `"Gambia"', add
label define bplcountry_lbl 15060 `"Ghana"', add
label define bplcountry_lbl 15070 `"Guinea"', add
label define bplcountry_lbl 15080 `"Guinea-Bissau"', add
label define bplcountry_lbl 15081 `"Guinea-Bissau and Cape Verde"', add
label define bplcountry_lbl 15090 `"Liberia"', add
label define bplcountry_lbl 15100 `"Mali"', add
label define bplcountry_lbl 15110 `"Mauritania"', add
label define bplcountry_lbl 15120 `"Niger"', add
label define bplcountry_lbl 15130 `"Nigeria"', add
label define bplcountry_lbl 15140 `"St. Helena and Ascension"', add
label define bplcountry_lbl 15150 `"Senegal"', add
label define bplcountry_lbl 15160 `"Sierra Leone"', add
label define bplcountry_lbl 15170 `"Togo"', add
label define bplcountry_lbl 15990 `"West Africa, n.s."', add
label define bplcountry_lbl 19990 `"Africa, other and n.s."', add
label define bplcountry_lbl 19991 `"Central and South Africa"', add
label define bplcountry_lbl 19992 `"East and Central Africa"', add
label define bplcountry_lbl 19993 `"Southeastern Africa"', add
label define bplcountry_lbl 19994 `"Saharan Africa"', add
label define bplcountry_lbl 20000 `"Americas"', add
label define bplcountry_lbl 21000 `"Caribbean"', add
label define bplcountry_lbl 21010 `"Anguilla"', add
label define bplcountry_lbl 21020 `"Antigua-Barbuda"', add
label define bplcountry_lbl 21030 `"Aruba"', add
label define bplcountry_lbl 21040 `"Bahamas"', add
label define bplcountry_lbl 21050 `"Barbados"', add
label define bplcountry_lbl 21060 `"British Virgin Islands"', add
label define bplcountry_lbl 21070 `"Cayman Isles"', add
label define bplcountry_lbl 21080 `"Cuba"', add
label define bplcountry_lbl 21090 `"Dominica"', add
label define bplcountry_lbl 21100 `"Dominican Republic"', add
label define bplcountry_lbl 21110 `"Grenada"', add
label define bplcountry_lbl 21120 `"Guadeloupe"', add
label define bplcountry_lbl 21130 `"Haiti"', add
label define bplcountry_lbl 21140 `"Jamaica"', add
label define bplcountry_lbl 21150 `"Martinique"', add
label define bplcountry_lbl 21160 `"Montserrat"', add
label define bplcountry_lbl 21170 `"Netherlands Antilles"', add
label define bplcountry_lbl 21180 `"Puerto Rico"', add
label define bplcountry_lbl 21190 `"St. Kitts-Nevis"', add
label define bplcountry_lbl 21200 `"St. Croix"', add
label define bplcountry_lbl 21210 `"St. John"', add
label define bplcountry_lbl 21220 `"St. Lucia"', add
label define bplcountry_lbl 21230 `"St Thomas"', add
label define bplcountry_lbl 21240 `"St. Vincent"', add
label define bplcountry_lbl 21250 `"Trinidad and Tobago"', add
label define bplcountry_lbl 21260 `"Turks and Caicos"', add
label define bplcountry_lbl 21270 `"U.S. Virgin Islands"', add
label define bplcountry_lbl 21990 `"Other Caribbean and n.s."', add
label define bplcountry_lbl 21991 `"Caribbean commonwealth, n.s."', add
label define bplcountry_lbl 22000 `"Central America"', add
label define bplcountry_lbl 22010 `"Belize/British Honduras"', add
label define bplcountry_lbl 22020 `"Costa Rica"', add
label define bplcountry_lbl 22030 `"El Salvador"', add
label define bplcountry_lbl 22040 `"Guatemala"', add
label define bplcountry_lbl 22050 `"Honduras"', add
label define bplcountry_lbl 22060 `"Mexico"', add
label define bplcountry_lbl 22070 `"Nicaragua"', add
label define bplcountry_lbl 22080 `"Panama"', add
label define bplcountry_lbl 22081 `"Panama Canal Zone"', add
label define bplcountry_lbl 22990 `"Central America, n.s."', add
label define bplcountry_lbl 22991 `"Central America and Caribbean"', add
label define bplcountry_lbl 23000 `"South America"', add
label define bplcountry_lbl 23010 `"Argentina"', add
label define bplcountry_lbl 23020 `"Bolivia"', add
label define bplcountry_lbl 23030 `"Brazil"', add
label define bplcountry_lbl 23040 `"Chile"', add
label define bplcountry_lbl 23050 `"Colombia"', add
label define bplcountry_lbl 23060 `"Ecuador"', add
label define bplcountry_lbl 23070 `"Falkland Islands"', add
label define bplcountry_lbl 23080 `"French Guiana"', add
label define bplcountry_lbl 23090 `"Guyana/British Guiana"', add
label define bplcountry_lbl 23100 `"Paraguay"', add
label define bplcountry_lbl 23110 `"Peru"', add
label define bplcountry_lbl 23120 `"Suriname"', add
label define bplcountry_lbl 23130 `"Uruguay"', add
label define bplcountry_lbl 23140 `"Venezuela"', add
label define bplcountry_lbl 23990 `"South America, other and n.s."', add
label define bplcountry_lbl 23991 `"South America or Central America, n.s."', add
label define bplcountry_lbl 23992 `"Central/South America and Caribbean"', add
label define bplcountry_lbl 24000 `"North America"', add
label define bplcountry_lbl 24010 `"Bermuda"', add
label define bplcountry_lbl 24020 `"Canada"', add
label define bplcountry_lbl 24030 `"Greenland"', add
label define bplcountry_lbl 24040 `"United States"', add
label define bplcountry_lbl 24990 `"North America, other and n.s."', add
label define bplcountry_lbl 24991 `"North America/Oceania"', add
label define bplcountry_lbl 29990 `"Americas, other and n.s."', add
label define bplcountry_lbl 30000 `"Asia"', add
label define bplcountry_lbl 31000 `"Eastern Asia"', add
label define bplcountry_lbl 31010 `"China"', add
label define bplcountry_lbl 31011 `"Hong Kong"', add
label define bplcountry_lbl 31012 `"Macau"', add
label define bplcountry_lbl 31013 `"Taiwan"', add
label define bplcountry_lbl 31020 `"Japan"', add
label define bplcountry_lbl 31030 `"Korea"', add
label define bplcountry_lbl 31031 `"Korea, DPR (North)"', add
label define bplcountry_lbl 31032 `"Korea, RO (South)"', add
label define bplcountry_lbl 31040 `"Mongolia"', add
label define bplcountry_lbl 31990 `"Eastern Asia, n.s."', add
label define bplcountry_lbl 32000 `"South-Central Asia"', add
label define bplcountry_lbl 32010 `"Afghanistan"', add
label define bplcountry_lbl 32020 `"Bangladesh"', add
label define bplcountry_lbl 32030 `"Bhutan"', add
label define bplcountry_lbl 32040 `"India"', add
label define bplcountry_lbl 32041 `"India/Pakistan"', add
label define bplcountry_lbl 32042 `"India/Pakistan/Bangladesh/Sri Lanka"', add
label define bplcountry_lbl 32050 `"Iran"', add
label define bplcountry_lbl 32060 `"Kazakhstan"', add
label define bplcountry_lbl 32070 `"Kyrgyzstan"', add
label define bplcountry_lbl 32080 `"Maldives"', add
label define bplcountry_lbl 32090 `"Nepal"', add
label define bplcountry_lbl 32100 `"Pakistan"', add
label define bplcountry_lbl 32101 `"Pakistan/Bangladesh"', add
label define bplcountry_lbl 32110 `"Sri Lanka (Ceylon)"', add
label define bplcountry_lbl 32120 `"Tajikistan"', add
label define bplcountry_lbl 32130 `"Turkmenistan"', add
label define bplcountry_lbl 32140 `"Uzbekistan"', add
label define bplcountry_lbl 32999 `"South-Central Asia, n.s."', add
label define bplcountry_lbl 33000 `"South-Eastern Asia"', add
label define bplcountry_lbl 33010 `"Brunei"', add
label define bplcountry_lbl 33020 `"Cambodia (Kampuchea)"', add
label define bplcountry_lbl 33030 `"East Timor"', add
label define bplcountry_lbl 33040 `"Indonesia"', add
label define bplcountry_lbl 33050 `"Laos"', add
label define bplcountry_lbl 33060 `"Malaysia"', add
label define bplcountry_lbl 33070 `"Myanmar (Burma)"', add
label define bplcountry_lbl 33080 `"Philippines"', add
label define bplcountry_lbl 33090 `"Singapore"', add
label define bplcountry_lbl 33100 `"Thailand"', add
label define bplcountry_lbl 33110 `"Vietnam"', add
label define bplcountry_lbl 33990 `"South-Eastern Asia, n.s."', add
label define bplcountry_lbl 34000 `"Western Asia"', add
label define bplcountry_lbl 34010 `"Armenia"', add
label define bplcountry_lbl 34020 `"Azerbaijan"', add
label define bplcountry_lbl 34030 `"Bahrain"', add
label define bplcountry_lbl 34040 `"Cyprus"', add
label define bplcountry_lbl 34050 `"Georgia"', add
label define bplcountry_lbl 34060 `"Iraq"', add
label define bplcountry_lbl 34070 `"Israel"', add
label define bplcountry_lbl 34071 `"Israel/Palestine"', add
label define bplcountry_lbl 34080 `"Jordan"', add
label define bplcountry_lbl 34090 `"Kuwait"', add
label define bplcountry_lbl 34100 `"Lebanon"', add
label define bplcountry_lbl 34110 `"Palestinian Territories"', add
label define bplcountry_lbl 34111 `"West Bank"', add
label define bplcountry_lbl 34112 `"Gaza Strip"', add
label define bplcountry_lbl 34120 `"Oman"', add
label define bplcountry_lbl 34130 `"Qatar"', add
label define bplcountry_lbl 34140 `"Saudi Arabia"', add
label define bplcountry_lbl 34150 `"Syria"', add
label define bplcountry_lbl 34151 `"Syria/Lebanon"', add
label define bplcountry_lbl 34160 `"Turkey"', add
label define bplcountry_lbl 34170 `"United Arab Emirates"', add
label define bplcountry_lbl 34180 `"Yemen"', add
label define bplcountry_lbl 34990 `"Western Asia, n.s."', add
label define bplcountry_lbl 34991 `"Middle East"', add
label define bplcountry_lbl 39990 `"Asia, other and n.s."', add
label define bplcountry_lbl 39991 `"Central Asia and Middle East, n.s."', add
label define bplcountry_lbl 39992 `"Far East, n.s."', add
label define bplcountry_lbl 39993 `"Eastern/Southeast Asia, n.s."', add
label define bplcountry_lbl 39994 `"Asia/Middle East, other and n.s."', add
label define bplcountry_lbl 40000 `"Europe"', add
label define bplcountry_lbl 41000 `"Eastern Europe"', add
label define bplcountry_lbl 41010 `"Belarus"', add
label define bplcountry_lbl 41020 `"Bulgaria"', add
label define bplcountry_lbl 41021 `"Bulgaria/Greece"', add
label define bplcountry_lbl 41030 `"Czech Republic/Czechoslovakia"', add
label define bplcountry_lbl 41040 `"Hungary"', add
label define bplcountry_lbl 41050 `"Poland"', add
label define bplcountry_lbl 41060 `"Moldova"', add
label define bplcountry_lbl 41070 `"Romania"', add
label define bplcountry_lbl 41080 `"Russia/USSR"', add
label define bplcountry_lbl 41090 `"Slovakia"', add
label define bplcountry_lbl 41100 `"Ukraine"', add
label define bplcountry_lbl 41990 `"Eastern Europe, other and n.s."', add
label define bplcountry_lbl 41991 `"Albania, Bulgaria, Czech, Hungary, Romania, Yugoslavia"', add
label define bplcountry_lbl 41992 `"Central-Eastern Europe"', add
label define bplcountry_lbl 42000 `"Northern Europe"', add
label define bplcountry_lbl 42010 `"Denmark"', add
label define bplcountry_lbl 42020 `"Estonia"', add
label define bplcountry_lbl 42030 `"Faroe Islands"', add
label define bplcountry_lbl 42040 `"Finland"', add
label define bplcountry_lbl 42050 `"Iceland"', add
label define bplcountry_lbl 42060 `"Ireland"', add
label define bplcountry_lbl 42070 `"Latvia"', add
label define bplcountry_lbl 42080 `"Lithuania"', add
label define bplcountry_lbl 42090 `"Norway"', add
label define bplcountry_lbl 42100 `"Svalbard and Jan Mayen Islands"', add
label define bplcountry_lbl 42110 `"Sweden"', add
label define bplcountry_lbl 42120 `"United Kingdom"', add
label define bplcountry_lbl 42990 `"Northern Europe, n.s."', add
label define bplcountry_lbl 43000 `"Southern Europe"', add
label define bplcountry_lbl 43010 `"Albania"', add
label define bplcountry_lbl 43020 `"Andorra"', add
label define bplcountry_lbl 43030 `"Bosnia and Herzegovina"', add
label define bplcountry_lbl 43040 `"Croatia"', add
label define bplcountry_lbl 43050 `"Gibraltar"', add
label define bplcountry_lbl 43060 `"Greece"', add
label define bplcountry_lbl 43070 `"Italy"', add
label define bplcountry_lbl 43071 `"Vatican City"', add
label define bplcountry_lbl 43080 `"Malta"', add
label define bplcountry_lbl 43090 `"Portugal"', add
label define bplcountry_lbl 43100 `"San Marino"', add
label define bplcountry_lbl 43110 `"Slovenia"', add
label define bplcountry_lbl 43120 `"Spain"', add
label define bplcountry_lbl 43121 `"Spain/Portugal"', add
label define bplcountry_lbl 43130 `"Macedonia"', add
label define bplcountry_lbl 43140 `"Yugoslavia"', add
label define bplcountry_lbl 43141 `"Montenegro"', add
label define bplcountry_lbl 43142 `"Serbia"', add
label define bplcountry_lbl 43143 `"Serbia and Montenegro"', add
label define bplcountry_lbl 43144 `"Kosovo"', add
label define bplcountry_lbl 43990 `"Southern Europe, n.s."', add
label define bplcountry_lbl 43991 `"Gibraltar/Malta"', add
label define bplcountry_lbl 43992 `"Portugal/Greece"', add
label define bplcountry_lbl 43993 `"Italy, Holy See, San Marino"', add
label define bplcountry_lbl 44000 `"Western Europe"', add
label define bplcountry_lbl 44010 `"Austria"', add
label define bplcountry_lbl 44020 `"Belgium"', add
label define bplcountry_lbl 44021 `"Belgium/Luxemburg"', add
label define bplcountry_lbl 44022 `"Belgium/Netherlands/Luxemburg"', add
label define bplcountry_lbl 44030 `"France"', add
label define bplcountry_lbl 44040 `"Germany"', add
label define bplcountry_lbl 44041 `"Germany/Austria"', add
label define bplcountry_lbl 44042 `"West Germany"', add
label define bplcountry_lbl 44050 `"Liechtenstein"', add
label define bplcountry_lbl 44060 `"Luxembourg"', add
label define bplcountry_lbl 44070 `"Monaco"', add
label define bplcountry_lbl 44080 `"Netherlands"', add
label define bplcountry_lbl 44090 `"Switzerland"', add
label define bplcountry_lbl 44990 `"Western Europe, n.s."', add
label define bplcountry_lbl 44991 `"Belgium, Denmark, Luxembourg, Netherlands"', add
label define bplcountry_lbl 49991 `"Turkey and U.S.S.R."', add
label define bplcountry_lbl 49992 `"European Union"', add
label define bplcountry_lbl 49993 `"European Union (Original 15)"', add
label define bplcountry_lbl 49994 `"Other European Union"', add
label define bplcountry_lbl 49995 `"EEA, Switzerland, associated microstates"', add
label define bplcountry_lbl 49999 `"Europe, other and n.s."', add
label define bplcountry_lbl 50000 `"Oceania"', add
label define bplcountry_lbl 51000 `"Australia and New Zealand"', add
label define bplcountry_lbl 51010 `"Australia"', add
label define bplcountry_lbl 51020 `"New Zealand"', add
label define bplcountry_lbl 51030 `"Norfolk Islands"', add
label define bplcountry_lbl 51999 `"Australia and New Zealand, n.s."', add
label define bplcountry_lbl 52000 `"Melanesia"', add
label define bplcountry_lbl 52010 `"Fiji"', add
label define bplcountry_lbl 52020 `"New Caledonia"', add
label define bplcountry_lbl 52030 `"Papua New Guinea"', add
label define bplcountry_lbl 52040 `"Solomon Islands"', add
label define bplcountry_lbl 52050 `"Vanuatu (New Hebrides)"', add
label define bplcountry_lbl 52999 `"Melanesia, n.s."', add
label define bplcountry_lbl 53000 `"Micronesia"', add
label define bplcountry_lbl 53010 `"Kiribati"', add
label define bplcountry_lbl 53020 `"Marshall Islands"', add
label define bplcountry_lbl 53030 `"Nauru"', add
label define bplcountry_lbl 53040 `"Northern Mariana Isls."', add
label define bplcountry_lbl 53050 `"Palau"', add
label define bplcountry_lbl 53990 `"Micronesia, n.e.c."', add
label define bplcountry_lbl 54000 `"Polynesia"', add
label define bplcountry_lbl 54010 `"Cook Islands"', add
label define bplcountry_lbl 54020 `"French Polynesia"', add
label define bplcountry_lbl 54030 `"Niue"', add
label define bplcountry_lbl 54040 `"Pitcairn Island"', add
label define bplcountry_lbl 54050 `"Samoa"', add
label define bplcountry_lbl 54060 `"Eastern Samoa"', add
label define bplcountry_lbl 54070 `"Tokelau"', add
label define bplcountry_lbl 54080 `"Tonga"', add
label define bplcountry_lbl 54090 `"Tuvalu"', add
label define bplcountry_lbl 54100 `"Wallis and Futuna Isls."', add
label define bplcountry_lbl 54990 `"Polynesia, n.s."', add
label define bplcountry_lbl 55000 `"U.S. Pacific Possessions"', add
label define bplcountry_lbl 55010 `"American Samoa"', add
label define bplcountry_lbl 55020 `"Baker Island"', add
label define bplcountry_lbl 55030 `"Guam"', add
label define bplcountry_lbl 55040 `"Howland Island"', add
label define bplcountry_lbl 55050 `"Johnston Atoll"', add
label define bplcountry_lbl 55060 `"Kingman Reef"', add
label define bplcountry_lbl 55070 `"Midway Islands"', add
label define bplcountry_lbl 55080 `"Wake Island"', add
label define bplcountry_lbl 55990 `"Other US Pacific"', add
label define bplcountry_lbl 59990 `"Oceania, n.s."', add
label define bplcountry_lbl 60000 `"OTHER ABROAD"', add
label define bplcountry_lbl 60100 `"U.S. Outlying Areas and Territories"', add
label define bplcountry_lbl 60200 `"Africa/Other"', add
label define bplcountry_lbl 60300 `"Central/South America or Africa"', add
label define bplcountry_lbl 60400 `"Asia/Africa"', add
label define bplcountry_lbl 60500 `"Europe, Australia, New Zealand"', add
label define bplcountry_lbl 60600 `"Other commonwealth"', add
label define bplcountry_lbl 60700 `"Asia, Australia, Oceania, n.s."', add
label define bplcountry_lbl 69900 `"Other countries, not specified"', add
label define bplcountry_lbl 99999 `"Unknown"', add
label values bplcountry bplcountry_lbl

label define bplmx_lbl 01 `"Aguascalientes"'
label define bplmx_lbl 02 `"Baja California"', add
label define bplmx_lbl 03 `"Baja California Sur"', add
label define bplmx_lbl 04 `"Campeche"', add
label define bplmx_lbl 05 `"Coahuila"', add
label define bplmx_lbl 06 `"Colima"', add
label define bplmx_lbl 07 `"Chiapas"', add
label define bplmx_lbl 08 `"Chihuahua"', add
label define bplmx_lbl 09 `"Distrito Federal"', add
label define bplmx_lbl 10 `"Durango"', add
label define bplmx_lbl 11 `"Guanajuato"', add
label define bplmx_lbl 12 `"Guerrero"', add
label define bplmx_lbl 13 `"Hidalgo"', add
label define bplmx_lbl 14 `"Jalisco"', add
label define bplmx_lbl 15 `"México"', add
label define bplmx_lbl 16 `"Michoacán"', add
label define bplmx_lbl 17 `"Morelos"', add
label define bplmx_lbl 18 `"Nayarit"', add
label define bplmx_lbl 19 `"Nuevo León"', add
label define bplmx_lbl 20 `"Oaxaca"', add
label define bplmx_lbl 21 `"Puebla"', add
label define bplmx_lbl 22 `"Querétaro"', add
label define bplmx_lbl 23 `"Quintana Roo"', add
label define bplmx_lbl 24 `"San Luis Potosí"', add
label define bplmx_lbl 25 `"Sinaloa"', add
label define bplmx_lbl 26 `"Sonora"', add
label define bplmx_lbl 27 `"Tabasco"', add
label define bplmx_lbl 28 `"Tamaulipas"', add
label define bplmx_lbl 29 `"Tlaxcala"', add
label define bplmx_lbl 30 `"Veracruz"', add
label define bplmx_lbl 31 `"Yucatán"', add
label define bplmx_lbl 32 `"Zacatecas"', add
label define bplmx_lbl 98 `"Foreign-born"', add
label define bplmx_lbl 99 `"Missing/unknown"', add
label values bplmx bplmx_lbl

label define school_lbl 0 `"NIU (not in universe)"'
label define school_lbl 1 `"Yes"', add
label define school_lbl 2 `"No, not specified"', add
label define school_lbl 3 `"No, attended in the past"', add
label define school_lbl 4 `"No, never attended"', add
label define school_lbl 9 `"Unknown/missing"', add
label values school school_lbl

label define lit_lbl 0 `"NIU (not in universe)"'
label define lit_lbl 1 `"No, illiterate"', add
label define lit_lbl 2 `"Yes, literate"', add
label define lit_lbl 9 `"Unknown/missing"', add
label values lit lit_lbl

label define edattain_lbl 0 `"NIU (not in universe)"'
label define edattain_lbl 1 `"Less than primary completed"', add
label define edattain_lbl 2 `"Primary completed"', add
label define edattain_lbl 3 `"Secondary completed"', add
label define edattain_lbl 4 `"University completed"', add
label define edattain_lbl 9 `"Unknown"', add
label values edattain edattain_lbl

label define edattaind_lbl 000 `"NIU (not in universe)"'
label define edattaind_lbl 100 `"Less than primary completed (n.s.)"', add
label define edattaind_lbl 110 `"No schooling"', add
label define edattaind_lbl 120 `"Some primary completed"', add
label define edattaind_lbl 130 `"Primary (4 yrs) completed"', add
label define edattaind_lbl 211 `"Primary (5 yrs) completed"', add
label define edattaind_lbl 212 `"Primary (6 yrs) completed"', add
label define edattaind_lbl 221 `"Lower secondary general completed"', add
label define edattaind_lbl 222 `"Lower secondary technical completed"', add
label define edattaind_lbl 311 `"Secondary, general track completed"', add
label define edattaind_lbl 312 `"Some college completed"', add
label define edattaind_lbl 320 `"Secondary or post-secondary technical completed"', add
label define edattaind_lbl 321 `"Secondary, technical track completed"', add
label define edattaind_lbl 322 `"Post-secondary technical education"', add
label define edattaind_lbl 400 `"University completed"', add
label define edattaind_lbl 999 `"Unknown/missing"', add
label values edattaind edattaind_lbl

label define yrschool_lbl 00 `"None or pre-school"'
label define yrschool_lbl 01 `"1 year"', add
label define yrschool_lbl 02 `"2 years"', add
label define yrschool_lbl 03 `"3 years"', add
label define yrschool_lbl 04 `"4 years"', add
label define yrschool_lbl 05 `"5 years"', add
label define yrschool_lbl 06 `"6 years"', add
label define yrschool_lbl 07 `"7 years"', add
label define yrschool_lbl 08 `"8 years"', add
label define yrschool_lbl 09 `"9 years"', add
label define yrschool_lbl 10 `"10 years"', add
label define yrschool_lbl 11 `"11 years"', add
label define yrschool_lbl 12 `"12 years"', add
label define yrschool_lbl 13 `"13 years"', add
label define yrschool_lbl 14 `"14 years"', add
label define yrschool_lbl 15 `"15 years"', add
label define yrschool_lbl 16 `"16 years"', add
label define yrschool_lbl 17 `"17 years"', add
label define yrschool_lbl 18 `"18 years or more"', add
label define yrschool_lbl 90 `"Not specified"', add
label define yrschool_lbl 91 `"Some primary"', add
label define yrschool_lbl 92 `"Some technical after primary"', add
label define yrschool_lbl 93 `"Some secondary"', add
label define yrschool_lbl 94 `"Some tertiary"', add
label define yrschool_lbl 95 `"Adult literacy"', add
label define yrschool_lbl 96 `"Special education"', add
label define yrschool_lbl 98 `"Unknown/missing"', add
label define yrschool_lbl 99 `"NIU (not in universe)"', add
label values yrschool yrschool_lbl

label define educmx_lbl 000 `"Less than primary"'
label define educmx_lbl 010 `"None, or never attended school"', add
label define educmx_lbl 020 `"Preschool or kindergarten"', add
label define educmx_lbl 021 `"Preschool, 1 year"', add
label define educmx_lbl 022 `"Preschool, 2 years"', add
label define educmx_lbl 023 `"Preschool, 3 years"', add
label define educmx_lbl 029 `"Preschool, unspecified years"', add
label define educmx_lbl 100 `"Primary"', add
label define educmx_lbl 101 `"Primary, 1 year"', add
label define educmx_lbl 102 `"Primary, 2 years"', add
label define educmx_lbl 103 `"Primary, 3 years"', add
label define educmx_lbl 104 `"Primary, 4 years"', add
label define educmx_lbl 105 `"Primary, 5 years"', add
label define educmx_lbl 106 `"Primary, 6 years"', add
label define educmx_lbl 109 `"Primary, years unspecified"', add
label define educmx_lbl 200 `"Lower secondary (middle or junior high school)"', add
label define educmx_lbl 210 `"Lower secondary, tech/commercial"', add
label define educmx_lbl 211 `"Lower secondary, tech/commercial, 1 year"', add
label define educmx_lbl 212 `"Lower secondary, tech/commercial, 2 years"', add
label define educmx_lbl 213 `"Lower secondary, tech/commercial, 3 years"', add
label define educmx_lbl 214 `"Lower secondary, tech/commercial, 4 years"', add
label define educmx_lbl 219 `"Lower secondary, tech/commercial, years unspec"', add
label define educmx_lbl 220 `"Lower secondary, general track"', add
label define educmx_lbl 221 `"Lower secondary, general track, 1 year"', add
label define educmx_lbl 222 `"Lower secondary, general track, 2 years"', add
label define educmx_lbl 223 `"Lower secondary, general track, 3 years"', add
label define educmx_lbl 229 `"Lower secondary, general track, years unspec."', add
label define educmx_lbl 300 `"Secondary (high school)"', add
label define educmx_lbl 310 `"Secondary tech/commercial"', add
label define educmx_lbl 311 `"Secondary tech/commercial, 1 year"', add
label define educmx_lbl 312 `"Secondary tech/commercial, 2 years"', add
label define educmx_lbl 313 `"Secondary tech/commercial, 3 years"', add
label define educmx_lbl 314 `"Secondary tech/commercial, 4 years"', add
label define educmx_lbl 315 `"Secondary tech/commercial, 5 years"', add
label define educmx_lbl 319 `"Secondary tech/commercial, years unspec"', add
label define educmx_lbl 320 `"Secondary, general track"', add
label define educmx_lbl 321 `"Secondary, general track, 1 year"', add
label define educmx_lbl 322 `"Secondary, general track, 2 years"', add
label define educmx_lbl 323 `"Secondary, general track, 3 years"', add
label define educmx_lbl 329 `"Secondary, general track, years unspec"', add
label define educmx_lbl 330 `"Technological track"', add
label define educmx_lbl 331 `"Secondary, technological track, year 1"', add
label define educmx_lbl 332 `"Secondary, technological track, years 2"', add
label define educmx_lbl 333 `"Secondary, technological track, years 3"', add
label define educmx_lbl 339 `"Secondary, technological track, year unspecified"', add
label define educmx_lbl 400 `"Normal school (teacher-training)"', add
label define educmx_lbl 401 `"Normal, 1 year"', add
label define educmx_lbl 402 `"Normal, 2 years"', add
label define educmx_lbl 403 `"Normal, 3 years"', add
label define educmx_lbl 404 `"Normal, 4 years"', add
label define educmx_lbl 409 `"Normal, years unspec"', add
label define educmx_lbl 500 `"Post-secondary technical"', add
label define educmx_lbl 501 `"Post-secondary technical, 1 year"', add
label define educmx_lbl 502 `"Post-secondary technical, 2 years"', add
label define educmx_lbl 503 `"Post-secondary technical, 3 years"', add
label define educmx_lbl 504 `"Post-secondary technical, 4 years"', add
label define educmx_lbl 505 `"Post-secondary technical, 5 years"', add
label define educmx_lbl 509 `"Post-secondary technical, years unspec"', add
label define educmx_lbl 600 `"University"', add
label define educmx_lbl 610 `"University undergraduate"', add
label define educmx_lbl 611 `"University undergraduate, 1 year"', add
label define educmx_lbl 612 `"University undergraduate, 2 years"', add
label define educmx_lbl 613 `"University undergraduate, 3 years"', add
label define educmx_lbl 614 `"University undergraduate, 4 years"', add
label define educmx_lbl 615 `"University undergraduate, 5 years"', add
label define educmx_lbl 616 `"University undergraduate, 6 years"', add
label define educmx_lbl 617 `"University undergraduate, 7 years"', add
label define educmx_lbl 618 `"University undergraduate, 8+ years"', add
label define educmx_lbl 619 `"University undergraduate, years unspec"', add
label define educmx_lbl 620 `"University graduate"', add
label define educmx_lbl 621 `"University graduate, 1 year"', add
label define educmx_lbl 622 `"University graduate, 2 years"', add
label define educmx_lbl 623 `"University graduate, 3 years"', add
label define educmx_lbl 624 `"University graduate, 4 years"', add
label define educmx_lbl 625 `"University graduate, 5 years"', add
label define educmx_lbl 626 `"University graduate, 6 years"', add
label define educmx_lbl 627 `"University graduate, 7 years"', add
label define educmx_lbl 628 `"University graduate, 8+ years"', add
label define educmx_lbl 629 `"University graduate, years unspec"', add
label define educmx_lbl 630 `"Masters degree (2005-2010)"', add
label define educmx_lbl 631 `"Masters, 1 year"', add
label define educmx_lbl 632 `"Masters, 2 years"', add
label define educmx_lbl 633 `"3 years"', add
label define educmx_lbl 639 `"Masters, year unspecified"', add
label define educmx_lbl 640 `"Doctoral degree (2005-2010)"', add
label define educmx_lbl 641 `"Doctoral, 1 year"', add
label define educmx_lbl 642 `"Doctoral, 2 years"', add
label define educmx_lbl 643 `"Doctoral, 3 years"', add
label define educmx_lbl 644 `"Doctoral, 4 years"', add
label define educmx_lbl 645 `"Doctoral, 5 years"', add
label define educmx_lbl 646 `"Doctoral, 6 years"', add
label define educmx_lbl 649 `"Doctoral, years unspecified"', add
label define educmx_lbl 650 `"Specialty degree"', add
label define educmx_lbl 651 `"Specialty, 1 year"', add
label define educmx_lbl 652 `"Specialty, 2 years"', add
label define educmx_lbl 659 `"Specialty, years unspecified"', add
label define educmx_lbl 700 `"Unspecified post-secondary"', add
label define educmx_lbl 701 `"Unspecified post-secondary, 1 year"', add
label define educmx_lbl 702 `"Unspecified post-secondary, 2 years"', add
label define educmx_lbl 703 `"Unspecified post-secondary, 3 years"', add
label define educmx_lbl 704 `"Unspecified post-secondary, 4 years"', add
label define educmx_lbl 705 `"Unspecified post-secondary, 5 years"', add
label define educmx_lbl 706 `"Unspecified post-secondary, 6 years"', add
label define educmx_lbl 707 `"Unspecified post-secondary, 7 years"', add
label define educmx_lbl 708 `"Unspecified post-secondary, 8+ years"', add
label define educmx_lbl 800 `"Unknown/missing"', add
label define educmx_lbl 999 `"NIU (not in universe)"', add
label values educmx educmx_lbl

label define empstat_lbl 0 `"NIU (not in universe)"'
label define empstat_lbl 1 `"Employed"', add
label define empstat_lbl 2 `"Unemployed"', add
label define empstat_lbl 3 `"Inactive"', add
label define empstat_lbl 9 `"Unknown/missing"', add
label values empstat empstat_lbl

label define empstatd_lbl 000 `"NIU (not in universe)"'
label define empstatd_lbl 100 `"Employed, not specified"', add
label define empstatd_lbl 110 `"At work"', add
label define empstatd_lbl 111 `"At work, and 'student'"', add
label define empstatd_lbl 112 `"At work, and 'housework'"', add
label define empstatd_lbl 113 `"At work, and 'seeking work'"', add
label define empstatd_lbl 114 `"At work, and 'retired'"', add
label define empstatd_lbl 115 `"At work, and 'no work'"', add
label define empstatd_lbl 116 `"At work, and other situation"', add
label define empstatd_lbl 117 `"At work, family holding, not specified"', add
label define empstatd_lbl 118 `"At work, family holding, not agricultural"', add
label define empstatd_lbl 119 `"At work, family holding, agricultural"', add
label define empstatd_lbl 120 `"Have job, not at work in reference period"', add
label define empstatd_lbl 130 `"Armed forces"', add
label define empstatd_lbl 131 `"Armed forces, at work"', add
label define empstatd_lbl 132 `"Armed forces, not at work in reference period"', add
label define empstatd_lbl 133 `"Military trainee"', add
label define empstatd_lbl 140 `"Marginally employed"', add
label define empstatd_lbl 200 `"Unemployed, not specified"', add
label define empstatd_lbl 201 `"Unemployed 6 or more months"', add
label define empstatd_lbl 202 `"Worked fewer than 6 months, permanent job"', add
label define empstatd_lbl 203 `"Worked fewer than 6 months, temporary job"', add
label define empstatd_lbl 210 `"Unemployed, experienced worker"', add
label define empstatd_lbl 220 `"Unemployed, new worker"', add
label define empstatd_lbl 230 `"No work available"', add
label define empstatd_lbl 240 `"Inactive unemployed"', add
label define empstatd_lbl 300 `"Inactive (not in labor force)"', add
label define empstatd_lbl 310 `"Housework"', add
label define empstatd_lbl 320 `"Unable to work, disabled or health reasons"', add
label define empstatd_lbl 321 `"Permanent disability"', add
label define empstatd_lbl 322 `"Temporary illness"', add
label define empstatd_lbl 323 `"Disabled or imprisoned"', add
label define empstatd_lbl 330 `"In school"', add
label define empstatd_lbl 340 `"Retirees and living on rent"', add
label define empstatd_lbl 341 `"Living on rents"', add
label define empstatd_lbl 342 `"Living on rents or pension"', add
label define empstatd_lbl 343 `"Retirees/pensioners"', add
label define empstatd_lbl 344 `"Retired"', add
label define empstatd_lbl 345 `"Pensioner"', add
label define empstatd_lbl 346 `"Non-retirement pension"', add
label define empstatd_lbl 347 `"Disability pension"', add
label define empstatd_lbl 348 `"Retired without benefits"', add
label define empstatd_lbl 350 `"Elderly"', add
label define empstatd_lbl 351 `"Elderly or disabled"', add
label define empstatd_lbl 360 `"Institutionalized"', add
label define empstatd_lbl 361 `"Prisoner"', add
label define empstatd_lbl 370 `"Intermittent worker"', add
label define empstatd_lbl 371 `"Not working, seasonal worker"', add
label define empstatd_lbl 372 `"Not working, occasional worker"', add
label define empstatd_lbl 380 `"Other income recipient"', add
label define empstatd_lbl 390 `"Inactive, other reasons"', add
label define empstatd_lbl 391 `"Too young to work"', add
label define empstatd_lbl 392 `"Dependent"', add
label define empstatd_lbl 999 `"Unknown/missing"', add
label values empstatd empstatd_lbl

label define occisco_lbl 01 `"Legislators, senior officials and managers"'
label define occisco_lbl 02 `"Professionals"', add
label define occisco_lbl 03 `"Technicians and associate professionals"', add
label define occisco_lbl 04 `"Clerks"', add
label define occisco_lbl 05 `"Service workers and shop and market sales"', add
label define occisco_lbl 06 `"Skilled agricultural and fishery workers"', add
label define occisco_lbl 07 `"Crafts and related trades workers"', add
label define occisco_lbl 08 `"Plant and machine operators and assemblers"', add
label define occisco_lbl 09 `"Elementary occupations"', add
label define occisco_lbl 10 `"Armed forces"', add
label define occisco_lbl 11 `"Other occupations, unspecified or n.e.c."', add
label define occisco_lbl 97 `"Response suppressed"', add
label define occisco_lbl 98 `"Unknown"', add
label define occisco_lbl 99 `"NIU (not in universe)"', add
label values occisco occisco_lbl

label define indgen_lbl 000 `"NIU (not in universe)"'
label define indgen_lbl 010 `"Agriculture, fishing, and forestry"', add
label define indgen_lbl 020 `"Mining"', add
label define indgen_lbl 030 `"Manufacturing"', add
label define indgen_lbl 040 `"Electricity, gas and water"', add
label define indgen_lbl 050 `"Construction"', add
label define indgen_lbl 060 `"Wholesale and retail trade"', add
label define indgen_lbl 070 `"Hotels and restaurants"', add
label define indgen_lbl 080 `"Transportation, storage and communications"', add
label define indgen_lbl 090 `"Financial services and insurance"', add
label define indgen_lbl 100 `"Public administration and defense"', add
label define indgen_lbl 110 `"Services, not specified"', add
label define indgen_lbl 111 `"Real estate and business services"', add
label define indgen_lbl 112 `"Education"', add
label define indgen_lbl 113 `"Health and social work"', add
label define indgen_lbl 114 `"Other services"', add
label define indgen_lbl 120 `"Private household services"', add
label define indgen_lbl 130 `"Other industry, n.e.c."', add
label define indgen_lbl 998 `"Response suppressed"', add
label define indgen_lbl 999 `"Unknown"', add
label values indgen indgen_lbl

label define classwk_lbl 0 `"NIU (not in universe)"'
label define classwk_lbl 1 `"Self-employed"', add
label define classwk_lbl 2 `"Wage/salary worker"', add
label define classwk_lbl 3 `"Unpaid worker"', add
label define classwk_lbl 4 `"Other"', add
label define classwk_lbl 9 `"Unknown/missing"', add
label values classwk classwk_lbl

label define classwkd_lbl 000 `"NIU (not in universe)"'
label define classwkd_lbl 100 `"Self-employed"', add
label define classwkd_lbl 101 `"Self-employed, unincorporated"', add
label define classwkd_lbl 102 `"Self-employed, incorporated"', add
label define classwkd_lbl 110 `"Employer"', add
label define classwkd_lbl 111 `"Sharecropper, employer"', add
label define classwkd_lbl 120 `"Working on own account"', add
label define classwkd_lbl 121 `"Own account, agriculture"', add
label define classwkd_lbl 122 `"Domestic worker, self-employed"', add
label define classwkd_lbl 123 `"Subsistence worker, own consumption"', add
label define classwkd_lbl 124 `"Own account, other"', add
label define classwkd_lbl 125 `"Own account, without temporary/unpaid help"', add
label define classwkd_lbl 126 `"Own account, with temporary/unpaid help"', add
label define classwkd_lbl 130 `"Member of cooperative"', add
label define classwkd_lbl 140 `"Sharecropper"', add
label define classwkd_lbl 141 `"Sharecropper, self-employed"', add
label define classwkd_lbl 142 `"Sharecropper, employee"', add
label define classwkd_lbl 150 `"Kibbutz member"', add
label define classwkd_lbl 200 `"Wage/salary worker"', add
label define classwkd_lbl 201 `"Management"', add
label define classwkd_lbl 202 `"Non-management"', add
label define classwkd_lbl 203 `"White collar (non-manual)"', add
label define classwkd_lbl 204 `"Blue collar (manual)"', add
label define classwkd_lbl 205 `"White or blue collar"', add
label define classwkd_lbl 206 `"Day laborer"', add
label define classwkd_lbl 207 `"Employee, with a permanent job"', add
label define classwkd_lbl 208 `"Employee, occasional, temporary, contract"', add
label define classwkd_lbl 209 `"Employee without legal contract"', add
label define classwkd_lbl 210 `"Wage/salary worker, private employer"', add
label define classwkd_lbl 211 `"Apprentice"', add
label define classwkd_lbl 212 `"Religious worker"', add
label define classwkd_lbl 213 `"Wage/salary worker, non-profit, NGO"', add
label define classwkd_lbl 214 `"White collar, private"', add
label define classwkd_lbl 215 `"Blue collar, private"', add
label define classwkd_lbl 216 `"Paid family worker"', add
label define classwkd_lbl 217 `"Cooperative employee"', add
label define classwkd_lbl 220 `"Wage/salary worker, government"', add
label define classwkd_lbl 221 `"Federal, government employee"', add
label define classwkd_lbl 222 `"State government employee"', add
label define classwkd_lbl 223 `"Local government employee"', add
label define classwkd_lbl 224 `"White collar, public"', add
label define classwkd_lbl 225 `"Blue collar, public"', add
label define classwkd_lbl 226 `"Public companies"', add
label define classwkd_lbl 227 `"Civil servants, local collectives"', add
label define classwkd_lbl 230 `"Domestic worker (work for private household)"', add
label define classwkd_lbl 240 `"Seasonal migrant"', add
label define classwkd_lbl 241 `"Seasonal migrant, no broker"', add
label define classwkd_lbl 242 `"Seasonal migrant, uses broker"', add
label define classwkd_lbl 250 `"Other wage and salary"', add
label define classwkd_lbl 251 `"Canal zone/commission employee"', add
label define classwkd_lbl 252 `"Government employment/training program"', add
label define classwkd_lbl 253 `"Mixed state/private enterprise/parastatal"', add
label define classwkd_lbl 254 `"Government public work program"', add
label define classwkd_lbl 300 `"Unpaid worker"', add
label define classwkd_lbl 310 `"Unpaid family worker"', add
label define classwkd_lbl 320 `"Apprentice, unpaid or unspecified"', add
label define classwkd_lbl 330 `"Trainee"', add
label define classwkd_lbl 340 `"Apprentice or trainee"', add
label define classwkd_lbl 350 `"Works for others without wage"', add
label define classwkd_lbl 400 `"Other"', add
label define classwkd_lbl 999 `"Unknown/missing"', add
label values classwkd classwkd_lbl

label define hrswork1_lbl 000 `"0 hours"'
label define hrswork1_lbl 001 `"1 hour"', add
label define hrswork1_lbl 002 `"2 hours"', add
label define hrswork1_lbl 003 `"3 hours"', add
label define hrswork1_lbl 004 `"4 hours"', add
label define hrswork1_lbl 005 `"5 hours"', add
label define hrswork1_lbl 006 `"6 hours"', add
label define hrswork1_lbl 007 `"7 hours"', add
label define hrswork1_lbl 008 `"8 hours"', add
label define hrswork1_lbl 009 `"9 hours"', add
label define hrswork1_lbl 010 `"10 hours"', add
label define hrswork1_lbl 011 `"11 hours"', add
label define hrswork1_lbl 012 `"12 hours"', add
label define hrswork1_lbl 013 `"13 hours"', add
label define hrswork1_lbl 014 `"14 hours"', add
label define hrswork1_lbl 015 `"15 hours"', add
label define hrswork1_lbl 016 `"16 hours"', add
label define hrswork1_lbl 017 `"17 hours"', add
label define hrswork1_lbl 018 `"18 hours"', add
label define hrswork1_lbl 019 `"19 hours"', add
label define hrswork1_lbl 020 `"20 hours"', add
label define hrswork1_lbl 021 `"21 hours"', add
label define hrswork1_lbl 022 `"22 hours"', add
label define hrswork1_lbl 023 `"23 hours"', add
label define hrswork1_lbl 024 `"24 hours"', add
label define hrswork1_lbl 025 `"25 hours"', add
label define hrswork1_lbl 026 `"26 hours"', add
label define hrswork1_lbl 027 `"27 hours"', add
label define hrswork1_lbl 028 `"28 hours"', add
label define hrswork1_lbl 029 `"29 hours"', add
label define hrswork1_lbl 030 `"30 hours"', add
label define hrswork1_lbl 031 `"31 hours"', add
label define hrswork1_lbl 032 `"32 hours"', add
label define hrswork1_lbl 033 `"33 hours"', add
label define hrswork1_lbl 034 `"34 hours"', add
label define hrswork1_lbl 035 `"35 hours"', add
label define hrswork1_lbl 036 `"36 hours"', add
label define hrswork1_lbl 037 `"37 hours"', add
label define hrswork1_lbl 038 `"38 hours"', add
label define hrswork1_lbl 039 `"39 hours"', add
label define hrswork1_lbl 040 `"40 hours"', add
label define hrswork1_lbl 041 `"41 hours"', add
label define hrswork1_lbl 042 `"42 hours"', add
label define hrswork1_lbl 043 `"43 hours"', add
label define hrswork1_lbl 044 `"44 hours"', add
label define hrswork1_lbl 045 `"45 hours"', add
label define hrswork1_lbl 046 `"46 hours"', add
label define hrswork1_lbl 047 `"47 hours"', add
label define hrswork1_lbl 048 `"48 hours"', add
label define hrswork1_lbl 049 `"49 hours"', add
label define hrswork1_lbl 050 `"50 hours"', add
label define hrswork1_lbl 051 `"51 hours"', add
label define hrswork1_lbl 052 `"52 hours"', add
label define hrswork1_lbl 053 `"53 hours"', add
label define hrswork1_lbl 054 `"54 hours"', add
label define hrswork1_lbl 055 `"55 hours"', add
label define hrswork1_lbl 056 `"56 hours"', add
label define hrswork1_lbl 057 `"57 hours"', add
label define hrswork1_lbl 058 `"58 hours"', add
label define hrswork1_lbl 059 `"59 hours"', add
label define hrswork1_lbl 060 `"60 hours"', add
label define hrswork1_lbl 061 `"61 hours"', add
label define hrswork1_lbl 062 `"62 hours"', add
label define hrswork1_lbl 063 `"63 hours"', add
label define hrswork1_lbl 064 `"64 hours"', add
label define hrswork1_lbl 065 `"65 hours"', add
label define hrswork1_lbl 066 `"66 hours"', add
label define hrswork1_lbl 067 `"67 hours"', add
label define hrswork1_lbl 068 `"68 hours"', add
label define hrswork1_lbl 069 `"69 hours"', add
label define hrswork1_lbl 070 `"70 hours"', add
label define hrswork1_lbl 071 `"71 hours"', add
label define hrswork1_lbl 072 `"72 hours"', add
label define hrswork1_lbl 073 `"73 hours"', add
label define hrswork1_lbl 074 `"74 hours"', add
label define hrswork1_lbl 075 `"75 hours"', add
label define hrswork1_lbl 076 `"76 hours"', add
label define hrswork1_lbl 077 `"77 hours"', add
label define hrswork1_lbl 078 `"78 hours"', add
label define hrswork1_lbl 079 `"79 hours"', add
label define hrswork1_lbl 080 `"80 hours"', add
label define hrswork1_lbl 081 `"81 hours"', add
label define hrswork1_lbl 082 `"82 hours"', add
label define hrswork1_lbl 083 `"83 hours"', add
label define hrswork1_lbl 084 `"84 hours"', add
label define hrswork1_lbl 085 `"85 hours"', add
label define hrswork1_lbl 086 `"86 hours"', add
label define hrswork1_lbl 087 `"87 hours"', add
label define hrswork1_lbl 088 `"88 hours"', add
label define hrswork1_lbl 089 `"89 hours"', add
label define hrswork1_lbl 090 `"90 hours"', add
label define hrswork1_lbl 091 `"91 hours"', add
label define hrswork1_lbl 092 `"92 hours"', add
label define hrswork1_lbl 093 `"93 hours"', add
label define hrswork1_lbl 094 `"94 hours"', add
label define hrswork1_lbl 095 `"95 hours"', add
label define hrswork1_lbl 096 `"96 hours"', add
label define hrswork1_lbl 097 `"97 hours"', add
label define hrswork1_lbl 098 `"98 hours"', add
label define hrswork1_lbl 099 `"99 hours"', add
label define hrswork1_lbl 100 `"100 hours"', add
label define hrswork1_lbl 101 `"101 hours"', add
label define hrswork1_lbl 102 `"102 hours"', add
label define hrswork1_lbl 103 `"103 hours"', add
label define hrswork1_lbl 104 `"104 hours"', add
label define hrswork1_lbl 105 `"105 hours"', add
label define hrswork1_lbl 106 `"106 hours"', add
label define hrswork1_lbl 107 `"107 hours"', add
label define hrswork1_lbl 108 `"108 hours"', add
label define hrswork1_lbl 109 `"109 hours"', add
label define hrswork1_lbl 110 `"110 hours"', add
label define hrswork1_lbl 111 `"111 hours"', add
label define hrswork1_lbl 112 `"112 hours"', add
label define hrswork1_lbl 113 `"113 hours"', add
label define hrswork1_lbl 114 `"114 hours"', add
label define hrswork1_lbl 115 `"115 hours"', add
label define hrswork1_lbl 116 `"116 hours"', add
label define hrswork1_lbl 117 `"117 hours"', add
label define hrswork1_lbl 118 `"118 hours"', add
label define hrswork1_lbl 119 `"119 hours"', add
label define hrswork1_lbl 120 `"120 hours"', add
label define hrswork1_lbl 121 `"121 hours"', add
label define hrswork1_lbl 122 `"122 hours"', add
label define hrswork1_lbl 123 `"123 hours"', add
label define hrswork1_lbl 124 `"124 hours"', add
label define hrswork1_lbl 125 `"125 hours"', add
label define hrswork1_lbl 126 `"126 hours"', add
label define hrswork1_lbl 127 `"127 hours"', add
label define hrswork1_lbl 128 `"128 hours"', add
label define hrswork1_lbl 129 `"129 hours"', add
label define hrswork1_lbl 130 `"130 hours"', add
label define hrswork1_lbl 131 `"131 hours"', add
label define hrswork1_lbl 132 `"132 hours"', add
label define hrswork1_lbl 133 `"133 hours"', add
label define hrswork1_lbl 134 `"134 hours"', add
label define hrswork1_lbl 135 `"135 hours"', add
label define hrswork1_lbl 136 `"136 hours"', add
label define hrswork1_lbl 137 `"137 hours"', add
label define hrswork1_lbl 138 `"138 hours"', add
label define hrswork1_lbl 139 `"139 hours"', add
label define hrswork1_lbl 140 `"140+ hours"', add
label define hrswork1_lbl 998 `"Unknown"', add
label define hrswork1_lbl 999 `"NIU (not in universe)"', add
label values hrswork1 hrswork1_lbl

label define migrate5_lbl 00 `"NIU (not in universe)"'
label define migrate5_lbl 10 `"Same major administrative unit"', add
label define migrate5_lbl 11 `"Same major, same minor administrative unit"', add
label define migrate5_lbl 12 `"Same major, different minor administrative unit"', add
label define migrate5_lbl 20 `"Different major administrative unit"', add
label define migrate5_lbl 30 `"Abroad"', add
label define migrate5_lbl 99 `"Unknown/missing"', add
label values migrate5 migrate5_lbl

label define migratep_lbl 00 `"NIU (not in universe)"'
label define migratep_lbl 10 `"Same major administrative unit"', add
label define migratep_lbl 11 `"Same major, same minor administrative unit"', add
label define migratep_lbl 12 `"Same major, different minor administrative unit"', add
label define migratep_lbl 20 `"Different major administrative unit"', add
label define migratep_lbl 30 `"Abroad"', add
label define migratep_lbl 98 `"Response suppressed"', add
label define migratep_lbl 99 `"Not reported/missing"', add
label values migratep migratep_lbl

label define migctry5_lbl 00000 `"NIU (not in universe)"'
label define migctry5_lbl 10000 `"Africa"', add
label define migctry5_lbl 11000 `"Eastern Africa"', add
label define migctry5_lbl 11010 `"Burundi"', add
label define migctry5_lbl 11020 `"Comoros"', add
label define migctry5_lbl 11030 `"Djibouti"', add
label define migctry5_lbl 11040 `"Eritrea"', add
label define migctry5_lbl 11050 `"Ethiopia"', add
label define migctry5_lbl 11060 `"Kenya"', add
label define migctry5_lbl 11070 `"Madagascar"', add
label define migctry5_lbl 11080 `"Malawi"', add
label define migctry5_lbl 11090 `"Mauritius"', add
label define migctry5_lbl 11100 `"Mozambique"', add
label define migctry5_lbl 11110 `"Reunion"', add
label define migctry5_lbl 11120 `"Rwanda"', add
label define migctry5_lbl 11130 `"Seychelles"', add
label define migctry5_lbl 11140 `"Somalia"', add
label define migctry5_lbl 11150 `"South Sudan"', add
label define migctry5_lbl 11160 `"Uganda"', add
label define migctry5_lbl 11170 `"Tanzania"', add
label define migctry5_lbl 11180 `"Zambia"', add
label define migctry5_lbl 11190 `"Zimbabwe"', add
label define migctry5_lbl 11999 `"Eastern Africa, n.s."', add
label define migctry5_lbl 12000 `"Middle Africa"', add
label define migctry5_lbl 12010 `"Angola"', add
label define migctry5_lbl 12020 `"Cameroon"', add
label define migctry5_lbl 12030 `"Central African Republic"', add
label define migctry5_lbl 12040 `"Chad"', add
label define migctry5_lbl 12050 `"Congo"', add
label define migctry5_lbl 12060 `"Democratic Republic of Congo"', add
label define migctry5_lbl 12070 `"Equatorial Guinea"', add
label define migctry5_lbl 12080 `"Gabon"', add
label define migctry5_lbl 12090 `"Sao Tome and Principe"', add
label define migctry5_lbl 12999 `"Middle Africa, n.s."', add
label define migctry5_lbl 13000 `"Northern Africa"', add
label define migctry5_lbl 13010 `"Algeria"', add
label define migctry5_lbl 13020 `"Egypt/United Arab Rep."', add
label define migctry5_lbl 13030 `"Libya"', add
label define migctry5_lbl 13040 `"Morocco"', add
label define migctry5_lbl 13050 `"Sudan"', add
label define migctry5_lbl 13060 `"Tunisia"', add
label define migctry5_lbl 13070 `"Western Sahara"', add
label define migctry5_lbl 13999 `"Northern Africa, n.s."', add
label define migctry5_lbl 14000 `"Southern Africa"', add
label define migctry5_lbl 14010 `"Botswana"', add
label define migctry5_lbl 14020 `"Lesotho"', add
label define migctry5_lbl 14030 `"Namibia"', add
label define migctry5_lbl 14040 `"South Africa"', add
label define migctry5_lbl 14050 `"Swaziland"', add
label define migctry5_lbl 14999 `"Southern Africa, n.s."', add
label define migctry5_lbl 15000 `"Western Africa"', add
label define migctry5_lbl 15010 `"Benin"', add
label define migctry5_lbl 15020 `"Burkina Faso"', add
label define migctry5_lbl 15030 `"Cape Verde"', add
label define migctry5_lbl 15040 `"Ivory Coast"', add
label define migctry5_lbl 15050 `"Gambia"', add
label define migctry5_lbl 15060 `"Ghana"', add
label define migctry5_lbl 15070 `"Guinea"', add
label define migctry5_lbl 15080 `"Guinea-Bissau"', add
label define migctry5_lbl 15090 `"Liberia"', add
label define migctry5_lbl 15100 `"Mali"', add
label define migctry5_lbl 15110 `"Mauritania"', add
label define migctry5_lbl 15120 `"Niger"', add
label define migctry5_lbl 15130 `"Nigeria"', add
label define migctry5_lbl 15140 `"St. Helena and Ascension"', add
label define migctry5_lbl 15150 `"Senegal"', add
label define migctry5_lbl 15160 `"Sierra Leone"', add
label define migctry5_lbl 15170 `"Togo"', add
label define migctry5_lbl 15999 `"Western Africa, n.s."', add
label define migctry5_lbl 19999 `"Africa, n.s."', add
label define migctry5_lbl 20000 `"Americas"', add
label define migctry5_lbl 21000 `"Caribbean"', add
label define migctry5_lbl 21010 `"Anguilla"', add
label define migctry5_lbl 21020 `"Antigua-Barbuda"', add
label define migctry5_lbl 21030 `"Aruba"', add
label define migctry5_lbl 21040 `"Bahamas"', add
label define migctry5_lbl 21050 `"Barbados"', add
label define migctry5_lbl 21060 `"British Virgin Islands"', add
label define migctry5_lbl 21070 `"Cayman Isles"', add
label define migctry5_lbl 21080 `"Cuba"', add
label define migctry5_lbl 21090 `"Dominica"', add
label define migctry5_lbl 21100 `"Dominican Republic"', add
label define migctry5_lbl 21110 `"Grenada"', add
label define migctry5_lbl 21120 `"Guadeloupe"', add
label define migctry5_lbl 21130 `"Haiti"', add
label define migctry5_lbl 21140 `"Jamaica"', add
label define migctry5_lbl 21150 `"Martinique"', add
label define migctry5_lbl 21160 `"Montserrat"', add
label define migctry5_lbl 21170 `"Netherlands Antilles"', add
label define migctry5_lbl 21180 `"Puerto Rico"', add
label define migctry5_lbl 21190 `"St. Kitts-Nevis"', add
label define migctry5_lbl 21200 `"St. Croix"', add
label define migctry5_lbl 21210 `"St. John"', add
label define migctry5_lbl 21220 `"St. Lucia"', add
label define migctry5_lbl 21230 `"St. Thomas"', add
label define migctry5_lbl 21240 `"St. Vincent"', add
label define migctry5_lbl 21250 `"Trinidad and Tobago"', add
label define migctry5_lbl 21260 `"Turks and Caicos"', add
label define migctry5_lbl 21270 `"U.S. Virgin Islands"', add
label define migctry5_lbl 21280 `"Curacao"', add
label define migctry5_lbl 21290 `"Sint Maarten"', add
label define migctry5_lbl 21999 `"Caribbean, n.s."', add
label define migctry5_lbl 22000 `"Central America"', add
label define migctry5_lbl 22010 `"Belize/British Honduras"', add
label define migctry5_lbl 22020 `"Costa Rica"', add
label define migctry5_lbl 22030 `"El Salvador"', add
label define migctry5_lbl 22040 `"Guatemala"', add
label define migctry5_lbl 22050 `"Honduras"', add
label define migctry5_lbl 22060 `"Mexico"', add
label define migctry5_lbl 22070 `"Nicaragua"', add
label define migctry5_lbl 22080 `"Panama"', add
label define migctry5_lbl 22081 `"Panama Canal Zone"', add
label define migctry5_lbl 22990 `"Central America, n.s."', add
label define migctry5_lbl 22991 `"Central America and Caribbean"', add
label define migctry5_lbl 23000 `"South America"', add
label define migctry5_lbl 23010 `"Argentina"', add
label define migctry5_lbl 23020 `"Bolivia"', add
label define migctry5_lbl 23030 `"Brazil"', add
label define migctry5_lbl 23040 `"Chile"', add
label define migctry5_lbl 23050 `"Colombia"', add
label define migctry5_lbl 23060 `"Ecuador"', add
label define migctry5_lbl 23070 `"Falkland Islands"', add
label define migctry5_lbl 23080 `"French Guiana"', add
label define migctry5_lbl 23090 `"Guyana/British Guiana"', add
label define migctry5_lbl 23100 `"Paraguay"', add
label define migctry5_lbl 23110 `"Peru"', add
label define migctry5_lbl 23120 `"Suriname"', add
label define migctry5_lbl 23130 `"Uruguay"', add
label define migctry5_lbl 23140 `"Venezuela"', add
label define migctry5_lbl 23999 `"South America, n.s."', add
label define migctry5_lbl 24000 `"North America"', add
label define migctry5_lbl 24010 `"Bermuda"', add
label define migctry5_lbl 24020 `"Canada"', add
label define migctry5_lbl 24030 `"Greenland"', add
label define migctry5_lbl 24040 `"United States"', add
label define migctry5_lbl 24041 `"U.S. Outlying Areas and Territories"', add
label define migctry5_lbl 24999 `"North or Central America, n.s."', add
label define migctry5_lbl 29999 `"Americas, n.s."', add
label define migctry5_lbl 30000 `"Asia"', add
label define migctry5_lbl 31000 `"Eastern Asia"', add
label define migctry5_lbl 31010 `"China"', add
label define migctry5_lbl 31011 `"Hong Kong"', add
label define migctry5_lbl 31012 `"Macau"', add
label define migctry5_lbl 31013 `"Taiwan"', add
label define migctry5_lbl 31020 `"Japan"', add
label define migctry5_lbl 31030 `"Korea"', add
label define migctry5_lbl 31031 `"Korea, DPR (North)"', add
label define migctry5_lbl 31032 `"Korea, RO (South)"', add
label define migctry5_lbl 31040 `"Mongolia"', add
label define migctry5_lbl 32000 `"South-Central Asia"', add
label define migctry5_lbl 32010 `"Afghanistan"', add
label define migctry5_lbl 32020 `"Bangladesh"', add
label define migctry5_lbl 32030 `"Bhutan"', add
label define migctry5_lbl 32040 `"India"', add
label define migctry5_lbl 32050 `"Iran"', add
label define migctry5_lbl 32060 `"Kazakhstan"', add
label define migctry5_lbl 32070 `"Kyrgyzstan"', add
label define migctry5_lbl 32080 `"Maldives"', add
label define migctry5_lbl 32090 `"Nepal"', add
label define migctry5_lbl 32100 `"Pakistan"', add
label define migctry5_lbl 32110 `"Sri Lanka (Ceylon)"', add
label define migctry5_lbl 32120 `"Tajikistan"', add
label define migctry5_lbl 32130 `"Turkmenistan"', add
label define migctry5_lbl 32140 `"Uzbekistan"', add
label define migctry5_lbl 32900 `"South Asia, not specified"', add
label define migctry5_lbl 33000 `"South-Eastern Asia"', add
label define migctry5_lbl 33010 `"Brunei"', add
label define migctry5_lbl 33020 `"Cambodia (Kampuchea)"', add
label define migctry5_lbl 33030 `"East Timor"', add
label define migctry5_lbl 33040 `"Indonesia"', add
label define migctry5_lbl 33050 `"Laos"', add
label define migctry5_lbl 33060 `"Malaysia"', add
label define migctry5_lbl 33070 `"Myanmar (Burma)"', add
label define migctry5_lbl 33080 `"Philippines"', add
label define migctry5_lbl 33090 `"Singapore"', add
label define migctry5_lbl 33100 `"Thailand"', add
label define migctry5_lbl 33110 `"Vietnam"', add
label define migctry5_lbl 34000 `"Western Asia"', add
label define migctry5_lbl 34010 `"Armenia"', add
label define migctry5_lbl 34020 `"Azerbaijan"', add
label define migctry5_lbl 34030 `"Bahrain"', add
label define migctry5_lbl 34040 `"Cyprus"', add
label define migctry5_lbl 34050 `"Georgia"', add
label define migctry5_lbl 34060 `"Iraq"', add
label define migctry5_lbl 34070 `"Israel"', add
label define migctry5_lbl 34080 `"Jordan"', add
label define migctry5_lbl 34090 `"Kuwait"', add
label define migctry5_lbl 34100 `"Lebanon"', add
label define migctry5_lbl 34110 `"Palestine"', add
label define migctry5_lbl 34120 `"Oman"', add
label define migctry5_lbl 34130 `"Qatar"', add
label define migctry5_lbl 34140 `"Saudi Arabia"', add
label define migctry5_lbl 34150 `"Syria"', add
label define migctry5_lbl 34151 `"Syria/Lebanon"', add
label define migctry5_lbl 34160 `"Turkey"', add
label define migctry5_lbl 34170 `"United Arab Emirates"', add
label define migctry5_lbl 34180 `"Yemen"', add
label define migctry5_lbl 34999 `"Middle East, n.e.c."', add
label define migctry5_lbl 39999 `"Asia, n.s."', add
label define migctry5_lbl 40000 `"Europe"', add
label define migctry5_lbl 41000 `"Eastern Europe"', add
label define migctry5_lbl 41010 `"Belarus"', add
label define migctry5_lbl 41020 `"Bulgaria"', add
label define migctry5_lbl 41030 `"Czech Republic"', add
label define migctry5_lbl 41040 `"Hungary"', add
label define migctry5_lbl 41050 `"Poland"', add
label define migctry5_lbl 41060 `"Moldova"', add
label define migctry5_lbl 41070 `"Romania"', add
label define migctry5_lbl 41080 `"Russia/USSR"', add
label define migctry5_lbl 41090 `"Slovakia"', add
label define migctry5_lbl 41100 `"Ukraine"', add
label define migctry5_lbl 41999 `"Eastern Europe, n.e.c."', add
label define migctry5_lbl 42000 `"Northern Europe"', add
label define migctry5_lbl 42010 `"Denmark"', add
label define migctry5_lbl 42020 `"Estonia"', add
label define migctry5_lbl 42030 `"Faroe Islands"', add
label define migctry5_lbl 42040 `"Finland"', add
label define migctry5_lbl 42050 `"Iceland"', add
label define migctry5_lbl 42060 `"Ireland"', add
label define migctry5_lbl 42070 `"Latvia"', add
label define migctry5_lbl 42080 `"Lithuania"', add
label define migctry5_lbl 42090 `"Norway"', add
label define migctry5_lbl 42110 `"Sweden"', add
label define migctry5_lbl 42120 `"United Kingdom"', add
label define migctry5_lbl 42199 `"Scandinavia"', add
label define migctry5_lbl 42999 `"Northern Europe, n.e.c."', add
label define migctry5_lbl 43000 `"Southern Europe"', add
label define migctry5_lbl 43010 `"Albania"', add
label define migctry5_lbl 43020 `"Andorra"', add
label define migctry5_lbl 43030 `"Bosnia"', add
label define migctry5_lbl 43040 `"Croatia"', add
label define migctry5_lbl 43050 `"Gibraltar"', add
label define migctry5_lbl 43060 `"Greece"', add
label define migctry5_lbl 43070 `"Italy"', add
label define migctry5_lbl 43080 `"Malta"', add
label define migctry5_lbl 43090 `"Portugal"', add
label define migctry5_lbl 43100 `"San Marino"', add
label define migctry5_lbl 43110 `"Slovenia"', add
label define migctry5_lbl 43120 `"Spain"', add
label define migctry5_lbl 43130 `"Macedonia"', add
label define migctry5_lbl 43140 `"Yugoslavia"', add
label define migctry5_lbl 43141 `"Montenegro"', add
label define migctry5_lbl 43142 `"Serbia"', add
label define migctry5_lbl 43143 `"Kosovo"', add
label define migctry5_lbl 43999 `"Southern Europe, n.s."', add
label define migctry5_lbl 44000 `"Western Europe"', add
label define migctry5_lbl 44010 `"Austria"', add
label define migctry5_lbl 44020 `"Belgium"', add
label define migctry5_lbl 44021 `"Belgium/Luxembourg"', add
label define migctry5_lbl 44022 `"Benelux (Belgium/Netherlands/Luxembourg)"', add
label define migctry5_lbl 44030 `"France"', add
label define migctry5_lbl 44040 `"Germany"', add
label define migctry5_lbl 44050 `"Liechtenstein"', add
label define migctry5_lbl 44060 `"Luxembourg"', add
label define migctry5_lbl 44070 `"Monaco"', add
label define migctry5_lbl 44080 `"Netherlands"', add
label define migctry5_lbl 44090 `"Switzerland"', add
label define migctry5_lbl 44999 `"Western Europe, n.e.c."', add
label define migctry5_lbl 49999 `"Europe, n.s."', add
label define migctry5_lbl 50000 `"Oceania"', add
label define migctry5_lbl 51000 `"Australia and New Zealand"', add
label define migctry5_lbl 51010 `"Australia"', add
label define migctry5_lbl 51020 `"New Zealand"', add
label define migctry5_lbl 51030 `"Norfolk Islands"', add
label define migctry5_lbl 51999 `"Australia and New Zealand, n.s."', add
label define migctry5_lbl 52000 `"Melanesia"', add
label define migctry5_lbl 52010 `"Fiji"', add
label define migctry5_lbl 52020 `"New Caledonia"', add
label define migctry5_lbl 52030 `"Papua New Guinea"', add
label define migctry5_lbl 52040 `"Solomon Islands"', add
label define migctry5_lbl 52050 `"Vanuatu (New Hebrides)"', add
label define migctry5_lbl 52999 `"Melanesia, n.e.c."', add
label define migctry5_lbl 53000 `"Micronesia"', add
label define migctry5_lbl 53010 `"Kiribati"', add
label define migctry5_lbl 53020 `"Marshall Islands"', add
label define migctry5_lbl 53030 `"Nauru"', add
label define migctry5_lbl 53040 `"Northern Mariana Isls."', add
label define migctry5_lbl 53050 `"Palau"', add
label define migctry5_lbl 53999 `"Micronesia, n.e.c."', add
label define migctry5_lbl 54000 `"Polynesia"', add
label define migctry5_lbl 54010 `"Cook Islands"', add
label define migctry5_lbl 54020 `"French Polynesia"', add
label define migctry5_lbl 54030 `"Niue"', add
label define migctry5_lbl 54040 `"Pitcairn Island"', add
label define migctry5_lbl 54050 `"Samoa"', add
label define migctry5_lbl 54060 `"Tokelau"', add
label define migctry5_lbl 54070 `"Tonga"', add
label define migctry5_lbl 54080 `"Tuvalu"', add
label define migctry5_lbl 54090 `"Wallis and Futuna Isls."', add
label define migctry5_lbl 54999 `"Polynesia, n.e.c."', add
label define migctry5_lbl 59999 `"Oceania, n.s."', add
label define migctry5_lbl 60000 `"Other"', add
label define migctry5_lbl 60010 `"Other Arab country"', add
label define migctry5_lbl 90000 `"Non-migrants (international)"', add
label define migctry5_lbl 99998 `"Response suppressed"', add
label define migctry5_lbl 99999 `"Unknown"', add
label values migctry5 migctry5_lbl

label define migyrs1_lbl 00 `"Less than 1 year"'
label define migyrs1_lbl 01 `"1 year (or 1 year or less)"', add
label define migyrs1_lbl 02 `"2 years"', add
label define migyrs1_lbl 03 `"3 years"', add
label define migyrs1_lbl 04 `"4 years"', add
label define migyrs1_lbl 05 `"5 years"', add
label define migyrs1_lbl 06 `"6 years"', add
label define migyrs1_lbl 07 `"7 years"', add
label define migyrs1_lbl 08 `"8 years"', add
label define migyrs1_lbl 09 `"9 years"', add
label define migyrs1_lbl 10 `"10 years"', add
label define migyrs1_lbl 11 `"11 years"', add
label define migyrs1_lbl 12 `"12 years"', add
label define migyrs1_lbl 13 `"13 years"', add
label define migyrs1_lbl 14 `"14 years"', add
label define migyrs1_lbl 15 `"15 years"', add
label define migyrs1_lbl 16 `"16 years"', add
label define migyrs1_lbl 17 `"17 years"', add
label define migyrs1_lbl 18 `"18 years"', add
label define migyrs1_lbl 19 `"19 years"', add
label define migyrs1_lbl 20 `"20 years"', add
label define migyrs1_lbl 21 `"21 years"', add
label define migyrs1_lbl 22 `"22 years"', add
label define migyrs1_lbl 23 `"23 years"', add
label define migyrs1_lbl 24 `"24 years"', add
label define migyrs1_lbl 25 `"25 years"', add
label define migyrs1_lbl 26 `"26 years"', add
label define migyrs1_lbl 27 `"27 years"', add
label define migyrs1_lbl 28 `"28 years"', add
label define migyrs1_lbl 29 `"29 years"', add
label define migyrs1_lbl 30 `"30 years"', add
label define migyrs1_lbl 31 `"31 years"', add
label define migyrs1_lbl 32 `"32 years"', add
label define migyrs1_lbl 33 `"33 years"', add
label define migyrs1_lbl 34 `"34 years"', add
label define migyrs1_lbl 35 `"35 years"', add
label define migyrs1_lbl 36 `"36 years"', add
label define migyrs1_lbl 37 `"37 years"', add
label define migyrs1_lbl 38 `"38 years"', add
label define migyrs1_lbl 39 `"39 years"', add
label define migyrs1_lbl 40 `"40 years"', add
label define migyrs1_lbl 41 `"41 years"', add
label define migyrs1_lbl 42 `"42 years"', add
label define migyrs1_lbl 43 `"43 years"', add
label define migyrs1_lbl 44 `"44 years"', add
label define migyrs1_lbl 45 `"45 years"', add
label define migyrs1_lbl 46 `"46 years"', add
label define migyrs1_lbl 47 `"47 years"', add
label define migyrs1_lbl 48 `"48 years"', add
label define migyrs1_lbl 49 `"49 years"', add
label define migyrs1_lbl 50 `"50 years"', add
label define migyrs1_lbl 51 `"51 years"', add
label define migyrs1_lbl 52 `"52 years"', add
label define migyrs1_lbl 53 `"53 years"', add
label define migyrs1_lbl 54 `"54 years"', add
label define migyrs1_lbl 55 `"55 years"', add
label define migyrs1_lbl 56 `"56 years"', add
label define migyrs1_lbl 57 `"57 years"', add
label define migyrs1_lbl 58 `"58 years"', add
label define migyrs1_lbl 59 `"59 years"', add
label define migyrs1_lbl 60 `"60 years"', add
label define migyrs1_lbl 61 `"61 years"', add
label define migyrs1_lbl 62 `"62 years"', add
label define migyrs1_lbl 63 `"63 years"', add
label define migyrs1_lbl 64 `"64 years"', add
label define migyrs1_lbl 65 `"65 years"', add
label define migyrs1_lbl 66 `"66 years"', add
label define migyrs1_lbl 67 `"67 years"', add
label define migyrs1_lbl 68 `"68 years"', add
label define migyrs1_lbl 69 `"69 years"', add
label define migyrs1_lbl 70 `"70 years"', add
label define migyrs1_lbl 71 `"71 years"', add
label define migyrs1_lbl 72 `"72 years"', add
label define migyrs1_lbl 73 `"73 years"', add
label define migyrs1_lbl 74 `"74 years"', add
label define migyrs1_lbl 75 `"75 years"', add
label define migyrs1_lbl 76 `"76 years"', add
label define migyrs1_lbl 77 `"77 years"', add
label define migyrs1_lbl 78 `"78 years"', add
label define migyrs1_lbl 79 `"79 years"', add
label define migyrs1_lbl 80 `"80 years"', add
label define migyrs1_lbl 81 `"81 years"', add
label define migyrs1_lbl 82 `"82 years"', add
label define migyrs1_lbl 83 `"83 years"', add
label define migyrs1_lbl 84 `"84 years"', add
label define migyrs1_lbl 85 `"85 years"', add
label define migyrs1_lbl 86 `"86 years"', add
label define migyrs1_lbl 87 `"87 years"', add
label define migyrs1_lbl 88 `"88 years"', add
label define migyrs1_lbl 89 `"89 years"', add
label define migyrs1_lbl 90 `"90 years"', add
label define migyrs1_lbl 91 `"91 years"', add
label define migyrs1_lbl 92 `"92 years"', add
label define migyrs1_lbl 93 `"93 years"', add
label define migyrs1_lbl 94 `"94 years"', add
label define migyrs1_lbl 95 `"95+"', add
label define migyrs1_lbl 96 `"Less than 5 years"', add
label define migyrs1_lbl 97 `"More than 5 years"', add
label define migyrs1_lbl 98 `"Unknown"', add
label define migyrs1_lbl 99 `"NIU (not in universe)"', add
label values migyrs1 migyrs1_lbl

label define migcause_lbl 00 `"NIU (not in universe)"'
label define migcause_lbl 10 `"Work"', add
label define migcause_lbl 11 `"Seeking work"', add
label define migcause_lbl 12 `"Job relocation"', add
label define migcause_lbl 13 `"Job assignment"', add
label define migcause_lbl 14 `"Opportunity"', add
label define migcause_lbl 15 `"Proximity to work"', add
label define migcause_lbl 19 `"Other work"', add
label define migcause_lbl 20 `"Family move"', add
label define migcause_lbl 21 `"Follow household head"', add
label define migcause_lbl 22 `"Follow spouse"', add
label define migcause_lbl 23 `"Follow relative"', add
label define migcause_lbl 30 `"Study"', add
label define migcause_lbl 31 `"End of education"', add
label define migcause_lbl 40 `"Marriage, divorce, widowhood"', add
label define migcause_lbl 41 `"Marriage or union"', add
label define migcause_lbl 42 `"Divorce or widowhood"', add
label define migcause_lbl 50 `"Insecurity, disaster, or violence"', add
label define migcause_lbl 51 `"War"', add
label define migcause_lbl 52 `"Violence or insecurity"', add
label define migcause_lbl 53 `"Social or political problems, including security"', add
label define migcause_lbl 54 `"Natural disaster"', add
label define migcause_lbl 58 `"Refugee, reason not specified"', add
label define migcause_lbl 59 `"Asylum seeker, reason not specified"', add
label define migcause_lbl 60 `"Other reason"', add
label define migcause_lbl 61 `"Health"', add
label define migcause_lbl 62 `"Repatriation"', add
label define migcause_lbl 63 `"Retirement"', add
label define migcause_lbl 64 `"House or flat acquisition"', add
label define migcause_lbl 65 `"Housing problems"', add
label define migcause_lbl 66 `"Visiting"', add
label define migcause_lbl 67 `"Ordination"', add
label define migcause_lbl 68 `"Military or institutional housing"', add
label define migcause_lbl 69 `"Other reason, not elsewhere classified"', add
label define migcause_lbl 99 `"Not specified"', add
label values migcause migcause_lbl

label define migmx1_lbl 00 `"NIU (not in universe)"'
label define migmx1_lbl 01 `"Aguascalientes"', add
label define migmx1_lbl 02 `"Baja California"', add
label define migmx1_lbl 03 `"Baja California Sur"', add
label define migmx1_lbl 04 `"Campeche"', add
label define migmx1_lbl 05 `"Coahuila"', add
label define migmx1_lbl 06 `"Colima"', add
label define migmx1_lbl 07 `"Chiapas"', add
label define migmx1_lbl 08 `"Chihuahua"', add
label define migmx1_lbl 09 `"Distrito Federal"', add
label define migmx1_lbl 10 `"Durango"', add
label define migmx1_lbl 11 `"Guanajuato"', add
label define migmx1_lbl 12 `"Guerrero"', add
label define migmx1_lbl 13 `"Hidalgo"', add
label define migmx1_lbl 14 `"Jalisco"', add
label define migmx1_lbl 15 `"México"', add
label define migmx1_lbl 16 `"Michoacán"', add
label define migmx1_lbl 17 `"Morelos"', add
label define migmx1_lbl 18 `"Nayarit"', add
label define migmx1_lbl 19 `"Nuevo León"', add
label define migmx1_lbl 20 `"Oaxaca"', add
label define migmx1_lbl 21 `"Puebla"', add
label define migmx1_lbl 22 `"Querétaro"', add
label define migmx1_lbl 23 `"Quintana Roo"', add
label define migmx1_lbl 24 `"San Luis Potosí"', add
label define migmx1_lbl 25 `"Sinaloa"', add
label define migmx1_lbl 26 `"Sonora"', add
label define migmx1_lbl 27 `"Tabasco"', add
label define migmx1_lbl 28 `"Tamaulipas"', add
label define migmx1_lbl 29 `"Tlaxcala"', add
label define migmx1_lbl 30 `"Veracruz"', add
label define migmx1_lbl 31 `"Yucatán"', add
label define migmx1_lbl 32 `"Zacatecas"', add
label define migmx1_lbl 98 `"Abroad"', add
label define migmx1_lbl 99 `"Unknown"', add
label values migmx1 migmx1_lbl

label define migmx2_lbl 00 `"NIU (not in universe)"'
label define migmx2_lbl 01 `"Aguascalientes"', add
label define migmx2_lbl 02 `"Baja California"', add
label define migmx2_lbl 03 `"Baja California Sur"', add
label define migmx2_lbl 04 `"Campeche"', add
label define migmx2_lbl 05 `"Coahuila"', add
label define migmx2_lbl 06 `"Colima"', add
label define migmx2_lbl 07 `"Chiapas"', add
label define migmx2_lbl 08 `"Chihuahua"', add
label define migmx2_lbl 09 `"Distrito Federal"', add
label define migmx2_lbl 10 `"Durango"', add
label define migmx2_lbl 11 `"Guanajuato"', add
label define migmx2_lbl 12 `"Guerrero"', add
label define migmx2_lbl 13 `"Hidalgo"', add
label define migmx2_lbl 14 `"Jalisco"', add
label define migmx2_lbl 15 `"México"', add
label define migmx2_lbl 16 `"Michoacán"', add
label define migmx2_lbl 17 `"Morelos"', add
label define migmx2_lbl 18 `"Nayarit"', add
label define migmx2_lbl 19 `"Nuevo León"', add
label define migmx2_lbl 20 `"Oaxaca"', add
label define migmx2_lbl 21 `"Puebla"', add
label define migmx2_lbl 22 `"Querétaro"', add
label define migmx2_lbl 23 `"Quintana Roo"', add
label define migmx2_lbl 24 `"San Luis Potosí"', add
label define migmx2_lbl 25 `"Sinaloa"', add
label define migmx2_lbl 26 `"Sonora"', add
label define migmx2_lbl 27 `"Tabasco"', add
label define migmx2_lbl 28 `"Tamaulipas"', add
label define migmx2_lbl 29 `"Tlaxcala"', add
label define migmx2_lbl 30 `"Veracruz"', add
label define migmx2_lbl 31 `"Yucatán"', add
label define migmx2_lbl 32 `"Zacatecas"', add
label define migmx2_lbl 98 `"Abroad"', add
label define migmx2_lbl 99 `"Unknown"', add
label values migmx2 migmx2_lbl

label define disemp_lbl 1 `"Disabled"'
label define disemp_lbl 2 `"Not disabled"', add
label define disemp_lbl 8 `"Unknown"', add
label define disemp_lbl 9 `"NIU (not in universe)"', add
label values disemp disemp_lbl

drop country //this data is only from Mexico 
drop sample //technical variable generated by IPUMS which contains the 
			//same information as is contained in the YEAR variable.
//note that YEAR and PERNUM uniquely identify individuals
replace geo1_mx = geo1_mx - 484000 //geo1_mx variable has 4840 prefix
compress


/*Crosswalk between 2-digit ISIC Rev. 3 industries and industry 
classification in 1990 Mexican Census. *
gen industry_group = .
*agriculture
replace industry_group = 10 if (year==1990 & ind>10000 & ind<20000) | /*
	*/ (year==2000 & ind>100 & ind<120)
*mining
replace industry_group = 20 if (year==1990 & ind>20000 & ind<30000) | /*
	*/(year==2000 & ind>200 & ind<240)
*food, beverages, tobacco
replace industry_group = 30 if (year==1990 & ind>31000 & ind<31100) | /*
	*/ (year==2000 & ind>=310 & ind<=311)
*textiles
replace industry_group = 40 if (year==1990 & ind>=31101 & ind<=31104) |/*
	*/ (year==2000 & ind==313)
*clothing
replace industry_group = 50 if (year==1990 & (ind>=31105 & ind<=31106) |/*
	*/ ind==31211)| (year==2000 & ind==314)
*furniture & manufactures not elsewhere classified
replace industry_group = 60 if (year==1990 & (ind==31311 | ind==32202 |/*
	*/ind==32403 | ind==32500)) | (year==2000 & (ind==336 | ind==337))
*electricity, water, and gas
replace industry_group = 80 if (year==1990 & ind>=41000 & ind<=41999) | /*
	*/(year==2000 & ind>=220 & ind<=222)
*chemicals
replace industry_group = 90 if (year==1990 & (ind>=32101 & ind<=32116))/*
	*/ | (year==2000 & ind==324)
*coke & refined petroleum
replace industry_group = 100 if (year==1990 & ind>=32121 & ind<=32132) |/*
	*/ (year==2000 & ind==323)
*electrical machinery
replace industry_group = 110 if (year==1990 & ind==32421) | /*
	*/(year==2000 & ind==334)
*fabricated metal products
replace industry_group = 120 if (year==1990 & (ind==32401|ind==32402|/*
	*/ind==32404)) | (year==2000 & ind==331)
*basic metals
replace industry_group = 130 if (year==1990 & ind>=32301 & ind<=32399)/*
	*/ | (year==2000 & ind==330)
*machinery & equipment 
replace industry_group = 140 if (year==1990 & (ind==32411|ind==32412))/*
	*/ | (year==2000 & ind==332)
*motor vehicles & transportation equipment
replace industry_group = 150 if (year==1990 & (ind==32431|ind==32432))/*
	*/ | (year==2000 & ind==335)
*office machinery, computers, TV, radio
replace industry_group = 160 if (year==1990 & (ind==32413|ind==32422))/*
	*/ | (year==2000 & ind==333)
*non-metallic mineral products, e.g. glass & cement
replace industry_group = 170 if (year==1990 & (ind==32201|/*
	*/(ind>=32211 & ind<=32222))) | (year==2000 & ind==326)
*paper and paper products
replace industry_group = 180 if (year==1990 & ind==32001) | /*
	*/ (year==2000 & ind==321)
*rubber and plastic products 
 replace industry_group = 190 if (year==1990 & ind>=32141 & ind<=32152)/*
	*/ | (year==2000 & ind==325)
*printing, publishing
replace industry_group = 200 if (year==1990 & ind==32011) | (year==2000/*
	*/ & ind==322)
*manufacture of wood & wood products
replace industry_group = 210 if (year==1990 & ind==3121) | /*
	*/(year==2000 & ind==320)

do "$build\code\label_industries.do"
*/

/*allocate workers in "unspecified" or "other manufacturing" industries
to specified industries as if the distribution for unspecified and
specified were the same. *

//Workers in "unspecified" manufacturing of textiles, clothing, and 
//furniture should be allocated across those 3 sectors as if 
//unspecified distribution is the same as dist. for specified workers.
preserve 
keep if year==1990 & ind>=31101 & ind<=31199
tab ind, generate(ind_dummy)
/* 1= 31101, 2= 31102, 3=31103, 4=31104, 5=31105, 6=31106, 7=31111, 
8=31199*/

local textiles = sum(ind_dummy1)+sum(ind_dummy2)+/*
	*/sum(ind_dummy3)+sum(ind_dummy4)
local clothing = sum(ind_dummy5)+sum(ind_dummy6)
local furniture = sum(ind_dummy7)
local total = `r(N)'-sum(ind_dummy8)
restore

gen randn = runiform() if year==1990 & ind>=31101 & ind<=31199
replace industry_group = 40 if randn!=. & randn<`textiles'/`total'
replace industry_group = 50 if randn<(`textiles'+`clothing')/`total' &/*
	*/ randn>=`textiles'/`total' & randn!=.
replace industry_group = 70 if randn!=. & randn<=1 & /*
	*/randn>=(`textiles'+`clothing')/`total'
	*/
/*need to fill this in for other industries later*/

gen population = perwt*100 if year==1990
replace population = perwt/.04 if year==1995
replace population = perwt*10/.106 if year==2000	

gen hhpop = hhwt*10/.106  if year==2000 
replace hhpop = hhwt*100 if year==1995

replace age = . if age==999
gen age2 = age^2
replace yrschool = . if yrschool>90

*log hourly wage; incearn is monthly earned income
replace hrswork1=. if hrswork1>=998
replace incearn = . if incearn>=99999998
gen ln_wage = ln(incearn/(30/7)/hrswork1)

*create dummy variables
gen urban_dummy = (urban==2)
gen homeowner = (ownership==1)
gen electric_dummy = (electric==1)
gen female = (sex==2)
gen married = (marst==2)
gen lt_primary_school = (edattain==1)
gen primary_school_only = (edattain==2)
gen secondary_school_only = (edattain==3)
gen college_grad = (edattain==4)
gen employed = (empstat==1)
gen secondary_school_plus = (secondary_school_only==1 | college_grad==1)
gen border_state = inlist(geo1_mx,2,26,8,5,19,28)

/*Merge individual variables for intermunicipality and int'l migration*/
merge 1:1 year serial pernum using /*
	*/"$build\input\ipumsi_mex_census90-00_interstatemig.dta"
drop _merge //all merged 

*municipio crosswalk
replace mx2000a_resmun = migmx2*1000 + mx2000a_resmun
merge m:1 mx1995a_resmun mx2000a_resmun  /*
	*/using "$build\temp\municipio_crosswalk.dta"
gen state_munic_code_5yrs_ago = state_munic_code_xwalk
//unmerged observations with mx2000a_resmun==0 have age<=5 
drop _merge	//unmerged municpalities from using are municipality unknown
			//e.g. end in 999 or else unknow code (99998) or NIU (99999)
			//for 1995 or 0 (NIU) or 999 (unknown) for 2000

recast long state_munic_code_5yrs_ago
replace state_munic_code_5yrs_ago= state_munic_code_5yrs_ago+484000000

gen flat_perwt95 = 1/.4 if year==1995

*adjust income for inflation
preserve 
import delimited using "$build\input\mexico_cpi_fred.csv",clear
gen year = substr(date,5,4)
destring year, replace
drop date
order year mex
keep if inlist(year,1990,1995,2000)
save "$build\input\mexico_cpi_fred.dta",replace
restore

merge m:1 year using "$build\input\mexico_cpi_fred.dta"

gen real_incearn = incearn
replace real_incearn = incearn/1000 if year==1990
//put pesos into 2010 pesos
replace real_incearn = real_incearn/(mexcpiallminmei/100)
gen ln_real_incearn = ln(real_incearn)
			
save "$build\temp\mex_census_90_95_00.dta",replace
