# Permutation Control - b200 run (GSE25055 only)

- Permutations: identity + 200 shuffled. Seed 20260620 (label shuffles offset +100000).
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
- leaky AUROC null: mean 0.8732 (0.6546-0.9747); frac > 0.5 = 1.000.
- guarded AUROC null: mean 0.5379 (0.4563-0.6813); frac > 0.5 = 0.855.
- leakage gap null: mean 0.3353 (0.1209-0.4610).

## Runtime
- mean compute 6.6 s/perm; wall 1.8 s/perm with 4 workers; total 6.0 min.
- old (serial, original selector) was 361.8 s/perm.
- estimated B=200: 6.0 min (0.10 h) ; B=1000: 30.1 min (0.50 h) (at current wall throughput).

_A guarded null centered near chance and a leaky null above chance would support the interpretation that feature-selection leakage can inflate apparent performance. Smoke B is small and intended only for code validation._
