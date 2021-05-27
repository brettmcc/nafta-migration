clear all
set more off,permanently

global build "C:\Users\bmccully\Documents\nafta-migration\build"
global analysis "C:\Users\bmccully\Documents\nafta-migration\analysis"

use $build\input\historical-migration-woodruff\mexstate,clear
keep state mig24rt mig5559

save $build\temp\historical_mig_rts.dta,replace
