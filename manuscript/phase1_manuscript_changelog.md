# Phase 1 Manuscript Hygiene Changelog

**Source:** `Leakage_Aware_SMO_SVM_Manuscript_v1_structured.docx` (Google Drive upload)
**Output:** `Leakage_Aware_SMO_SVM_Manuscript_v2_phase1_clean.docx`
**Scope:** `manuscript/hygiene-tense-cleanup` (roadmap issue #7) — text hygiene only.
**Guarantee:** No result values, numbers, tables, figures, or claims were changed.
Structure is identical (187 paragraphs, 9 tables). This is **not** the
claim-calibration pass (#9); statistical-significance wording is unchanged here.

The uploaded v1_structured had already removed several proposal-era sections
(the "Manuscript Status / Updated Paper Map", "Planned Figures and Tables", the
literature-search appendix, and the "APA 7 author-date" production note), so this
pass cleaned the remaining proposal language, self-instructions, placeholders,
and one orphan reference.

## 1. Proposal / future-tense → completed-study tense
Removed "proposed manuscript / proposed paper / proposed framework" and
future-tense "will report / will treat / planned / must avoid", converting them to
present/past completed-study phrasing.

- Abstract: "The proposed Reproducible Omics Evidence Audit provides…" → "The Reproducible Omics Evidence Audit provides…"
- Intro (feature stability): "The present manuscript therefore treats… The planned framework will report…" → "This study treats… The framework reports…"
- Lit review: "in the proposed manuscript" → "in this study"; "The proposed manuscript builds on…" → "This study builds on…"; "for the proposed paper" → "for this study"; "for the planned audit" → "for this audit"; "The proposed manuscript will therefore report…" → "This study therefore reports…"; "the proposed framework will report…" → "this framework reports…"; "The proposed manuscript will treat these datasets…" → "This study treats these datasets…"; "Although the proposed manuscript is a methodology paper…" → "Although this study is a methodology paper…"; "The proposed manuscript addresses this gap…" → "This study addresses this gap…"
- Dataset-design rule: "The planned analysis must avoid… External validation must be truly held out…" → "The analysis avoided… External validation was held out…"
- Reproducibility: "A frozen repository release should be archived … before submission." → "… will be archived … at submission."

## 2. Self-instructions / internal editorial notes → removed or rephrased
- "This manuscript should avoid overstating algorithmic novelty…" → declarative "This study does not overstate algorithmic novelty. SMO/SVM is not new; the novelty is the audit architecture around it…"
- Table 1 caption "Literature Matrix **for the Updated Manuscript**" → "Literature Matrix"; note "manuscript-facing synthesis of the literature-review report…" → "The table summarizes peer-reviewed and foundational sources that directly support the methodology."
- Table 2 note "states the novelty position **to preserve in the introduction, cover letter, and response to reviewers**" → "The table summarizes how this study is positioned relative to existing tools."
- Table 8 note "…**and should be updated if GSE41998 or additional feature-selection methods are added**" → "The evidence audit summarizes the current results."
- Methods (feature selection): removed "**after coauthor review**"; "preserves **the paper's** methodological focus" → "preserves the methodological focus".
- Future work: removed the internal instruction "Any BioTrust-related language should remain in the Discussion or future-work framing and should not dominate the title or abstract."
- Ethics: removed "Final ethics language should be reviewed according to institutional policy before submission"; the statement now reads as a completed declaration.

## 3. Placeholders ("To be finalized") → clean placeholders, informal names removed
- Competing interests: removed the "If BioTrust or LA BioStart is mentioned…" internal note → "Competing interests will be declared by all authors prior to submission."
- Funding: "To be finalized." → "Funding sources will be declared prior to submission."
- Authors' contributions: removed informal first-name planning ("Iris will lead…; Prof. Wong will contribute…; Paul…; any UCLA biomedical collaborator…") → "Author contributions will be finalized prior to submission. Anticipated roles span study design and leakage-audit framing; SMO/SVM modeling, feature-selection design, and validation rigor; evidence-audit framing and translational relevance; and disease and transcriptomic interpretation."
- Acknowledgements: "To be finalized." → "Acknowledgements will be added prior to submission."
- Availability of data and materials: rephrased "The final submission should include the GitHub repository and an archived Zenodo DOI…" into a declarative availability statement.

## 4. Orphan reference fixed
- **Berrar & Flach (2012)** was listed in the References but never cited in text. Added a supporting citation where it is directly relevant — the metrics paragraph noting that "AUROC alone can be misleading when the minority class is clinically important **(Berrar & Flach, 2012)**." All other references are cited; no reference was deleted.

## 5. Explicitly NOT changed
- All result numbers (AUROC 0.7705 / 0.7265, PR-AUC 0.4020 / 0.3656, gaps +0.0440 / +0.0363, external 0.6078 / 0.3060, stability 222/28/102, Nogueira 0.5409, cohort counts, etc.).
- All eight result tables and their values.
- Scientific claims and interpretation (including the cautious operating-point wording already present in v1_structured).
- Confidence-interval / significance wording — deferred to `manuscript/claim-calibration` (#9), which will incorporate the bootstrap-CI results (#10, PR #20).
