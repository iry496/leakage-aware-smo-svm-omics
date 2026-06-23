# Submission-Ready Update Changelog (v7)

Source: `…v6_methods_specificity.docx` (the latest manuscript; Step 2 output).
Output: `Leakage_Aware_SMO_SVM_Manuscript_v7_submission_ready.docx`.
No result values changed; no new analysis run; cautious language preserved; BioTrust kept out of
the title, abstract, and Results.

## Scope note (important, for honesty)
At the time of this update, three planned analyses had **not been executed** and therefore have
**no results to report**: the selector top-K sweep, the elastic-net comparator, and the
cross-platform GSE41998 external validation. Their numbers were **not** invented. They are
referenced only as pre-specified robustness extensions (Future work). The integrable, real
material — the v6 manuscript plus the reproducible evidence-audit dashboard — is what this update
adds.

## Changes
1. **Title** — unchanged (already audit-first, SMO removed in Step 1).
2. **Abstract** — added one sentence noting the audit is consolidated in a reproducible
   evidence-audit table and dashboard generated deterministically from the committed outputs.
   No numbers changed; no product/BioTrust language.
3. **Methods (Reproducibility and software availability)** — added that a machine-readable
   evidence-audit artifact and a six-panel dashboard are produced from committed outputs by
   `scripts/10_build_evidence_audit_artifact.R` and `scripts/11_plot_evidence_audit_dashboard.R`,
   with no new modeling.
4. **Results tables** — unchanged (no new results exist to add; no values altered).
5. **Figure 7 added** — the evidence-audit dashboard embedded at the end of the Results
   (Integrated Reproducible Omics Evidence Audit subsection), with an in-text reference; existing
   Figures 1–6 and Tables 1–10 unchanged.
6. **Discussion / Limitations** — Principal findings and Limitations retained from v6 (already
   calibrated). Future work expanded to list the pre-specified robustness extensions (top-K
   sensitivity sweep; elastic-net comparator for model-class generality; leakage-safe
   cross-platform GSE41998 validation), each to be reported once executed under its frozen,
   pre-registered protocol — stated without results.

## Verification
- Document validates and renders (43 pages; Figure 7 page spot-checked).
- 7 embedded figures (captions 1–7); Tables 1–10 preserved.
- Key numbers intact (0.7705, 0.7265, +0.044, 0.878, 27 of 30, 0.054, 0.6078, 0.5409, …).
- No dramatic language (proves/confirms/smoking gun/undeniable/catastrophic/mirage); abstract once;
  no Google Docs artifacts; **no BioTrust anywhere**, and specifically not in title/abstract/Results.
