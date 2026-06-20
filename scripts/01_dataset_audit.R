# Dataset audit script.
# Goal: create Table 1 with sample counts, endpoint labels, platform, and cohort roles.

source("R/00_config.R")

# TODO:
# 1. Download GEO metadata for candidate accessions using GEOquery.
# 2. Extract sample IDs, platform, treatment notes, and pCR/RD labels.
# 3. Check for duplicate GSM IDs or duplicate sample identifiers across cohorts.
# 4. Export tables/table1_dataset_audit_filled.csv.

message("Dataset audit scaffold. Implement GEOquery extraction after locking accessions.")
