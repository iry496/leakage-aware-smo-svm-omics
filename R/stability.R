# Feature-stability helpers.

selection_matrix <- function(feature_sets, all_features) {
  mat <- matrix(0L, nrow = length(feature_sets), ncol = length(all_features))
  colnames(mat) <- all_features
  for (i in seq_along(feature_sets)) {
    mat[i, colnames(mat) %in% feature_sets[[i]]] <- 1L
  }
  mat
}

jaccard_pairwise <- function(feature_sets) {
  n <- length(feature_sets)
  out <- matrix(NA_real_, n, n)
  for (i in seq_len(n)) {
    for (j in seq_len(n)) {
      inter <- length(intersect(feature_sets[[i]], feature_sets[[j]]))
      union <- length(union(feature_sets[[i]], feature_sets[[j]]))
      out[i, j] <- if (union == 0) NA_real_ else inter / union
    }
  }
  out
}

nogueira_stability_safe <- function(feature_sets, p) {
  # Preferred implementation: stabm package. The exact function signature may depend on package version.
  # Keep fold-level feature sets so stability can be recomputed transparently.
  if (!requireNamespace("stabm", quietly = TRUE)) {
    warning("Package stabm is not installed; returning NA for Nogueira stability.")
    return(NA_real_)
  }
  tryCatch({
    stabm::stabilityNogueira(feature_sets, p = p)
  }, error = function(e) {
    warning("stabm::stabilityNogueira failed; check package signature. Error: ", e$message)
    NA_real_
  })
}

feature_selection_frequency <- function(feature_sets) {
  sort(table(unlist(feature_sets)), decreasing = TRUE)
}
