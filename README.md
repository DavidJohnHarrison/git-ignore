# git-ignore
`git` command to download and apply .gitignore templates from
[https://gitignore.io](https://gitignore.io).


## Installation
To install `git-ignore`, run:

    sudo make install

If you want to install in development mode, run:

    sudo make dev-install

This will symlink the files instead of copying them,
allowing you to work in your local repository and have changes reflected system-wide
without having to reinstall.


## Uninstallation
To uninstall `git-ignore`, run:

    sudo make uninstall


## Usage
Basic usage is `git ignore <template>`. So for example, to ignore all C, C++, and macOS files:

    git ignore c c++ macos

This will create a `.gitignore` file in the current directory with the specified template(s)
(or append to it if one exists).

For a full list of options, run:

    git help ignore


## Justification
[https://gitignore.io](https://gitignore.io) already provides some shell commands to alias
in order to download and apply `.gitignore` templates.
The purpose of this tool is to expand upon this,
offering convenience such as validation
(i.e. checking the requested template exists)
and fitting into the `git` workflow in a more standard way.
