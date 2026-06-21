# Revision Roadmap After AI Review

_Planning document for the manuscript-strengthening phase of_
**"A Leakage-Aware Data Mining Framework for Transcriptomic Biomarker
Classification Using Nested SMO/SVM and Feature-Stability Auditing"**
(target: _BioData Mining_, methodology article).

This roadmap turns the AI-review feedback into a prioritized, trackable plan. It
defines the GitHub issues, recommended branch names, phase ordering, and the
gates for internal (Prof. Wong) review and journal submission. No analysis code,
manuscript text, or result values are changed by this document.

Priority key: **P0 = critical / likely blocks acceptance**, **P1 = high**,
**P2 = medium**. All input paths refer to `main`.

---

## 1. Major reviewer concerns

1. **Point estimates without uncertainty.** Headline metrics (AUROC, PR-AUC,
   balanced accuracy, MCC, sensitivity, specificity) and the leakage gap are
   reported as single numbers with no confidence intervals or significance test.
2. **No negative control.** There is no label-shuffle / permutation evidence that
   the observed signal — and the leakage inflation — exceed chance.
3. **Single-seed fragility.** Results rest on one set of folds; robustness across
   seeds is unquantified for both the leakage gap and feature stability.
4. **Thin external independence.** Only one same-platform external cohort
   (GSE25065, Hatzis lineage). No cross-platform validation.
5. **Overstated / mis-scoped claims.** The leakage gap (internal) and the
   transportability drop (internal → external) risk being conflated; calling the
   guarded pipeline a "better classifier" rests on threshold-dependent metrics.
6. **Novelty framing.** SMO/SVM is not new; the contribution must be framed as an
   audit framework, with explicit positioning against existing tools.
7. **Draft hygiene.** Proposal/future-tense language, self-instructions, internal
   notes, placeholders, and orphan references signal an unfinished paper.
8. **Reproducibility packaging.** Data/materials availability is still a
   placeholder; no environment lockfile, seeds, fold assignments, or archived
   release.

## 2. Two root causes

**Root cause A — Insufficient statistical rigor and breadth.**
Concerns 1, 2, 3, 5 (partly), and the single-selector/single-classifier scope.
Addressed by: bootstrap CIs and significance tests, permutation controls,
repeated nested CV, an elastic-net comparator, and (optional) selector/K and
calibration analyses.

**Root cause B — Insufficient external independence and thin audit novelty.**
Concerns 4, 5, 6, 8. Addressed by: a leakage-safe second external cohort
(GSE41998), an audit-not-algorithm novelty reframe with explicit positioning,
calibrated claims, a summary dashboard figure, and a reproducible release.

Draft hygiene (concern 7) is cross-cutting and underpins reviewer trust in both.

---

## 3. Prioritized issue list

| # | Issue group | Priority | New modeling | Branch |
|---|-------------|----------|--------------|--------|
| 1 | manuscript/hygiene-tense-cleanup | P1 | No | `manuscript/hygiene-tense-cleanup` |
| 2 | manuscript/novelty-reframe | P1 | No | `manuscript/novelty-reframe` |
| 3 | manuscript/claim-calibration | P0 | No | `manuscript/claim-calibration` |
| 4 | analysis/bootstrap-ci | P0 | No (resampling of stored predictions) | `analysis/bootstrap-ci` |
| 5 | analysis/permutation-control | P1 | Yes | `analysis/permutation-control` |
| 6 | analysis/repeated-nested-cv | P1 | Yes | `analysis/repeated-nested-cv` |
| 7 | analysis/gse41998-external | P2 | Yes | `analysis/gse41998-external` |
| 8 | analysis/comparator-elasticnet | P2 | Yes | `analysis/comparator-elasticnet` |
| 9 | figure/evidence-audit-dashboard | P2 | No | `figure/evidence-audit-dashboard` |
| 10 | repo/reproducibility-release | P1 | No | `repo/reproducibility-release` |
| 11 | analysis/selector-and-k-sweep _(optional)_ | P2 | Yes | `analysis/selector-and-k-sweep` |
| 12 | analysis/calibration-threshold _(optional)_ | P2 | Yes | `analysis/calibration-threshold` |

### Issue details

**1. manuscript/hygiene-tense-cleanup** — P1, no new modeling.
Convert the draft from proposal to completed-study report: remove future-tense
("will"/"planned"), self-instructions and internal notes, placeholders ("To be
finalized", BioTrust/LA BioStart asides), the irrelevant "APA 7 author-date"
production note, and fix orphan references.
_Inputs:_ `manuscript/*.docx`, `manuscript/results_section_v1.md`, reference list.
_Outputs:_ cleaned versioned `.docx` + changelog.
_Depends on:_ none (do early).

**2. manuscript/novelty-reframe** — P1, no new modeling.
Frame the contribution as audit-not-algorithm; de-emphasize SMO as novelty (keep
it as the sensitive test classifier); add explicit positioning vs `nestedcv`,
OmicSelector, and the leakage-audit literature; keep language measured.
_Inputs:_ manuscript draft, Table 2 (Direct Competitor Positioning), references.
_Outputs:_ revised Introduction/Background novelty paragraphs + updated table.
_Depends on:_ none.

**3. manuscript/claim-calibration** — P0, no new modeling.
Separate the leakage gap (internal) from the transportability drop (external); do
not claim the guarded pipeline is a better classifier from threshold-dependent
metrics alone; interpret operating-point metrics cautiously.
_Inputs:_ pilot + external summaries; outputs of #4 and #5 for final wording.
_Outputs:_ revised Results/Discussion interpretation.
_Depends on:_ #4, #5 (soft — finalize wording after CIs and permutation p-values).

**4. analysis/bootstrap-ci** — P0, no new model fitting (resampling only).
Bootstrap CIs for AUROC, PR-AUC, balanced accuracy, MCC, sensitivity,
specificity (internal and external); paired/stratified bootstrap and DeLong test
for ΔAUROC and ΔPR-AUC.
_Inputs:_ stored out-of-fold predicted probabilities + labels (pilot/nested-CV
and GSE25065 projection) — **confirm these prediction artifacts exist first**.
_Outputs:_ `tables/uncertainty/bootstrap_ci.csv`,
`results/uncertainty/delong_tests.csv`, CI script.
_Depends on:_ availability of per-fold prediction scores.

**5. analysis/permutation-control** — P1, new modeling.
Label-shuffle negative control under both leaky and guarded pipelines; report
null distributions and empirical p-values for metrics and the leakage gap.
_Inputs:_ GSE25055 matrix + labels (GEOquery), pilot pipeline code, fixed seeds.
_Outputs:_ `results/permutation/null_distributions.csv`,
`figures/permutation_null.*`, empirical p-values.
_Depends on:_ none (reuses pilot pipeline).

**6. analysis/repeated-nested-cv** — P1, new modeling.
Repeat nested CV across 20–30 seeds; report distributions of the leakage gap and
of feature-stability metrics (Nogueira, Jaccard, core/tail counts).
_Inputs:_ GSE25055 matrix + labels; guarded nested pipeline code; seed list.
_Outputs:_ `tables/repeated_cv/leakage_gap_by_seed.csv`,
`tables/repeated_cv/stability_by_seed.csv`, distribution figures.
_Depends on:_ none.

**7. analysis/gse41998-external** — P2, new modeling (projection only).
Design leakage-safe GSE41998 (GPL571) validation: no joint normalization, no
global ComBat; shared probe/gene mapping derived without test data; freeze the
GSE25055 model before projection; resolve GSE41998 label coding first.
_Inputs:_ GSE41998 matrix + resolved labels, frozen GSE25055 model + features,
platform mapping table.
_Outputs:_ `results/external_validation_gse41998/*`,
`tables/external_validation_gse41998_summary.csv`, harmonization note.
_Depends on:_ GSE41998 label resolution; frozen model from pilot.

**8. analysis/comparator-elasticnet** — P2, new modeling.
Add elastic net as a second classifier through the identical audit
(leaky-vs-guarded, stability, external) to support the audit-not-algorithm frame.
_Inputs:_ GSE25055/GSE25065 matrices + labels, shared audit/pipeline code.
_Outputs:_ comparator rows in performance/stability/external tables,
`results/comparator_elasticnet/*`.
_Depends on:_ #2 (conceptually), shared pipeline.

**9. figure/evidence-audit-dashboard** — P2, no new modeling.
Multi-panel dashboard: leakage gap (with CIs), feature stability, external drop,
reproducibility-status badges; provides the referenced "Figure 1".
_Inputs:_ `tables/evidence_audit/reproducible_omics_evidence_audit.csv`,
performance/stability/external summaries, #4 CIs.
_Outputs:_ `figures/evidence_audit_dashboard.*` + plotting script.
_Depends on:_ #4, #5, #6.

**10. repo/reproducibility-release** — P1, no new modeling.
README, environment/lockfile (`renv.lock`), seeds, fold assignments,
selected-feature lists, run instructions; tag a frozen release; Zenodo metadata.
_Inputs:_ whole repo, finalized outputs from #4–#8, seed/fold artifacts.
_Outputs:_ `README.md`, `renv.lock`/`environment.yml`, `CITATION.cff`, Zenodo
metadata, release notes.
_Depends on:_ all analyses final (sequence last).

**11. analysis/selector-and-k-sweep** _(optional)_ — P2, new modeling.
Sweep feature selectors (t-test/ANOVA, Information Gain, SVM-RFE, mRMR) and
top-K values; show the leakage gap and stability are not artifacts of one
selector/K. Addresses the "single primary selector" limitation.
_Inputs:_ GSE25055 matrix + labels, pipeline code, selector configs.
_Outputs:_ `tables/sweeps/selector_k_sweep.csv`, sensitivity figures.
_Depends on:_ #6 infrastructure.

**12. analysis/calibration-threshold** _(optional)_ — P2, new modeling.
Assess probability calibration (curves, Brier score) and threshold selection done
strictly inside training folds; contrast threshold-free vs threshold-dependent
metrics to support cautious operating-point claims.
_Inputs:_ stored predicted probabilities + labels.
_Outputs:_ `results/calibration/*`, calibration/threshold figures.
_Depends on:_ #4 (predictions); supports #3.

---

## 4. Recommended branch names

```
manuscript/hygiene-tense-cleanup
manuscript/novelty-reframe
manuscript/claim-calibration
analysis/bootstrap-ci
analysis/permutation-control
analysis/repeated-nested-cv
analysis/gse41998-external
analysis/comparator-elasticnet
figure/evidence-audit-dashboard
repo/reproducibility-release
analysis/selector-and-k-sweep        # optional
analysis/calibration-threshold       # optional
```

Workflow for each: branch → PR → review → merge into `main`. No direct commits to
`main`; no branch is merged without review.

## 5. Phase ordering

**Phase 1 — Foundations (parallelizable, low/no compute).**
`analysis/bootstrap-ci` (P0), `manuscript/hygiene-tense-cleanup` (P1),
`manuscript/novelty-reframe` (P1). Unblocks claim wording; quick credibility wins.

**Phase 2 — Evidence hardening.**
`analysis/permutation-control` (P1), `analysis/repeated-nested-cv` (P1) → then
finalize `manuscript/claim-calibration` (P0) once CIs, permutation p-values, and
seed distributions exist.

**Phase 3 — Scope expansion.**
`analysis/gse41998-external` (P2, gate on label resolution),
`analysis/comparator-elasticnet` (P2). Optional: `analysis/selector-and-k-sweep`,
`analysis/calibration-threshold`.

**Phase 4 — Presentation + packaging.**
`figure/evidence-audit-dashboard` (P2, needs Phase 1–2 outputs), then
`repo/reproducibility-release` (last).

---

## 6. Gates

### Before Prof. Wong review
Goal: present statistically credible, honestly framed results.

- manuscript/hygiene-tense-cleanup
- manuscript/novelty-reframe
- manuscript/claim-calibration (interim wording)
- analysis/bootstrap-ci
- analysis/permutation-control
- analysis/repeated-nested-cv

### Before journal submission
Goal: external independence, generalization, presentation, reproducibility.

- analysis/gse41998-external
- analysis/comparator-elasticnet
- figure/evidence-audit-dashboard
- repo/reproducibility-release
- manuscript/claim-calibration (final wording, all evidence incorporated)

### Delay / optional / out of scope for this round
- analysis/selector-and-k-sweep and analysis/calibration-threshold — run if time
  allows or if reviewers request added robustness.
- GSE20194 / GSE20271 sensitivity analyses — remain held pending sample-level
  de-duplication (MDACC lineage overlap risk).
- RNA-seq, multi-omics, survival endpoints, and automated evidence-dossier
  extensions — future-work framing only.
- Any BioTrust / LA BioStart positioning — keep in Discussion/future work; do not
  let it drive title or abstract.

---

## 7. Open prerequisite

Confirm whether per-fold out-of-fold predicted probabilities (and the GSE25065
projection scores) were stored. `analysis/bootstrap-ci` (DeLong / paired
bootstrap) needs these; if only summary CSVs were saved, the prediction artifacts
must be located or re-exported before Phase 1 can complete.

---

## 8. Recommended first issue

**analysis/bootstrap-ci** (P0). It uses only stored predictions (no new
modeling), and its confidence intervals and ΔAUROC/ΔPR-AUC tests are
prerequisites for finalizing `manuscript/claim-calibration` and the dashboard
figure. Start it in parallel with the low-effort `manuscript/hygiene-tense-cleanup`.
