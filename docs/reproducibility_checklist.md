# Reproducibility Checklist

This checklist documents the reproducibility artifacts for the study and maps to the manuscript's "Reproducible Omics Evidence Audit." Items marked **[PLACEHOLDER]** require a value that is finalized at release.

## Data

- [x] All input data are public (GEO: GSE25055, GSE25065, GSE41998); accessions listed in the Data Availability Statement.
- [x] Data acquisition method documented (author-processed GEO Series Matrix files via `GEOquery`, `GSEMatrix = TRUE`, `getGPL = FALSE`; raw CEL files not reprocessed).
- [x] Inclusion/exclusion of samples documented (label cleaning; usable counts: GSE25055 306 [57 pCR / 249 RD]; GSE25065 182 [42 pCR / 140 RD]; GSE41998 253 [69 pCR / 184 RD]).
- [x] Cohorts documented-but-excluded recorded with reason (GSE20194, GSE20271 — MDACC-lineage overlap risk).

## Code and environment

- [x] Analysis code in version control (GitHub: iry496/leakage-aware-smo-svm-omics).
- [x] Run/order of scripts documented (dataset audit → leaky baseline → nested pipeline → feature stability → external validation → figures/tables).
- [ ] **[PLACEHOLDER]** Package/version environment file (e.g., `sessionInfo()` / `renv.lock`) committed and referenced by exact path.
- [ ] **[PLACEHOLDER]** Exact commit hash recorded for the frozen release.

## Modeling and leakage controls

- [x] Leakage-control rules stated (scaling, supervised feature selection, hyperparameter tuning, class weighting/SMOTE, and threshold all confined to training folds; external validation frozen).
- [x] Classifier and configuration fixed and reported (SMO-trained linear SVM; 100 top-ranked probes; cost C = 0.25; 0.5 P(pCR) threshold; discovery-derived scaling).
- [x] Nested cross-validation design described (inner loop for tuning; outer loop for evaluation).
- [x] External validation frozen before validation data loaded (model, feature set, threshold, scaling all fixed).

## Randomness and robustness

- [x] Random seeds recorded; 30-seed repeated nested CV reported (directional, seed/fold-level, not patient-level inference).
- [x] Permutation negative control reported (B = 1000 label-shuffle).
- [x] Bootstrap confidence intervals reported for key estimates.
- [ ] **[PLACEHOLDER]** Seed list / fold-assignment files referenced by exact path in the repository.

## Outputs and artifacts

- [x] Committed performance tables and external-validation outputs (manuscript Tables 5–12).
- [x] Feature-stability outputs (Nogueira index 0.5409; per-seed stability).
- [x] Figures regenerable from committed outputs (Figures 1–8).
- [ ] **[PLACEHOLDER]** Zenodo archive DOI for the frozen release.

## Reporting standards

- [x] Reporting aligned with TRIPOD+AI guidance (Collins et al., 2024) for prediction-model reporting.
- [x] Class-imbalance-aware metrics reported (PR-AUC, MCC, balanced accuracy, sensitivity/specificity) alongside AUROC.
- [x] Scope limits stated (within-cohort methodological audit; not clinical biomarker discovery; not a new algorithm).

## Outstanding before release

- [ ] Insert exact commit hash and Zenodo DOI.
- [ ] Commit environment/version file and seed/fold artifact paths.
