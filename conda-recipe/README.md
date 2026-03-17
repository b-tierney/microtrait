# Conda files for microtrait

This folder contains two different Conda YAML files for different tasks.

## 1) `meta.yaml` (Conda recipe)
Use this with `conda-build`/`mambabuild` to build an installable package.

```bash
conda mambabuild conda-recipe
# or
conda-build conda-recipe
```

> `meta.yaml` uses Jinja templating (`{% set version = ... %}`), so it is not a valid input for `mamba create -f`.

## 2) `environment.yml` (environment spec)
Use this to create a runnable environment.

```bash
mamba env create -f conda-recipe/environment.yml
conda activate microtrait
```

This env file intentionally avoids the `defaults` channel and only uses `conda-forge` + `bioconda`.

### Packages not currently available as Conda artifacts
`gRodon` and `kmed` are imported by microtrait but are not currently resolvable as Conda packages (`r-grodon`/`r-kmed`) in typical channels.

Install them inside the created environment with R:

```bash
R -q -e "install.packages('kmed', repos='https://cloud.r-project.org')"
R -q -e "if (!requireNamespace('remotes', quietly = TRUE)) install.packages('remotes', repos='https://cloud.r-project.org'); remotes::install_github('jlw-ecoevo/gRodon')"
```
