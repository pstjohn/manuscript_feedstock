# Manuscript markdown source
MARKDOWN=manuscript.markdown

# Supporting files
FIGURES_SVG=$(wildcard figs/*.svg)
BIBFILE=bibliography.bib
CSLFILE=$(wildcard *.csl) # Only if a CSL is being used

# Intermediate build targets
FIGURES_PDF=$(FIGURES_SVG:.svg=.pdf)
FIGURES_PNG=$(FIGURES_SVG:.svg=.png)

# Docker commands
DOCKER_CMD=docker run -v `pwd`:/source
DOCKER_IMG=pstjohn/pandoc
PANDOC=pandoc -F pandoc-crossref -F pandoc-citeproc
INKSCAPE=inkscape

# Build targets
all: output/document_ms.pdf output/document_ms.docx output/document_ms.html
pdf: output/document_ms.pdf
docx: output/document_ms.docx
html: output/document_ms.html


clean:
	rm figs/*.pdf figs/*.png

# Build figures
figs/%.pdf: figs/%.svg
	$(DOCKER_CMD) $(DOCKER_IMG) $(INKSCAPE) -f $< --export-pdf=$@

figs/%.png: figs/%.svg
	$(DOCKER_CMD) $(DOCKER_IMG) $(INKSCAPE) -f $< --export-png=$@ --export-dpi=200

# Build manuscript files
output/document_ms.docx: $(MARKDOWN) $(BIBFILE) $(FIGURES_PNG) $(CSLFILE)
	$(DOCKER_CMD) $(DOCKER_IMG) $(PANDOC) --default-image-extension=png $(MARKDOWN) -o $@

output/document_ms.pdf: $(MARKDOWN) $(BIBFILE) $(FIGURES_PDF) latex_style.sty $(CSLFILE)
	$(DOCKER_CMD) $(DOCKER_IMG) $(PANDOC) --default-image-extension=pdf -H latex_style.sty -V subparagraph $(MARKDOWN) -o $@

output/document_ms.html: $(MARKDOWN) $(BIBFILE) $(FIGURES_PDF) latex_style.sty $(CSLFILE)
	$(DOCKER_CMD) $(DOCKER_IMG) $(PANDOC) --default-image-extension=svg --self-contained -c html_style.css $(MARKDOWN) -o $@
