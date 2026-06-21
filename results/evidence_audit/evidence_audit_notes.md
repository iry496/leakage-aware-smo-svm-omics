# Reproducible Omics Evidence Audit - Notes (v1)

## Purpose
First integrated evidence audit for the leakage-aware SMO/SVM omics study.
It consolidates four completed stages - dataset audit, GSE25055 leaky-vs-guarded
pilot, feature-stability analysis, and GSE25065 external validation - into one
auditable table. No models were run here; all numbers are read from committed
outputs and recombined.

## Cohorts
- GSE25055 (discovery): RD=249, pCR=57, 4 NA excluded (N=310); pCR prevalence 18.6%.
- GSE25065 (external): RD=140, pCR=42, 16 NA excluded (N=198); pCR prevalence 23.1%.
- Same platform (GPL96), non-overlapping by design (GSE25066 split).

## Leakage sensitivity (leaky vs guarded nested, GSE25055)
- Leaky AUROC 0.7705 vs guarded nested AUROC 0.7265 -> leakage gap +0.0440.
- Leaky PR-AUC 0.4020 vs guarded nested PR-AUC 0.3656 -> leakage gap +0.0363.
- The leaky pipeline inflates AUROC and PR-AUC. Guarding selection removes that
  optimism and, importantly, the guarded nested pipeline IMPROVES the
  imbalance-aware metrics (balanced accuracy 0.5792, MCC 0.2250) over the leaky
  baseline (balanced accuracy 0.5546, MCC 0.2063).

## Feature stability (5 outer folds, K=100)
- 222 unique features selected across folds; 28 in all 5 folds (stable core);
  102 selected in exactly one fold (unstable tail).
- Mean Jaccard 0.3734, median Jaccard 0.3699, Nogueira stability 0.5409.
- Interpretation: stability is MODERATE - a small reproducible core coexists
  with a large unstable tail.

## External validation (GSE25065) and internal->external drop
- External AUROC 0.6078, PR-AUC 0.3060, balanced accuracy 0.5381, MCC 0.1347, sensitivity 0.1190, specificity 0.9571.
- Drop from guarded nested CV to external: AUROC +0.1187, PR-AUC +0.0596, balanced accuracy +0.0411,
  MCC +0.0903, sensitivity +0.0915, specificity -0.0094.
- Interpretation: external validation shows clear TRANSPORTABILITY LIMITS;
  discrimination and minority-class recall fall on the independent cohort,
  while specificity is roughly maintained.

## Cautious interpretation
- This is a METHODOLOGY / AUDIT result, NOT a clinical biomarker discovery.
- No clinical claims are made; pCR sensitivity is low internally and externally.
- The leaky pipeline inflates AUROC/PR-AUC; guarded nested validation gives an
  honest estimate and improves imbalance-aware metrics.
- Feature stability is moderate (stable core + unstable tail).
- External validation demonstrates real transportability limits.

## Limitations / unresolved risks
- Single same-platform external cohort (GSE25065).
- GSE41998 (cross-platform) and GSE20194/GSE20271 (overlap/de-dup) deliberately
  excluded pending harmonization and sample-level de-duplication.
- Feature-tail instability: 102 of 222 features selected only once.
- Low pCR sensitivity limits practical utility.

