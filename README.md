# doc-archive
TODO: migrate to hugo/docsy

[![Open in Visual Studio Code](https://open.vscode.dev/badges/open-in-vscode.svg)](https://open.vscode.dev/CGRG-lab/doc-archive)
[![ci](https://github.com/CGRG-lab/doc-archive/actions/workflows/gh-pages.yml/badge.svg)](https://github.com/CGRG-lab/doc-archive/actions/workflows/gh-pages.yml)

The repository publishes the document archive to the Github Pages website, providing a quick start for new members of CGRG.

## Modify the website and view the changes locally
### First use
1. Install git from the [official website](https://git-scm.com/).
2. Install python through [anaconda](https://www.anaconda.com/products/individual).
3. If your operating system is Windows, please open "Anaconda Powershell Prompt" (if your operating system is Linux, please open "terminal") and use `cd` command to change the current working directory to the directory you want.
   - For example, if you prefer to manage all your projects in the `D:\project\` directory, then you can use `cd D:\project\` in "Anaconda Powershell Prompt" to change the current working directory to `D:\project\`.
4. In "Anaconda Powershell Prompt", use the following command to clone the repository on github.
   ```shell
   git clone https://github.com/CGRG-lab/doc-archive.git
   ```
5. In "Anaconda Powershell Prompt", use the following command to change the current working directory to the `doc-archive` directory.
   ```shell
   cd doc-archive
   ```
6. In "Anaconda Powershell Prompt", use the following command to create the python environment of `doc-archive`.
    ```shell
    conda env update --prune --file environment.yml
    ```
7. In "Anaconda Powershell Prompt", use the following command to activate `doc-archive` environment.
    ```shell
    conda activate doc-archive
    ```
8. In "Anaconda Powershell Prompt", use the following command to serve the website locally.
    ```shell
    mkdocs serve
    ```
9. Navigate to `localhost:8000` in a browser and you should see a preview of any modifications you make locally.

10. Modify `mkdocs.yml` and the files in `docs/` to make changes.

> ℹ️ If you don't know how to set the options during the installation phase, you can leave them as default.
### Python environment has been established
1. If your operating system is Windows, please open "Anaconda Powershell Prompt" (if your operating system is Linux, please open "terminal") and use `cd` command to change the current working directory to the `doc-archive` directory.
    - For example, if your `doc-archive` directory is in the path `D:\project\doc-archive`, then you can use `cd D:\project\doc-archive` in "Anaconda Powershell Prompt" to change the current working directory.
2. Use `git pull` to update the remote repository version to the local.
3.  (🏷️optional) If you want to update the python environment of `doc-archive`, use the following command in "Anaconda Powershell Prompt".
    ```shell
    conda env update --prune --file environment.yml
    ```
4. In "Anaconda Powershell Prompt", use the following command to activate `doc-archive` environment.
    ```shell
    conda activate doc-archive
    ```
5. In "Anaconda Powershell Prompt", use the following command to serve the website locally.
    ```shell
    mkdocs serve
    ```
6. Navigate to `localhost:8000` in a browser and you should see a preview of any modifications you make locally.

7.  Modify `mkdocs.yml` and the files in `docs/` to make changes.


## Contribute your changes to the remote repository on github
1. If your operating system is Windows, please open "Anaconda Powershell Prompt" (if your operating system is Linux, please open "terminal") and use `cd` command to change the current working directory to the `doc-archive` directory.
    - For example, if your `doc-archive` directory is in the path `D:\project\doc-archive`, then you can use `cd D:\project\doc-archive` in "Anaconda Powershell Prompt" to change the current working directory.
2. Use `git pull` to update the remote repository version to the local.
3. Use `git add .` to add all changed file contents to the index.
4. Use `git commit -m "your commit message"` to commit changes. For example, `git commit -m "Update mkdocs.yml"`
5. Use `git push` to update remote repository on github.

## References
- [mkdocs](https://www.mkdocs.org/)
- [mkdocs-material](https://squidfunk.github.io/mkdocs-material/)
- [Alinex Development Guide - mkdocs](https://alinex.gitlab.io/env/mkdocs/)
- [Open Water Foundation / Learn MkDocs](http://learn.openwaterfoundation.org/owf-learn-mkdocs/)