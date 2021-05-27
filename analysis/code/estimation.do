/*This program estimates the effect of NAFTA's tariff reductions
on migration.*/

clear all
set more off

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

/**STATE-LEVEL**/
use $analysis\input\merged_state,clear

*Decomposition of population change regressions
areg prop_chg_labor_force RTC2_us5yr RTC2_mex5yr,absorb(year) /*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_state.tex",/*
	*/label replace addtext(Year FE, Y) 
areg interst_mig_infl_rt RTC2_us5yr RTC2_mex5yr,absorb(year) /*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_state.tex",/*
	*/label append tex(frag) addtext(Year FE, Y)
areg interst_mig_outfl_rt RTC2_us5yr RTC2_mex5yr,absorb(year) /*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_state.tex",/*
	*/label append tex(frag) addtext(Year FE, Y)
areg intl_return_mig_rt RTC2_us5yr RTC2_mex5yr,absorb(year) /*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_state.tex",/*
	*/label append tex(frag) addtext(Year FE, Y)
areg intl_mig_rt RTC2_us5yr RTC2_mex5yr,absorb(year) /*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_state.tex",/*
	*/label append tex(frag) addtext(Year FE, Y)
	
*International migration regressions
areg intl_mig_rt RTC2_us5yr RTC2_mex5yr,absorb(year) vce(cluster state)
outreg2 using "$analysis\output\tables\state_regs.tex",label replace /*
	*/addtext(Year FE, Y, State FE, N, Controls,N)
areg intl_mig_rt RTC2_us5yr RTC2_mex5yr border_state employed_female_lag/*
	*/ urban_dummy_lag homeowner_lag secondary_school_plus_lag /*
	*/c.chg_prop_ejido_activated_norm#c.RTC2_us5yr /*
	*/c.chg_prop_ejido_activated_norm#c.RTC2_mex5yr /*
	*/ chg_prop_ejido_activated_norm, /*
	*/absorb(year) vce(cluster state)
outreg2 using "$analysis\output\tables\state_regs.tex",label /*
	*/append tex(frag) drop(border_state employed_female_lag/*
	*/ urban_dummy_lag homeowner_lag secondary_school_plus_lag) /*
	*/addtext(Year FE, Y, State FE, N, Controls, Y)
areg intl_mig_rt RTC2_us5yr RTC2_mex5yr employed_female_lag/*
	*/ urban_dummy_lag homeowner_lag secondary_school_plus_lag /*
	*/chg_prop_ejido_activated_norm  i.year /*
	*/c.chg_prop_ejido_activated_norm#c.RTC2_us5yr /*
	*/c.chg_prop_ejido_activated_norm#c.RTC2_mex5yr, /*
	*/absorb(state) vce(cluster state)
outreg2 using "$analysis\output\tables\state_regs.tex",label /*
	*/append tex(frag) drop(employed_female_lag i.year/*
	*/ urban_dummy_lag homeowner_lag secondary_school_plus_lag i.year)/*
	*/ addtext(Year FE, Y, State FE, Y, Controls, Y)
reg intl_mig_rt l5.RTC2_us5yr l5.RTC2_mex5yr
outreg2 using "$analysis\output\tables\state_regs.tex",label /*
	*/append tex(frag) addtext(Year FE, N, State FE, N, Controls, N)
reg intl_mig_rt l5.RTC2_us5yr l5.RTC2_mex5yr border_state /*
	*/ l5.chg_prop_ejido_activated_norm /*
	*/l5.c.chg_prop_ejido_activated_norm#c.l5.RTC2_us5yr /*
	*/l5.c.chg_prop_ejido_activated_norm#c.l5.RTC2_mex5yr, robust
outreg2 using "$analysis\output\tables\state_regs.tex",label /*
	*/append tex(frag) drop(border_state) /*
	*/addtext(Year FE, N, State FE, N, Controls, Y)

//add 10-year regression?


/**MUNICIPALITY-LEVEL**/
use $analysis\input\merged_muni,clear

*International migration regressions
reg intl_mig_rt2 RTC2_us00 RTC2_mex00 [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs.tex",label replace /*
	*/addtext(Weighted, Y, State FE, N, Controls, Y)
areg intl_mig_rt2 RTC2_us00 RTC2_mex00 [aweight=N],absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, N) 
areg intl_mig_rt2 RTC2_us00 RTC2_mex00 /*
	*/secondary_school_plus_lag urban_dummy_lag homeowner_lag /*
	*/employed_female_lag prop_ejido_activated_normalized[aweight=N],/*
	*/absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/ keep(RTC2_us00 RTC2_mex00)

reg intl_mig_rt_partialhh RTC2_us00 RTC2_mex00 [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, N, Controls, Y) 
areg intl_mig_rt_partialhh RTC2_us00 RTC2_mex00 [aweight=N],absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, N) 
areg intl_mig_rt_partialhh RTC2_us00 RTC2_mex00 /*
	*/secondary_school_plus_lag urban_dummy_lag homeowner_lag /*
	*/employed_female_lag prop_ejido_activated_normalized[aweight=N],/*
	*/absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/addnote(Standard errors clustered at state level. Weighted by /*
	*/sample size.) keep(RTC2_us00 RTC2_mex00)
	
//winsorized imputed international emigration rates
use $analysis\input\merged_muni_all_winsorized,clear

*Decomposition of population change regressions
reg prop_chg_labor_force2 RTC2_us00 RTC2_mex00 [aweight=N],/*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_muni.tex",/*
	*/label replace addtext(Weighted, Y) ctitle("% Chg. Pop.")
reg intermn_mig_infl_rt2 RTC2_us00 RTC2_mex00 [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_muni.tex",/*
	*/label append tex(frag) addtext(Weighted, Y) /*
	*/ctitle("Intermuni. Inflow Rate")
reg intermn_mig_outfl_rt2 RTC2_us00 RTC2_mex00 [aweight=N],/*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_muni.tex",/*
	*/label append tex(frag) addtext(Weighted, Y) /*
	*/ctitle("Intermuni. Outflow Rate")
reg intl_return_mig_rt2 RTC2_us00 RTC2_mex00 [aweight=N], /*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_muni.tex",/*
	*/label append tex(frag) addtext(Weighted, Y) /*
	*/ctitle(Intl. Inflow Rate)
reg intl_mig_rt2 RTC2_us00 RTC2_mex00 [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_muni.tex",/*
	*/label append tex(frag) addtext(Weighted, Y) /*
	*/ctitle(Intl. Emig. Rt-Census q.) /*
	*/addnote(Standard errors clustered at state level. Weighted by /*
	*/sample size.)
reg intl_mig_rt_partialhh RTC2_us00 RTC2_mex00 [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\popchg_decomp_muni.tex",/*
	*/label append tex(frag) addtext(Weighted, Y) /*
	*/ctitle(Intl. Emig. Rt-Net Mig. Method)
	
*International migration regressions
reg intl_mig_rt2 RTC2_us00 RTC2_mex00 [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized.tex",label replace /*
	*/addtext(Weighted, Y, State FE, N, Controls, Y) /*
	*/ctitle(Net-mig. method)
areg intl_mig_rt2 RTC2_us00 RTC2_mex00 [aweight=N],absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, N) /*
	*/ctitle(Net-mig. method)	
areg intl_mig_rt2 RTC2_us00 RTC2_mex00 /*
	*/secondary_school_plus_lag urban_dummy_lag homeowner_lag /*
	*/employed_female_lag prop_ejido_activated_normalized [aweight=N],/*
	*/absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/keep(RTC2_us00 RTC2_mex00) /*
	*/ctitle(Net-mig. method)
	
reg intl_mig_rt_partialhh RTC2_us00 RTC2_mex00 [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, N, Controls, Y) /*
	*/ctitle(Census q.)
areg intl_mig_rt_partialhh RTC2_us00 RTC2_mex00 [aweight=N],absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, N) /*
	*/ctitle(Census q.)
areg intl_mig_rt_partialhh RTC2_us00 RTC2_mex00 /*
	*/secondary_school_plus_lag urban_dummy_lag homeowner_lag /*
	*/employed_female_lag prop_ejido_activated_normalized [aweight=N],/*
	*/absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/keep(RTC2_us00 RTC2_mex00) /*
	*/ctitle(Census q.) addnote(Standard errors clustered at state level./*
	*/ Weighted by sample size.)
	
/*Input tariffs*/
use $analysis\input\merged_muni_all_winsorized,clear

corr RTC2_*

*International migration regressions
reg intl_mig_rt2 RTC2_IO_mex00 [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO.tex",label replace /*
	*/addtext(Weighted, Y, State FE, N, Controls, N) /*
	*/ctitle(Net-mig. method)
areg intl_mig_rt2 RTC2_IO_mex00 [aweight=N],absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, N) /*
	*/ctitle(Net-mig. method)	
areg intl_mig_rt2 RTC2_IO_mex00 /*
	*/secondary_school_plus_lag urban_dummy_lag homeowner_lag /*
	*/employed_female_lag prop_ejido_activated_normalized [aweight=N],/*
	*/absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/keep(RTC2_IO_mex00) /*
	*/ctitle(Net-mig. method)
	
reg intl_mig_rt_partialhh RTC2_IO_mex00 [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, N, Controls, N) /*
	*/ctitle(Census q.)
areg intl_mig_rt_partialhh RTC2_IO_mex00 [aweight=N],absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, N) /*
	*/ctitle(Census q.)
areg intl_mig_rt_partialhh RTC2_IO_mex00 /*
	*/secondary_school_plus_lag urban_dummy_lag homeowner_lag /*
	*/employed_female_lag prop_ejido_activated_normalized [aweight=N],/*
	*/absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/keep(RTC2_IO_mex00) /*
	*/ctitle(Census q.) addnote(Standard errors clustered at state level./*
	*/ Weighted by sample size.)
	
*International migration regressions -- all RTC variables in reg.
reg intl_mig_rt2 RTC2_* [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO2.tex",label replace /*
	*/addtext(Weighted, Y, State FE, N, Controls, N) /*
	*/ctitle(Net-mig. method)
areg intl_mig_rt2 RTC2_* [aweight=N],absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO2.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, N) /*
	*/ctitle(Net-mig. method)	
areg intl_mig_rt2 RTC2_* /*
	*/secondary_school_plus_lag urban_dummy_lag homeowner_lag /*
	*/employed_female_lag prop_ejido_activated_normalized [aweight=N],/*
	*/absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO2.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/keep(RTC2_mex00 RTC2_us00 RTC2_IO_mex00) /*
	*/ctitle(Net-mig. method)
	
reg intl_mig_rt_partialhh RTC2_* [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO2.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, N, Controls, N) /*
	*/ctitle(Census q.)
areg intl_mig_rt_partialhh RTC2_* [aweight=N],absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO2.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, N) /*
	*/ctitle(Census q.)
areg intl_mig_rt_partialhh RTC2_* /*
	*/secondary_school_plus_lag urban_dummy_lag homeowner_lag /*
	*/employed_female_lag prop_ejido_activated_normalized [aweight=N],/*
	*/absorb(state) /*
	*/ vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_winsorized_IO2.tex",label /*
	*/append tex(frag) /*
	*/addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/keep(RTC2_mex00 RTC2_us00 RTC2_IO_mex00) /*
	*/ctitle(Census q.) addnote(Standard errors clustered at state level./*
	*/ Weighted by sample size.)	
	
	
	
	
	
	
	
*Regressions -- Adriana's suggestion to start iteratively adding
*regressors to identify what is shifting change to 'wrong' sign.
use $analysis\input\merged_state,clear
reg intl_mig_rt RTC2_us5yr,vce(cluster state)
outreg2 using "$analysis\output\tables\state_regs_5yr_simul.tex", /*
	*/replace label/*
	*/ addtext(Weighted, N, Year FE, N, Controls, N) /*
	*/addnote(Standard errors clustered by state) 
reg intl_mig_rt RTC2_mex5yr,vce(cluster state)
outreg2 using "$analysis\output\tables\state_regs_5yr_simul.tex", append label/*
	*/ addtext(Weighted, N, Year FE, N, Controls, N) tex(frag)
reg intl_mig_rt RTC2_us5yr RTC2_mex5yr,vce(cluster state)
outreg2 using "$analysis\output\tables\state_regs_5yr_simul.tex", append label/*
	*/ addtext(Weighted, N, Year FE, N, Controls, N) tex(frag)
reg intl_mig_rt RTC2_us5yr RTC2_mex5yr i.year,vce(cluster state)
outreg2 using "$analysis\output\tables\state_regs_5yr_simul.tex", append label/*
	*/ addtext(Weighted, N, Year FE, Y, Controls, N) tex(frag) /*
	*/drop(1995b.year 2000.year)
reg intl_mig_rt RTC2_us5yr RTC2_mex5yr i.year secondary_school_plus_lag/*
	*/ urban_dummy_lag homeowner_lag employed_female_lag /*
	*/prop_ejido_activated_normalized,vce(cluster state)
outreg2 using "$analysis\output\tables\state_regs_5yr_simul.tex", append label/*
	*/ addtext(Weighted, N, Year FE, Y, Controls, Y) tex(frag) /*
	*/drop(1995b.year 2000.year employed_female_lag prop_ejido_activated_normalized/*
	*/ urban_dummy_lag homeowner_lag secondary_school_plus_lag)

twoway (scatter intl_mig_rt RTC2_us5yr) (lfit intl_mig_rt RTC2_us5yr) /*
	*/ if year==1995
twoway (scatter intl_mig_rt RTC2_us5yr) (lfit intl_mig_rt RTC2_us5yr) /*
	*/ if year==2000
twoway (scatter intl_mig_rt RTC2_mex5yr) (lfit intl_mig_rt RTC2_mex5yr) /*
	*/if year==1995
twoway (scatter intl_mig_rt RTC2_mex5yr) (lfit intl_mig_rt RTC2_mex5yr) /*
	*/if year==2000
	
	
use $analysis\input\merged_muni,clear

reg intl_mig_rt2 RTC2_us5yr,vce(cluster munic)
outreg2 using "$analysis\output\tables\muni_regs_5yr_simul.tex", /*
	*/replace label/*
	*/ addtext(Weighted, N, Year FE, N, State FE, N, Muni. FE, N, /*
	*/Controls, N) /*
	*/addnote(Standard errors clustered by municipality.) 
reg intl_mig_rt2 RTC2_mex5yr,vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_5yr_simul.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, N, Year FE, N, State FE, N,Muni. FE, N, /*
	*/Controls, N) 
reg intl_mig_rt2 RTC2_us5yr [aweight=N],vce(cluster munic)
outreg2 using "$analysis\output\tables\muni_regs_5yr_simul.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, Year FE, N, State FE,  N,Muni. FE, N, /*
	*/Controls, N) 
reg intl_mig_rt2 RTC2_mex5yr [aweight=N],vce(cluster munic)
outreg2 using "$analysis\output\tables\muni_regs_5yr_simul.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, Year FE, N, State FE, N, Muni. FE, N, /*
	*/Controls, N) 
reg intl_mig_rt2 RTC2_us5yr RTC2_mex5yr [aweight=N],vce(cluster munic)
outreg2 using "$analysis\output\tables\muni_regs_5yr_simul.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, Year FE, N, State FE, N, Muni. FE, N, /*
	*/Controls, N) 
	
reg intl_mig_rt2 RTC2_us5yr RTC2_mex5yr i.year [aweight=N]/*
	*/,vce(cluster munic)
outreg2 using "$analysis\output\tables\muni_regs_5yr_simul2.tex", /*
	*/replace label/*
	*/ addtext(Weighted, Y, Year FE, Y, State FE, N, Muni. FE, N, /*
	*/Controls, N) 
areg intl_mig_rt2 RTC2_us5yr RTC2_mex5yr i.year [aweight=N]/*
	*/,vce(cluster munic) absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_5yr_simul2.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, Year FE, Y, State FE, Y, Muni. FE, N, /*
	*/Controls, N) 
areg intl_mig_rt2 RTC2_us5yr RTC2_mex5yr employed_female_lag/*
	*/ urban_dummy_lag homeowner_lag secondary_school_plus_lag /*
	*/chg_prop_ejido_activated_norm i.year [aweight=N]/*
	*/,vce(cluster munic) absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_5yr_simul2.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, Year FE, Y, State FE, Y, Muni. FE, N, /*
	*/Controls, Y) drop(employed_female_lag/*
	*/ urban_dummy_lag homeowner_lag secondary_school_plus_lag /*
	*/chg_prop_ejido_activated_norm i.year)
areg intl_mig_rt2 RTC2_us5yr RTC2_mex5yr employed_female_lag/*
	*/ urban_dummy_lag homeowner_lag secondary_school_plus_lag /*
	*/chg_prop_ejido_activated_norm i.year [aweight=N]/*
	*/,vce(cluster munic) absorb(munic)
outreg2 using "$analysis\output\tables\muni_regs_5yr_simul2.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, Year FE, Y, State FE, N, Muni. FE, Y, /*
	*/Controls, Y) drop(employed_female_lag/*
	*/ urban_dummy_lag homeowner_lag secondary_school_plus_lag /*
	*/chg_prop_ejido_activated_norm i.year)

**scatter plots

//Import tariffs - 2000
use $analysis\input\merged_muni_winsorized,clear

label variable RTC2_mex00 "RTC-Imports"
label variable RTC2_us00 "RTC-Exports (US)"
label variable intl_mig_rt2 "Intl. Outflow Rate (all obs.)"
label variable intl_mig_rt_partialhh "Intl. Outflow Rate (partial HH)"
twoway (scatter intl_mig_rt2 RTC2_mex00 [aweight=N], /*
	*/msymbol(circle_hollow)) /*
	*/ (lfit intl_mig_rt2 RTC2_mex00 [aweight=N]), /*
	*/title(Net-migration Method)
graph save $analysis\temp\rtc_intlemig_scatter,replace
graph export $analysis\output\graphs\rtcm_intlemig_scatter.png,replace
twoway (scatter intl_mig_rt_partialhh RTC2_mex00 [aweight=N], /*
	*/msymbol(circle_hollow)) /*
	*/ (lfit intl_mig_rt_partialhh RTC2_mex00 [aweight=N]), /*
	*/title(Census Question)
graph save $analysis\temp\rtc_intlemigprtlhh_scatter,replace
graph export $analysis\output\graphs\rtcm_intlemigprtlhh_scatter.png, /*
	*/replace

//export tariffs - 2000
use $analysis\input\merged_muni,clear
label variable RTC2_mex5yr "RTC-Imports"
label variable RTC2_us5yr "RTC-Exports (US)"
label variable intl_mig_rt2 "Intl. Outflow Rate (all obs.)"
label variable intl_mig_rt_partialhh "Intl. Outflow Rate (partial HH)"
twoway (scatter intl_mig_rt2 RTC2_us5yr if year==2000 [aweight=N], /*
	*/msymbol(circle_hollow)) /*
	*/ (lfit intl_mig_rt2 RTC2_us5yr if year==2000 [aweight=N])
graph save $analysis\temp\rtc_intlemig_scatter,replace
graph export $analysis\output\rtcx_intlemig_scatter.png,replace

twoway (scatter intl_mig_rt_partialhh RTC2_us5yr if year==2000 [aweight=N],/*
	*/msymbol(circle_hollow)) /*
	*/ (lfit intl_mig_rt_partialhh RTC2_us5yr if year==2000 [aweight=N])
graph save $analysis\temp\rtc_intlemig_scatter_prtlhh,replace
graph export $analysis\output\rtcx_intlemig_scatter_prtlhh.png,replace

use $analysis\input\merged_muni_winsorized,clear
label variable RTC2_mex5yr "RTC-Imports"
label variable RTC2_us5yr "RTC-Exports (US)"
label variable intl_mig_rt2 "Intl. Outflow Rate (Winsorized 98%)"
twoway (scatter intl_mig_rt2 RTC2_us5yr if year==2000 [aweight=N], /*
	*/msymbol(circle_hollow)) /*
	*/ (lfit intl_mig_rt2 RTC2_us5yr if year==2000 [aweight=N])
graph save $analysis\temp\rtc_intlemig_scatter_winsorized,replace
graph export $analysis\output\rtcx_intlemig_scatter_winsorized.png,replace

graph combine $analysis\temp\rtc_intlemig_scatter.gph /*
	*/$analysis\temp\rtc_intlemig_scatter_prtlhh.gph /*
	*/$analysis\temp\rtc_intlemig_scatter_winsorized.gph, /*
	*/note(Weighted by sample size) /*
	*/title("Correlation between RTC-Exports and Intl. Emigration, 2000")
graph export $analysis\output\graphs\rtcx_intlmigrt_scatter.png,replace

	
/*Autor, Dorn, Hanson (2013) style regressions on LFP and % manuf.*/

//LFP
use $analysis\input\merged_allmuni_10yr, clear
label variable mig5559 "% Migrated 1955-59"

reg chg_lfp RTC2_us00 RTC2_mex00 [aweight=muni_pop],vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_lfp_10yr.tex", /*
	*/replace label ctitle(Chg. LFP)/*
	*/ addtext(Weighted, Y, State FE, N, Controls, N)
areg chg_lfp RTC2_us00 RTC2_mex00 [aweight=muni_pop],vce(cluster state) /*
	*/absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_lfp_10yr.tex", /*
	*/append tex(frag) label ctitle(Chg. LFP)/*
	*/ addtext(Weighted, Y, State FE, Y, Controls, N)
areg chg_lfp RTC2_us00 RTC2_mex00 urban_dummy_lag homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag [aweight=muni_pop],/*
	*/vce(cluster state) absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_lfp_10yr.tex", /*
	*/append tex(frag) label ctitle(Chg. LFP)/*
	*/ addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/keep(RTC2_us00 RTC2_mex00)
	
//Chg. % manufacturing
	
use $analysis\input\merged_allmuni_10yr, clear
label variable mig5559 "% Migrated 1955-59"

reg chg_pct_manufacturing RTC2_us00 RTC2_mex00 [aweight=muni_pop],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_manuf_10yr.tex", /*
	*/replace label ctitle("Chg. Pct. Manuf.")/*
	*/ addtext(Weighted, Y, State FE, N, Controls, N)
areg chg_pct_manufacturing RTC2_us00 RTC2_mex00 [aweight=muni_pop],/*
	*/vce(cluster state) absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_manuf_10yr.tex", /*
	*/append tex(frag) label ctitle("Chg. Pct. Manuf.")/*
	*/ addtext(Weighted, Y, State FE, Y, Controls, N) 
areg chg_pct_manufacturing RTC2_us00 RTC2_mex00 urban_dummy_lag /*
	*/homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag [aweight=muni_pop],/*
	*/vce(cluster state) absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_manuf_10yr.tex", /*
	*/append tex(frag) label ctitle("Chg. Pct. Manuf.")/*
	*/ addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/keep(RTC2_us00 RTC2_mex00)
	
//chg. in wages

use $analysis\input\merged_allmuni_10yr, clear
label variable mig5559 "% Migrated 1955-59"

reg chg_ln_real_incearn RTC2_us00 RTC2_mex00 [aweight=muni_pop],vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_wages_10yr.tex", /*
	*/replace label ctitle("Chg. Ln Wages")/*
	*/ addtext(Weighted, Y, State FE, N, Controls, N)
reg chg_ln_real_incearn RTC2_us00 RTC2_mex00 mig5559 /*
	*/[aweight=muni_pop],vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_wages_10yr.tex", /*
	*/append tex(frag) label ctitle("Chg. Ln Wages")/*
	*/ addtext(Weighted, Y, State FE, N, Controls, N)
areg chg_ln_real_incearn RTC2_us00 RTC2_mex00 [aweight=muni_pop],vce(cluster state) /*
	*/absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_wages_10yr.tex", /*
	*/append tex(frag) label ctitle("Chg. Ln Wages")/*
	*/ addtext(Weighted, Y, State FE, Y, Controls, N)
areg chg_ln_real_incearn RTC2_us00 RTC2_mex00 urban_dummy_lag homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag [aweight=muni_pop],/*
	*/vce(cluster state) absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_wages_10yr.tex", /*
	*/append tex(frag) label ctitle("Chg. Ln Wages")/*
	*/ addtext(Weighted, Y, State FE, Y, Controls, Y) /*
	*/keep(RTC2_us00 RTC2_mex00)
	
	
	
use $analysis\input\merged_muni,clear
label variable mig5559 "% Migrated 1955-59"

*LFP
reg chg_lfp RTC2_us5yr [aweight=N], vce(cluster munic)
outreg2 using "$analysis\output\tables\muni_regs_lfp_5yr_rtcus.tex", /*
	*/replace label/*
	*/ addtext(Weighted, Y, Year FE, N, State FE, N, Muni. FE, N, /*
	*/Controls, N) 
reg chg_lfp RTC2_us5yr i.year [aweight=N], vce(cluster munic)
outreg2 using "$analysis\output\tables\muni_regs_lfp_5yr_rtcus.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, Year FE, Y, State FE, N, Muni. FE, N, /*
	*/Controls, N) keep(RTC2_us5yr RTC2_mex5yr)
areg chg_lfp RTC2_us5yr i.year urban_dummy_lag homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag/*
	*/[aweight=N], vce(cluster munic)/*
	*/absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_lfp_5yr_rtcus.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, Year FE, Y, State FE, Y, Muni. FE, N, /*
	*/Controls, Y)  keep(RTC2_us5yr RTC2_mex5yr)
areg chg_lfp RTC2_us5yr i.year urban_dummy_lag homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag /*
	*/mig5559 [aweight=N], vce(cluster munic)/*
	*/absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_lfp_5yr_rtcus.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, Year FE, Y, State FE, Y, Muni. FE, N, /*
	*/Controls, Y) keep(RTC2_us5yr RTC2_mex5yr)
areg chg_lfp RTC2_us5yr i.year urban_dummy_lag homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag /*
	*/chg_prop_ejido_activated_norm mig5559 [aweight=N], vce(cluster munic)/*
	*/absorb(munic)
outreg2 using "$analysis\output\tables\muni_regs_lfp_5yr_rtcus.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, Year FE, Y, State FE, N, Muni. FE, Y, /*
	*/Controls, Y) keep(RTC2_us5yr RTC2_mex5yr)

reg chg_lfp RTC2_us00 RTC2_mex00 [aweight=N], vce(cluster munic)
outreg2 using "$analysis\output\tables\muni_regs_lfp_5yr_rtcboth.tex", /*
	*/replace label/*
	*/ addtext(Weighted, Y, State FE, N, /*
	*/Controls, N)
areg chg_lfp RTC2_us00 RTC2_mex00 [aweight=N],vce(cluster state) /*
	*/absorb(state)
areg chg_lfp RTC2_us00 RTC2_mex00 urban_dummy_lag homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag/*
	*/[aweight=N], vce(cluster munic)/*
	*/absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_lfp_5yr_rtcboth.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, State FE, Y, /*
	*/Controls, Y) keep(RTC2_us00 RTC2_mex00)
ivregress 2sls chg_lfp RTC2_us00 RTC2_mex00 urban_dummy_lag homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag/*
	*/ (intl_mig_rt2=mig5559) [aweight=N],vce(cluster state)
ivregress 2sls chg_lfp RTC2_us00 RTC2_mex00 urban_dummy_lag homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag/*
	*/ (intl_mig_rt_partialhh=mig5559) [aweight=N],vce(cluster state)
	
*% chg. in manufacturing
reg chg_pct_manufacturing RTC2_us00 RTC2_mex00 [aweight=N],/*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_manuf_5yr_rtcboth.tex", /*
	*/replace label/*
	*/ addtext(Weighted, Y, State FE, N, /*
	*/Controls, N)
reg chg_pct_manufacturing RTC2_us00 RTC2_mex00 mig5559 [aweight=N], /*
	*/vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_manuf_5yr_rtcboth.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, State FE, N, /*
	*/Controls, N) keep(RTC2_us00 RTC2_mex00 mig5559)
areg chg_pct_manufacturing RTC2_us00 RTC2_mex00 [aweight=N], /*
	*/vce(cluster state) absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_manuf_5yr_rtcboth.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, State FE, Y, /*
	*/Controls, N) keep(RTC2_us00 RTC2_mex00)
areg chg_pct_manufacturing RTC2_us00 RTC2_mex00 urban_dummy_lag /*
	*/homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag/*
	*/[aweight=N], vce(cluster state)/*
	*/ absorb(state)
outreg2 using "$analysis\output\tables\muni_regs_manuf_5yr_rtcboth.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, State FE, Y, /*
	*/Controls, Y) keep(RTC2_us00 RTC2_mex00)
	
*chg. in log wages
use $analysis\input\merged_muni_winsorized,clear
label variable mig5559 "% Migrated 1955-59"

reg chg_ln_real_incearn RTC2_us00 RTC2_mex00 /*
	*/[aweight=N], vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_wages.tex", /*
	*/replace label/*
	*/ addtext(Weighted, Y,  /*
	*/Controls, N) ctitle(OLS) keep(RTC2_us00 RTC2_mex00)
reg chg_ln_real_incearn RTC2_us00 RTC2_mex00 mig5559 /*
	*/[aweight=N], vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_wages.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, /*
	*/Controls, N) ctitle(OLS) keep(RTC2_us00 RTC2_mex00 mig5559)
ivregress 2sls chg_ln_real_incearn RTC2_us00 RTC2_mex00 /*
	*/(intl_mig_rt2=mig5559) [aweight=N], vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_wages.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, /*
	*/Controls, N) ctitle(IV) keep(RTC2_us00 RTC2_mex00 intl_mig_rt2)
ivregress 2sls chg_ln_real_incearn RTC2_us00 RTC2_mex00 /*
	*/(intl_mig_rt_partialhh=mig5559) [aweight=N], vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_wages.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, /*
	*/Controls, N) ctitle(IV) /*
	*/keep(RTC2_us00 RTC2_mex00 intl_mig_rt_partialhh)
ivregress 2sls chg_ln_real_incearn RTC2_us00 RTC2_mex00 urban_dummy_lag /*
	*/homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag /*
	*/ (intl_mig_rt2=mig5559) /*
	*/ [aweight=N], vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_wages.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, /*
	*/Controls, Y) ctitle(IV) keep(RTC2_us00 RTC2_mex00 intl_mig_rt2)
ivregress 2sls chg_ln_real_incearn RTC2_us00 RTC2_mex00 urban_dummy_lag /*
	*/homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag /*
	*/ (intl_mig_rt_partialhh=mig5559) /*
	*/ [aweight=N], vce(cluster state)
outreg2 using "$analysis\output\tables\muni_regs_wages.tex", /*
	*/append tex(frag) label/*
	*/ addtext(Weighted, Y, /*
	*/Controls, Y) ctitle(IV) /*
	*/keep(RTC2_us00 RTC2_mex00 intl_mig_rt_partialhh)
	
use $analysis\input\merged_muni_winsorized,clear
areg chg_ln_real_incearn RTC2_us5yr RTC2_mex5yr urban_dummy_lag /*
	*/homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag /*
	*/ if year==2000 [aweight=N], vce(cluster munic)/*
	*/ absorb(state)
ivregress 2sls chg_ln_real_incearn RTC2_us5yr RTC2_mex5yr /*
	*/urban_dummy_lag homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag /*
	*/ (intl_mig_rt2=mig5559) /*
	*/if year==2000 [aweight=N], vce(cluster munic)
	
//10-year
use $analysis\input\merged_muni_10yr,clear
reg chg_lfp RTC2_us00 RTC2_mex00 [aweight=pop90],/*
	*/vce(cluster state)
reg chg_lfp RTC2_us00 RTC2_mex00 mig5559 [aweight=pop90], /*
	*/vce(cluster state)
areg chg_lfp RTC2_us00 RTC2_mex00 urban_dummy_lag /*
	*/homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag/*
	*/[aweight=pop90], vce(cluster state)/*
	*/ absorb(state)

reg chg_pct_manufacturing RTC2_us00 RTC2_mex00 [aweight=pop90],/*
	*/vce(cluster state)
reg chg_pct_manufacturing RTC2_us00 RTC2_mex00 mig5559 [aweight=pop90], /*
	*/vce(cluster state)
areg chg_pct_manufacturing RTC2_us00 RTC2_mex00 urban_dummy_lag /*
	*/homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag/*
	*/[aweight=pop90], vce(cluster state)/*
	*/ absorb(state)

reg chg_ln_real_incearn RTC2_us00 RTC2_mex00 [aweight=pop90],/*
	*/vce(cluster state)
reg chg_ln_real_incearn RTC2_us00 RTC2_mex00 mig5559 [aweight=pop90], /*
	*/vce(cluster state)
areg chg_ln_real_incearn RTC2_us00 RTC2_mex00 urban_dummy_lag /*
	*/homeowner_lag /*
	*/secondary_school_plus_lag employed_female_lag/*
	*/[aweight=pop90], vce(cluster state)/*
	*/ absorb(state)

//Chiquiar et al. specification
reg chg_ln_real_incearn opw_exports employed_female_lag /*
	*/secondary_school_plus_lag mig5559, robust
reg chg_ln_real_incearn opw_exports employed_female_lag /*
	*/secondary_school_plus_lag mig5559 [aweight=pop90], robust
ivregress 2sls chg_ln_real_incearn  employed_female_lag /*
	*/secondary_school_plus_lag mig5559 (opw_exports=RTC2_us00) /*
	*/[aweight=pop90], robust

