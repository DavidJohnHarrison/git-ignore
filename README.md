# git-ignore
`git` command to download and apply `.gitignore` templates from
[gitignore.io](https://gitignore.io).


## Installation
To install `git-ignore`, run:

    sudo make install

If you want to install in development mode, run:

    sudo make dev-install

This will symlink the files instead of copying them,
allowing you to work in your local repository and have changes reflected system-wide without
having to reinstall.


## Uninstallation
To uninstall `git-ignore`, run:

    sudo make uninstall


## Usage
Basic usage is `git ignore <template>`. So for example, to ignore all C, C++, and macOS files:

    git ignore c c++ macos

This will create a `.gitignore` file in the current directory with the specified template(s),
or append to it if one already exists.

For a full list of options, run:

    git help ignore


## Justification
[https://docs.gitignore.io/install/command-line](https://docs.gitignore.io/install/command-line)
already provides some shell commands to alias in order to download `.gitignore` templates.
The purpose of this tool is to expand upon this,
offering conveniences such as validation (i.e. checking the requested template exists),
autocomplete,
and a more standard `git` workflow.


## Acknowledgements
Special thanks to [Toptal](https://toptal.com) for creating [gitignore.io](https://gitignore.io),
as well as to those who have contributed templates.

## References
- [gitignore.io](https://gitignore.io) source code:
[https://github.com/toptal/gitignore.io](https://github.com/toptal/gitignore.io)

- `.gitignore` template repository:
[https://github.com/toptal/gitignore](https://github.com/toptal/gitignore)
