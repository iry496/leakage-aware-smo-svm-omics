#!/usr/bin/env python3
"""scripts/checks/08_permutation_control_smoke_check.py

Optional DIRECTIONAL cross-check for the permutation control (Phase 2A).

This is NOT a byte-for-byte reproduction of the R pilot (different SVM solver
and fold RNG); it is a fast sanity check that, under shuffled labels, the leaky
arm sits ABOVE chance while the guarded arm sits NEAR chance. The canonical
analysis is `scripts/08_permutation_control.R` (run in R/RStudio).

It requires a LOCAL copy of the GSE25055 matrix, because GEO data is not
committed and is not fetched here. Export once from RStudio, e.g.:

    dat <- load_gse25055(); x <- prep_expression(dat$x)
    write.csv(data.frame(sample_id = rownames(x), x),
              "processed_data/gse25055_expr.csv", row.names = FALSE)
    write.csv(data.frame(sample_id = rownames(x), label = as.character(dat$y)),
              "processed_data/gse25055_labels.csv", row.names = FALSE)

If those files are absent this script prints instructions and exits 0 (it does
NOT invent data or results).

Scope: GSE25055 ONLY. The four excluded cohorts are never referenced.
"""
import os
import sys
import time
import numpy as np
import pandas as pd

EXPR = "processed_data/gse25055_expr.csv"
LABELS = "processed_data/gse25055_labels.csv"
SEED, POS, TOP_K, B = 20260620, "pCR", 100, 20
OUT_DIR = "results/permutation"


def main():
    if not (os.path.exists(EXPR) and os.path.exists(LABELS)):
        print("[smoke-check] GSE25055 matrix not found at:")
        print(f"    {EXPR}\n    {LABELS}")
        print("[smoke-check] Export it once from RStudio (see this file's header),")
        print("              or run the canonical scripts/08_permutation_control.R in RStudio.")
        print("[smoke-check] No data fetched, no results fabricated. Exiting.")
        return 0

    try:
        from scipy import stats
        from sklearn.svm import SVC
        from sklearn.model_selection import StratifiedKFold
        from sklearn.metrics import roc_auc_score
    except ImportError as e:
        print(f"[smoke-check] missing dependency: {e}; pip install scipy scikit-learn")
        return 1

    os.makedirs(OUT_DIR, exist_ok=True)
    X = pd.read_csv(EXPR).set_index("sample_id")
    y = pd.read_csv(LABELS).set_index("sample_id").loc[X.index, "label"].values
    Xv = X.values.astype(float)
    yb = (y == POS).astype(int)
    n = len(yb)
    print(f"[smoke-check] N={n}; pCR={yb.sum()}; RD={(1-yb).sum()}")

    def ttest_topk(Xtr, ytr, k=TOP_K):
        # Welch two-sample t (matches R t.test default var.equal=FALSE)
        t, _ = stats.ttest_ind(Xtr[ytr == 1], Xtr[ytr == 0], axis=0, equal_var=False)
        return np.argsort(-np.abs(np.nan_to_num(t)))[:k]

    def leaky_auroc(Xm, yl, seed):
        idx = ttest_topk(Xm, yl)                       # global FS = leaky
        Xs = Xm[:, idx]
        aucs = []
        for rep in range(5):
            skf = StratifiedKFold(5, shuffle=True, random_state=seed + rep)
            oof = np.zeros(len(yl))
            for tr, te in skf.split(Xs, yl):
                mu, sd = Xs[tr].mean(0), Xs[tr].std(0); sd[sd == 0] = 1
                clf = SVC(kernel="linear", C=1, class_weight="balanced")
                clf.fit((Xs[tr] - mu) / sd, yl[tr])
                oof[te] = clf.decision_function((Xs[te] - mu) / sd)
            aucs.append(roc_auc_score(yl, oof))
        return float(np.mean(aucs))

    def guarded_auroc(Xm, yl, seed):
        skf = StratifiedKFold(5, shuffle=True, random_state=seed)
        oof = np.zeros(len(yl))
        for tr, te in skf.split(Xm, yl):
            idx = ttest_topk(Xm[tr], yl[tr])           # FS inside train only
            Xtr, Xte = Xm[tr][:, idx], Xm[te][:, idx]
            mu, sd = Xtr.mean(0), Xtr.std(0); sd[sd == 0] = 1
            clf = SVC(kernel="linear", C=1, class_weight="balanced")
            clf.fit((Xtr - mu) / sd, yl[tr])
            oof[te] = clf.decision_function((Xte - mu) / sd)
        return roc_auc_score(yl, oof)

    rng = np.random.default_rng(SEED)
    rows = []
    t0 = time.time()
    for pid in range(B + 1):
        yl = yb if pid == 0 else yb[rng.permutation(n)]
        ts = time.time()
        la, ga = leaky_auroc(Xv, yl, SEED + pid), guarded_auroc(Xv, yl, SEED + pid)
        rows.append(dict(permutation_id=pid, is_identity=(pid == 0),
                         leaky_auroc=round(la, 4), guarded_auroc=round(ga, 4),
                         gap_auroc=round(la - ga, 4), runtime_secs=round(time.time() - ts, 2)))
        print(f"[{pid}/{B}]{' identity' if pid==0 else ''} leaky={la:.4f} guarded={ga:.4f}")
    df = pd.DataFrame(rows)
    df.to_csv(f"{OUT_DIR}/permutation_smoke_crosscheck_null_distributions.csv", index=False)

    sh = df[df.permutation_id > 0]
    idn = df[df.permutation_id == 0].iloc[0]
    print("\n[smoke-check] DIRECTIONAL cross-check (not exact R reproduction):")
    print(f"  identity leaky={idn.leaky_auroc} guarded={idn.guarded_auroc}")
    print(f"  leaky null mean={sh.leaky_auroc.mean():.4f} frac>0.5={ (sh.leaky_auroc>0.5).mean():.3f}")
    print(f"  guarded null mean={sh.guarded_auroc.mean():.4f} frac>0.5={ (sh.guarded_auroc>0.5).mean():.3f}")
    print(f"  mean {((time.time()-t0)/(B+1)):.1f}s/perm")
    return 0


if __name__ == "__main__":
    sys.exit(main())
