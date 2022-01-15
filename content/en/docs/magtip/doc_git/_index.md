---
author: "Tsung-Hsi, Wu"
title: "Setting up MagTIP"
date: "2022-01-15"
linkTitle: "Setting up MagTIP"
weight: 30
---

{{% alert title="Notice" color="warning" %}}
- [MagTIP-2022](https://github.com/okatsn/MagTIP-2022) and its dependent [toolbox](https://github.com/okatsn/toolbox) are hosted on Github; in which, [MagTIP-2022](https://github.com/okatsn/MagTIP-2022) is private.
- To use MagTIP, you need to have a Github account and get authorized in order to access the repository. 
{{% /alert %}}

{{% alert title="Hint" color="info" %}}
- Have [Git](https://git-scm.com/downloads) installed before you can use the command in the following sections.
{{% /alert %}}


## I'm a user of MagTIP
Right click on the links to download the batch files below and:
- Double click on the file [clone_MagTIP_and_toolbox.bat](./clone_MagTIP_and_toolbox.bat) to clone and set upstream for MagTIP and its dependent toolbox (do this only once).
- Double click on [force_update.bat](./force_update.bat) to make the local up-to-date with the latest MagTIP (⚠️**any changes on the source code will be lost**).


## I'm a developer of MagTIP
- MagTIP-2022 depends on [okatsn's toolbox](https://github.com/okatsn/toolbox); therefore, in git bash (or command window), `git clone https://github.com/okatsn/toolbox.git` first (the target directory can be arbitrary chosen).
- Go to https://github.com/okatsn/MagTIP-2022/ and fork it ([see how to fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo)).
- In git bash (or command window) clone your fork to local, 
    - for example, `git clone https://github.com/YOURNAME/MagTIP-2022/` 
    - [more details about how to clone](https://docs.github.com/en/get-started/quickstart/fork-a-repo#cloning-your-forked-repository)
- `cd MagTIP-2022` and set up for synchronization ([see here for how to set upstream](https://docs.github.com/en/get-started/quickstart/fork-a-repo#configuring-git-to-sync-your-fork-with-the-original-repository): `git remote add upstream https://github.com/okatsn/MagTIP-2022.git` 
- Create a pull request to request for merging your work with the main.
- For more about how to use git, see [here]({{< ref "docs/learning-resources/git/_index.md" >}}).
