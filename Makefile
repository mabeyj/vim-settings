VIMINIT=~/.vim/init.vim
VIMRC=~/.vimrc
PATHOGEN=.vim/autoload/pathogen.vim

.PHONY: install
install: submodules $(PATHOGEN) $(VIMINIT) $(VIMRC)

.PHONY: submodules
submodules:
	git submodule update --init

.PHONY: update-submodules
update-submodules:
	git submodule update --recursive --remote

$(PATHOGEN): submodules/pathogen/autoload/pathogen.vim
	mkdir -p $$(dirname $@)
	cp $^ $@

$(VIMINIT): Makefile
	mkdir -p $$(dirname $(VIMINIT))
	echo "source $(VIMRC)" > $(VIMINIT)

$(VIMRC): Makefile
	echo "let &runtimepath = printf(\"$(PWD)/.vim,%s,$(PWD)/.vim/after\", &runtimepath)" > $(VIMRC)
	echo "source $(PWD)/.vimrc" >> $(VIMRC)
