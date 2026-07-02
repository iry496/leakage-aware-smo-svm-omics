# Leakage-Aware SMO/SVM Omics Audit

This repository supports the manuscript draft:

**A Leakage-Aware Data Mining Framework for Transcriptomic Biomarker Classification Using Nested SMO/SVM and Feature-Stability Auditing**

Target journal: **BioData Mining**
Article type: **Methodology**

## Project purpose

This project compares two families of public transcriptomic biomarker classification pipelines:

1. **Naive / leaky SMO/SVM pipeline**: supervised feature selection is performed globally before cross-validation.
2. **Guarded nested SMO/SVM pipeline**: preprocessing, feature selection, class-imbalance handling, and hyperparameter tuning are performed only inside training folds.

The goal is to quantify feature-selection leakage, evaluate feature stability, and test external transportability using public breast cancer neoadjuvant chemotherapy response datasets.

## Current status

This is a **repository scaffold**. It contains the planned directory structure, protocol, notebook templates, R function stubs, and table templates. It does not yet contain final analysis outputs.

## Planned public datasets

Candidate GEO cohorts:

- GSE25055: discovery/nested-CV candidate
- GSE25065: external-validation candidate if non-overlapping and clean
- GSE20194: external-validation candidate
- GSE41998 / GSE20271: optional sensitivity cohorts after metadata audit

Final cohort roles must be locked in `docs/protocol_v0_1.md` after sample overlap and endpoint harmonization checks.

## Leakage-control rules

| Step | Guarded implementation |
|---|---|
| Scaling | Fit on training fold only; apply to validation/test folds |
| Supervised feature selection | Training fold only |
| Hyperparameter tuning | Inner cross-validation loop only |
| Class weighting / SMOTE | Training fold only; SMOTE only as sensitivity analysis |
| External validation | Frozen preprocessing, feature set, model, and threshold |

## Repository structure

```text
leakage-aware-smo-svm-omics/
  R/                Reusable R functions
  scripts/          Run scripts for dataset audit and pipelines
  notebooks/        Quarto notebook templates for protocol and analyses
  data_accessions/  GEO accession registry and dataset notes
  metadata/         Curated sample metadata after audit
  raw_data/         Local raw downloads; do not commit large raw data
  processed_data/   Derived matrices; do not commit large files without policy check
  results/          Pilot and full analysis outputs
  figures/          Manuscript figures
  tables/           Manuscript and supplementary tables
  docs/             Protocol and analysis notes
  manuscript/       Manuscript DOCX and writing files
  supplementary/    Supplementary tables and files
  environment/      Package/version environment files
```

## Suggested execution order

1. `notebooks/00_protocol_v0_1.qmd`
2. `scripts/01_dataset_audit.R`
3. `scripts/02_run_leaky_baseline.R`
4. `scripts/03_run_nested_pipeline.R`
5. `scripts/04_feature_stability.R`
6. `scripts/05_external_validation.R`
7. `scripts/06_make_figures_tables.R`

## Reproducibility plan

Before submission, archive a frozen release on Zenodo and include:

- GitHub commit hash
- Zenodo DOI
- package versions / session info
- random seeds
- fold assignments
- selected feature lists
- performance tables
- external validation outputs

## License

This repository is dual-licensed:

- **Code** (e.g. `R/`, `scripts/`, `notebooks/`) is licensed under the **MIT License** — see [`LICENSE`](LICENSE).
- **Manuscript, figures, tables, and derived data content** are licensed under **Creative Commons Attribution 4.0 International (CC-BY-4.0)** — see [`LICENSE-CONTENT`](LICENSE-CONTENT).

Citation metadata is in [`CITATION.cff`](CITATION.cff); archival/deposit metadata is in `.zenodo.json`. After Zenodo archival, cite the resulting DOI.

## Important note

This repository is designed to prevent leakage. Do not modify the pipeline by fitting feature selection, scaling, threshold selection, SMOTE, or hyperparameter tuning on test or external validation data.
