# Co-Author Review Packet — Paul (Evidence-Audit Framing / Translational Relevance)

**Manuscript:** *An Audit of Data Leakage and Feature Stability in Transcriptomic Biomarker Classification Using Nested SMO/SVM and External Validation.*

**Current version:** `manuscript/Leakage_Aware_SMO_SVM_Manuscript_v3_phase2_claim_calibrated_polished.docx` (on `main`). This packet introduces no new analysis and changes no result values.

---

## Plain-language summary

When researchers build a gene-expression model to predict whether a breast-cancer patient will respond to chemotherapy, it is surprisingly easy to fool yourself. If you pick the "best" genes using the whole dataset before testing, the model looks better than it really is — it has effectively peeked at the answers. This paper builds a careful, transparent way to *audit* that mistake rather than claiming a new algorithm. We run two versions of the same model — one that peeks (the "leaky" version) and one that is walled off properly (the "guarded" version) — and we measure the gap between them. We then stress-test that gap three ways: with confidence intervals (how sure are we?), with a "shuffle test" that scrambles the answer key to see how much performance is just an artifact, and by repeating the whole thing 30 times with different random splits to see if the result holds up. The honest bottom line is measured: in this one dataset the leakage gap is real in direction but small and not statistically nailed down, while the shuffle test clearly shows the leaky version can manufacture good-looking results from pure noise. We also check whether the "important genes" stay the same across runs (they are only moderately stable), and whether the model still works on an independent patient group (performance drops — a transportability limit). The product of the paper is a reusable **Evidence Audit Table** that lays all of this out in one place.

## BioTrust / evidence-dossier relevance

The work maps cleanly onto a BioTrust-style "evidence dossier" idea: a structured, skeptical scorecard for a computational biomarker claim. Instead of a single headline accuracy number, the audit reports, side by side, *how sensitive the result is to leakage, how reproducible the gene signature is, how well it transfers to a new cohort, and whether the analysis is reproducible from committed artifacts.* That is exactly the kind of standardized, trust-oriented reporting a dossier product would automate. The manuscript demonstrates the template on a real pCR/RD problem; the translational pitch is that this scorecard could become a routine gate before any biomarker claim is trusted, funded, or advanced.

## What the Evidence Audit Table (Table 10) means

Table 10 ("Reproducible Omics Evidence Audit") is the one-page trust summary. Each row is an audit *dimension*, not just a metric:

- **Dataset integrity** — how many usable labeled samples, same-platform, non-overlapping.
- **Leakage sensitivity** — the leaky-vs-guarded gap (with its confidence interval that includes zero) and the permutation control showing the leaky pipeline scores above chance even on shuffled labels (diagnostic of a leakage artifact).
- **Guarded performance / class-imbalance behavior** — operating-point metrics, flagged as varying under class imbalance and to be read cautiously.
- **Feature stability** — moderate stability (a small reproducible core of genes, a large unstable tail).
- **External validation** — the transportability drop on the independent cohort.
- **Reproducibility status** — results regenerate from committed code/seeds/outputs.
- **Limitations** — no clinical biomarker claim.

The point is that a reader (or an investor, or a reviewer) can scan one table and see the *whole* trust picture, including the weaknesses, rather than a single optimistic AUROC.

## What NOT to overclaim

- This is a **methodology / audit** paper, **not** a clinical biomarker discovery. The recurrent genes are "stability-ranked candidates," never validated markers.
- The leakage gap is **positive but modest, with a confidence interval that includes zero** in this single cohort — do not present it as a large or definitively significant effect.
- The 30-seed result shows **reproducibility across data splits**, not patient-level statistical proof — keep that distinction.
- The permutation control demonstrates the leakage **mechanism**; it does not prove the size of the real-data gap.
- The external-cohort drop is a **transportability limit**, not evidence of leakage, and the external cohort is **same-platform / same-study-family**, so it is not a strong test of broad generalization.
- Avoid dramatic language (e.g., "proves," "confirms," "smoking gun"); the manuscript intentionally uses "supports the interpretation," "diagnostic," "within-cohort," "modest but reproducible."

---

## Three questions for Paul

1. **Is the evidence-audit story understandable?** Reading the plain-language summary and Table 10, does the core narrative — *peeking inflates results; here is how we measure and bound that, plus stability and transportability* — land clearly for a non-specialist or investor audience, or is it still too technical?

2. **Is Table 10 useful as a BioTrust evidence-dossier template?** Does the row structure (integrity, leakage sensitivity, stability, transportability, reproducibility, limitations) work as a reusable dossier scorecard, and what rows or framing would a BioTrust product need that the current table is missing?

3. **Where should BioTrust / founder / investor framing appear without weakening academic credibility?** Our working assumption is to keep the title and abstract strictly academic (no product language) and to place any BioTrust / translational / dossier framing in the Discussion's future-work and practical-recommendations sections. Do you agree with that placement, and how prominent should the dossier framing be there?

---

_Prepared for co-author review. No new analysis was run; all numbers are from the merged Phase 1/2 outputs in the repository._
