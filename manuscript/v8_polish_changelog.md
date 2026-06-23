# v8 QA Polish Changelog

Source: `Leakage_Aware_SMO_SVM_Manuscript_v8_full_results_integrated.docx` (PR #38).
Output: `Leakage_Aware_SMO_SVM_Manuscript_v8_full_results_integrated_polished.docx`.

Pre-merge QA polish only. No new analysis was run; no elastic-net or GSE41998 results were added;
no result values were changed; no code was edited; no references were added.

## Fixes
1. **Removed a duplicated bootstrap-CI paragraph** in "Uncertainty quantification for the leakage
   gap." The paragraph text ("Bootstrapped confidence intervals place the leaky-versus-guarded
   comparison in context … reported in Table 5.") had been duplicated within the paragraph, which
   rendered as the run-on "Table 5.Bootstrapped confidence intervals …". The redundant second copy
   was deleted; the paragraph now appears once and ends cleanly at "… reported in Table 5."
2. **Removed the APA row** from the List of Abbreviations ("APA — American Psychological
   Association"), which was irrelevant to the manuscript.
3. **Calibrated the Conclusion wording.** Replaced "whereas the guarded pipeline improved balanced
   accuracy and MCC." with "whereas operating-point metrics varied under class imbalance and were
   interpreted cautiously." This avoids presenting threshold-dependent operating-point metrics as
   primary evidence that the guarded pipeline is superior, consistent with the calibrated framing
   used elsewhere in the paper.
4. **Qualified GSE25065 in Table 4.** The dataset-audit role cell for GSE25065 was changed from
   "External validation" to "Same-platform, same-study-family validation," matching the Methods and
   Limitations framing. (Other contextually-qualified mentions, e.g., the Methods "same-platform,
   same-study-family external cohort" and the Limitations text, were already correct and unchanged;
   the transportability results table still reports the GSE25065 external drop.)

## Verification
- Bootstrap-CI paragraph now occurs exactly once; the "Table 5.Bootstrapped" run-on is gone.
- "American Psychological Association" / APA row: 0 occurrences.
- Old Conclusion phrase: 0; new calibrated phrase: 1.
- GSE25065 Table 4 role now reads "Same-platform, same-study-family validation."
- **No result values changed.** All key values still present (0.7705, 0.7265, +0.044, 0.4016 / 0.3653,
  0.5546 / 0.5792, 0.2105, "27 of 30", and the Table 11 K-sweep values 0.8365 … 0.8198). The only
  per-value count reductions are the redundant copies inside the removed duplicate paragraph.
- **Figure 7 and Table 11 intact.**
- Elastic-net and GSE41998 remain described only as planned/future extensions (no completed-results
  language); the top-K sweep remains the single completed extension.
- No BioTrust/founder/investor language. Reference count unchanged (no citations added).
- Document validates (`validate.py`: PASSED) and renders (44 pages).
