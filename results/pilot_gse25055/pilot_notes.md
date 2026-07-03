# Pilot notes: leaky vs nested SMO/SVM on GSE25055

Notes for the first pilot (GSE25055 discovery cohort, GPL96 / HG-U133A).

## Scope

- GSE25055 only (discovery cohort).
- Labels: pCR vs RD from `pathologic_response_pcr_rd`; NA-coded samples excluded.
- Single feature budget: top K = 100. Feature selector: t-test.
- Class imbalance handled with class weights (no SMOTE in this pilot).

## Status

The pilot scripts have been executed and their outputs are committed in this
folder: `leaky_baseline_metrics.csv`, `nested_smo_svm_metrics.csv`,
`*_predictions.csv`, `leaky_baseline_selected_features.csv`,
`nested_selected_features_by_fold.csv`, and `pilot_session_info.txt`, with the
performance comparison in `tables/pilot_gse25055/`.

## Required packages

- CRAN: `caret`, `e1071`, `pROC`, `PRROC` (see `environment/packages.R`).
- Bioconductor: `GEOquery`, `Biobase` (for loading GSE25055).

## Notes

- PR-AUC is computed with `PRROC` when available (see `R/metrics.R`).
- SVM probability estimates use libsvm Platt scaling (`e1071::svm(probability = TRUE)`).
- With ~57 pCR samples across 5 outer folds, per-fold metrics are stabilized by
  pooling outer-fold predictions (nested pipeline) or repeated 5x5 CV (leaky baseline).
