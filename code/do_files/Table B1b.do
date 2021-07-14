qui global controls_all "groupdummy i.survey1_social i.survey1_blooddonation i.survey1_othersaltruism survey2_awarenessdeutschesrotesk survey2_awarenesshaema survey2_awarenessuniversitätskli i.postsurvey_gender i.postsurvey_migration_any survey2_yearsinbonn survey2_wheredonate_drk survey2_wheredonate_haema survey2_wheredonate_ukb"

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

gen age_above30 = 1 if inrange(age,31,100)  //above median in the sample
replace  age_above30 = 0 if inrange(age,18,30) 

egen visibility_age = concat(socialimage age_above30)
replace visibility_age = "1" if visibility_age == "00"
replace visibility_age = "2" if visibility_age == "01"
replace visibility_age = "3" if visibility_age == "10"
replace visibility_age = "4" if visibility_age == "11"
destring visibility_age, replace

qui eststo m1: reg donation_willing i.visibility_age, vce(robust)
qui lincom (4.visibility_age-2.visibility_age)- ///
	(3.visibility_age-1.visibility_age)
qui loc c_m1 : di %4.3f round(r(estimate), 0.001)
qui loc p_m1 : di %4.3f round(r(p), 0.001)
qui eststo m2: reg donation_willing i.visibility_age $lassochosen_y ///
	$lassochosen_v $lassochosen_t $lassochosen_g , vce(robust)
qui lincom (4.visibility_age-2.visibility_age)- ///
	(3.visibility_age-1.visibility_age)
qui loc c_m2 : di %4.3f round(r(estimate), 0.001)
qui loc p_m2 : di %4.3f round(r(p), 0.001)
qui eststo m3: reg donation_willing i.visibility_age $lassochosen_y ///
	$lassochosen_v $lassochosen_t $lassochosen_g postsurvey_socialimage, vce(robust)
qui lincom (4.visibility_age-2.visibility_age)- ///
	(3.visibility_age-1.visibility_age)
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
		
qui eststo m4: reg donation_willing i.visibility_age if donation_treatment==0, vce(robust)
qui lincom (4.visibility_age-2.visibility_age)- ///
	(3.visibility_age-1.visibility_age)
qui loc c_m4 : di %4.3f round(r(estimate), 0.001)
qui loc p_m4 : di %4.3f round(r(p), 0.001)	
qui eststo m5: reg donation_willing i.visibility_age $lassochosen_y ///
	$lassochosen_v $lassochosen_g if donation_treatment==0, vce(robust)
qui lincom (4.visibility_age-2.visibility_age)- ///
	(3.visibility_age-1.visibility_age)
qui loc c_m5 : di %4.3f round(r(estimate), 0.001)
qui loc p_m5 : di %4.3f round(r(p), 0.001)
qui eststo m6: reg donation_willing i.visibility_age $lassochosen_y ///
	$lassochosen_v $lassochosen_g postsurvey_socialimage if donation_treatment==0, vce(robust)
qui lincom (4.visibility_age-2.visibility_age)- ///
	(3.visibility_age-1.visibility_age)
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

qui eststo m7: reg donation_willing i.visibility_age if donation_treatment==1, vce(robust)
qui lincom (4.visibility_age-2.visibility_age)- ///
	(3.visibility_age-1.visibility_age)
qui loc c_m7 : di %4.3f round(r(estimate), 0.001)
qui loc p_m7 : di %4.3f round(r(p), 0.001)
qui eststo m8: reg donation_willing i.visibility_age $lassochosen_y ///
	$lassochosen_v $lassochosen_g if donation_treatment==1, vce(robust)
qui lincom (4.visibility_age-2.visibility_age)- ///
	(3.visibility_age-1.visibility_age)
qui loc c_m8 : di %4.3f round(r(estimate), 0.001)
qui loc p_m8 : di %4.3f round(r(p), 0.001)
qui eststo m9: reg donation_willing i.visibility_age $lassochosen_y ///
	$lassochosen_v $lassochosen_g postsurvey_socialimage if donation_treatment==1, vce(robust)
qui lincom (4.visibility_age-2.visibility_age)- ///
	(3.visibility_age-1.visibility_age)
qui loc c_m9 : di %4.3f round(r(estimate), 0.001)
qui loc p_m9 : di %4.3f round(r(p), 0.001)


qui esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 using "${out}/Table_B1b.tex", keep(*visibility_age _cons) ///
	b(3) se(3) stats(N r2, fmt(%6.0g) labels("Observations" "\(R^{2}\)")) replace

di as res "################################## TABLE B1 Panel B ##################################"

estout m1 m2 m3 m4 m5 m6 m7 m8 m9, keep(*visibility_age _cons) ///
	stats( N r2, fmt(%6.0g) labels("Observations" "R2")) ///
	ce(b(fmt(3) label("Coef")) se(par fmt(3))) nobaselevel title("TABLE B1a")

preserve
	qui clear
	qui set obs 2
	qui gen varname = ""
	qui replace varname = "Public: Age below 30 - Age at least 30" in 1
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
