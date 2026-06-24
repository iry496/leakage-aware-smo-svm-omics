# v10 GSE41998-Aware Submission Draft Changelog

Source: `Leakage_Aware_SMO_SVM_Manuscript_v9_submission_polished.docx` (latest v9 on `main`).
Output: `Leakage_Aware_SMO_SVM_Manuscript_v10_gse41998_aware.docx`.

Integrates the **completed, merged** GSE41998 cross-platform external validation (PR #42, on `main`).
No analysis was run for this manuscript build; no result values were changed; no references were
added; no affiliations/funding/declarations were invented. All GSE41998 numbers are taken verbatim
from the committed outputs (`results/external_validation_gse41998/gse41998_metrics.csv`,
`tables/external_validation_gse41998/gse41998_summary.csv`).

## GSE41998 result integrated (frozen GSE25055 model, primary discovery-scaling)
N = 253 evaluable (69 pCR, 184 RD; prevalence 0.273; 20 "0"-coded + 6 missing excluded). Exact
GPL96∩GPL571 probe intersection recovered 100/100 frozen probes. AUROC 0.6638, PR-AUC 0.4353,
balanced accuracy 0.5697, MCC 0.1845, sensitivity 0.2319, specificity 0.9076 (confusion 16/53/167/17).
Within-cohort z-score sensitivity variant: AUROC 0.6779, PR-AUC 0.4300.

## Changes (completed path)
1. **Methods (External validation protocol):** added a paragraph describing GSE41998 as a
   pre-registered cross-platform transportability sensitivity cohort (GPL571), with the predeclared
   label rule (N = 253), exact probe-ID intersection (no gene-symbol collapse, no joint
   normalization, no ComBat), discovery-frozen model, and the clearly-separated within-cohort z-score
   sensitivity (unsupervised adaptation).
2. **Results:** new subsection "Cross-platform transportability sensitivity on GSE41998" with the full
   metric set + confusion matrix, framed cautiously.
3. **New table (Table 11):** *Cross-Platform Transportability Sensitivity on GSE41998* — a three-cohort
   comparison (discovery guarded CV / GSE25065 same-study-family / GSE41998 cross-platform).
4. **New figure (Figure 7):** the GSE41998 transportability figure embedded.
5. **Discussion (Principal findings):** expanded from four to five distinct quantities, separating
   the leakage gap, permutation mechanism, repeated-CV robustness, **same-study-family** validation
   (GSE25065), and **cross-platform** transportability (GSE41998).
6. **Limitations:** updated — GSE41998 was evaluated as a cross-platform sensitivity analysis; notes
   the GPL571 platform and treatment-regimen heterogeneity (AC-then-ixabepilone/paclitaxel trial vs
   the discovery taxane–anthracycline cohorts); moderate external performance is a transportability
   limit, not a leakage effect.
7. **Evidence-audit table (now Table 12):** added a "Cross-platform transportability" row
   (GSE41998 AUROC/PR-AUC 0.6638/0.4353).
8. **Abstract:** one cautious sentence added (cross-platform GSE41998 AUROC 0.6638; comparable
   transportability drop reinforcing that leakage control and cross-platform transportability are
   distinct).
9. **Future work:** GSE41998 moved from planned to completed (Tables 6 and 11; Figure 7); the
   **elastic-net comparator is now the only remaining future/planned analysis**.

## Numbering note
Because GSE41998 (detail) belongs with the external-validation results and the integrated evidence
audit is the closing summary, the GSE41998 table/figure are numbered **Table 11 / Figure 7** and the
Reproducible Omics Evidence Audit table/dashboard moved to **Table 12 / Figure 8**, with all in-text
cross-references updated. Final order is sequential: Figures 1–8, Tables 1–12.

## Verification
- Document validates (`validate.py`: PASSED) and renders (47 pages); Table 11 and Figure 7 (GSE41998)
  and the audit Table 12 / Figure 8 render cleanly; figure/table numbering is sequential.
- Table 11 GSE41998 column cross-checked cell-by-cell against `gse41998_metrics.csv`.
- **No existing result values changed** (0.7705, 0.7265, +0.044, 0.6078, 0.5409, "27 of 30", the
  K-sweep values 0.8365…0.8198 all intact).
- "SMO/SVM" = 0; "BioTrust"/founder/investor = 0; GSE25065 still same-platform, same-study-family;
  leakage (within-cohort) and transportability (external) kept distinct; title audit-first;
  author block/Declarations untouched; references unchanged (43; none added).
- Elastic-net remains future/planned only; GSE41998 is now reported as completed.
