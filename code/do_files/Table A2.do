qui global controls_all "i.survey1_social i.survey1_blooddonation i.survey1_othersaltruism survey2_awarenessdeutschesrotesk survey2_awarenesshaema survey2_awarenessuniversitätskli i.age_group i.postsurvey_gender i.postsurvey_migration_any survey2_yearsinbonn"

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
				
qui logit donation_willing socialimage, vce(robust)
qui eststo m0: margins, dydx(*) post
qui logit donation_willing socialimage $lassochosen_y ///
	$lassochosen_v $lassochosen_t, vce(robust)
qui eststo m2: margins, dydx(*) post

qui cap gen interaction= (socialimage==1 & donation_treatment==1)

qui logit donation_willing socialimage donation_treatment interaction, vce(robust) // which is identical to logit donation_willing i.socialimage##i.donation_treatment, vce(robust) -- except that we can compute marginal effects
qui eststo m3: margins, dydx(*) post
qui logit donation_willing socialimage donation_treatment interaction ///
	$lassochosen_y $lassochosen_v $lassochosen_t, vce(robust)
qui eststo m5: margins , dydx(*) post

qui esttab m0 m2 m3 m5 using "${out}/Table_A2.tex", keep(socialimage* donation_treatment* interaction) ///
	b(3) se(3) stats( N r2, fmt(%6.0g) labels("Observations" "\(R^{2}\)")) replace

di as res "################################## TABLE A2 ##################################"

estout m0 m2 m3 m5, keep(socialimage* donation_treatment* interaction) ///
	stats( N r2, fmt(%6.0g) labels("Observations" "R2")) ///
	ce(b(fmt(3) label("Coef")) se(par fmt(3))) nobaselevel title("TABLE A2")
