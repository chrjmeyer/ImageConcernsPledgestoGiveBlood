qui gen matched = (!missing(donated_during_study_period))

qui mat input rows_to_fill = (2, 3, 4, 5, 6, 9, 10, 11, 14, 15, 16, 17)
qui loc row_to_pick = 1
foreach command in ///
	"tab donation_treatment socialimage, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 1, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 1 & choose_drk == 1, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 1 & choose_haema == 1, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 0, matcell(A)" ///
	"tab donation_treatment socialimage if matched == 1, matcell(A)" ///
	"tab donation_treatment socialimage if already_donor != 0, matcell(A)" ///
	"tab donation_treatment socialimage if donated_during_study_period & matched == 1, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 1 & matched == 1, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 1 & matched == 1 & donated_during_study_period, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 0 & matched == 1, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 0 & matched == 1 & donated_during_study_period == 1, matcell(A)"{
	qui `command' // execute the command
	qui loc row = rows_to_fill[1, `row_to_pick'] // pick the row of the tbl from the row to be used
	qui mat v = J(1, 5, .) // empty vector, to fill later with the row values
	qui mat v[1, 1] = r(N) // obs number, always in first col, so first element of vector
	qui loc j = 2
	forval r = 1/2{ // this double loop fill the position 2-4 of vector v
		forval c = 1/2{
			qui mat v[1, `j'] = A[`r', `c'] // here it is
			qui loc j = `j' + 1
		}
	}
	forval c = 1/5{
		qui loc t`row'`c' = v[1, `c'] // define the element ij of the table, picking from the vector
	}
	qui loc row_to_pick = `row_to_pick' + 1 // update to pick the next row in the next loop
}
drop matched


preserve
	qui clear
	qui set obs 17
	qui gen varname = ""
	forval col = 1/3{
		qui gen c`col' = ""
	}
	qui loc j = 1
	foreach row in ///
		"a) All study participants" ///
		"Total" ///
		"Pledged a donation in study" ///
		"of which pledged donation with CHARITABLE" ///
		"of which pledged donation with COMMERCIAL" ///
		"Did not pledge a donation in study" ///
		"b) Donor status of study subjects" ///
		"Matched with donor databases" ///
		"of which previously donated with either organization" ///
		"of which donated in study period to either organization" ///
		"c) Pledges and donations" ///
		"Pledged a donation in study" ///
		"of which donated" ///
		"Did not pledge a donation in study" ///
		"of which donated"{
		if "`row'" == "b) Donor status of study subjects"{
		 	qui loc j = `j' + 1
		}
		else if "`row'" == "c) Pledges and donations"{
			qui loc j = `j' + 1
		}
		qui replace varname = "`row'" in `j'
		qui loc j = `j' + 1

	}
	forval row = 1/17{
		forval col = 1/3{
			qui replace c`col' = "`t`row'`col''" in `row'
			if "`t`row'`col''" == "."{
				qui replace c`col' = "0" in `row'
			}
		}
	}
	qui loc j = 1
	foreach col in total_choose private public{
		qui rename c`j' `col'
		qui loc j = `j' + 1
	}
	qui order varname total_choose public private
	di as res "################################### TABLE D1 ###################################"
	list, sep(100) abb(15)
restore
