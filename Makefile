XSLTPROC=xsltproc

#TRGFORMAT=pdf

ifndef TRGFORMAT
  TRGFORMAT=pdf
endif

ifndef TRGLANG
  TRGLANG=en
endif

SRCFILES := $(wildcard *.xml)
TRGFILES := $(patsubst %.xml,%.$(TRGFORMAT),$(wildcard *.xml))

default						:	all

%.pre.xml					:
							$(XSLTPROC) -o step1.xml $*.preproc.xsl $*.$(TRGLANG).xml

%.fo						:	%.pre.xml
							$(XSLTPROC) -o step2.fo $*.fo.xsl step1.xml

%.$(TRGLANG).$(TRGFORMAT)	:	%.fo
							fop -fo step2.fo -$(TRGFORMAT) $(*).$(TRGLANG).$(TRGFORMAT)

all							:	$(TRGFILES)

clean						:
							rm -f step1.xml step2.fo *.pdf *.txt *.rtf *.png
