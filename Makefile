makefile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
makefile_dir := $(dir $(makefile_path))

install_prefix := "/usr/local"
install_script_dir := "$(install_prefix)/bin/"
install_man_dir := "$(install_prefix)/share/man/man1"


# Installs the git command. Requires superuser privileges.
install:
	cp ./src/git-ignore.sh $(install_script_dir)/git-ignore
	mkdir -p $(install_man_dir)
	cp ./man/git-ignore.1 $(install_man_dir)


# Installs by symlinking the development file in this repo instead of copying.
# This means the development copy will be used system-wide, making dev/debug
# easier. Requires superuser privileges.
dev-install:
	ln -s $(makefile_dir)/src/git-ignore.sh $(install_script_dir)/git-ignore
	mkdir -p $(install_man_dir)
	ln -s $(makefile_dir)/man/git-ignore.1 $(install_man_dir)/git-ignore.1


# Uninstall the git command (undoes both install and dev-install targets).
# Requires superuser privileges.
uninstall:
	rm $(install_script_dir)/git-ignore
	rm $(install_man_dir)/git-ignore.1
