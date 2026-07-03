# Reproducible Omics Evidence Audit

This repository supports the manuscript:

**A Reproducible Evidence-Audit Framework for Leakage, Feature Stability, and Transportability in Translational Omics Classification**

- Target journal: **Journal of Biomedical Informatics**
- Article type: **Research Paper**

This repository contains the analysis code, random seeds, fold assignments, selected-feature lists, software-environment files, generated figures and tables, supplementary materials, and preserved analysis outputs corresponding to the submitted manuscript.

## Archived manuscript release

- Version DOI (this manuscript snapshot): [10.5281/zenodo.21134086](https://doi.org/10.5281/zenodo.21134086)
- Concept DOI (all versions): [10.5281/zenodo.21134085](https://doi.org/10.5281/zenodo.21134085)

## Summary

High-dimensional omics classifiers can appear credible when data leakage, unstable feature selection, class-imbalance behavior, and weak external transportability remain hidden. This work presents a reproducible **evidence-audit framework** — the Reproducible Omics Evidence Audit — that integrates leakage sensitivity, a label-permutation negative control, guarded (nested) validation, feature-selection stability, external and cross-platform transportability, class-imbalance behavior, reproducibility artifacts, and explicit red-flag triggers into a single reusable reporting instrument. Public breast-cancer neoadjuvant-chemotherapy cohorts (pCR vs. residual disease) serve as a high-dimensional stress test; an established linear SVM is used as a transparent workhorse, not as a methodological advance.

## Cohorts

| Cohort | Platform | Role |
| --- | --- | --- |
| GSE25055 | Affymetrix HG-U133A (GPL96) | Discovery / internal validation |
| GSE25065 | Affymetrix HG-U133A (GPL96) | Same-platform, same-study-family validation |
| GSE41998 | Affymetrix HG-U133A 2.0 (GPL571) | Cross-platform transportability sensitivity |
| GSE20194 / GSE20271 | — | Documented but held out (MDACC-lineage patient-overlap risk) |

## Repository structure

```
R/                Reusable R functions (feature selection, preprocessing, model, metrics)
scripts/          Analysis scripts: dataset audit, leaky baseline, guarded nested pipeline,
                  feature stability, external validation (GSE25065, GSE41998), evidence-audit
                  table, bootstrap CIs, permutation control, repeated nested CV, selector K-sweep,
                  figures, and evidence-audit dashboard
notebooks/        Quarto notebooks
data_accessions/  GEO accession registry
processed_data/   Derived matrices (large files not committed)
raw_data/         Local raw downloads (not committed)
results/          Analysis outputs: metrics, predictions, selected features, fold assignments,
                  permutation null distributions, bootstrap CIs
figures/          Generated figures
tables/           Generated tables (dataset audit, pipeline comparison, evidence audit)
environment/      Package/version environment files
manuscript/       Manuscript files
supplementary/    Supplementary files
```

## Leakage-control rules

| Step | Guarded implementation |
|---|---|
| Scaling | Fit on training fold only |
| Supervised feature selection | Training fold only |
| Hyperparameter tuning | Inner cross-validation loop only |
| Class weighting | Training fold only |
| External validation | Frozen preprocessing, feature set, model, and threshold |

## License

This repository is dual-licensed:

- **Code** (`R/`, `scripts/`, `notebooks/`) under the **MIT License** — see [`LICENSE`](LICENSE).
- **Manuscript, figures, tables, and derived data content** under **Creative Commons Attribution 4.0 International (CC-BY-4.0)** — see [`LICENSE-CONTENT`](LICENSE-CONTENT).

## How to cite

See [`CITATION.cff`](CITATION.cff). Please cite the archived Zenodo release (version DOI 10.5281/zenodo.21134086).
