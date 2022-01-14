---
title: "Git"
date: 2021-08-05T17:24:17+08:00
draft: false
---
### Download GIT
https://git-scm.com/downloads

### Initiate/Clone
- `git init`: initiate the current directory as a git repository
- `git clone https://github.com/SOMEONES/ACertainRepo.git`: copy the repository of other's to local

### Add
- `git remote add origin https://github.com/yourname/YourRepo.git`: create a remote named `origin` and establish the connection between local and the remote.

- `git add -A`: make every file to be tracked and stage all changes (i.e., make all of them ready to be committed)

- `git add --all`: Stage all changes; that is, make every modified files ready to be committed.
### Commit and push

- `git commit -m "whatever message is OK"`: stage all changes of tracked files and commit; untracked files won't be committed.


- `git push --set-upstream origin master`(the first time) or `git push` (therein after)
> Setting `master` as upstream means that from now on the target branch is set to be the `master`, and you can push and pull without specifying the target branch. 

> 💩 Explain furthermore:
> - ["origin" is a shorthand name for the remote repository that a project was originally cloned from.](https://www.git-tower.com/learn/git/glossary/origin/)

### Set and sync with the upstream
Develop *someone* else's project: 
- Go to the project of *someone*, for example, https://github.com/SOMEONES/SOMEONESREPO and fork it ([see how to fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo)).
- In git bash clone your fork to local, 
    - for example, `git clone https://github.com/YOURNAME/SOMEONESREPO.git` 
    - [more details about how to clone](https://docs.github.com/en/get-started/quickstart/fork-a-repo#cloning-your-forked-repository)
- `cd SOMEONESREPO` and set the upstream branch for synchronizing with that *someone* ([more details about how to set upstream](https://docs.github.com/en/get-started/quickstart/fork-a-repo#configuring-git-to-sync-your-fork-with-the-original-repository): `git remote add upstream https://github.com/SOMEONES/SOMEONESREPO.git` 
    > you may like to check the current remote repository and upstream by `git remote -v`.
- [Sync with the original (upstream)](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/syncing-a-fork#syncing-a-fork-from-the-command-line) by 
    - `git fetch upstream` or `git pull upstream master`
    - `git merge upstream/master` (merge the current local branch with `upstream`'s `master` branch)
- Pull request
    - I think it is more convenient to handle pull request directly on Github; see [Merging a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request)
    - [GitHub Pull Requests and Issues](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github) can be useful in review the differences.

![](https://raw.githubusercontent.com/NEONScience/NEON-Data-Skills/dev-aten/graphics/reproducible-science/git-fork-clone-flow.png)
> [Source of this figure](https://www.neonscience.org/resources/learning-hub/tutorials/git-setup-remote)


> **📖Explain**:
> - `fetch` retrieve the latest metadata info from remote; `pull` does that AND copy those changes from remote repository to local. 

### Handling file renames in Git
`git mv css/iphone.css css/mobile.css`
See [this](https://stackoverflow.com/questions/2641146/handling-file-renames-in-git).

### Other useful commands
[Cheat sheet](https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet)
- use `git log` to view the commit history
- use `git status` to see the current status (list the staged and unstaged files that have beem modified, added, or deleted.)