# Release Notes — v1.0.0

**Release date:** 2026-06-24
**Repository:** https://github.com/iry496/leakage-aware-smo-svm-omics
**Zenodo DOI:** **[PLACEHOLDER — insert once minted on archival of this release]**
**Associated manuscript version:** v10.5 (submission candidate for BioData Mining, article type: Methodology)

## What this release is

The first tagged, citable release of the leakage-aware SMO/SVM omics audit. It bundles the submission-candidate manuscript and the reproducibility artifacts for a transparent audit of data leakage, feature-selection stability, and external-cohort transportability in transcriptomic biomarker classification.

## Contents

- Manuscript (v10.5) and per-version changelogs (`manuscript/`).
- Submission package (`submission/`): cover letter, data-availability statement, declarations, CRediT template, competing-interests template, suggested reviewers, submission checklist.
- Documentation (`docs/`): citation verification report, reproducibility checklist, these release notes.
- `CITATION.cff` for citation metadata.

## Scientific summary (no values changed in this packaging release)

- Discovery cohort GSE25055 (306 usable samples; 57 pCR / 249 RD).
- Naive (leaky) vs. guarded nested linear-SVM pipelines: AUROC 0.7705 vs. 0.7265; single-cohort ΔAUROC +0.044 (95% CI −0.013 to +0.103; CI includes zero).
- 1000-permutation label-shuffle negative control supports a leakage-artifact interpretation; 30-seed repeated nested CV shows a modest, directionally reproducible gap (27 of 30 seeds), reported as seed/fold-level — not patient-level — evidence.
- Feature-selection stability: Nogueira index 0.5409.
- Same-platform, same-study-family external validation (GSE25065): AUROC 0.6078 — a transportability drop distinct from internal leakage.
- Predeclared cross-platform transportability sensitivity (GSE41998, GPL571): AUROC 0.6638 — a comparable transportability drop; a sensitivity check, not proof of leakage.

## Provenance from prior versions

- v10.2: cohort-role wording consistency (GSE25055/25065/41998).
- v10.3: desk-review blocker cleanup (typo fix; abstract trim).
- v10.4: final copyedit/consistency.
- v10.5: table & figure readability (compact tables; landscape Evidence Audit dashboard).

## Known open items (see `submission/submission_checklist.md`)

Submission-blocking admin items remain and require author input before journal submission:
- Competing interests, funding, author contributions (CRediT), acknowledgements — not invented; templates provided.
- Two citation fixes pending approval: add GSE41998 source (Horak et al., 2013) and resolve the OmicSelector citation (preprint/software).
- Insert the Zenodo DOI and exact commit hash; commit the environment/version and seed/fold artifact paths.
- ORCIDs for all authors.

## How to cite

See `CITATION.cff`. After Zenodo archival, cite the minted DOI.
