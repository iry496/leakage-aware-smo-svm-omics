# Co-Author Review Packet — Prof. Wong (Methodology / Validation Rigor)

**Manuscript:** *An Audit of Data Leakage and Feature Stability in Transcriptomic Biomarker Classification Using Nested SMO/SVM and External Validation.*

**Current version:** `manuscript/Leakage_Aware_SMO_SVM_Manuscript_v3_phase2_claim_calibrated_polished.docx` (on `main`). This packet introduces no new analysis and changes no result values; all figures are from the merged Phase 1/2 outputs.

---

## One-paragraph scientific summary

Using GSE25055 (306 usable samples; 57 pCR, 249 RD) as a discovery cohort and GSE25065 as a same-platform, same-study-family external cohort, we treat an SMO-trained linear SVM as a transparent workhorse to audit three things that high-dimensional biomarker papers usually conflate: the optimistic bias from feature-selection leakage, the reproducibility of the selected features, and cross-cohort transportability. We compare a deliberately leaky pipeline (global t-test top-K selection before cross-validation) against a guarded nested pipeline (selection and tuning confined to training folds), and we calibrate the comparison with bootstrap confidence intervals, a 1000-permutation label-shuffle negative control, and a 30-seed repeated nested cross-validation. The headline finding is deliberately measured: the single-cohort leakage gap is positive but modest and its CI includes zero, yet the gap is positive in 27 of 30 seeds and the permutation control shows the leaky pipeline scoring well above chance on randomized labels — together supporting the interpretation that feature-selection leakage is a real, diagnosable optimistic-bias mechanism rather than a large effect, and that the contribution is an integrated leakage-aware *audit*, not a new algorithm.

## Key methods / results (bullets)

- **Cohorts.** Discovery GSE25055 (n = 306; 57 pCR, 249 RD; prevalence 18.6%). External GSE25065 (n = 182; 42 pCR, 140 RD), same platform GPL96, non-overlapping by design.
- **Pipelines.** Leaky = global Welch t-test top-100 before 5×5 repeated CV (fixed cost = 1). Guarded = nested 5-outer × 5-inner CV; t-test top-100 and cost tuning (grid 0.25/1/4) inside training folds only; class weighting for imbalance (no SMOTE).
- **Model.** Linear SMO/SVM (libsvm via e1071), probability outputs; metrics AUROC, PR-AUC, balanced accuracy, MCC, sensitivity, specificity.
- **Leakage gap (GSE25055).** Leaky AUROC 0.7705 (95% CI 0.711–0.824) vs guarded 0.7265 (0.653–0.791); ΔAUROC +0.044 (95% CI −0.013 to +0.103; paired bootstrap p = 0.13). ΔPR-AUC +0.036 (−0.048 to +0.125). DeLong per-repeat p 0.07–0.51 (median 0.18).
- **Permutation control (B = 1000).** Leaky null AUROC mean 0.878 (all permutations > chance); observed leaky lies within its own null (p ≈ 0.97). Guarded null AUROC mean 0.540 (near chance), real-label guarded exceeds its null (p = 0.001 for AUROC and PR-AUC); guarded PR-AUC null ≈ prevalence (0.192 vs 0.186).
- **Repeated nested CV (30 seeds).** ΔAUROC median +0.054 (2.5–97.5% −0.007 to +0.108), positive in 27/30 seeds, Wilcoxon V = 456, p = 4.5×10⁻⁶; ΔPR-AUC positive in 27/30, V = 445, p = 1.3×10⁻⁵.
- **Feature stability.** Single split: 222 unique probes, stable core 28 (all 5 folds), unstable tail 102 (1 fold), mean Jaccard 0.3734, Nogueira 0.5409. Across 30 seeds: median Nogueira 0.55 (0.49–0.60), median stable core 30, median unstable tail 104 — moderate and reproducible.
- **External validation (GSE25065).** Frozen guarded model (cost 0.25, 100 probes, all aligned): AUROC 0.6078 (0.506–0.700); transportability drop vs discovery guarded CV ΔAUROC −0.119, sensitivity −0.092 — framed as a generalization limit distinct from internal leakage.

## Phase 1 / Phase 2 analysis summary

- **Phase 1.** Bootstrap CIs (stratified percentile, B = 2000) for all metrics; paired-bootstrap + DeLong tests for the gap; manuscript hygiene; novelty reframed as an audit, not an algorithm. Key finding fed forward: the single-cohort leakage gap is not statistically resolved as nonzero.
- **Phase 2A.** B = 1000 permutation-control negative control (GSE25055 only); identity permutation reproduces the committed point estimates exactly.
- **Phase 2B.** 30-seed repeated nested CV (matched seed-level comparison) with per-seed gap and stability distributions plus Wilcoxon signed-rank tests.
- **Phase 2 claim calibration.** v3 manuscript folds CIs, permutation control, and repeated-CV into cautious, within-cohort/diagnostic language, separating the internal gap, the permutation mechanism, the external transportability drop, and feature-stability robustness.

---

## Six technical questions for Prof. Wong

1. **SMO/SVM framing and the title.** We use SMO/SVM as a transparent audit workhorse, not as a novel method, and the abstract states this explicitly. Should "SMO" remain in the title, or does foregrounding the solver risk implying an algorithmic contribution we are not claiming? Would a title centered on the leakage-aware audit (with SVM, not SMO) read better to a methods audience?

2. **Feature-selection design — is t-test top-K = 100 acceptable as the *primary* selector?** The audit currently uses a univariate Welch t-test top-100 filter throughout. Is this defensible as the primary selector for the main results, with a selector/K sweep (e.g., information gain, SVM-RFE, mRMR; K ∈ {25, 50, 100, 250}) as a sensitivity analysis, or should additional selectors be promoted into the main analysis?

3. **GSE41998 harmonization (Phase 3) — probe intersection vs gene-symbol collapse.** GSE41998 is on a different platform (GPL571). For leakage-safe cross-platform validation, do you prefer (a) restricting to the intersecting probe set, or (b) collapsing to gene symbols (e.g., max/mean-variance probe per gene) with a training-derived mapping? Either way we would freeze the mapping on GSE25055 and avoid joint normalization — does that match your expectation?

4. **External scaling policy — discovery-derived scaling vs within-cohort standardization.** External validation currently applies the *frozen, discovery-derived* center/scale to GSE25065 (no refit). An alternative is within-cohort standardization on the external set. The frozen approach is more conservative for transportability claims but can be sensitive to platform/batch shifts. Which do you consider the defensible default, and should we report both as a sensitivity analysis?

5. **Need for an elastic-net comparator.** We currently report a single linear SMO/SVM classifier. Would an elastic-net (or RBF-SVM) comparator strengthen the audit by showing the leakage/stability behavior is not classifier-specific, and if so should it be a main-text comparator or supplementary?

6. **Statistical framing of the three calibration analyses.** We present (i) bootstrap CIs for the gap (CI includes zero, p ≈ 0.13), (ii) a permutation negative control (leaky null far above chance), and (iii) a 30-seed Wilcoxon on the per-seed gap (p < 0.001), with the explicit caveat that (iii) is fold-level reproducibility, not patient-level inference. Is this separation correct and clearly stated, or would you frame the relationship among these three differently (e.g., a different primary test, or a mixed-effects model across seeds)?

---

_Prepared for co-author review. No new analysis was run; all numbers are from the merged Phase 1/2 outputs in the repository._
