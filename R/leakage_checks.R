# Leakage-control checks.
# These are lightweight checks and reminders; they do not replace code review.

assert_no_overlap <- function(train_ids, test_ids) {
  overlap <- intersect(train_ids, test_ids)
  if (length(overlap) > 0) {
    stop("Train/test sample overlap detected: ", paste(overlap, collapse = ", "))
  }
  TRUE
}

assert_features_available <- function(selected_features, x) {
  missing <- setdiff(selected_features, colnames(x))
  if (length(missing) > 0) {
    stop("Selected features missing in data matrix: ", paste(missing, collapse = ", "))
  }
  TRUE
}

log_pipeline_step <- function(step, fold_id = NA, notes = "") {
  message(sprintf("[%s] fold=%s %s", step, fold_id, notes))
}
