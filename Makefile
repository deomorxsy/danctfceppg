# all:
# 	latexmk -gg -bibtex-cond -pdf ppgec-abntex2-modelo.tex
# clean:
# 	@rm -f *.out *.aux *.alg *.brf *.acr *.dvi *.gls *.log *.bbl *.blg *.ntn *.not *.lof *.lot *.toc *.loa *.lsg *.nlo *.nls *.ilg *.ind *.ist *.glg *.glo *.xdy *.acn *.idx *.loq *.synctex.gz *~
#

# Default project directories
OUT_DIR=output
AUX_DIR=aux
SVG_DIR=svg-inkscape
STYLES_DIR=./assets/styles
# IN_DIR=markdown
IN_DIR=./
STYLE=riceamasters

# Testing directories
TEST_OUT_DIR=output
TEST_AUX_DIR=aux

all: pdf

clean: $(OUT_DIR) $(AUX_DIR) $(SVG_DIR)
	rm -rf $(AUX_DIR)/*
	rm -rf $(OUT_DIR)/*
	rm -rf $(SVG_DIR)/*


$(OUT_DIR):
	@echo "|> Creating directory: $(OUT_DIR)"
	mkdir -p $@

$(AUX_DIR):
	@echo "|> Creating directory: $(AUX_DIR)"
	mkdir -p $@

$(SVG_DIR):
	@echo "|> Creating directory: $(SVG_DIR)"
	mkdir -p $@

pdf: init
	set -x
	#xelatex -no-pdf -interaction=nostopmode -file-line-error -shell-escape -recorder -output-directory="aux"  "ppgec-abntex2-modelo.tex"
	xelatex -interaction=nostopmode -file-line-error -shell-escape -recorder -output-directory="aux"  "ppgec-abntex2-modelo.tex"

trace_pdf: init
	set -x
	strace -f xelatex -no-pdf -interaction=nostopmode -file-line-error -shell-escape -recorder -output-directory="aux"  "ppgec-abntex2-modelo.tex"

#"main.tex"

# pdf: init
# 	set -x
# 	for f in $(IN_DIR)/*.md; do \
# 		FILE_NAME=`basename $$f | sed 's/.md//g'`; \
# 		echo $$FILE_NAME.pdf; \
# 		pandoc --standalone --template $(STYLES_DIR)/$(STYLE).tex \
# 			--from markdown --to context \
# 			--variable papersize=A4 \
# 			--output $(OUT_DIR)/$$FILE_NAME.tex $$f > /dev/null; \
# 		mtxrunjit --path=$(OUT_DIR) --script context $$FILE_NAME.tex > $(OUT_DIR)/context_$$FILE_NAME.log 2>&1; \
# 	done

html: init
	for f in $(IN_DIR)/*.md; do \
		FILE_NAME=`basename $$f | sed 's/.md//g'`; \
		echo $$FILE_NAME.html; \
		pandoc --standalone --include-in-header $(STYLES_DIR)/$(STYLE).css \
			--lua-filter=pdc-links-target-blank.lua \
			--from tex --to html \
			--output $(OUT_DIR)/$$FILE_NAME.html $$f \
			--metadata pagetitle=$$FILE_NAME;\
	done

init: dir version

# create ./output, ./aux, ./svg directories
dir:
	mkdir -p $(OUT_DIR)
	mkdir -p $(AUX_DIR)
	mkdir -p $(SVG_DIR)


version:
	PANDOC_VERSION=`pandoc --version | head -1 | cut -d' ' -f2 | cut -d'.' -f1`; \
	if [ "$$PANDOC_VERSION" -eq "2" ]; then \
		SMART=-smart; \
	else \
		SMART=--smart; \
	fi \



