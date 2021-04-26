** Balance table for completed surveys: Full sample, T1, T2, T3
/* Variables:

Survey on altruism:
- Social engagement	(survey1_social)
- Value of blood donation (survey1_blooddonation)
- Perceiption of altruism in others donating (survey1_othersaltruism)

Survey on institutions:
- Awareness: DRK (survey2_awarenessdeutschesrotesk)
- Would donate: DRK (survey2_wheredonate_drk)
- Awareness: Haema (survey2_awarenesshaema)
- Would donate: Haema (survey2_wheredonate_haema)
- Awareness: UKB (survey2_awarenessuniversitätskli)
- Would donate: UKB (survey2_wheredonate_ukb)

Demographics:
- Age (age)
- Gender (postsurvey_gender)
- Group (postsurvey_group)
- Any migration background (postsurvey_migration_any)
- Years lived in Bonn (tab survey2_yearsinbonn )

Survey conditions:
- Perceived social image (postsurvey_socialimage)
- Perceived attention (postsurvey_attention)
	
*/

* Same as above, without choose
preserve
	qui drop if donation_treatment==2
	* Initalize Excel sheet
	qui putexcel set "${out}/Table_1.xlsx", modify sheet("balancetable_cond_wo_choose",replace)
	qui putexcel A1 = ("Summary Statistics of Variables in Bonn City Hall Experiment, by Treatment Assignment") ///
		A2 = ("Means and Standard Errors")
	qui putexcel B4 = ("Full sample") C4 = ("Not paid, Private") D4 = ("Paid, Private ") ///
		E4 = ("Not paid, Public") F4 = ("Paid, Public") G4 = ("F-test p-value") H4 = ("Kruskal-Wallis p-value")

	* Loop over all relevant variables
	qui loc i = 6 // First row where we start to write into Excel sheet
	foreach v in survey1_social survey1_blooddonation survey1_othersaltruism ///
		survey2_awarenessdeutschesrotesk survey2_wheredonate_drk survey2_awarenesshaema ///
		survey2_wheredonate_haema survey2_awarenessuniversitätskli survey2_wheredonate_ukb ///
		age postsurvey_gender postsurvey_group postsurvey_migration_any survey2_yearsinbonn ///
		postsurvey_socialimage postsurvey_attention {
	
		qui loc varlab : di `"`: var label `v''"' 
		
		* a) Calculate means and se of mean for full sample and treatment groups
		qui mean `v'
		qui mat a = r(table)
		qui loc fullsamplemean = a[1,1]
		qui loc fullsamplese = a[2,1]
		qui loc fullsamplese : di %4.3f round(`fullsamplese', 0.001)

		
		qui mean `v', over(donation_condition)
		qui mat a = r(table)
		qui mat conditionmeans = a[1,1..4]
		* Reformat std errors so that we can write into Excel sheet with brackets
		forval t = 1/7 {
			qui loc se`t' = a[2,`t']
			qui loc se`t' : di %4.3f round(`se`t'', 0.001)
			}

		* b) One-way ANOVA F-test over treatment (for normal
		qui oneway `v' donation_condition 
		qui loc pval_f = Ftail(r(df_m), r(df_r), r(F)) // calculate p-value from F distr
		
		* c) One-way ANOVA on ranks / Kruskal-Wallis test
		* Documented here: http://www.stata.com/manuals13/rkwallis.pdf
		qui kwallis `v', by(donation_condition)
		qui loc pval_kw = chi2tail(r(df),r(chi2_adj))  // calculate p-value from Chi^2
		
		* d) Write into Excel sheet
		qui putexcel A`i' = ("`varlab'") B`i' = (`fullsamplemean') C`i' = matrix(conditionmeans) I`i' = (`pval_f') J`i' = (`pval_kw')
		qui loc ++i	// Go to next row for standard errors
		qui putexcel B`i' = ("(`fullsamplese')") 	C`i' = ("(`se1')")	D`i' = ("(`se2')")	///
			E`i' = ("(`se3')")  F`i' = ("(`se4')")	G`i' = ("(`se5')")	H`i' = ("(`se6')")
		qui loc ++i // Go to next row for next variable
	}
	
	
	* e) Calculate N
	qui loc ++i // Space out by one row
	qui tab donation_condition, matcell(a)
	qui loc fullsampleN=`r(N)'
	qui mat treatmentN=a'
	qui putexcel A`i' = ("N") B`i' = (`fullsampleN') C`i' = matrix(treatmentN)
	
restore



preserve
	qui import excel "${out}/Table_1.xlsx", firstrow allstring cellrange(A4:J39) clear
	qui drop Ftestpvalue KruskalWallispvalue
	qui rename I Ftestpvalue
	qui rename J KruskalWallispvalue
	qui rename A varname
	qui drop if _n == 1
	foreach x in Fullsample NotpaidPrivate PaidPrivate NotpaidPublic PaidPublic ///
		Ftestpvalue KruskalWallispvalue{
		qui gen temp = strpos( `x', ")")
		qui gen first_dot = strpos(`x', ".")
		qui replace `x' = substr(`x', 1, 6) if temp == 0 & first_dot == 3
		qui replace `x' = substr(`x', 1, 5) if temp == 0 & first_dot == 2
		qui replace `x' = string(0) + substr(`x', 1, 4) if temp == 0 & first_dot == 1
		qui drop temp first_dot
	}
	drop Ftestpvalue
	qui replace varname = subinstr(varname, " (5 point likert scale)", " ", 1)
	di as res "################################### TABLE 1 ###################################"
	list, sep(100) ab(8)
restore
