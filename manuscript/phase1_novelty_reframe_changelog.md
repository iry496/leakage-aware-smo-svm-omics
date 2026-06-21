# Phase 1 Novelty-Reframe Changelog

**Source:** `Leakage_Aware_SMO_SVM_Manuscript_v2_phase1_clean.docx` (output of the hygiene pass, PR #21).
**Output:** `Leakage_Aware_SMO_SVM_Manuscript_v2_phase1_novelty_reframe.docx`
**Scope:** `manuscript/novelty-reframe` (roadmap issue #8) — novelty framing only.
**Guarantee:** No result values changed. Structure preserved (187 paragraphs, 9 tables). The four numeric result tables (Tables 5–8) are byte-for-byte unchanged. The only table edited is the qualitative competitor-positioning table (Table 2). Tone kept measured; no dramatic language ("mirage", "catastrophic", "shatters", "undeniable proof", "smoking gun") was used.

## Objective
Reframe the manuscript so the novelty is unambiguously the **integrated empirical audit**, not the algorithm, the validation procedure, or the stability metric.

## Sections revised (5 paragraphs + 1 table row)

1. **Abstract.** Added one sentence making the contribution explicit: "The SMO/SVM classifier, nested cross-validation, and feature-stability metrics are established methods; the contribution is their integration into a single reproducible audit that couples a leakage-gap comparison, fold-level feature-stability profiling, frozen external validation, and structured evidence reporting." (The existing "Rather than claiming a new algorithm…" and "without claiming clinical biomarker discovery" wording was retained.)

2. **Introduction → Study objective and contributions.** Added: "The SMO/SVM classifier, nested cross-validation, and feature-stability metrics employed here are all established methods and are not claimed as contributions," and recast the contribution as "an integrated empirical audit that quantifies … inflation, profiles feature-selection stability across folds, tests external transportability …, and reports these dimensions together in a single evidence-audit table."

3. **Literature Review → Remaining methodological gap.** Strengthened positioning against existing tools and literature: now names **nestedcv (Lewis et al., 2023)**, **OmicSelector** (automated omics feature-selection / deep-learning environment that enforces nested CV and computes stability metrics), and the **data-leakage literature (Ambroise & McLachlan, 2002; Kapoor & Narayanan, 2023)**, then states the missing piece as a focused empirical audit (leakage gap + stability profile + external transportability + single evidence-audit table) and contrasts with pCR/RD signature studies.

4. **Discussion → Relation to existing tools and literature.** Added that the work "does not introduce a new classifier, validation procedure, or stability metric," and positioned it explicitly against nestedcv and OmicSelector: those provide reusable machinery, while this study's contribution is "the empirical audit such machinery enables."

5. **Conclusion.** Sharpened: "the novelty lies in the integrated audit architecture—coupling leakage-gap quantification, feature-stability profiling, and external validation—rather than in the classifier, the nested-validation procedure, or the stability metrics, each of which is established."

6. **Table 2 (Direct Competitor Positioning).** Added one row for **OmicSelector**, mirroring the table's four columns (closest literature / what it contributes / what remains missing / how this manuscript differs), formatted to match the existing rows.

## Novelty now stated explicitly
- SMO/SVM is an established workhorse classifier, **not** the novelty.
- Nested cross-validation is established, **not** the novelty.
- Feature-stability metrics (Nogueira index, Jaccard, selection frequencies) are established, **not** the novelty.
- The novelty is the **integrated empirical audit**: leakage gap + feature stability + external validation + evidence-audit reporting, applied to an established workhorse.
- The paper is explicitly **not** a clinical biomarker discovery study (retained throughout abstract, results intro, and conclusion).

## Positioning added relative to
- **nestedcv** (Lewis et al., 2023) — nested CV machinery vs. our empirical audit.
- **OmicSelector** — automated omics FS/DL environment vs. our focused leakage-gap + transportability audit. Mentioned **by name only** (no author-year citation): OmicSelector is a bioRxiv preprint/software, and the manuscript's literature policy excludes preprints; a non-referenced in-text citation would also create a new orphan. This mirrors the existing "stabm" mention.
- **Data-leakage literature** (Ambroise & McLachlan, 2002; Kapoor & Narayanan, 2023) — both already in the reference list.
- **Transcriptomic pCR/RD biomarker studies** — contrasted as signature-focused rather than audit-focused.

## Results / tables
- **No results or numeric tables changed.** All values (AUROC 0.7705/0.7265, PR-AUC 0.4020/0.3656, gaps +0.0440/+0.0363, external 0.6078/0.3060, stability 222/28/102, Nogueira 0.5409, cohort counts) are identical. Tables 5–8 unchanged. Only Table 2 (qualitative positioning) gained one OmicSelector row.
- No new reference was added (OmicSelector named only; no orphan created).
