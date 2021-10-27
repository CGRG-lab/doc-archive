---
title: "Git"
linkTitle: "Git"
weight: 5
---

- Use `.gitignore` to exclude files from git tracking
    - for example, in a new line of the `.gitignore` file, 
        - add `*.png` to exclude all files suffixed by `.png`
        - add `temp/` to exclude all files under the folder named `temp` that is exactly under the same directory as the `.gitignore`
        - add `**/temp/` to exclude all files and folders in any folder named `temp`
        - add `**/data/*.mat` to exclude any `.mat` files in all folders named `data` (`.mat` files under the subfolders of `data` will NOT be excluded)
        - add `**/data/**/*.mat` to exclude any `.mat` files under all folders named `data` (`.mat` files under the subfolders of `data` will also be excluded)
- Develop on a branch other than `master` or `main`
- Don't commit many unrelated changes at once, split them into multiple commits so that the changes in each commit are related. In this way, the commit message can more accurately describe the change.