XSLTPROC=xsltproc

#TRGFORMAT=pdf
#TRG=cv

ifndef TRGFORMAT
  TRGFORMAT=pdf
endif

SRCFILES := $(wildcard *.xml)
TRGFILES := $(patsubst %.xml,%.pdf,$(wildcard *.xml))

default		:	all

%.pre.xml	:
			$(XSLTPROC) -o step1.xml $*.preproc.xsl $*.xml

%.fo		:	%.pre.xml
			$(XSLTPROC) -o step2.fo $*.fo.xsl step1.xml

%.pdf		:	%.fo
			fop -fo step2.fo -$(TRGFORMAT) $(*).$(TRGFORMAT)

all			:	$(TRGFILES)

clean		:
			rm -f step1.xml step2.fo *.pdf *.txt *.rtf *.png
