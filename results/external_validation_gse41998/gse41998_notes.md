# GSE41998 external validation (GO) — frozen GSE25055 model

- Status: GO. Usable n=253 (pCR=69, RD=184; prevalence 0.273). Label column: 'characteristics_ch1.11'.
- Frozen feature set: top-100 (Welch t-test on full GSE25055); recovered in GSE41998: 100/100 (coverage 1.000).
- Frozen cost=0.25 (guarded discovery CV); threshold=0.50 on P(pCR); no GSE41998 tuning/selection.
- Exact probe-ID intersection; no gene-symbol collapse; no joint normalization; no ComBat.

## Results (frozen-model projection)
- PRIMARY (discovery-derived scaling): AUROC 0.6638, PR-AUC 0.4353, balanced acc 0.5697, MCC 0.1845, sens 0.2319, spec 0.9076.
- SENSITIVITY (within-cohort z-score): AUROC 0.6779, PR-AUC 0.4300.

## Interpretation
Cross-platform transportability of a frozen model; a generalization limit, not a leakage effect.
Within-cohort/diagnostic; not biomarker discovery. GSE41998 labels used only for final evaluation.

_Runtime 1.5 min. No raw expression written._
