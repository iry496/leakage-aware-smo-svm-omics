# Phase 2 Claim-Calibration — Polish Pass Changelog

Source: `Leakage_Aware_SMO_SVM_Manuscript_v3_phase2_claim_calibrated.docx`
Output: `Leakage_Aware_SMO_SVM_Manuscript_v3_phase2_claim_calibrated_polished.docx`
Scope: wording-only polish. No result values changed, no analysis run, no references added,
no figures or tables changed except wording in Table 10. All numeric result values preserved
exactly (verified: the only numeric-token change is one added cross-reference, "Table 5").

## 1. Measured wording for the permutation result
Replaced "collapsed toward chance" with "shifted toward chance" in both occurrences:
- Abstract (guarded permutation null sentence).
- Discussion, "Principal findings" (guarded pipeline under the negative control).

## 2. Removed internal-process language from the Results opening
In the first paragraph under "Results", removed the two internal-workflow sentences
("This Results section reports only completed analyses already integrated into the project
repository. No new modeling was performed in preparing this manuscript update."). The
paragraph now opens directly with the substantive framing ("The contribution described here
is methodological and audit-oriented: ..."). No other internal-workflow notes remain in the
manuscript body.

## 3. Calibrated Table 10 (Reproducible Omics Evidence Audit) wording
Softened three pre-existing interpretation cells so they no longer overstate; values unchanged:
- AUROC gap row: "Global feature selection inflates apparent discrimination." ->
  "Global feature selection can inflate apparent discrimination; single-cohort gap CI includes zero (Table 5)."
- PR-AUC gap row: "Leakage also inflates minority-class ranking performance." ->
  "Leakage can also raise minority-class (PR-AUC) ranking; single-cohort gap CI includes zero."
- Guarded nested performance row: "Nested validation improves imbalance-aware operating metrics." ->
  "Operating-point metrics vary under class imbalance and should be interpreted cautiously."

## 4. Same-platform / same-study-family qualifier for GSE25065
Added a qualifier where GSE25065 is first called external validation:
- Abstract first mention: "External validation on GSE25065 (42 pCR, 140 RD)" ->
  "Same-platform, same-study-family external validation on GSE25065 (42 pCR, 140 RD)".
- Cohort-construction first body mention: "GSE25065 as the external-validation cohort" ->
  "GSE25065 as the non-overlapping, same-study-family external-validation cohort".

## Verification
- Numeric result values unchanged (token diff = +1 occurrence of "5" from the "Table 5"
  cross-reference only; no result value added or removed).
- Forbidden dramatic words absent: proves, confirms, smoking gun, undeniable, catastrophic, mirage.
- No internal-workflow notes remain in the body ("No new modeling", "manuscript update",
  "reports only completed analyses" all removed).
- Table 10 is consistent with the calibrated, confidence-bounded claims.
- DOCX passes schema validation and renders correctly (37 pages; spot-checked Abstract,
  Results opening, External-validation section, and the Table 10 page).
