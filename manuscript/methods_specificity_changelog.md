# Methods Specificity Cleanup Changelog (v6)

Source: `…v5_title_scope_reframed.docx` (Step 1 output, PR #32 branch — the latest manuscript).
Output: `Leakage_Aware_SMO_SVM_Manuscript_v6_methods_specificity.docx`.
No result values changed; no new analysis; all numbers verified intact. Six figures and table
numbering (1–10) preserved; title and abstract unchanged from Step 1.

## 1. Exact implemented leaky-vs-guarded difference
- Pipeline A (leaky): added that t-test top-100 feature selection is performed once on the entire
  discovery cohort before any split, then a linear SVM with fixed cost 1 is evaluated by 5×5
  repeated CV.
- Pipeline B (guarded): added the concrete inner-loop description and an explicit statement that
  the two pipelines differ in exactly three implemented respects — (i) global vs training-fold
  feature selection, (ii) fixed cost 1 vs inner-CV-tuned cost, (iii) 5×5 repeated CV vs
  5-outer × 5-inner nested CV.

## 2. Final frozen external model construction
External validation protocol rewritten to specify the frozen model exactly:
- Final feature set: 100 top-ranked probes from a Welch t-test on the full GSE25055 discovery cohort.
- Final cost: selected by guarded discovery-only CV over {0.25, 1, 4}; selected value C = 0.25.
- Threshold rule: fixed 0.5 on the predicted probability of pCR; no post-hoc threshold tuning.
- Scaling rule: center/scale estimated on the full discovery cohort (selected features only) and
  applied unchanged to GSE25065 with no refitting; all 100 frozen probes present in GSE25065.

## 3. Metric aggregation (pooled vs fold-averaged), described consistently
Added to the metrics section: guarded metrics are computed once on the pooled out-of-fold
predictions from the five outer folds; leaky metrics are computed within each of the five repeats
(pooling that repeat’s folds) and averaged across repeats. Each pipeline is summarized as a single
value per metric, and the leakage gap is the leaky-minus-guarded difference of these summaries.

## 4. GSE25065 framing in the external protocol
Stated explicitly that GSE25065 is a same-platform (Affymetrix HG-U133A, GPL96), same-study-family
external cohort from the Hatzis lineage, non-overlapping with GSE25055 by design.

## 5. DeLong positioned as secondary
Added: the DeLong test is reported only as a secondary sensitivity check; the bootstrap confidence
intervals, the permutation negative control, and the repeated nested cross-validation carry the
primary interpretation.

## 6. Removed planning language
Removed "(Phase 3)" from the Limitations section; GSE41998 is now described simply as future work
requiring cross-platform, leakage-safe handling. No "Phase N" planning labels remain in the body.

## Verification
- Document passes schema validation and renders (42 pages); external-protocol page spot-checked.
- Key numbers intact (0.7705, 0.7265, +0.044, 0.878, 27 of 30, 0.6078, C = 0.25, etc.).
- No dramatic language (proves/confirms/smoking gun/undeniable/catastrophic/mirage); abstract once;
  no Google Docs artifacts.
