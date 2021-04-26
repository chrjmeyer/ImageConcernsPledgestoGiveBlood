cls
des, s
gen matched = (!missing(donated_during_study_period))

mat input rows_to_fill = (2, 3, 4, 7, 8, 9, 10)
loc row_to_pick = 1
foreach command in ///
	"tab donation_treatment socialimage, matcell(A)" ///
	"tab donation_treatment socialimage if matched == 1, matcell(A)" ///
	"tab donation_treatment socialimage if already_donor != 0, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 1 & matched == 1, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 1 & matched == 1 & donated_during_study_period, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 0 & matched == 1, matcell(A)" ///
	"tab donation_treatment socialimage if donation_willing == 0 & matched == 1 & donated_during_study_period == 1, matcell(A)"{
	qui `command' // execute the command
	loc row = rows_to_fill[1, `row_to_pick'] // pick the row of the tbl from the row to be used
	mat v = J(1, 5, .) // empty vector, to fill later with the row values
	mat v[1, 1] = r(N) // obs number, always in first col, so first element of vector
	loc j = 2
	forval r = 1/2{ // this double loop fill the position 2-4 of vector v
		forval c = 1/2{
			mat v[1, `j'] = A[`r', `c'] // here it is
			loc j = `j' + 1
		}
	}
	forval c = 1/5{
		loc t`row'`c' = v[1, `c'] // define the element ij of the table, picking from the vector
	}
	loc row_to_pick = `row_to_pick' + 1 // update to pick the next row in the next loop
}
drop matched


preserve
	clear
	set obs 10
	gen varname = ""
	forval col = 1/5{
		qui gen c`col' = ""
	}
	qui loc j = 1
	foreach row in ///
		"a) Name matching and donor status of study subjects" ///
		"All Participants" ///
		"Matched with donor databases" ///
		"Previously donated with either blood collector" ///
		"b) Pledges and donations" ///
		"Pledged a donation in study" ///
		"of which donated" ///
		"Did not pledge a donation in study" ///
		"of which donated"{
		qui replace varname = "`row'" in `j'
		qui loc j = `j' + 1
		if "`row'" == "Previously donated with either blood collector"{
		 	qui loc j = `j' + 1
		}
	}
	forval row = 1/10{
		forval col = 1/5{
			qui replace c`col' = "`t`row'`col''" in `row'
			if "`t`row'`col''" == "."{
				qui replace c`col' = "0" in `row'
			}
		}
	}
	qui loc j = 1
	foreach col in whole_sample char_priv char_publ comm_priv comm_publ{
		qui rename c`j' `col'
		qui loc j = `j' + 1
	}
	di as res "################################### TABLE 4 ###################################"
	list, sep(100) abb(15)
restore
