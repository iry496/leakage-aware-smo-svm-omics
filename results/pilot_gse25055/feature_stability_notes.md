# GSE25055 feature-stability pilot

## Question
Are the genes selected by the guarded nested SMO/SVM pipeline stable across the outer CV folds?

## Why this matters for biomarker reproducibility
Classification performance alone does not guarantee a reproducible signature. A model can
achieve acceptable discrimination while selecting largely different genes in each fold. If the
selected genes are unstable, the panel is unlikely to validate in independent cohorts, is hard
to interpret biologically, and reported gene lists may reflect a particular data split rather
than real biology. Feature-stability auditing therefore complements performance and leakage
auditing. Importantly, LOW stability is itself an informative result: it argues that biomarker
selection must be audited before a signature is trusted.

## How these numbers were produced
The per-fold feature sets were reproduced deterministically from the committed nested run
(identical SEED, identical caret::createFolds outer folds, identical t-test top-K selection in
scripts/03_nested_smo_svm_gse25055.R). No SVM was retrained and no external dataset was used.
scripts/03 was also extended (logging only) to emit nested_selected_features_by_fold.csv on
future full runs.

## Results
- Outer folds: 5
- Features selected per fold (top K): 100
- Candidate feature universe: 22283 genes
- Total unique features ever selected: 222
- Features selected in all 5 folds: 28
- Features selected in only 1 fold: 102
- Mean pairwise Jaccard overlap: 0.3734
- Median pairwise Jaccard overlap: 0.3699
- Nogueira (2018) stability index: 0.5409

## Interpretation
MODERATE stability: the per-fold gene sets show partial but incomplete agreement.

## Top recurrent features
- 202870_s_at: 5/5
- 203693_s_at: 5/5
- 203702_s_at: 5/5
- 203999_at: 5/5
- 204750_s_at: 5/5
- 204822_at: 5/5
- 204825_at: 5/5
- 205225_at: 5/5
- 205548_s_at: 5/5
- 206373_at: 5/5
- 206392_s_at: 5/5
- 209204_at: 5/5
- 209289_at: 5/5
- 209604_s_at: 5/5
- 210052_s_at: 5/5

## Limitations
- Single discovery cohort (GSE25055); no external validation here by design.
- Stability assessed for the t-test top-K filter only (the pipeline's current selector).
- 5 outer folds give 10 pairwise comparisons; estimates are pilot-scale.
- Near-zero-variance filtering is applied on the full matrix (existing pipeline behaviour,
  unsupervised and unchanged here).
