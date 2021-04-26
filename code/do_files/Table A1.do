* Initalize matrices
qui clear matrix 

* Initalize Excel sheet
qui putexcel set "${out}/Table_A1.xlsx", replace
qui putexcel A1 = ("Summary Statistics of Variables in Bonn City Hall Experiment, by Participation Status") ///
	A2 = ("Means and Standard Errors")
qui putexcel B4 = ("Participated") C4 = ("Aborted") D4 = ("Did not participate") ///
	E4 = ("F-test p-value") F4 = ("Kruskal-Wallis p-value") G4 = ("Study sample")

* Loop over all relevant variables
qui loc i = 6 // First row where we start to write into Excel sheet
foreach v of varlist age_group postsurvey_gender postsurvey_migration_any ///
	postsurvey_group postsurvey_socialimage {

	qui loc varlab : di `"`: var label `v''"' 
	
	* a) Calculate means and se of mean for various groups
	qui mean `v', over(selection)
	qui mat a = r(table)
	if "`v'" == "postsurvey_socialimage" {
		qui mat treatmentmeans = a[1,1..2]
	} 
	else {
		qui mat treatmentmeans = a[1,1..3]
	}
	* Reformat std errors so that we can write into Excel sheet with brackets
	forval t = 1/3 {
		qui loc se`t' = a[2,`t']
		qui loc se`t' : di %4.3f `se`t''
		}

	* b) One-way ANOVA F-test over treatment (for normal
	qui oneway `v' selection 
	qui loc pval_f = Ftail(r(df_m), r(df_r), r(F)) // calculate p-value from F distr
	
	* c) One-way ANOVA on ranks / Kruskal-Wallis test
	* Documented here: http://www.stata.com/manuals13/rkwallis.pdf
	qui kwallis `v', by(selection)
	qui loc pval_kw = chi2tail(r(df),r(chi2_adj))  // calculate p-value from Chi^2
	
	* d) Write into Excel sheet
	qui putexcel A`i' = ("`varlab'") B`i' = matrix(treatmentmeans) ///
		E`i' = (`pval_f') F`i' = (`pval_kw')
	qui loc ++i	// Go to next row for standard errors
	qui putexcel B`i' = ("(`se1')")	C`i' = ("(`se2')")	D`i' = ("(`se3')")
	qui loc ++i // Go to next row for next variable
}

loc i = 6 // First row where we start to write into Excel sheet
foreach v of varlist age_group postsurvey_gender postsurvey_migration_any ///
	postsurvey_group postsurvey_socialimage {

	* a) Calculate means and se of mean for various groups
	qui mean `v'
	qui mat a = r(table)
	qui loc mu : di %4.3f a[1, 1]
	qui loc se : di %4.3f a[2, 1]
	* d) Write into Excel sheet
	qui putexcel G`i' = ("`mu'")
	qui loc ++i	// Go to next row for standard errors
	qui putexcel G`i' = ("(`se')")
	qui loc ++i // Go to next row for next variable
}

loc ++i // Space out by one row
qui tab selection, matcell(a)
qui mat treatmentN=a'
qui putexcel A`i' = ("N") B`i' = matrix(treatmentN)
loc tot = _N
qui putexcel G`i' = ("`tot'")

preserve
	qui import excel "${out}/Table_A1.xlsx", firstrow allstring cellrange(A4:G17) clear
	qui rename A varname
	drop Ftestpvalue
	qui drop if inlist(_n, 1, 10, 11)
	foreach x in Participated Aborted Didnotparticipate KruskalWallispvalue{
		qui gen temp = strpos( `x', ")")
		qui gen first_dot = strpos(`x', ".")
		qui replace `x' = substr(`x', 1, 6) if temp == 0 & first_dot == 3
		qui replace `x' = substr(`x', 1, 5) if temp == 0 & first_dot == 2
		qui replace `x' = string(0) + substr(`x', 1, 4) if temp == 0 & first_dot == 1
		qui drop temp first_dot
	}
	qui gen first_one = strpos(KruskalWallispvalue, "1")
	replace KruskalWallispvalue = "0.000" if first_one == 1
	drop first_one
	qui replace varname = subinstr(varname, " (5 point likert scale)", " ", 1)
	order varname Studysample Participated Aborted Didnotparticipate KruskalWallispvalue
	di as res "################################### TABLE A1 ###################################"
	list, sep(100) ab(8)
restore

