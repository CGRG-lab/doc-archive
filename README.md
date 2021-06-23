# doc-archive

[![ci](https://github.com/CGRG-lab/doc-archive/actions/workflows/ci.yml/badge.svg)](https://github.com/CGRG-lab/doc-archive/actions/workflows/ci.yml)

The repository publishes the document archive to the Github Pages website, providing a quick start for new members of CGRG.

## Modify the website and view the changes locally

Clone the repository and change the current working directory to it. Use [pip](https://pypi.org/) or [poetry](https://python-poetry.org/) to install python dependencies, and then use the following command in the shell to serve the website locally.
```shell
mkdocs serve
```

Navigate to `localhost:8000` in a browser and you should see a preview of any modifications you make locally.

Modify `mkdocs.yml` and the files in `docs/` to make changes.

## References
- [mkdocs](https://www.mkdocs.org/)
- [mkdocs-material](https://squidfunk.github.io/mkdocs-material/)
- [Alinex Development Guide - mkdocs](https://alinex.gitlab.io/env/mkdocs/)
- [Open Water Foundation / Learn MkDocs](http://learn.openwaterfoundation.org/owf-learn-mkdocs/)