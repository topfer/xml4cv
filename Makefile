XSLTPROC=xsltproc
FOXSL=fo.xsl
PREPPROCXSL=preproc.xsl

#TRGFORMAT=pdf
#TRG=cv

ifndef TRG
  TRG=cv
endif

ifndef TRGFORMAT
  TRGFORMAT=pdf
endif

default	:	all

gencv	:
			$(XSLTPROC) -o step1.xml $(TRG)_preproc.xsl $(TRG).xml

genfo	:	gencv
			$(XSLTPROC) -o step2.fo $(TRG)_fo.xsl step1.xml

gentrg	:	genfo
			fop -fo step2.fo -$(TRGFORMAT) $(TRG).$(TRGFORMAT)

genall	:	gentrg

all		:	genall
			open $(TRG).$(TRGFORMAT)

clean	:
			rm -f step1.xml step2.fo *.pdf *.txt *.rtf *.png
