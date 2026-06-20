# Project instructions for Claude

This repository supports a BioData Mining methodology manuscript:

"A Leakage-Aware Data Mining Framework for Transcriptomic Biomarker Classification Using Nested SMO/SVM and Feature-Stability Auditing."

## Scientific rules

1. Do not introduce data leakage.
2. Do not fit preprocessing, scaling, imputation, SMOTE, feature selection, or hyperparameter tuning on test folds.
3. In the guarded pipeline, all supervised steps must occur inside training folds only.
4. External validation data must not be used for feature selection, threshold tuning, hyperparameter tuning, or batch correction.
5. Do not claim biological biomarker discovery; this is a methodology/audit paper.
6. Preserve random seeds and fold assignments.
7. Prefer reproducible scripts over manual steps.

## Repository rules

1. Do not commit large raw data files.
2. Do not commit credentials, API keys, tokens, or local file paths.
3. Do not delete files unless explicitly instructed.
4. Use clear commit messages.
5. Summarize every changed file after editing.
6. When possible, run the relevant script or notebook and report whether it passed.

## Coding style

- R-first project.
- Use readable functions.
- Keep notebooks explanatory.
- Keep scripts reproducible.
- Save outputs to tables/, figures/, or results/.
- Do not overwrite manuscript files unless explicitly instructed.

## Current priority

Start with dataset audit:
- verify GEO accession metadata;
- identify pCR/RD labels;
- confirm dataset independence;
- create tables/table1_dataset_audit_filled.csv.

This file will make Claude much safer and more useful.
