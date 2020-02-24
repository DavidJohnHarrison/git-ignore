makefile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
makefile_dir := $(dir $(makefile_path))

install_dir := "/usr/local/bin/"


# Installs the git command. Requires superuser privileges.
install:
	cp ./src/git-ignore.sh $(install_dir)/git-ignore


# Installs by symlinking the development file in this repo instead of copying.
# This means the development copy will be used system-wide, making dev/debug
# easier. Requires superuser privileges.
dev-install:
	ln -s $(makefile_dir)/src/git-ignore.sh $(install_dir)/git-ignore


# Uninstall the git command (undoes both install and dev-install targets).
# Requires superuser privileges.
uninstall:
	rm $(install_dir)/git-ignore
