# Feature-selection helpers.
# Rule: call these functions only on training data inside the appropriate fold.

select_ttest <- function(x_train, y_train, top_k = 100) {
  x_train <- as.matrix(x_train)
  y_train <- as.factor(y_train)
  if (nlevels(y_train) != 2) stop("select_ttest currently requires a binary outcome.")
  scores <- apply(x_train, 2, function(z) {
    out <- try(stats::t.test(z ~ y_train)$statistic, silent = TRUE)
    if (inherits(out, "try-error") || !is.finite(out)) return(0)
    abs(as.numeric(out))
  })
  selected <- names(sort(scores, decreasing = TRUE))[seq_len(min(top_k, length(scores)))]
  list(features = selected, scores = scores[selected], method = "t_test")
}

select_information_gain <- function(x_train, y_train, top_k = 100) {
  if (!requireNamespace("FSelectorRcpp", quietly = TRUE)) {
    stop("Package FSelectorRcpp is required for information gain feature selection.")
  }
  df <- as.data.frame(x_train)
  df$.outcome <- as.factor(y_train)
  scores <- FSelectorRcpp::information_gain(.outcome ~ ., df)
  scores <- scores[order(scores$importance, decreasing = TRUE), , drop = FALSE]
  selected <- head(scores$attributes, top_k)
  list(features = selected, scores = scores, method = "information_gain")
}

select_features <- function(x_train, y_train, method = c("t_test", "information_gain"), top_k = 100) {
  method <- match.arg(method)
  if (method == "t_test") return(select_ttest(x_train, y_train, top_k = top_k))
  if (method == "information_gain") return(select_information_gain(x_train, y_train, top_k = top_k))
}

# Placeholder for SVM-RFE. Implement after deciding package and computational budget.
select_svm_rfe <- function(x_train, y_train, top_k = 100) {
  stop("SVM-RFE is planned but not yet implemented in this scaffold.")
}
