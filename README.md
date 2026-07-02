# A Reproducible Audit of Data Leakage, Feature Stability, and Transportability in Transcriptomic Biomarker Classification

This repository accompanies the manuscript submitted for review. It is organized for **AI desk review** and for archival on **Zenodo**.

## Authors

- **Iris Yang**¹ \* — California State University, Los Angeles, USA; Purdue University, USA
- **Wing-Keung Wong**² \* — Asia University, Taiwan
- **Paul Tan**³ — Affiliation to be finalized
- **Chung-I Huang**⁴ — National Chung Hsing University, Taiwan
- **Jewel Wang**⁵ — Brandeis University, USA

\* Co-corresponding authors.

## Summary

High-dimensional transcriptomic biomarker studies are vulnerable to **data leakage** when feature selection, preprocessing, scaling, or class balancing is performed before validation splitting, because reported performance can then reflect contamination of the test fold rather than generalizable signal. This work is a reproducible **audit case study** using a leakage-aware linear SVM (SMO-trained) workflow on public breast-cancer neoadjuvant-chemotherapy cohorts (pCR vs. residual disease). It contrasts a naive pipeline that allows global feature-selection leakage against a guarded nested pipeline, and reports leakage sensitivity, feature-selection stability, and external-cohort transportability together in a single evidence-audit template.

The study is **not** a new algorithm, a clinical biomarker discovery claim, or a demonstration of model-agnostic universality.

## Cohorts

| Cohort | Platform | Role |
| --- | --- | --- |
| GSE25055 | Affymetrix HG-U133A (GPL96) | Discovery / internal validation |
| GSE25065 | Affymetrix HG-U133A (GPL96) | Same-platform, same-study-family validation |
| GSE41998 | Affymetrix HG-U133A 2.0 (GPL571) | Predeclared cross-platform transportability sensitivity |
| GSE20194 / GSE20271 | — | Documented but held out (MDACC-lineage patient-overlap risk) |

Leakage and transportability are treated as **distinct** properties. The GSE41998 result is a cross-platform transportability sensitivity check, **not** proof of leakage.

## Repository structure

```
.
├── README.md                                  # this file
├── LICENSE                                    # CC-BY-4.0
├── CITATION.cff                               # citation metadata
├── .zenodo.json                               # Zenodo deposit metadata
├── .gitignore
└── manuscript/
    ├── Leakage_Aware_SMO_SVM_Manuscript_v10_2_final_QA.docx
    └── v10_2_final_QA_changelog.md            # v10.1 → v10.2 consistency patch
```

## Version

Current manuscript version: **v10.2** (final consistency QA). See `manuscript/v10_2_final_QA_changelog.md` for the v10.1 → v10.2 change record.

## License

This work is licensed under the **Creative Commons Attribution 4.0 International (CC-BY-4.0)** license. See [`LICENSE`](LICENSE).

## How to cite

See [`CITATION.cff`](CITATION.cff). After Zenodo archival, cite the resulting DOI.
