# v9 Final Submission Polish Changelog

Source: `Leakage_Aware_SMO_SVM_Manuscript_v8_AI_desk_review_ready.docx`.
Output: `Leakage_Aware_SMO_SVM_Manuscript_v9_submission_polished.docx`.

Resolves remaining ChatGPT Deep Research / Reviewer #2 issues before BioData Mining submission. No
analysis was run; no elastic-net or GSE41998 results added; no new models/selectors; no result
values changed; no references added; no code edited. Technical statements added in Methods were
taken directly from the committed code (scripts/07, scripts/02 loader, R/model_smo_svm.R,
R/metrics.R, R/preprocessing.R), not invented.

## Changes
1. **Pipeline comparability (Figure 1 caption).** Removed the "differ only in whether feature
   selection occurs before/after the split" phrasing. The caption now states the naive baseline
   intentionally performs supervised feature selection on the full dataset before validation and is
   evaluated with flat 5×5 repeated CV, whereas the guarded pipeline nests feature selection,
   scaling, class weighting, and cost tuning inside training folds before outer-fold evaluation. The
   permutation negative-control interpretation (supports the feature-selection leakage mechanism) is
   preserved.
2. **SVM scores/probabilities (new Methods paragraph "Scores and probabilities").** AUROC/PR-AUC are
   computed from P(pCR); probabilities are e1071/libsvm built-in (Platt-style) estimates fit by
   libsvm on training data; calibration fit only inside training folds and discovery-only for the
   frozen external model; notes that global probability calibration would itself leak.
3. **Class weighting (new Methods paragraph "Class weighting").** Inverse-frequency weights
   w_k = N/(K·n_k) via e1071 `class.weights`, recomputed from each training partition in both
   pipelines; the naive arm's leakage is from global feature selection, not class weighting.
4. **Raw preprocessing detail (new Methods paragraph "Expression data and preprocessing").** GEO
   Series Matrix (not raw CEL); author-normalized values, no extra normalization/log transform;
   HG-U133A (GPL96), 22,283-probe universe; probe-level features (no gene-symbol collapse);
   near-zero-variance filter (var ≤ 1×10⁻⁸); no imputation; training-fold-only z-scoring; label
   extraction from `pathologic_response_pcr_rd` with NA/blank/NaN/N/A exclusions (4/310 → 306;
   16/198 → 182).
5. **Leaky repeated-CV bootstrap (new Methods paragraph "Resampling unit for the naive baseline").**
   The naive baseline keeps five repeat-level predictions per patient; point estimates are the mean
   of the five per-repeat values; the stratified bootstrap resamples patients (within pCR/RD strata)
   and recomputes the mean-over-repeats — predictions are not collapsed to one per patient —
   consistent with `scripts/07_bootstrap_ci.R`.
6. **Softened overclaiming.** "the guarded pipeline captures genuine, label-dependent signal" →
   "the guarded pipeline result is consistent with label-dependent signal under the guarded
   validation architecture"; permutation-table note "real signal exceeds null" → "real-label value
   exceeds null" (both rows).
7. **Layout.** All tables set to repeat the header row and to avoid mid-row splits (`<w:tblHeader/>`
   + `<w:cantSplit/>`), fixing broken header fragments (covers Tables 2, 5, 6, 7). Figure 7
   (evidence-audit dashboard) enlarged to ~6.5 in width (aspect preserved). Render spot-checked:
   Figure 7 panels are legible and the adjacent table header is intact. If reviewers still find the
   6-panel dashboard dense, moving the full dashboard to a supplement with a simplified main figure
   is a low-risk follow-up (not done here to avoid regenerating figures / renumbering).
8. **Abstract shortened** from ~386 to **289 words** (target 275–325). Retains cohort sizes, leaky
   vs guarded AUROC/PR-AUC, CI-includes-zero gap, permutation control, 30-seed directionality,
   feature stability (Nogueira 0.5409), external AUROC (0.6078), and the contribution statement.
   Secondary numbers (null AUROC means, PR-AUC CIs, Jaccard, "30 of 222", exact p-values) now live
   in Results/Tables only — no values changed.
9. **Placeholders.** Per instruction, "Affiliation to be finalized" (author 3) was left in place for
   internal review. **Submission-blocking items the authors must complete before journal submission:**
   (a) author 3 affiliation; (b) Competing interests; (c) Funding; (d) Authors' contributions;
   (e) Acknowledgements — these remain as standard "to be declared/finalized prior to submission"
   placeholders in the Declarations. No affiliations, funding, or declarations were invented.
10. **SMO/SVM wording.** Replaced "SMO/SVM" throughout the body with "linear SVM" (so the paper does
    not read as an SMO/SVM algorithm paper). Kept "SMO-trained linear SVM" in the Methods model
    specification, "(SMO)" in the abstract, the SMO abbreviation, and the historical SMO references
    where solver detail is appropriate.

## Verification
- Document validates (`validate.py`: PASSED) and renders (45 pages; Figure 7 page and the K-sweep /
  evidence-audit tables spot-checked and render cleanly).
- **No result values changed:** 0.7705 / 0.7265, +0.044 (CI −0.013 to +0.103), 0.4016 / 0.3653,
  0.6078 (0.506–0.700), Nogueira 0.5409, Jaccard 0.3734, "27 of 30", median ΔAUROC +0.054, and the
  K-sweep values (0.8365 … 0.8198) are all intact. All figure (1–7) and table (1–11) numbers
  unchanged.
- "SMO/SVM" = 0; "linear linear SVM" = 0; "captures genuine" = 0; "real signal exceeds null" = 0;
  the four new Methods blocks present; "22,283" present; "scripts/07_bootstrap_ci.R" present.
- Elastic-net and GSE41998 remain future/planned only. No BioTrust/founder/investor language.
  GSE25065 still described as same-platform, same-study-family validation. Leakage (within-cohort)
  and transportability (external drop) remain distinct. References unchanged (none added).
