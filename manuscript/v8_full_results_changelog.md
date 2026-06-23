# v8 Full-Results Integration Changelog

Source: `Leakage_Aware_SMO_SVM_Manuscript_v7_submission_ready.docx` (latest merged manuscript on `main`).
Output: `Leakage_Aware_SMO_SVM_Manuscript_v8_full_results_integrated.docx`.

Only **real, merged** outputs were integrated. No result values were invented; no unrun analysis
was included; no citations were added; no BioTrust/founder/investor language was added.

## What was integrated (and what was not)
- **Integrated — selector top-K sweep** (merged to `main`, PR #37; `scripts/12_selector_k_sweep.R`,
  `tables/sensitivity/k_sweep_summary.csv`). K = 25, 50, 100, 200 on GSE25055 only; K = 100
  reproduces the primary analysis exactly.
- **Already present in v7 — evidence-audit artifact and six-panel dashboard** (Figure 7); unchanged.
- **Not integrated — elastic-net comparator and GSE41998 external validation:** neither is run or
  merged, so neither appears with any numbers. They remain pre-specified future-work extensions.

## Changes
1. **Methods — Feature-selection methods.** Added a "Selector-budget sensitivity analysis" paragraph
   describing the pre-specified top-K sweep (Welch t-test selector held fixed; K varied; all other
   settings unchanged; K = 100 anchors the sweep; `scripts/12_selector_k_sweep.R`; no external cohorts).
2. **Results — new subsection "Sensitivity to the feature-selection budget (top-K sweep)"** added
   after the uncertainty-quantification subsection, with a prose paragraph and **Table 11**
   (*Selector Top-K Sweep: Leakage Gap and Feature Stability on GSE25055*). All values are taken
   verbatim from the committed `k_sweep_summary.csv`. ΔAUROC is positive at every K
   (+0.117/+0.067/+0.044/+0.104); ΔPR-AUC positive at every K; feature stability rises monotonically
   with K (Nogueira 0.371→0.606; Jaccard 0.232→0.439; stable core 3→77; unstable tail 46→174).
   Operating-point metrics (balanced accuracy, MCC, sensitivity, specificity) are reported per the
   committed summary. Framed as a within-cohort budget-sensitivity analysis that does **not** test
   sensitivity to the model class.
3. **Discussion — Principal findings.** One sentence added: the direction of the internal leakage gap
   is robust across the feature-selection budget (smallest at K = 100) and stability increases with K,
   while explicitly noting this does not test generalization across model classes.
4. **Limitations.** Updated to note the single selector was varied only in budget (top-K sweep) and
   that generalization across selector families and model classes remains untested.
5. **Future work.** The top-K sweep is marked completed and reported (Table 11); only the elastic-net
   comparator and the GSE41998 cross-platform validation remain as pre-specified extensions.

## Hygiene / cleanup
- **Removed a duplicated paragraph** in "Seed-level robustness across 30 repeated cross-validation
  runs" (the body paragraph had been pasted twice). It now appears once.
- **Fixed an incorrect figure cross-reference**: that paragraph cited "Figure 2 (leakage gap) and
  Figure 3 (feature stability)"; corrected to "Figure 4 (leakage gap) and Figure 5 (feature
  stability)" to match the actual captions.
- **Removed planning/versioning language**: deleted "used in v1" from the Table 4 dataset cells;
  reworded the two "will be archived … at submission" sentences to non-future phrasing; removed the
  "Anticipated roles span …" sentence from Authors' contributions; neutralized the forward-looking
  GSE41998 / GSE20194 / GSE20271 cohort bullets to factual "documented but not used" statements.
- Changed the GSE41998 audit-table note from "held for future analysis because …" to "not used in
  current modeling because …".

## Preserved exactly (unchanged)
All existing key values: AUROC 0.7705 / 0.7265, ΔAUROC +0.044, PR-AUC 0.4020 / 0.3656, balanced
accuracy 0.5546 / 0.5792, MCC 0.2063 / 0.2250, sensitivity 0.1333 / 0.2105, "27 of 30" seeds,
median ΔAUROC +0.054, Nogueira 0.55, and all of Table 5 and the bootstrap CIs. Title, abstract, and
introduction unchanged. GSE25065 kept as same-platform, same-study-family validation. Leakage
(within-cohort) and transportability (external drop) kept distinct. Paper remains audit-first; no
biomarker-discovery claim; no model-agnostic universality claim (the only such phrase is the
pre-existing disclaimer in Scope).

## Verification
- Document validates (`validate.py`: PASSED) and renders (45 pages).
- Table 11 values cross-checked cell-by-cell against `tables/sensitivity/k_sweep_summary.csv`.
- Forbidden terms BioTrust/founder/investor = 0; "used in v1" = 0; "Anticipated roles" = 0;
  "will be archived" = 0; "Phase 3" = 0.
- Duplicate seed paragraph removed (signature phrases occur once); cross-reference corrected.
