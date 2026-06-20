# Global configuration for leakage-aware SMO/SVM omics audit

PROJECT_ROOT <- normalizePath(file.path(dirname(sys.frame(1)$ofile %||% "."), ".."), mustWork = FALSE)
SEED <- 20260620
set.seed(SEED)

# Primary candidate datasets. Final roles must be locked after metadata audit.
DATASETS <- list(
  discovery_candidate = c("GSE25055", "GSE25065"),
  external_candidate = c("GSE25065", "GSE20194"),
  sensitivity_candidate = c("GSE41998", "GSE20271")
)

# Feature-selection sizes to test.
TOP_K_GRID <- c(25, 50, 100, 250)

# SMO/SVM hyperparameter grid.
SVM_C_GRID <- 2 ^ c(-5, -3, -1, 0, 1, 2, 3, 4)
SVM_GAMMA_GRID <- 2 ^ c(-15, -11, -7, -3, 1, 3)

`%||%` <- function(x, y) if (is.null(x)) y else x
