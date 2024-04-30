# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
BUILDDIR      = _build

venv:
	python3 -m venv venv
	./venv/bin/pip install -r requirements.txt

# Put it first so that "make" without argument is like "make help".
help:
	@if [ -f venv/bin/activate ]; then . venv/bin/activate; fi; \
		$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@if [ -f venv/bin/activate ]; then . venv/bin/activate; fi; \
		$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

github:
	@make html
	@cp -a _build/html/. docs
