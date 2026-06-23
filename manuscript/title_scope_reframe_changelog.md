# Title & Scope Reframe Changelog (v5)

Source: the user's uploaded `…v4_figures.docx` (the most recent version, which includes the
user's added author/affiliation block and the six figures).
Output: `Leakage_Aware_SMO_SVM_Manuscript_v5_title_scope_reframed.docx`.
No result values changed; no new analysis; no citations added; no figures removed; table
numbering unchanged.

## 1. Title (SMO removed; audit-first)
Old: "An Audit of Data Leakage and Feature Stability in Transcriptomic Biomarker
Classification Using Nested SMO/SVM and External Validation."
New (Option A): **"A Reproducible Audit of Data Leakage, Feature Stability, and
Transportability in Transcriptomic Biomarker Classification."**
No model name in the title (model details kept in Methods).

## 2. Abstract (audit-first; SMO as implementation detail)
- Lead model sentence rewritten to present the work as a reproducible audit first: "We present
  a reproducible audit of leakage, feature-selection stability, and external-cohort
  transportability, using a linear support vector machine (SVM)—trained by sequential minimal
  optimization (SMO)—as a transparent, high-dimensional workhorse model."
- "The SMO/SVM classifier … are established methods" → "The linear SVM classifier …".
- "guarded nested SMO/SVM pipeline" → "guarded nested SVM pipeline". The only remaining SMO
  mention in the abstract is the parenthetical training-solver note.

## 3. Study objective and contributions
- "apply an established SMO/SVM approach" → "apply an established linear-SVM approach".
- Contribution 1: "leakage-aware SMO/SVM workflow" → "leakage-aware linear-SVM workflow".
- Added a **Scope** paragraph making the framing explicit: this is a reproducible audit case
  study and is explicitly NOT (i) a new SVM algorithm (SMO is only the training solver for a
  standard linear SVM), (ii) a clinical biomarker discovery study (recurrent probes are
  stability-ranked candidates, not validated markers), or (iii) a demonstration of model-agnostic
  universality (results shown with a single linear SVM workhorse on one discovery cohort and one
  same-study-family external cohort; a within-cohort methodological demonstration).

## 4. Methods — model specification
- Heading "SMO/SVM model specification" → **"Model specification (linear SVM)"**.
- Added: "Sequential minimal optimization (SMO) is used only as the training solver for this
  linear SVM and is an implementation detail rather than a methodological contribution."

## Preservation & cleanup
- All result values preserved exactly (spot-checked: 0.7705, 0.7265, +0.044, 95% CI −0.013 to
  +0.103, 0.878, 0.540, 27 of 30, 0.054, 0.6078, 0.5409, 0.3734).
- Six figures preserved (captions Figure 1–6); table numbering preserved (Table 1–10).
- Author/affiliation block preserved.
- Removed re-introduced Google Docs content-control artifacts (`goog_rdk` `<w:sdt>`) and added
  the required `pgMar gutter` attribute; document passes schema validation and renders (41 pages).
- Verified: SMO absent from the title; SMO/SVM described only as a workhorse model / training
  solver; no duplicated paragraphs; no internal-process notes; no dramatic language
  (proves/confirms/smoking gun/undeniable/catastrophic/mirage).
