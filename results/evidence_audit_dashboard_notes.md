# Evidence Audit Dashboard — Notes

A single six-panel figure that visually summarizes the Reproducible Omics Evidence Audit.
**No new modeling**: every panel is drawn from outputs already committed to the repository.

## Files
- `scripts/11_plot_evidence_audit_dashboard.R` — canonical generator (base R); reads the committed
  outputs and writes the PNG and PDF.
- `figures/evidence_audit_dashboard.png` / `.pdf` — the dashboard.

## Panels and sources
1. **Single-seed leakage gap with CI** — ΔAUROC +0.044 [−0.0125, +0.1028] and ΔPR-AUC +0.0362
   [−0.0483, +0.1247], with bootstrap p-values; the CI includes zero in this single cohort.
   Source: `tables/uncertainty/delta_auroc_prauc_ci.csv`.
2. **B=1000 permutation null behaviour** — histograms of the leaky vs guarded null AUROC under
   shuffled labels (leaky null ≈ 0.88, guarded null ≈ 0.54), with observed real-label AUROCs and a
   0.5 chance line. Labelled "diagnostic of leakage artifact". Sources:
   `results/permutation/permutation_b1000_null_distributions.csv`, `…_pvalues.csv`.
3. **30-seed leakage-gap distribution** — boxplot + points of ΔAUROC across 30 seeds (positive in
   27/30; "modest but reproducible"). Source: `tables/repeated_cv/leakage_gap_by_seed.csv`.
4. **Feature-stability distribution** — per-seed Nogueira index and mean Jaccard (dashed lines mark
   the single-split values 0.5409 and 0.3734); labelled "moderate feature stability". Source:
   `tables/repeated_cv/stability_by_seed.csv`.
5. **Same-study-family external-validation drop** — discovery (guarded CV) vs GSE25065 for AUROC,
   PR-AUC, and sensitivity; labelled "transportability drop, not leakage". Sources:
   `results/external_validation_gse25065/gse25065_external_metrics.csv`, `tables/uncertainty/bootstrap_ci.csv`.
6. **Reproducibility / audit status** — checklist of the committed analyses (scripts 07–10), fixed
   seeds, frozen external model, and the framing line "Not biomarker discovery".

## Cautious labels used
"diagnostic of leakage artifact" (panel 2); "same-study-family validation" / "transportability
drop, not leakage" (panel 5); "moderate feature stability" (panel 4); "modest but reproducible"
(panel 3); "within-cohort, diagnostic" and "not biomarker discovery" (title and panel 6).

## Regeneration
```
Rscript scripts/11_plot_evidence_audit_dashboard.R
```
Reads only committed outputs; performs no modeling, resampling, or external-data access.

## Authoring note
Because R is not runnable in the authoring environment, the committed PNG/PDF were produced by an
equivalent matplotlib builder reading the same committed inputs; the canonical R script reproduces
the same dashboard and should be run to confirm.
