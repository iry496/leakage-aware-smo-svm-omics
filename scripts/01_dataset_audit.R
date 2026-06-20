# ==============================================================================
# 01_dataset_audit.R
# ------------------------------------------------------------------------------
# Purpose: Build the dataset audit table (Table 1) for the leakage-aware
#          SMO/SVM transcriptomic biomarker classification project.
#
# IMPORTANT (see CLAUDE.md):
#   - This script does NOT download or commit large raw expression matrices.
#   - It records ONLY metadata summaries and accession-level information.
#   - All numeric cohort counts below are PLACEHOLDERS that MUST be verified
#     by a human against the official GEO records before use. They are flagged
#     with the value NA and a "# VERIFY:" comment.
#
# Output: tables/table1_dataset_audit_filled.csv
# ==============================================================================

# ---- Setup -------------------------------------------------------------------
# No internet access or raw-data download is performed here. If, in a later
# version, metadata is pulled programmatically (e.g. via GEOquery::getGEO with
# GSEMatrix = FALSE to fetch series metadata only), keep it metadata-only and
# never persist the full expression matrix to the repository.

suppressPackageStartupMessages({
    library(tibble)
    library(readr)
  })

# Reproducibility: no randomness is used in this audit, but we set a seed so the
# script is consistent with the rest of the guarded pipeline (see CLAUDE.md).
set.seed(42)

# Ensure the output directory exists (tables/ is the canonical output location).
out_dir <- "tables"
if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)

# ---- Audit table -------------------------------------------------------------
# Columns required by the task:
#   geo_accession, role, platform, total_n, pcr_n, rd_n,
#   endpoint_definition, treatment_context, overlap_risk, notes
#
# Roles:
#   "discovery"  -> used for model development / nested CV
#   "external"   -> held-out external validation (NEVER used for feature
#                   selection, threshold/hyperparameter tuning, or batch
#                   correction; see CLAUDE.md scientific rule 4)
#   "optional"   -> candidate cohorts pending inclusion decision

audit <- tibble::tribble(
    ~geo_accession, ~role,        ~platform,            ~total_n, ~pcr_n, ~rd_n, ~endpoint_definition,                              ~treatment_context,                                  ~overlap_risk,                                   ~notes,
    "GSE25055",     "discovery",  "Affymetrix HG-U133A", NA,      NA,     NA,    "pCR vs RD (residual disease) at surgery",         "Neoadjuvant taxane-anthracycline chemotherapy",     "Shares MDACC/MAQC-II cohorts with GSE25065/GSE20194", "MAQC-II / Hatzis et al. discovery series. VERIFY counts vs GEO.",
    "GSE25065",     "external",   "Affymetrix HG-U133A", NA,      NA,     NA,    "pCR vs RD (residual disease) at surgery",         "Neoadjuvant taxane-anthracycline chemotherapy",     "Companion validation series to GSE25055; check sample overlap", "Hatzis et al. validation series. VERIFY counts vs GEO.",
    "GSE20194",     "external",   "Affymetrix HG-U133A", NA,      NA,     NA,    "pCR vs RD at surgery",                            "Neoadjuvant chemotherapy (MAQC-II breast)",         "HIGH: overlaps MAQC-II samples present in GSE25055/65", "Popovici/MAQC-II. Likely sample overlap - confirm GSM IDs.",
    "GSE41998",     "optional",   "Affymetrix HG-U133A", NA,      NA,     NA,    "pCR vs RD at surgery",                            "Neoadjuvant ixabepilone vs paclitaxel",             "Check against discovery cohorts for shared patients",   "OPTIONAL. Include only after independence is confirmed.",
    "GSE20271",     "optional",   "Affymetrix HG-U133A", NA,      NA,     NA,    "pCR vs RD at surgery",                            "Neoadjuvant T/FAC chemotherapy",                    "Check against discovery cohorts for shared patients",   "OPTIONAL. Include only after independence is confirmed."
  )

# ---- Human-verification checklist (DO NOT SKIP) ------------------------------
# The following MUST be confirmed manually from each GEO series page / supplement
# before any of these datasets are used downstream:
#   [ ] Confirm platform (GPL) accession for each series.
#   [ ] Fill total_n, pcr_n, rd_n from the curated clinical annotation, not from
#       the raw GSM count (some GSMs may be excluded for QC or missing endpoint).
#   [ ] Confirm the exact pCR / RD endpoint definition used by each study.
#   [ ] Cross-check GSM identifiers across GSE25055 / GSE25065 / GSE20194 to
#       quantify true sample OVERLAP (critical for leakage control).
#   [ ] Decide inclusion of optional cohorts (GSE41998 / GSE20271) only after
#       independence from discovery/external sets is established.
# These map to the "Current priority" section of CLAUDE.md.

# ---- Write output ------------------------------------------------------------
out_path <- file.path(out_dir, "table1_dataset_audit_filled.csv")
readr::write_csv(audit, out_path)

message("Wrote dataset audit table to: ", out_path)
message("NOTE: numeric cohort counts are NA placeholders pending human verification.")
