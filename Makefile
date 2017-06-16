VIMRC=~/.vimrc
PATHOGEN=.vim/autoload/pathogen.vim
TARGETS=$(PATHOGEN)

.PHONY: install
install: submodules $(TARGETS)
	echo "let &runtimepath = printf(\"$(PWD)/.vim,%s\", &runtimepath)" > $(VIMRC)
	echo "source $(PWD)/.vimrc" >> $(VIMRC)

.PHONY: submodules
submodules:
	git submodule update --init

.PHONY: update-submodules
update-submodules:
	git submodule update --recursive --remote

$(PATHOGEN): submodules/pathogen/autoload/pathogen.vim

$(TARGETS):
	mkdir --parents $$(dirname $@)
	cp $^ $@
