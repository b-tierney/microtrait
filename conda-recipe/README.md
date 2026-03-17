# Conda files for microtrait

This folder contains **two different Conda YAML files** for different tasks:

## 1) `meta.yaml` (Conda recipe)
Use this with `conda-build`/`mambabuild` to build an installable package.

```bash
conda mambabuild conda-recipe
# or
conda-build conda-recipe
```

> `meta.yaml` includes Jinja templating (`{% set version = ... %}`), so it is **not** a valid env spec for `mamba create -f`.

## 2) `environment.yml` (environment spec)
Use this to create a runnable environment for development or use of microtrait.

```bash
mamba env create -f conda-recipe/environment.yml
conda activate microtrait
```
