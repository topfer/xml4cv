XSLTPROC=xsltproc
FOXSL=fo.xsl
PREPPROCXSL=preproc.xsl

default	:	all

gencv	:
			$(XSLTPROC) -o step1.xml preproc.xsl cv.xml

genfo	:	gencv
			$(XSLTPROC) -o step2.fo fo.xsl step1.xml

genpdf	:	genfo
			fop -fo step2.fo cv.pdf

genall	:	genpdf

all		:	genall
			open cv.pdf

clean	:
			rm -f step1.xml step2.fo cv.pdf