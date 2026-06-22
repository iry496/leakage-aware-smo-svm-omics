# Phase 2 Claim-Calibration Plan

_Planning document for the BioData Mining methodology manuscript_
**"An Audit of Data Leakage and Feature Stability in Transcriptomic Biomarker Classification Using Nested SMO/SVM and External Validation."**

Status: **plan only**. Branch `manuscript/claim-calibration`. No manuscript edits, no new analysis, no external cohorts. This document specifies how to update the manuscript using the already-merged evidence:

- Phase 1 bootstrap confidence intervals (`tables/uncertainty/bootstrap_ci.csv`, `tables/uncertainty/delta_auroc_prauc_ci.csv`, `results/uncertainty/delong_tests.csv`).
- Phase 2A B=1000 permutation-control negative control (`results/permutation/permutation_b1000_pvalues.csv`, `results/permutation/permutation_b1000_notes.md`).
- Phase 2B 30-seed repeated nested CV (`tables/repeated_cv/leakage_gap_by_seed.csv`, `tables/repeated_cv/stability_by_seed.csv`, `results/repeated_cv/repeated_cv_gap_tests.csv`, `results/repeated_cv/repeated_cv_full_notes.md`).

Source manuscript: `manuscript/Leakage_Aware_SMO_SVM_Manuscript_v2_phase1_novelty_reframe.docx`.

## Central calibration principle

Three distinct questions must never be conflated:

1. **Patient-level uncertainty of the gap** — the paired bootstrap CI of the leakage gap *includes zero* (ΔAUROC +0.044, 95% CI [-0.013, +0.103], p ≈ 0.13). Not resolved as nonzero at the patient level.
2. **Fold-level reproducibility of the gap** — the 30-seed repeated nested CV gives a Wilcoxon signed-rank p ≈ 10⁻⁶, but this tests reproducibility of the gap across fold randomizations, NOT patient-level generalization.
3. **The leakage mechanism** — the B=1000 permutation control shows the leaky pipeline scoring well above chance on randomized labels (null mean ≈ 0.88), demonstrating the mechanism directly.

Keeping these separate is the entire purpose of this revision.

## Evidence summary (numbers to fold in)

Bootstrap CIs (GSE25055): leaky AUROC 0.7705 [0.711, 0.824], guarded 0.7265 [0.653, 0.791]; leaky PR-AUC 0.4016 [0.333, 0.497], guarded 0.3653 [0.281, 0.472]. Gap: ΔAUROC +0.044 [-0.013, +0.103] (boot p 0.125); ΔPR-AUC +0.036 [-0.048, +0.125] (boot p 0.383). DeLong per-repeat p 0.066-0.513. External GSE25065 AUROC 0.6078 [0.506, 0.700]; MCC 0.1347 [-0.032, 0.304] (CI includes 0).

Permutation control (B=1000): leaky AUROC null mean 0.8783 [0.761, 0.956], 100% above chance, observed 0.7705 sits inside/below its own null (p_obs>=null 0.967); guarded AUROC null mean 0.5401 (~chance), observed 0.7265 significant (p 0.001); guarded PR-AUC null mean 0.1917 (~prevalence 0.1863), observed 0.3656 significant (p 0.001); null gap mean 0.3382.

Repeated nested CV (30 seeds): ΔAUROC median 0.0536 [-0.007, 0.108], positive 27/30, Wilcoxon V 456, p 4.5e-6; ΔPR-AUC median 0.0569 [-0.024, 0.139], positive 27/30, V 445, p 1.3e-5. Stability: Nogueira median 0.550 [0.490, 0.595], mean Jaccard median 0.383 [0.328, 0.428], stable-core median 30 [23, 35], unstable-tail median 103.5 [75, 123].

---

## 1. Abstract sentences to revise

The Abstract currently reports point estimates only. Revise to:

- Headline performance sentence: attach 95% bootstrap CIs to leaky and guarded AUROC/PR-AUC.
- Leakage sentence: state the single-cohort gap is small with a CI that includes zero (ΔAUROC +0.044 [-0.013, +0.103]), but is positive in 27/30 repeated-CV seeds, and that a permutation control shows the leaky pipeline scoring well above chance on randomized labels.
- Add one sentence framing these as robustness/diagnostic evidence, not proof of a large effect.
- External sentence: keep AUROC 0.6078, add its CI [0.506, 0.700], label it transportability (not leakage).

## 2. Methods subsections to update

- **Performance, leakage, and stability metrics**: add the bootstrap CI procedure (stratified percentile, B = 2000, fixed seed), the paired-bootstrap and DeLong tests for the gap, the B=1000 label-shuffle permutation control with empirical p-values, and the 30-seed repeated nested CV (matched seed-level comparison) with the Wilcoxon signed-rank on per-seed deltas.
- **Study design overview**: one sentence adding the two robustness analyses to the design.
- **Reproducibility and software availability**: list `scripts/07_bootstrap_ci.R`, `scripts/08_permutation_control.R`, `scripts/09_repeated_nested_cv.R` and their output tables.
- No change to Pipeline A/B, SMO/SVM specification, or the external-validation protocol (design unchanged).

## 3. New Results subsections

Add three, after "Leaky versus guarded nested SMO/SVM performance":

- **Uncertainty quantification (bootstrap CIs and the leakage gap)** — CIs for every metric (both arms + external); ΔAUROC and ΔPR-AUC with CIs and bootstrap p; DeLong per-repeat range. Message: the single-cohort gap is positive but not resolved as nonzero at patient level.
- **Permutation-control negative control (B=1000)** — leaky null strongly above chance (mean 0.878, 100% > 0.5), observed leaky inside/below its own null; guarded null at chance and guarded real performance significant (p 0.001). Message: the leakage mechanism manufactures discrimination; the guarded pipeline is well-calibrated and captures real signal.
- **Seed-level robustness (30-seed repeated nested CV)** — ΔAUROC/ΔPR-AUC medians, 27/30 positive, Wilcoxon p; stability reproducible (Nogueira/Jaccard/core/tail medians and ranges). Message: gap direction and moderate stability are reproducible across fold assignments; explicitly fold-level reproducibility, not patient-level inference.

## 4. Tables to update or add

- **Table 5 (leaky vs guarded)**: add CI columns per metric; gap row with CI + boot p.
- **Table 6 (feature stability)**: add 30-seed median [range] beside single-split values.
- **Table 7 (external)**: add CI columns (keep as transportability).
- **New Table 8 — Permutation-control summary** (from `permutation_b1000_pvalues.csv`).
- **New Table 9 — Repeated-CV gap & stability summary** (medians/percentiles + Wilcoxon from `repeated_cv_gap_tests.csv`).
- **Integrated Reproducible Omics Evidence Audit table**: add rows for leakage gap (CI), permutation control, seed robustness.

## 5. Figures to reference

- `figures/permutation_b1000_null.png` — null AUROC distributions (leaky vs guarded) -> permutation subsection.
- `figures/repeated_cv/leakage_gap_distribution_full.png` — per-seed AUROC + gap boxplot -> robustness subsection.
- `figures/repeated_cv/stability_distribution_full.png` — per-seed Nogueira/Jaccard -> stability subsection.
- Existing stability/Jaccard figures remain.

## 6. How to state the leakage result cautiously

Layer the three pieces explicitly: (a) single-cohort gap positive but CI includes zero (paired bootstrap p ≈ 0.13), not resolved as nonzero by patient-level resampling; (b) gap positive in 27/30 repeated-CV seeds and reproducibly > 0 across fold randomizations (Wilcoxon p < 0.001), but the per-seed interval still grazes zero and this is fold-level reproducibility, not patient-level inference; (c) permutation control shows the leaky pipeline strongly above chance on randomized labels (null mean ≈ 0.88) while the guarded pipeline collapses to chance and significantly exceeds it on real labels. Bottom line: a small, mechanistically demonstrated, fold-robust optimistic bias — not a large or patient-level-significant effect.

## 7. Separating the three quantities

1. **Internal leakage gap** — a magnitude (leaky - guarded, same cohort), small, CI includes 0.
2. **Permutation-control leakage mechanism** — a demonstration that leaky FS scores above chance on random labels (no real-data magnitude attached).
3. **External transportability drop** — a generalization limit (discovery guarded CV -> GSE25065, ΔAUROC -0.119), explicitly not a leakage effect.

Each gets its own Results subsection; a Discussion paragraph names all three and states they answer different questions; the Evidence Audit table lists them as separate rows.

## 8. Discussion paragraphs to rewrite

- **Principal findings**: restate the gap with its CI plus the 27/30 and permutation evidence; keep leakage-vs-transportability separation.
- **Why leakage-aware validation changes interpretation**: fold in the permutation mechanism as the strongest qualitative evidence.
- **Feature stability versus predictive performance**: add seed-robustness of the stability metrics.
- **Limitations**: add single-cohort gap not patient-level significant; repeated-CV significance is fold-level not inferential; single selector/classifier; low pCR sensitivity persists.
- **Future work**: keep GSE41998 / cross-platform as future (Phase 3).

## 9. What not to overclaim

- Do not call the leakage gap "statistically significant" without qualifying which test; never present the Wilcoxon p ≈ 10⁻⁶ as patient-level significance.
- Do not claim the permutation control proves the size of the real gap (it shows the mechanism).
- Do not read the external drop as leakage.
- No biomarker/clinical-discovery claims; recurrent probes remain "stability-ranked candidates."
- Avoid "proves/confirms"; keep "supports the interpretation," "diagnostic," "within-cohort."
- Do not imply external generalization was established (single same-platform cohort).

## 10. Recommended output filename

`manuscript/Leakage_Aware_SMO_SVM_Manuscript_v3_phase2_claim_calibration.docx`, with a `manuscript/phase2_claim_calibration_changelog.md` (matching the existing v2 changelog convention).

## 11. GSE41998

Keep as future work until Phase 3 (roadmap item #13, `analysis/gse41998-external`). It needs cross-platform leakage-safe handling and label resolution. This revision calibrates claims around existing evidence only; GSE41998 is mentioned solely in Limitations/Future work.

---

## Next step (after approval)

Implement v3 from this plan on a new branch: read the `docx` skill, build `manuscript/Leakage_Aware_SMO_SVM_Manuscript_v3_phase2_claim_calibration.docx` from the v2 source, add the three Results subsections, update the tables/abstract/Discussion, and write the changelog. No new analysis is required; all numbers come from the merged Phase 1/2A/2B outputs.
