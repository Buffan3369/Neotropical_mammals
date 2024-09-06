This folder contains fossil occurrences datasets with different stages of cleaning/time matching:

	- 1-Raw_Cnz_SA_Mammals_occurrences.csv : Raw South American Mammal occurrences downloaded from PBDB on the 2023-12-11.
	- 2-Matched_Uncleaned_Cnz_SA_Mammals.RDS: Raw occurrences with age range reassigned to time boundaries of the corresponding interval indicated in PBDB (both ICC and SALMA).
	- 3-Fully_cleaned_Cnz_SA_mammals_SALMA_kept.RDS: Fully cleaned Cnz occurrences (no SALMA extension) (only new EOT taxa added!!).
	- 4-Fully_cleaned_Cnz_SA_mammals_SALMA_kept_Tropics_Diet.RDS: Fully cleaned Cnz occurrences with assigned tropical/extratropical affinities and diet
	- 5-Fully_cleaned_EOT_SA_Mammals_SALMA_kept_Tropics_Diet.RDS: Fully cleaned EOT occurrences (+Tropics/diet).
	- 6-Fully_cleaned_EOT_SA_Mammals_SALMA_smoothed.RDS: Fully cleaned EOT occurrences (+Tropics/diet) with smoothed SALMAs, i.e occurrences associated to a SALMA re-assigned to the ICC stage which they most overlapped with.
	- 7-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_kept_Tropics_Diet.RDS: Fully cleaned Late Palaeocene-Early Miocene occurrences with assigned tropical/extratropical affinities and diet
	- 8-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_smoothed_Tropics_Diet.RDS: Fully cleaned Late Palaeocene-Early Miocene occurrences with assigned tropical/extratropical affinities and diet (SALMA smoothed, i.e occurrences associated to a SALMA re-assigned to the ICC stage which they most overlapped with)
	- 9-Fully_cleaned_EOT_extended_SA_Mammals_SALMA_smoothed_Tropics_Diet-CTA-TAR-Olig.RDS: Same as 8 but after allowing occurrences from key Eocene levels of the localities of Contamata and Tarapoto to have an Early Oligocene age.
	


nb. Note that most of the cleaning effort has been made for the Eocene-Oligocene occurrences. Hence, datasets extending from Late Palaeoncene to Early Miocene are likely to comprise errors, which does not affect Eocene-Oligocene inference.




## Additional information: how to open a .RDS file?

.RDS ("R Data Serialisation") is a built-in compression format in R. Therefore, to open a .RDS file (e.g. "file1.rds"), simply type in an R console

						data <- readRDS("file1.rds")

That way, the content of file1.rds will be stored within the local variable `data`.
