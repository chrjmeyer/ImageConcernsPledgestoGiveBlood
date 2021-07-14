*************************************
**** 		 Startup 			*****
*************************************

clear all
set mem 500M
capture log close _all
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
gl data "${base}/data"
gl dopath "${base}/code/do_files"
gl out "${base}/results"
gl logs "${base}/logs"

** Data Analysis

** Table 1
use "${data}/main.dta", clear
do "${dopath}/Table 1.do" 

** Table 2
use "${data}/main.dta", clear
do "${dopath}/Table 2.do" 

** Figure 1
use "${data}/main.dta", clear
do "${dopath}/Figure 1.do"

** Table 3
use "${data}/main.dta", clear
do "${dopath}/Table 3.do" 

** Table 4
use "${data}/data_table_4.dta", clear
do "${dopath}/Table 4.do" 

** Figure B1
use "${data}/main.dta", clear
rename survey2_awarenessuniversitätskli survey2_awarenessuniversitatskli
save "${data}/tempfile_for_R.dta", replace
do "${dopath}/Figure B1.do"
erase "${data}/tempfile_for_R.dta"

** Table A1
use "${data}/data_table_a1.dta", clear
do "${dopath}/Table A1.do"

** Table A2
use "${data}/main.dta", clear
do "${dopath}/Table A2.do"

** Table A3
use "${data}/main.dta", clear
do "${dopath}/Table A3.do" 

** Table B1a
use "${data}/main.dta", clear
do "${dopath}/Table B1a.do" 

** Table B1b
use "${data}/main.dta", clear
do "${dopath}/Table B1b.do" 

** Table D1
use "${data}/data_table_d1.dta", clear
do "${dopath}/Table D1.do"
