# v8 AI Desk-Review-Ready Polish Changelog

Source: `Leakage_Aware_SMO_SVM_Manuscript_v8_full_results_integrated_polished.docx`.
Output: `Leakage_Aware_SMO_SVM_Manuscript_v8_AI_desk_review_ready.docx`.

Final hygiene/consistency polish before AI desk review. No analysis was run; no elastic-net or
GSE41998 results were added; no result values were changed; no code was edited; no references were
added.

## Changes
1. **Table numbering fixed to document order (the main issue).** The K-sweep table previously sat
   after Table 5 but was labelled Table 11. Tables were renumbered so captions appear sequentially,
   and **all in-text references** were updated in the same pass:
   - K-sweep: Table 11 → **Table 6**
   - Permutation control: Table 6 → **Table 7**
   - Repeated nested CV: Table 7 → **Table 8**
   - Feature stability: Table 8 → **Table 9**
   - GSE25065 transportability: Table 9 → **Table 10**
   - Reproducible Omics Evidence Audit: Table 10 → **Table 11**
   Tables 1–5 unchanged. Caption order is now 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11.
2. **Evidence-audit table (now Table 11) GSE25065 wording calibrated:**
   - "External validation is same-platform and non-overlapping." →
     "Same-platform, same-study-family validation cohort is non-overlapping."
   - "External validation shows transportability limits." →
     "Same-study-family validation shows a transportability drop; broader external transportability
     remains untested."
3. **Repository/Zenodo availability softened** (status not overclaimed): "… suitable for DOI archival
   (for example, through Zenodo) accompanies the analysis." → "… will accompany the final
   submission."
4. **Softened strong rhetoric** in the permutation-control interpretation (both occurrences of the
   verb "manufactures"): "manufactures apparent discrimination from noise" → "can produce apparent
   discrimination under randomized labels"; and the Discussion echo "manufactures apparent
   discrimination even when no signal exists" → "can produce apparent discrimination even when no
   signal exists." The scientific point (the negative control behaves as expected) is unchanged.
5. **Author block:** "^3^Affiliation not provided" → "^3^Affiliation to be finalized." No affiliation
   was invented.
6. **Keywords:** removed "sequential minimal optimization" (kept "support vector machine"). SMO
   remains described in the Methods/Introduction as the SVM training solver, in the abstract, in the
   abbreviations list, and in the cited reference — only the keyword was dropped.

## Verification
- Table captions now run 1–11 in order; figure captions unchanged (1–7).
- All K-sweep references (Results, Discussion, Future work) now read "Table 6"; the only remaining
  "Table 11" is the evidence-audit table caption (correct, now last).
- No result values changed: 0.7705 / 0.7265, +0.044, the K-sweep values (0.8365 … 0.8198), Nogueira
  0.5409, Jaccard 0.3734, "27 of 30" all intact. Figure 7 and the K-sweep table intact.
- Elastic-net and GSE41998 remain described only as planned/future extensions (no completed-results
  language); the top-K sweep remains the single completed extension.
- No BioTrust/founder/investor language. Reference count unchanged (43; none added).
- Abstract still describes the model as "trained by sequential minimal optimization (SMO)"
  (solver/implementation detail), consistent with the audit-first framing.
- Document validates (`validate.py`: PASSED) and renders (44 pages).
