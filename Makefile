XSLTPROC=xsltproc
FOXSL=fo.xsl
PREPPROCXSL=preproc.xsl

#TRG=cv

default	:	all

gencv	:
			$(XSLTPROC) -o step1.xml $(TRG)_preproc.xsl $(TRG).xml

genfo	:	gencv
			$(XSLTPROC) -o step2.fo fo.xsl step1.xml

genpdf	:	genfo
			fop -fo step2.fo $(TRG).pdf

genall	:	genpdf

all		:	genall
			open $(TRG).pdf

clean	:
			rm -f step1.xml step2.fo *.pdf

test	:
			@echo %1
