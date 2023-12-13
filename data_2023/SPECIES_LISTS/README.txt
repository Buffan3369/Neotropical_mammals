This folder contains fossil occurrences datasets with different stages of cleaning/time matching:

	- 1-Raw_Cnz_SA_Mammals_occurrences.csv : Raw South American Mammal occurrences downloaded from PBDB on the 2023-12-11.
	- 2-Matched_Uncleaned_Cnz_SA_Mammals.RDS: Raw occurrences with age range reassigned to time boundaries of the corresponding interval indicated in PBDB (both ICC and SALMA).
	- 3-Fully_cleaned_Cnz_SA_mammals_SALMA_kept.RDS: Fully cleaned Cnz occurrences (no SALMA extension) (only new EOT taxa added!!).
	- 4-Fully_cleaned_Cnz_SA_mammals_SALMA_kept_Tropics_Diet.RDS: Fully cleaned Cnz occurrences with assigned tropical/extratropical affinities and diet
	- 5-Fully_cleaned_EOT_SA_Mammals_SALMA_kept_Tropics_Diet.RDS: Fully cleaned EOT occurrences (+Tropics/diet).
	- 6-Fully_cleaned_EOT_SA_Mammals_SALMA_smoothed.RDS: Fully cleaned EOT occurrences (+Tropics/diet) with smoothed SALMAs, i.e occurrences associated to a SALMA re-assigned to the ICC stage which they most overlapped with.