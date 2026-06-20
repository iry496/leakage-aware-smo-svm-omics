# Pipeline skeletons.
# These functions are intentionally conservative and should be completed after dataset audit.

source("R/preprocessing.R")
source("R/feature_selection.R")
source("R/model_smo_svm.R")
source("R/metrics.R")
source("R/leakage_checks.R")

run_leaky_baseline <- function(x, y, feature_method = "t_test", top_k = 100,
                               kernel = "linear", cost = 1, positive_class) {
  # WARNING: This pipeline is intentionally leaky for comparison.
  fs <- select_features(x, y, method = feature_method, top_k = top_k)
  x_selected <- as.matrix(x)[, fs$features, drop = FALSE]
  # TODO: add repeated CV using caret::createFolds or rsample.
  list(
    selected_features = fs$features,
    note = "Leaky baseline selected features globally before cross-validation. CV implementation pending."
  )
}

run_guarded_nested_pipeline <- function(x, y, outer_folds, inner_folds_fn,
                                        feature_methods = c("t_test"), top_k_grid = c(50, 100),
                                        cost_grid = c(0.25, 1, 4), kernel = "linear",
                                        positive_class) {
  # TODO: implement full nested pipeline after final dataset audit.
  # Required behavior:
  # - outer test fold never used for fitting scaler, feature selector, class balancing, or hyperparameters
  # - inner loop selects feature_method, top_k, and cost
  # - store predictions, features, and hyperparameters for every outer fold
  stop("Guarded nested pipeline skeleton not yet implemented. Complete after dataset audit.")
}
