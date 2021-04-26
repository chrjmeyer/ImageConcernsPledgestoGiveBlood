****************************************
**                                    **
** Sorting Into Incentives            **
** for Prosocial Behavior:            **
** The Case of Blood Donations        **
**  							 	  **
** Christian Meyer, Egon Tripodi      **
**                                    **
** christian.meyer@eui.eu             **
** egon.tripodi@eui.eu                **
**                                    **
**                                    **
** This file analyzes data from the   **
** field experiment.         	      **
**                                    **
****************************************


*************************************
**** 		 Startup 			*****
*************************************

clear all
set mem 500M
capture log close
set more off, perm
graph set window fontface "Helvetica neue light" 
cap set scheme s1mono 

* Install additional programs using SSC, capture if already installed
foreach p in seq coefplot mixlogit cibar semean estout kdens moremata ralpha lassopack rsource{
	cap which `p'
	if _rc == 111 cap noi ssc install `p'
}
net install dm79

* Define globals for base paths
gl base ""

* Set other paths from base
gl data_confidential "${base}/data_confidential"
gl dopath "${base}/code/do_files"
gl out "${base}/results"
gl logs "${base}/logs"

** Data Analysis

** Table 1
use "${data_confidential}/data_clean.dta", clear
do "${dopath}/Table 1.do" 

** Table 2
use "${data_confidential}/data_clean.dta", clear
do "${dopath}/Table 2.do" 

** Figure 1
use "${data_confidential}/data_clean.dta", clear
do "${dopath}/Figure 1.do"

** Table 3
use "${data_confidential}/data_clean.dta", clear
do "${dopath}/Table 3.do" 

** Table 4
use "${data_confidential}/data_clean.dta", clear
do "${dopath}/Table 4.do" 

** Figure B1
use "${data_confidential}/data_clean.dta", clear
do "${dopath}/Figure B1.do"

** Table A1
use "${data_confidential}/data_table_a1.dta", clear
do "${dopath}/Table A1.do" 

** Table A2
use "${data_confidential}/data_clean.dta", clear
do "${dopath}/Table A2.do"

** Table A3
use "${data_confidential}/data_clean.dta", clear
do "${dopath}/Table A3.do" 

** Table D1
use "${data_confidential}/choose_treatment.dta", clear
do "${dopath}/Table D1.do"
