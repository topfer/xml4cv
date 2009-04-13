XSLTPROC=xsltproc

ifndef TRGLANG
  TRGLANG=en
endif

SRCFILES := $(wildcard *.xml)
TRGFILES := $(patsubst %.xml,%.trg,$(wildcard *.xml))

default				:	all

%.pre.xml			:
					$(XSLTPROC) -o step1.xml $*.preproc.xsl $*.$(TRGLANG).xml

%.fo				:	%.pre.xml
					$(XSLTPROC) -o step2.fo $*.fo.xsl step1.xml

%.$(TRGLANG).trg	:	%.fo
					fop -fo step2.fo -pdf $*.$(TRGLANG).pdf
					fop -fo step2.fo -dpi 128 -png $(*).$(TRGLANG).png
					fop -fo step2.fo -rtf $*.$(TRGLANG).rtf

all					:	$(TRGFILES)

clean				:
					rm -f step1.xml step2.fo *.pdf *.txt *.rtf *.png
