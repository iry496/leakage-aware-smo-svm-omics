# Permutation Control - b1000 run (GSE25055 only)

- Permutations: identity + 1000 shuffled. Seed 20260620 (label shuffles offset +100000).
- Fast Welch selector: TRUE ; parallel: TRUE (4 workers).
- Folds regenerated per permutation (stratified on shuffled labels); FS rerun per permutation.
- Leaky arm: global t-test top-100 before CV. Guarded arm: t-test inside training folds only.

## Identity reproduction check
- leaky AUROC = 0.7705 (ref 0.7705); guarded AUROC = 0.7265 (ref 0.7265). Within 0.01: PASS.

## Selector validation (original vs fast Welch)
- identity: overlap 100/100, exact_order=TRUE.
- perm1: overlap 100/100, exact_order=TRUE.
- perm2: overlap 100/100, exact_order=TRUE.
- perm3: overlap 100/100, exact_order=TRUE.
- perm4: overlap 100/100, exact_order=TRUE.
- perm5: overlap 100/100, exact_order=TRUE.

## Null summary (shuffled labels)
- leaky AUROC null: mean 0.8783 (0.6546-0.9751); frac > 0.5 = 1.000.
- guarded AUROC null: mean 0.5401 (0.4475-0.6813); frac > 0.5 = 0.871.
- leakage gap null: mean 0.3382 (0.1209-0.4909).

## Runtime
- mean compute 6.2 s/perm; wall 1.6 s/perm with 4 workers; total 26.6 min.
- old (serial, original selector) was 361.8 s/perm.
- estimated B=200: 5.3 min (0.09 h) ; B=1000: 26.5 min (0.44 h) (at current wall throughput).

_This permutation run estimates null behavior under shuffled labels. The leaky null distribution should be interpreted as a diagnostic of feature-selection leakage, not as evidence of biological signal. It supports the interpretation that feature-selection leakage can inflate apparent performance._
