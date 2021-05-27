set more off, permanently
clear all
global build "C:\Users\bmccully\Documents\nafta-migration\build"

insheet using /*
	*/$build\input\Crosswalks\isicr3_oecd_bins-mex90ind-crosswalk.csv/*
	*/, comma clear

reshape long mex90ind, i(description isicr3_oecd_bins) j(index)
drop if mex90ind==.
drop index
rename mex90ind ind
	
save $build\temp\isicr3_oecd_bins-mex90ind-crosswalk, replace
