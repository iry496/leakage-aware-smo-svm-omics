# Repeated Nested CV - full run (GSE25055 only)

- Seeds (30): 20260620, 20260621, 20260622, 20260623, 20260624, 20260625, 20260626, 20260627, 20260628, 20260629, 20260630, 20260631, 20260632, 20260633, 20260634, 20260635, 20260636, 20260637, 20260638, 20260639, 20260640, 20260641, 20260642, 20260643, 20260644, 20260645, 20260646, 20260647, 20260648, 20260649
- Matched seed-level comparison (NOT identical fold structure): leaky = 5x5 repeated CV,
  guarded = nested 5-outer x 5-inner; within each seed both arms draw stratified folds
  from the same master seed.
- Fast Welch selector: TRUE ; parallel across seeds: TRUE (4 workers); CV loops serial.
- Leaky arm: global t-test top-100 before CV. Guarded arm: t-test inside training folds only.
- Cost grid: 0.25, 1, 4. Top-K = 100.

## Anchor reproduction check (seed 20260620)
- leaky AUROC = 0.7705 (ref 0.7705)
- guarded AUROC = 0.7265 (ref 0.7265)
- Nogueira = 0.5409 (ref 0.5409)
- mean Jaccard = 0.3734 (ref 0.3734)
- stable-core count = 28 (ref 28)
- unstable-tail count = 102 (ref 102)
- Overall: PASS

## Selector validation (original vs fast Welch)
- identity: overlap 100/100, exact_order=TRUE.
- perm1: overlap 100/100, exact_order=TRUE.
- perm2: overlap 100/100, exact_order=TRUE.
- perm3: overlap 100/100, exact_order=TRUE.
- perm4: overlap 100/100, exact_order=TRUE.
- perm5: overlap 100/100, exact_order=TRUE.

## Per-seed leakage gap (AUROC)
- leaky AUROC: 0.7705, 0.7644, 0.7657, 0.7675, 0.7604, 0.7540, 0.7464, 0.7545, 0.7509, 0.7532, 0.7581, 0.7738, 0.7630, 0.7708, 0.7740, 0.7722, 0.7763, 0.7840, 0.7781, 0.7771, 0.7773, 0.7747, 0.7751, 0.7799, 0.7807, 0.7850, 0.7778, 0.7805, 0.7826, 0.7794
- guarded AUROC: 0.7265, 0.7471, 0.7087, 0.7188, 0.6879, 0.7475, 0.7440, 0.7605, 0.6775, 0.6956, 0.7077, 0.7306, 0.7373, 0.7729, 0.7100, 0.6877, 0.7233, 0.7285, 0.7874, 0.6865, 0.6877, 0.7277, 0.6984, 0.6715, 0.7511, 0.7401, 0.7235, 0.7088, 0.6754, 0.6821
- gap AUROC (leaky-guarded): 0.0440, 0.0173, 0.0569, 0.0487, 0.0725, 0.0066, 0.0024, -0.0060, 0.0733, 0.0576, 0.0504, 0.0432, 0.0256, -0.0021, 0.0640, 0.0846, 0.0529, 0.0555, -0.0092, 0.0906, 0.0896, 0.0471, 0.0768, 0.1085, 0.0296, 0.0449, 0.0543, 0.0717, 0.1072, 0.0973
- gap PR-AUC: 0.0363, 0.0252, 0.0094, 0.0033, 0.0979, -0.0154, 0.0111, 0.0214, 0.0716, 0.0870, 0.0642, 0.0916, -0.0446, 0.0266, 0.0851, 0.1330, 0.0759, 0.0945, -0.0026, 0.0496, 0.1026, 0.0663, 0.1100, 0.1544, 0.0407, 0.0339, 0.0358, 0.0790, 0.1156, 0.0420

## Per-seed feature stability
- Nogueira: 0.5409, 0.5319, 0.5460, 0.5500, 0.5329, 0.5319, 0.5158, 0.5771, 0.5600, 0.5470, 0.5952, 0.5399, 0.5419, 0.5871, 0.4897, 0.5349, 0.5520, 0.5530, 0.5650, 0.5028, 0.5510, 0.5650, 0.5319, 0.5630, 0.5500, 0.5741, 0.5650, 0.5661, 0.5158, 0.5570
- mean Jaccard: 0.3734, 0.3660, 0.3785, 0.3831, 0.3667, 0.3659, 0.3514, 0.4083, 0.3927, 0.3790, 0.4277, 0.3736, 0.3747, 0.4181, 0.3278, 0.3686, 0.3846, 0.3891, 0.3969, 0.3388, 0.3837, 0.3974, 0.3651, 0.3950, 0.3818, 0.4054, 0.3979, 0.3997, 0.3517, 0.3884
- stable-core count: 28, 30, 29, 28, 23, 30, 25, 32, 30, 27, 30, 25, 31, 30, 24, 28, 30, 26, 33, 27, 33, 32, 28, 31, 35, 32, 30, 30, 25, 30
- unstable-tail count: 102, 110, 113, 95, 114, 111, 115, 75, 104, 106, 88, 100, 99, 80, 119, 109, 107, 96, 98, 121, 118, 94, 112, 103, 116, 97, 93, 103, 123, 92

## Runtime
- mean 7.0 s/seed (compute, within worker); wall 2.8 s/seed; total 1.4 min.
- estimated full 20 seeds: 0.9 min (0.02 h) ; 30 seeds: 1.4 min (0.02 h) (at current wall throughput).

## Gap significance (Wilcoxon signed-rank, paired delta vs 0)
- delta AUROC: V = 456, p = 4.5e-06; positive in 27/30 seeds.
- delta PR-AUC: V = 445, p = 1.3e-05; positive in 27/30 seeds.
- The leakage gaps are positive in 27/30 seeds and statistically positive across seeds (Wilcoxon p < 0.001 for both AUROC and PR-AUC), but the 2.5-97.5% interval includes small negative values, so claims should remain cautious: this is a within-cohort, methodology/diagnostic finding, not biomarker discovery.

_Full repeated-CV run across 30 seeds; estimates seed/fold robustness of the leakage gap and feature stability (within-cohort, diagnostic; not biomarker discovery)._
