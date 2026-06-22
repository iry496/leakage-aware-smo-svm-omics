# Phase 2 Claim-Calibration Changelog

Source: `Leakage_Aware_SMO_SVM_Manuscript_v2_phase1_novelty_reframe.docx`
Output: `Leakage_Aware_SMO_SVM_Manuscript_v3_phase2_claim_calibrated.docx`
Method: mechanical assembly via `outputs/v3work/build_v3.py` (python-docx), then schema
validation and PDF render-check. All prose/numbers taken verbatim from `CONTENT_SPEC.md`.
No numbers or wording were invented or altered.

## EDIT 1 — Abstract
Replaced the single Abstract body paragraph (after the "Abstract" heading, before
"Keywords:") with the new claim-calibrated paragraph. Now reports bootstrap CIs
(AUROC 0.7705, 95% CI 0.711–0.824; guarded 0.7265, 0.653–0.791; PR-AUC pairs), the
confidence-bounded leakage gap (ΔAUROC +0.044, 95% CI −0.013 to +0.103; p = 0.13),
the 1000-permutation negative control (leaky null mean 0.88; guarded null 0.54; p = 0.001),
seed-level robustness (positive in 27 of 30 seeds; median ΔAUROC +0.054; Wilcoxon p < 0.001),
reproducible stability, and the external transportability drop. Keywords paragraph unchanged.

## EDIT 2 — Methods: new Heading-2 subsection + reproducibility sentence
Inserted a new Heading-2 subsection **"Uncertainty quantification, permutation control, and
repeated cross-validation"** with 4 body paragraphs immediately after the body of
"Performance, leakage, and stability metrics" and before "External validation protocol".
Appended one sentence to the end of "Reproducibility and software availability" listing
scripts 07_bootstrap_ci.R, 08_permutation_control.R, 09_repeated_nested_cv.R and output dirs.

## EDIT 3 — Table 5 (Leaky vs Guarded) rewrite
Replaced all 6 metric data rows so each value carries its 95% bootstrap CI, and the
AUROC/PR-AUC gap cells include the gap CI and bootstrap p. Updated the Table 5 Note to the
spec wording (B = 2000 stratified-bootstrap CIs; both gap CIs include zero; MCC definition).
Header row and column structure preserved (Metric | Leaky baseline | Guarded nested SMO/SVM |
Leaky − guarded gap).

## EDIT 4 — Results: three new Heading-2 subsections, Tables 6 & 7, Figures 1–3
Inserted after the Table 5 Note and before "Feature-stability audit":
- **"Uncertainty quantification for the leakage gap"** (1 paragraph).
- **"Permutation-control negative control"** (1 paragraph) + Figure 1
  (`figures/permutation_b1000_null.png`, ~6 in) with caption + new **Table 6**
  ("Permutation-Control Negative Control (B = 1000), GSE25055", 5 cols, 5 data rows) + Note.
- **"Seed-level robustness across 30 repeated cross-validation runs"** (1 paragraph)
  + Figure 2 (`figures/repeated_cv/leakage_gap_distribution_full.png`, ~6.5 in) + caption
  + Figure 3 (`figures/repeated_cv/stability_distribution_full.png`, ~6.5 in) + caption
  + new **Table 7** ("Seed-Level Robustness ... GSE25055", 4 cols, 8 data rows) + Note.
New tables match existing table look (Table5 style, 9360 dxa, centered, single borders,
fixed layout, shaded header row d9eaf7). Three PNGs embedded (word/media/image1–3.png).

## EDIT 5 — Renumber downstream caption paragraphs
Performed BEFORE inserting the new Table 6/Table 7 (matched by adjacent title text):
- old "Table 6" (Feature-Stability Summary) → "Table 8"
- old "Table 7" (External Validation on GSE25065) → "Table 9"
- old "Table 8" (Reproducible Omics Evidence Audit Summary) → "Table 10"

## EDIT 6 — Evidence-audit table (now Table 10): append 3 rows
Appended three rows to the table with header
Audit domain | Metric | Value | Interpretation:
- Leakage sensitivity | Internal leakage gap, ΔAUROC (95% CI) | +0.044 (−0.013 to +0.103) | …
- Leakage sensitivity | Permutation control, leaky null AUROC | 0.88 (all permutations > chance) | …
- Reproducibility | Seed robustness, ΔAUROC (27/30 seeds) | median +0.054; Wilcoxon p < 0.001 | …

## EDIT 7 — Discussion
- 7: Replaced the "Principal findings" body paragraph with the new four-quantities paragraph.
- 7b: Appended one sentence to "Why leakage-aware validation changes biomarker interpretation".
- 7c: Appended one sentence to "Feature stability versus predictive performance".

## EDIT 8 — Limitations + Future work
- 8: Replaced the entire "Limitations" body paragraph with the calibrated limitations text.
- 8b: Appended one sentence to "Future work" (leakage-safe cross-platform validation).

## Schema/formatting note
Added the schema-required `w:gutter="0"` attribute to the section `w:pgMar` element (this
attribute was missing in v2 and is required for clean validation). No content change.

## Validation & render-check
- `validate.py`: All validations PASSED.
- Rendered PDF: 37 pages; page images `outputs/v3work/v3page-01.jpg` … `v3page-37.jpg`.
- Self-checks: Abstract contains 0.7705, −0.013 to +0.103, "27 of 30", p = 0.001; new Tables 6
  and 7 present; 3 figures embedded; no forbidden words present as standalone words
  (only "improves", an allowed substring of "proves", occurs).
