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
				
//interaction
qui eststo m0: reg donation_willing i.socialimage, vce(robust)
*eststo m1: reg donation_willing i.socialimage $controls_all, vce(robust)
qui eststo m2: reg donation_willing i.socialimage $lassochosen_y ///
	$lassochosen_v $lassochosen_t, vce(robust)

qui eststo m3: reg donation_willing i.socialimage##i.donation_treatment, vce(robust)
*eststo m4: reg donation_willing i.socialimage##i.donation_treatment $controls_all, vce(robust)
qui eststo m5: reg donation_willing i.socialimage##i.donation_treatment ///
	$lassochosen_y $lassochosen_v $lassochosen_t, vce(robust)

qui esttab m0 m2 m3 m5 using "${out}/Table_2.tex", keep(1.socialimage* 1.donation_treatment* _cons) ///
	b(3) se(3) stats( N r2, fmt(%6.0g) labels("Observations" "\(R^{2}\)")) replace

di as res "################################## TABLE 2 ##################################"

estout m0 m2 m3 m5, keep(1.socialimage* 1.donation_treatment* _cons) ///
	stats( N r2, fmt(%6.0g) labels("Observations" "R2")) ///
	ce(b(fmt(3) label("Coef")) se(par fmt(3))) nobaselevel title("TABLE 2")


* Baseline means
mean donation_willing if socialimage==0 //cols 1-2
mean donation_willing if socialimage==0 & donation_treatment==0 //cols 3-4

/*
//split sample
reg donation_willing socialimage  if donation_treatment==0, vce(robust)
reg donation_willing socialimage $controls_all if donation_treatment==0, vce(robust)

reg donation_willing socialimage  if donation_treatment==1, vce(robust)
reg donation_willing socialimage $controls_all if donation_treatment==1, vce(robust)



