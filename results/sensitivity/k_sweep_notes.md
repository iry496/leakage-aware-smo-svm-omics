# Selector K-sweep (full run, GSE25055 only)

- Selector fixed (Welch t-test top-K); K in {25, 50, 100, 200}. Seed 20260620.
- Leaky: global FS top-K before 5x5 repeated CV (cost 1). Guarded: nested 5-outer x 5-inner; FS + cost tuning in training folds.
- K=100 is the anchor and reproduces the committed pilot (leaky ~0.7705, guarded ~0.7265, Nogueira ~0.5409).

## Results by K
- K=25: AUROC leaky 0.8365 / guarded 0.7197 (gap 0.1167); PR-AUC leaky 0.5041 / guarded 0.3340 (gap 0.1701); bal.acc 0.5793 / 0.5326; MCC 0.2618 / 0.1139; sens 0.1860 / 0.1053; spec 0.9727 / 0.9598; Nogueira 0.3713, mean Jaccard 0.2317, stable core 3, unstable tail 46.
- K=50: AUROC leaky 0.8094 / guarded 0.7426 (gap 0.0668); PR-AUC leaky 0.4627 / guarded 0.3735 (gap 0.0892); bal.acc 0.5749 / 0.5366; MCC 0.2416 / 0.1363; sens 0.1860 / 0.1053; spec 0.9639 / 0.9679; Nogueira 0.4448, mean Jaccard 0.2906, stable core 9, unstable tail 68.
- K=100: AUROC leaky 0.7705 / guarded 0.7265 (gap 0.0440); PR-AUC leaky 0.4020 / guarded 0.3656 (gap 0.0363); bal.acc 0.5546 / 0.5792; MCC 0.2063 / 0.2250; sens 0.1333 / 0.2105; spec 0.9759 / 0.9478; Nogueira 0.5409, mean Jaccard 0.3734, stable core 28, unstable tail 102.
- K=200: AUROC leaky 0.8198 / guarded 0.7154 (gap 0.1044); PR-AUC leaky 0.4572 / guarded 0.3717 (gap 0.0855); bal.acc 0.5724 / 0.5894; MCC 0.2276 / 0.2161; sens 0.1825 / 0.2632; spec 0.9622 / 0.9157; Nogueira 0.6055, mean Jaccard 0.4389, stable core 77, unstable tail 174.

- Total runtime: 0.6 min.

_Sensitivity analysis only; within-cohort, diagnostic; not biomarker discovery._
