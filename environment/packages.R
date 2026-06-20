# Suggested R packages for the leakage-aware SMO/SVM omics audit.
# Install only after confirming local R/Bioconductor setup.

cran_packages <- c(
  "tidyverse",
  "data.table",
  "caret",
  "e1071",
  "kernlab",
  "pROC",
  "PRROC",
  "yardstick",
  "FSelectorRcpp",
  "stabm",
  "rmarkdown",
  "quarto"
)

bioc_packages <- c(
  "GEOquery",
  "Biobase",
  "limma",
  "affy",
  "oligo",
  "annotate"
)

install_if_missing <- function(pkgs) {
  for (pkg in pkgs) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      install.packages(pkg)
    }
  }
}

# install_if_missing(cran_packages)
# if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# BiocManager::install(bioc_packages)
