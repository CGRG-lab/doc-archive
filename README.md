# doc-archive

[![github pages](https://github.com/CGRG-lab/doc-archive/actions/workflows/gh-pages.yml/badge.svg)](https://github.com/CGRG-lab/doc-archive/actions/workflows/gh-pages.yml)

The repository publishes the document archive to the Github Pages website, providing a quick start for new members of CGRG.

## Modify the website and view the changes locally
### Repository has not been downloaded
1. Install git from the [official website](https://git-scm.com/).
1. Open a terminal (Git Bash, Windows PowerShell, Command Prompt, etc.) and change the current working directory to your desired directory.
    ```shell
    cd replace-your-desired-dir-here
    ```
    For example
    ```shell
    cd D:\dir-where-doc-archive-is-stored
    ```
    > If you are using the Command Prompt in Windows, you may need to change to a different drive with `cd /d replace-your-desired-dir-here`.
1. Clone the repository with the following command.
    ```shell
    git clone --recursive https://github.com/CGRG-lab/doc-archive.git
    ```
1. Go to [Repository downloaded](#repository-downloaded) section and follow the instructions.

### Repository downloaded
1. Open a terminal (Git Bash, Windows PowerShell, Command Prompt, etc.) and change the current working directory to `doc-archive` directory.
1. Use `git pull` to update the remote repository version to the local.
1. Open `File Explorer` and browse the `doc-archive` folder. Then double-click `serve_locally.bat` to serve the hugo locally. 
1. After a successful serve, you will see the `cmd.exe` window display
    ```
    ... lots of messages ...
    Web Server is available at http://localhost:1313/doc-archive/ (bind address 127.0.0.1)
    Press Ctrl+C to stop
    ```
    You can use a web browser to link to  http://localhost:1313/doc-archive/.
1. Edit files in `doc-archive/content`. Changes to the file will also change the local web page you are serving.
1. Press **Ctrl+C** in the `cmd.exe` window to terminate the server.

## Contribute your changes to the remote repository on github
1. Open a terminal (Git Bash, Windows PowerShell, Command Prompt, etc.) and change the current working directory to `doc-archive` directory.
1. Use `git pull` to update the remote repository version to the local.
1. Use `git add .` to add all changed file contents to the index.
1. Use `git commit -m "your commit message"` to commit changes. For example, `git commit -m "Update config.toml"`
1. Use `git push` to update remote repository on github.

## References
- [Hugo](https://gohugo.io/)
- [Docsy](https://www.docsy.dev/)
