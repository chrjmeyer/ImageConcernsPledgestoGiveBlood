qui gen socialimageandgroup=1
qui replace socialimageandgroup = 2 if socialimage ==1 & groupdummy==0
qui replace socialimageandgroup = 3 if socialimage ==0 & groupdummy==1
qui replace socialimageandgroup = 4 if socialimage ==1 & groupdummy==1
qui la define socialimageandgroup 1 "Alone, Private" 2 "Alone, Public" 3 "Group, Private" 4 "Group, Public"
qui la val socialimageandgroup socialimageandgroup

qui by socialimageandgroup,sort: egen pledging_rate_any=mean(donation_willing)
qui by socialimageandgroup,sort: egen pledging_rate_count=count(donation_willing)
qui by socialimageandgroup,sort: egen pledging_rate_sd=sd(donation_willing)
qui gen pledging_rate_semean = pledging_rate_sd/sqrt(pledging_rate_count)
qui gen ul_any = pledging_rate_any + 1.96*pledging_rate_semean
qui gen ll_any = pledging_rate_any - 1.96*pledging_rate_semean
qui drop pledging_rate_count pledging_rate_sd pledging_rate_semean

qui by socialimageandgroup donation_treatment,sort: egen pledging_rate=mean(donation_willing)
qui by socialimageandgroup donation_treatment,sort: egen pledging_rate_count=count(donation_willing)
qui by socialimageandgroup donation_treatment,sort: egen pledging_rate_sd=sd(donation_willing)
qui gen pledging_rate_semean = pledging_rate_sd/sqrt(pledging_rate_count)
qui gen ul = pledging_rate + 1.96*pledging_rate_semean
qui gen ll = pledging_rate - 1.96*pledging_rate_semean



qui twoway (bar pledging_rate_any socialimageandgroup, color(red) fintensity(inten100) ///
	barw(0.4) ytitle("") xtitle("") title("(a) Charitable & Commercial Pooled", color(black)) ///
	ylabel(0(0.10)0.6, labsize(medium)) xlabel(,valuelabel labsize(medium) angle(30))) ///
	(rcap ll_any ul_any socialimageandgroup, color(black)), ///
	graphregion(color(white)) graphregion(margin(0 0 0 0)) legend(off) name(graph0,replace)
qui twoway (bar pledging_rate socialimageandgroup if donation_treatment==0, color(red) ///
	fintensity(inten100) barw(0.4) ytitle("") xtitle("") title("(b) Charitable", color(black)) ///
	ylabel(0(0.10)0.6, labsize(medium)) xlabel(,valuelabel labsize(medium) angle(30))) ///
	(rcap ll ul socialimageandgroup if donation_treatment==0, color(black)), ///
	graphregion(color(white)) graphregion(margin(0 0 0 0)) legend(off) name(graph1,replace)
qui twoway (bar pledging_rate socialimageandgroup if donation_treatment==1, color(red) ///
	fintensity(inten100) barw(0.4) ytitle("") xtitle("") title("(c) Commercial", color(black)) ///
	ylabel(0(0.10)0.6, labsize(medium)) xlabel(,valuelabel labsize(medium) angle(30))) ///
	(rcap ll ul socialimageandgroup if donation_treatment==1, color(black)), ///
	graphregion(color(white)) graphregion(margin(0 0 0 0)) legend(off) name(graph2,replace)
qui graph combine graph0 graph1 graph2, graphregion(color(white)) ///
	graphregion(margin(8 1 0 0)) ysize(2) xsize(5) ycommon row(1) scale(1.3)
qui graph export "${out}/Figure_1.png", replace width(500)

	
