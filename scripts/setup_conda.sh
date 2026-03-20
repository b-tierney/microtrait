#!/usr/bin/env bash
set -euo pipefail

if ! command -v R >/dev/null 2>&1; then
  echo "error: R is not on PATH. Activate the Conda environment first." >&2
  exit 1
fi

if ! command -v hmmsearch >/dev/null 2>&1; then
  echo "error: hmmsearch is not on PATH. Create/activate the Conda environment first." >&2
  exit 1
fi

if ! command -v prodigal >/dev/null 2>&1; then
  echo "error: prodigal is not on PATH. Create/activate the Conda environment first." >&2
  exit 1
fi

if ! command -v hmmpress >/dev/null 2>&1; then
  echo "error: hmmpress is not on PATH. Create/activate the Conda environment first." >&2
  exit 1
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

# Use remotes here on purpose: it is much lighter-weight than devtools for
# installing a local checkout and the GitHub-only gRodon dependency.
R --vanilla <<'RSCRIPT'
options(repos = c(CRAN = "https://cloud.r-project.org"))

if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

if (!requireNamespace("kmed", quietly = TRUE)) {
  install.packages("kmed")
}

if (!requireNamespace("gRodon", quietly = TRUE)) {
  remotes::install_github("jlw-ecoevo/gRodon", upgrade = "never")
}

remotes::install_local(".", upgrade = "never", dependencies = FALSE, force = TRUE)
microtrait::prep.hmmmodels()

library(microtrait)
genome_file <- system.file("extdata/genomic/2896171935.fna", package = "microtrait")
result <- microtrait::extract.traits(
  genome_file,
  out_dir = tempdir(),
  growthrate_predict = FALSE,
  optimalT_predict = FALSE
)
stopifnot(file.exists(result$rds_file))
cat("microtrait Conda setup completed successfully\n")
RSCRIPT
