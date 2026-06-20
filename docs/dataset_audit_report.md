# Dataset Audit Report (v1)

Task 1 of the leakage-aware SMO/SVM omics study. This report records the metadata audit, endpoint label counts, sample-overlap assessment, and cohort-role recommendation for the five candidate GEO cohorts. No expression matrices or raw CEL files were downloaded; only GEO sample-characteristics metadata was parsed. No modeling was performed.

## Cohorts and verified label counts

Counts were tallied from each series' per-sample characteristics field (the exact field name used is recorded as the label source).

GSE25055 (discovery): platform GPL96 (HG-U133A), total N = 310. Label field `pathologic_response_pcr_rd`: pCR = 57, RD = 249, plus 4 samples coded NA (excluded). Status: verified from sample metadata. Source: Hatzis et al., JAMA 2011 (PMID 21558518).

GSE25065 (external validation 1): platform GPL96, total N = 198. Label field `pathologic_response_pcr_rd`: pCR = 42, RD = 140, plus 16 samples coded NA (excluded). Status: verified from sample metadata. Source: Hatzis et al., JAMA 2011.

GSE20194 (sensitivity; demoted from validation): platform GPL96, total N = 278. Label field `pcr_vs_rd`: pCR = 56, RD = 222, all samples labeled. Status: verified from sample metadata. Source: Shi et al., Nat Biotechnol 2010 / Popovici et al., Breast Cancer Res 2010.

GSE41998 (external validation 2; pending): platform GPL571 (HG-U133A 2.0), total N = 279. Label field `pcr`: Yes = 69, No = 184, value "0" = 20, with 6 samples missing the field. Status: unclear / needs manual review (see open issues). Source: Horak et al., Clin Cancer Res 2013 (PMID 23340299).

GSE20271 (optional sensitivity): platform GPL96, total N = 178. Label field `pcr or rd`: pCR = 26, RD = 152, all samples labeled. Status: verified from sample metadata. Source: Tabchy et al., Clin Cancer Res 2010 (PMID 20829329).

## Endpoint harmonization

All five cohorts report a binary pathologic-complete-response versus residual-disease endpoint, so harmonization is feasible in principle. However the label is stored under a different field name in every cohort (`pathologic_response_pcr_rd`, `pcr_vs_rd`, `pcr or rd`, `pcr`), and value encodings differ (pCR/RD/NA versus Yes/No versus numeric). A single harmonization mapping must be defined and applied per cohort before any modeling.

## Open issue 1: GSE41998 pCR label ambiguity

The `pcr` field in GSE41998 takes values Yes (69), No (184), and "0" (20), and 6 samples lack the field entirely. The missing-field samples correspond to non-randomized patients (treatment arm "none") with AC-phase progressive or stable disease. The "0" value co-occurs with an "AC response = complete response" annotation in several records, so it cannot be mapped cleanly to pCR or RD without the original study's coding key. pCR_N and RD_N for this cohort are therefore left as "needs human verification" rather than guessed. This must be resolved before GSE41998 can serve as external validation cohort 2.

## Open issue 2: MDACC FNA overlap risk

GSE20194 and GSE20271 are both MDACC fine-needle-aspiration cohorts drawn from overlapping neoadjuvant accrual programs, sharing investigators with the Hatzis discovery/validation cohorts (GSE25055 / GSE25065, SuperSeries GSE25066). Patient-level overlap among these series is plausible and well documented in the literature. Treating any two of them as independent would silently leak information into external validation. GSE25055 and GSE25065 are non-overlapping with each other by design (the original discovery/validation split), so that pairing is safe.

## Open issue 3: sample-level de-duplication required

Series-level metadata cannot confirm independence. Before GSE20194 or GSE20271 is used even as a sensitivity cohort, a sample-level de-duplication must be performed against the discovery and validation cohorts using clinical identifiers, hybridization/biopsy dates, and GSM-level matching. This step has not been done.

## Cohort-role recommendation

Discovery: GSE25055. External validation 1: GSE25065 (same platform; minimal harmonization). External validation 2: GSE41998 (independent trial, but on platform GPL571 requiring cross-platform harmonization, and pending label resolution). Optional sensitivity: GSE20271 (only after de-duplication). GSE20194 is demoted from external validation to sensitivity-only because of its overlap risk with the Hatzis cohorts.

## Constraints honored

No raw CEL files or expression matrices downloaded; only GEO sample-characteristics metadata parsed. No modeling performed. protocol_v0_1.md not edited.
