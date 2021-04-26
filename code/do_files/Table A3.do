qui global controls_all "i.survey1_social i.survey1_blooddonation i.survey1_othersaltruism survey2_awarenessdeutschesrotesk survey2_awarenesshaema survey2_awarenessuniversitätskli i.age_group i.postsurvey_gender i.postsurvey_migration_any survey2_yearsinbonn survey2_wheredonate_drk survey2_wheredonate_haema survey2_wheredonate_ukb"

qui lasso2 donation_willing $controls_all, postresults 
qui lasso2, lic(aic) postresults 
qui gl lassochosen_y=e(selected)

if "$lassochosen_y"=="." { 
	qui gl lassochosen_y 
		}
		
qui lasso2 socialimage $controls_all, postresults 
qui lasso2, lic(aic) postresults 
qui gl lassochosen_v=e(selected)

if "$lassochosen_v"=="." { 
	qui gl lassochosen_v 
		}
		
qui lasso2 donation_treatment $controls_all, postresults 
qui lasso2, lic(aic) postresults 
qui gl lassochosen_t=e(selected)
 
if "$lassochosen_t"=="." { 
	qui gl lassochosen_t 
		}
		
qui lasso2 groupdummy $controls_all if donation_treatment==1, postresults 
qui lasso2, lic(aic) postresults 
qui gl lassochosen_g=e(selected)

if "$lassochosen_g"=="." { 
	qui gl lassochosen_g 
}

qui logit donation_willing i.visibility_composition, vce(robust)
qui eststo m1: margins, dydx(*) post
qui lincom (4.visibility_composition-2.visibility_composition)- ///
	(3.visibility_composition-1.visibility_composition)
qui loc c_m1 : di %4.3f round(r(estimate), 0.001)
qui loc p_m1 : di %4.3f round(r(p), 0.001)
qui logit donation_willing i.visibility_composition $lassochosen_y ///
	$lassochosen_v $lassochosen_t $lassochosen_g , vce(robust)
qui eststo m2: margins, dydx(*) post
qui lincom (4.visibility_composition-2.visibility_composition)- ///
	(3.visibility_composition-1.visibility_composition)
qui loc c_m2 : di %4.3f round(r(estimate), 0.001)
qui loc p_m2 : di %4.3f round(r(p), 0.001)
qui logit donation_willing i.visibility_composition $lassochosen_y ///
	$lassochosen_v $lassochosen_t $lassochosen_g postsurvey_socialimage, vce(robust)
qui eststo m3: margins, dydx(*) post
qui lincom (4.visibility_composition-2.visibility_composition)- ///
	(3.visibility_composition-1.visibility_composition)
qui loc c_m3 : di %4.3f round(r(estimate), 0.001)
qui loc p_m3 : di %4.3f round(r(p), 0.001)


qui lasso2 donation_willing $controls_all if donation_treatment==0, postresults 
qui lasso2, lic(aic) postresults 
qui gl lassochosen_y=e(selected)

if "$lassochosen_y"=="." { 
	qui gl lassochosen_y 
		}
		
qui lasso2 socialimage $controls_all if donation_treatment==0, postresults 
qui lasso2, lic(aic) postresults 
qui gl lassochosen_v=e(selected)

if "$lassochosen_v"=="." { 
	qui gl lassochosen_v 
		}

qui lasso2 groupdummy $controls_all if donation_treatment==0, postresults 
qui lasso2, lic(aic) postresults 
qui gl lassochosen_g=e(selected)

if "$lassochosen_g"=="." { 
	qui gl lassochosen_g 		
}
		
qui logit donation_willing i.visibility_composition if donation_treatment==0, vce(robust)
qui eststo m4: margins, dydx(*) post
qui lincom (4.visibility_composition-2.visibility_composition)- ///
	(3.visibility_composition-1.visibility_composition)
qui loc c_m4 : di %4.3f round(r(estimate), 0.001)
qui loc p_m4 : di %4.3f round(r(p), 0.001)	
qui logit donation_willing i.visibility_composition $lassochosen_y ///
	$lassochosen_v $lassochosen_g if donation_treatment==0, vce(robust)
qui eststo m5: margins, dydx(*) post
qui lincom (4.visibility_composition-2.visibility_composition)- ///
	(3.visibility_composition-1.visibility_composition)
qui loc c_m5 : di %4.3f round(r(estimate), 0.001)
qui loc p_m5 : di %4.3f round(r(p), 0.001)
qui logit donation_willing i.visibility_composition $lassochosen_y ///
	$lassochosen_v $lassochosen_g postsurvey_socialimage if donation_treatment==0, vce(robust)
qui eststo m6: margins, dydx(*) post
qui lincom (4.visibility_composition-2.visibility_composition)- ///
	(3.visibility_composition-1.visibility_composition)
qui loc c_m6 : di %4.3f round(r(estimate), 0.001)
qui loc p_m6 : di %4.3f round(r(p), 0.001)

qui lasso2 donation_willing $controls_all if donation_treatment==1, postresults 
qui lasso2, lic(aic) postresults 
qui gl lassochosen_y=e(selected)

if "$lassochosen_y"=="." { 
	qui gl lassochosen_y 
		}
		
qui lasso2 socialimage $controls_all if donation_treatment==1, postresults 
qui lasso2, lic(aic) postresults 
qui gl lassochosen_v=e(selected)

if "$lassochosen_v"=="." { 
	qui gl lassochosen_v 
		}
		
qui lasso2 groupdummy $controls_all if donation_treatment==1, postresults 
qui lasso2, lic(aic) postresults 
qui gl lassochosen_g=e(selected)

if "$lassochosen_g"=="." { 
	qui gl lassochosen_g 
		}

qui logit donation_willing i.visibility_composition if donation_treatment==1, vce(robust)
qui eststo m7: margins, dydx(*) post
qui lincom (4.visibility_composition-2.visibility_composition)- ///
	(3.visibility_composition-1.visibility_composition)
qui loc c_m7 : di %4.3f round(r(estimate), 0.001)
qui loc p_m7 : di %4.3f round(r(p), 0.001)
qui logit donation_willing i.visibility_composition $lassochosen_y ///
	$lassochosen_v $lassochosen_g if donation_treatment==1, vce(robust)
qui eststo m8: margins, dydx(*) post
qui lincom (4.visibility_composition-2.visibility_composition)- ///
	(3.visibility_composition-1.visibility_composition)
qui loc c_m8 : di %4.3f round(r(estimate), 0.001)
qui loc p_m8 : di %4.3f round(r(p), 0.001)
qui logit donation_willing i.visibility_composition $lassochosen_y ///
	$lassochosen_v $lassochosen_g postsurvey_socialimage if donation_treatment==1, vce(robust)
qui eststo m9: margins, dydx(*) post
qui lincom (4.visibility_composition-2.visibility_composition)- ///
	(3.visibility_composition-1.visibility_composition)
qui loc c_m9 : di %4.3f round(r(estimate), 0.001)
qui loc p_m9 : di %4.3f round(r(p), 0.001)

qui esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 using "${out}/Table_A3.tex", ///
	keep(*visibility_composition) b(3) se(3) stats(N r2, fmt(%6.0g) labels("Observations" "\(R^{2}\)")) replace

di as res "################################## TABLE A3 ##################################"

estout m1 m2 m3 m4 m5 m6 m7 m8 m9, keep(*visibility_composition) stats( N r2, fmt(%6.0g) ///
		labels("Observations" "R2")) ce(b(fmt(3) label("Coef")) se(par fmt(3))) nobaselevel title("TABLE A3")

preserve
	qui clear
	qui set obs 2
	qui gen varname = ""
	qui replace varname = "Public: Group - Alone" in 1
	qui replace varname = "(p-value)" in 2
	forval col = 1/9{
		qui gen m`col' = ""
	}
	forval col = 1/9{
		qui replace m`col' = "`c_m`col''" in 1
		qui replace m`col' = "`p_m`col''" in 2
	}
	list, sep(100)
restore
