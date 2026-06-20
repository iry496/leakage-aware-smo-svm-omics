# Pilot notes: leaky vs nested SMO/SVM on GSE25055

This file tracks warnings and unresolved issues for the first pilot
(branch: `pilot-leaky-vs-nested-gse25055`).

## Scope

- GSE25055 **only** (discovery cohort, GPL96 / HG-U133A).
- Labels: pCR vs RD from `pathologic_response_pcr_rd`; NA-coded samples excluded.
- Single feature budget: top K = 100. Feature selector: t-test.
- No external validation; no GSE25065 / GSE41998 / GSE20194 / GSE20271.
- No SMOTE in this pilot; class imbalance handled with class weights.

## Run status

- [ ] `scripts/02_leaky_baseline_gse25055.R` executed
- [ ] `scripts/03_nested_smo_svm_gse25055.R` executed
- [ ] `notebooks/02_pilot_leaky_vs_nested_gse25055.qmd` rendered

> NOTE: As committed, the code has **not** yet been executed. These scripts
> were authored and committed via the GitHub web interface, where no R runtime,
> network access to GEO, or Bioconductor packages are available. They must be
> run locally (or in CI) to produce the CSV / session-info outputs below.

## Expected output files (produced by running the scripts/notebook)

- `tables/pilot_gse25055/pilot_performance_comparison.csv`
- `results/pilot_gse25055/pilot_predictions.csv`
- `results/pilot_gse25055/pilot_session_info.txt`
- Per-pipeline: `leaky_baseline_metrics.csv`, `nested_smo_svm_metrics.csv`,
  `*_predictions.csv`, `leaky_baseline_selected_features.csv`,
  `nested_smo_svm_fold_info.csv`.

## Required packages

- CRAN: `caret`, `e1071`, `pROC`, `PRROC` (see `environment/packages.R`).
- Bioconductor: `GEOquery`, `Biobase` (for loading GSE25055).

## Known warnings / unresolved issues

1. **Label field robustness.** The loader searches `pData()` columns for
   `pathologic_response_pcr_rd` and strips a `field: value` prefix. If GEO has
   relabeled the characteristic column for GSE25055, the loader will stop with a
   clear error. Verify against `tables/table1_dataset_audit_filled.csv`
   (expected: 310 total, 57 pCR, 249 RD, 4 NA).
2. **PR-AUC dependency.** PR-AUC is computed only if `PRROC` is installed;
   otherwise it is reported as NA (per `R/metrics.R`).
3. **Probability calibration.** AUROC/PR-AUC use libsvm probability estimates
   (`e1071::svm(probability = TRUE)`), which are Platt-scaled and may be noisy on
   small folds. Acceptable for a pilot; revisit for the full analysis.
4. **Fold count vs minority class.** With ~57 pCR samples and 5 folds, each test
   fold holds ~11 positives. Metrics per fold can be unstable; the leaky script
   uses repeated CV (5x5) to stabilize, the nested script pools outer-fold
   predictions before computing metrics.
5. **Not yet run.** No numeric results are committed; this branch contains code
   + scaffolding only.
