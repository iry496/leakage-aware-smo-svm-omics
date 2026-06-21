# scripts/04_feature_stability_gse25055.R
# ==========================================================================
# Feature-stability pilot for GSE25055 (guarded nested SMO/SVM pipeline)
# ==========================================================================
#
# SCIENTIFIC QUESTION
#   Are the genes selected by the guarded nested pipeline stable across the
#   outer cross-validation folds, or does feature selection choose largely
#   different genes in each fold?
#
# WHY FEATURE STABILITY MATTERS FOR BIOMARKER REPRODUCIBILITY
#   Classification performance alone does not tell us whether a gene signature
#   is reproducible. A model can reach acceptable discrimination while the
#   *identity* of the selected genes changes from fold to fold. If the selected
#   "biomarker" genes are unstable:
#     - the signature is unlikely to replicate in independent cohorts,
#     - it is difficult to interpret biologically, and
#     - reported gene lists may be artefacts of a particular data split.
#   Auditing feature-selection stability is therefore a necessary complement
#   to performance auditing and leakage auditing. Low stability is itself an
#   informative result: it argues that biomarker panels must be audited before
#   they are trusted.
#
# DESIGN / REPRODUCIBILITY NOTE
#   This script does NOT change the scientific design of the leaky or nested
#   pipelines. It reuses the EXACT deterministic feature-selection step from
#   scripts/03_nested_smo_svm_gse25055.R (identical SEED, identical outer folds
#   via caret::createFolds, identical t-test top-K selection). Because that step
#   is fully deterministic, the per-fold feature sets reproduced here are
#   identical to those used by the committed nested run. No SVM is retrained and
#   NO external validation dataset is used.
# ==========================================================================

suppressPackageStartupMessages({
  library(GEOquery)
  library(Biobase)
})

# Load the nested pipeline's helpers and constants (SEED, OUTER_FOLDS, TOP_K,
# load_gse25055(), prep_expression(), select_features()). Sourcing only defines
# objects; main() is guarded by sys.nframe() and does not run on source.
source("scripts/03_nested_smo_svm_gse25055.R")

RESULTS_DIR <- "results/pilot_gse25055"
TABLES_DIR  <- "tables/pilot_gse25055"
FIG_DIR     <- "figures/pilot_gse25055"
dir.create(FIG_DIR, recursive = TRUE, showWarnings = FALSE)

# --------------------------------------------------------------------------
# 1. Reproduce per-outer-fold selected features (deterministic)
# --------------------------------------------------------------------------
dat <- load_gse25055()
x   <- prep_expression(dat$x)
y   <- dat$y

P <- ncol(x)   # size of the candidate feature universe used by selection

set.seed(SEED)                                    # identical seed to run_nested()
folds <- caret::createFolds(y, k = OUTER_FOLDS, returnTrain = FALSE)

fold_sets    <- vector("list", length(folds))
feat_records <- list()
for (f in seq_along(folds)) {
  test_idx  <- folds[[f]]
  train_idx <- setdiff(seq_along(y), test_idx)
  fs    <- select_features(x[train_idx, , drop = FALSE], y[train_idx],
                           method = "t_test", top_k = TOP_K)
  feats <- fs$features
  fold_sets[[f]] <- feats
  feat_records[[f]] <- data.frame(
    fold    = f,
    rank    = seq_along(feats),
    feature = feats,
    stringsAsFactors = FALSE
  )
}
by_fold <- do.call(rbind, feat_records)
write.csv(by_fold, file.path(RESULTS_DIR, "nested_selected_features_by_fold.csv"),
          row.names = FALSE)

M      <- length(fold_sets)                       # number of outer folds
k_each <- vapply(fold_sets, length, integer(1))   # features per fold (top K)
kbar   <- mean(k_each)

# --------------------------------------------------------------------------
# 2. Feature-selection frequency (how often each gene is chosen)
# --------------------------------------------------------------------------
all_feats       <- unlist(fold_sets)
freq            <- sort(table(all_feats), decreasing = TRUE)
total_unique    <- length(freq)
freq_int        <- as.integer(freq)
names(freq_int) <- names(freq)
freq_dist       <- table(factor(freq_int, levels = seq_len(M)))  # #features by #folds

n_in_all    <- sum(freq_int == M)
n_in_single <- sum(freq_int == 1)

top_recurrent <- head(data.frame(feature = names(freq_int), n_folds = freq_int,
                                 stringsAsFactors = FALSE), 15)
rownames(top_recurrent) <- NULL

# --------------------------------------------------------------------------
# 3. Pairwise Jaccard overlap between folds
# --------------------------------------------------------------------------
jaccard <- function(a, b) length(intersect(a, b)) / length(union(a, b))
J <- matrix(1, M, M, dimnames = list(paste0("fold", 1:M), paste0("fold", 1:M)))
pair_vals <- numeric(0)
for (i in 1:(M - 1)) for (j in (i + 1):M) {
  v <- jaccard(fold_sets[[i]], fold_sets[[j]])
  J[i, j] <- v; J[j, i] <- v
  pair_vals <- c(pair_vals, v)
}
mean_jac   <- mean(pair_vals)
median_jac <- median(pair_vals)

# --------------------------------------------------------------------------
# 4. Nogueira (2018) stability index
#    Phi = 1 - [ (1/P) sum_f (M/(M-1)) phat_f (1-phat_f) ] / [ (kbar/P)(1-kbar/P) ]
#    phat_f = (#folds selecting feature f) / M. Never-selected features add 0.
# --------------------------------------------------------------------------
phat      <- freq_int / M
var_terms <- (M / (M - 1)) * phat * (1 - phat)
numerator <- sum(var_terms) / P
denom     <- (kbar / P) * (1 - kbar / P)
nogueira  <- 1 - numerator / denom

# --------------------------------------------------------------------------
# 5. Figures
# --------------------------------------------------------------------------
png(file.path(FIG_DIR, "feature_selection_frequency.png"),
    width = 1100, height = 750, res = 130)
bp <- barplot(as.integer(freq_dist), names.arg = names(freq_dist),
              col = "#4292c6", border = NA,
              ylim = c(0, max(as.integer(freq_dist)) * 1.15),
              xlab = sprintf("Number of outer folds selecting a feature (out of %d)", M),
              ylab = "Number of features",
              main = "GSE25055 nested pipeline: feature-selection frequency")
text(bp, as.integer(freq_dist), labels = as.integer(freq_dist), pos = 3, cex = 0.9, xpd = NA)
dev.off()

png(file.path(FIG_DIR, "jaccard_overlap_heatmap.png"),
    width = 820, height = 760, res = 130)
op   <- par(mar = c(4.5, 4.5, 4, 2))
cols <- colorRampPalette(c("#f7fbff", "#6baed6", "#08306b"))(100)
image(1:M, 1:M, J, col = cols, zlim = c(0, 1), axes = FALSE, xlab = "", ylab = "",
      main = "GSE25055: pairwise Jaccard overlap\nof per-fold selected features")
axis(1, at = 1:M, labels = paste0("fold ", 1:M), tick = FALSE)
axis(2, at = 1:M, labels = paste0("fold ", 1:M), tick = FALSE, las = 1)
for (i in 1:M) for (j in 1:M) {
  text(i, j, sprintf("%.2f", J[i, j]), cex = 0.95,
       col = ifelse(J[i, j] > 0.5, "white", "black"))
}
box()
par(op)
dev.off()

# --------------------------------------------------------------------------
# 6. Summary table
# --------------------------------------------------------------------------
summary_tbl <- data.frame(
  metric = c("n_outer_folds", "top_k_per_fold", "feature_universe_size",
             "total_unique_features", "features_selected_in_all_folds",
             "features_selected_in_single_fold", "mean_pairwise_jaccard",
             "median_pairwise_jaccard", "nogueira_stability_index"),
  value  = c(M, paste(unique(k_each), collapse = ","), P,
             total_unique, n_in_all, n_in_single,
             round(mean_jac, 4), round(median_jac, 4), round(nogueira, 4)),
  stringsAsFactors = FALSE
)
top_rows <- data.frame(
  metric = sprintf("top_recurrent_%02d", seq_len(nrow(top_recurrent))),
  value  = sprintf("%s (%d/%d)", top_recurrent$feature, top_recurrent$n_folds, M),
  stringsAsFactors = FALSE
)
summary_tbl <- rbind(summary_tbl, top_rows)
write.csv(summary_tbl, file.path(TABLES_DIR, "feature_stability_summary.csv"),
          row.names = FALSE)

# --------------------------------------------------------------------------
# 7. Notes (why stability matters + results + interpretation + limitations)
# --------------------------------------------------------------------------
interpret <- if (mean_jac < 0.30 || nogueira < 0.40) {
  "LOW stability: the per-fold gene sets overlap only modestly, so the selected biomarker panel is NOT reproducible across folds."
} else if (mean_jac < 0.60) {
  "MODERATE stability: the per-fold gene sets show partial but incomplete agreement."
} else {
  "HIGH stability: the per-fold gene sets largely agree."
}

notes <- c(
  "# GSE25055 feature-stability pilot",
  "",
  "## Question",
  "Are the genes selected by the guarded nested SMO/SVM pipeline stable across the outer CV folds?",
  "",
  "## Why this matters for biomarker reproducibility",
  "Classification performance alone does not guarantee a reproducible signature. A model can",
  "achieve acceptable discrimination while selecting largely different genes in each fold. If the",
  "selected genes are unstable, the panel is unlikely to validate in independent cohorts, is hard",
  "to interpret biologically, and reported gene lists may reflect a particular data split rather",
  "than real biology. Feature-stability auditing therefore complements performance and leakage",
  "auditing. Importantly, LOW stability is itself an informative result: it argues that biomarker",
  "selection must be audited before a signature is trusted.",
  "",
  "## How these numbers were produced",
  "The per-fold feature sets were reproduced deterministically from the committed nested run",
  "(identical SEED, identical caret::createFolds outer folds, identical t-test top-K selection in",
  "scripts/03_nested_smo_svm_gse25055.R). No SVM was retrained and no external dataset was used.",
  "scripts/03 was also extended (logging only) to emit nested_selected_features_by_fold.csv on",
  "future full runs.",
  "",
  "## Results",
  sprintf("- Outer folds: %d", M),
  sprintf("- Features selected per fold (top K): %s", paste(unique(k_each), collapse = ", ")),
  sprintf("- Candidate feature universe: %d genes", P),
  sprintf("- Total unique features ever selected: %d", total_unique),
  sprintf("- Features selected in all %d folds: %d", M, n_in_all),
  sprintf("- Features selected in only 1 fold: %d", n_in_single),
  sprintf("- Mean pairwise Jaccard overlap: %.4f", mean_jac),
  sprintf("- Median pairwise Jaccard overlap: %.4f", median_jac),
  sprintf("- Nogueira (2018) stability index: %.4f", nogueira),
  "",
  "## Interpretation",
  interpret,
  "",
  "## Top recurrent features",
  paste0("- ", top_recurrent$feature, ": ", top_recurrent$n_folds, "/", M),
  "",
  "## Limitations",
  "- Single discovery cohort (GSE25055); no external validation here by design.",
  "- Stability assessed for the t-test top-K filter only (the pipeline's current selector).",
  "- 5 outer folds give 10 pairwise comparisons; estimates are pilot-scale.",
  "- Near-zero-variance filtering is applied on the full matrix (existing pipeline behaviour,",
  "  unsupervised and unchanged here)."
)
writeLines(notes, file.path(RESULTS_DIR, "feature_stability_notes.md"))

cat("\n==== Feature-stability pilot complete ====\n")
cat(sprintf("Total unique features: %d | in all folds: %d | single-fold: %d\n",
            total_unique, n_in_all, n_in_single))
cat(sprintf("Mean Jaccard: %.4f | Median Jaccard: %.4f | Nogueira: %.4f\n",
            mean_jac, median_jac, nogueira))
