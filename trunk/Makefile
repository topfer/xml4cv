XSLTPROC=xsltproc
FOP=/opt/bin/fop

ifndef TRGLANG
  TRGLANG=en
endif

SRCFILES := $(wildcard *.xml)
TRGFILES := $(patsubst %.xml,%.trg,$(wildcard *.xml))
#TRGFILES := cv.en.trg

default			:	all

cv.%.pre.xml	:
				$(XSLTPROC) -o tmp.step1.xml cv.preproc.xsl cv.$*.xml

cl.%.pre.xml	:
				$(XSLTPROC) -o tmp.step1.xml cl.preproc.xsl cl.$*.xml

cv.%.fo			:	cv.%.pre.xml
				$(XSLTPROC) -o tmp.step2.fo cv.fo.xsl tmp.step1.xml

cl.%.fo			:	cl.%.pre.xml
				$(XSLTPROC) -o tmp.step2.fo cl.fo.xsl tmp.step1.xml

%.trg			:	%.fo
				$(FOP) -fo tmp.step2.fo -pdf $*.pdf
				#$(FOP) -fo tmp.step2.fo -dpi 128 -png $*.png
				$(FOP) -fo tmp.step2.fo -rtf $*.rtf
				#$(FOP) -fo tmp.step2.fo -txt $*.txt

all				:	$(TRGFILES)

clean			:
				rm -f tmp.* *.pdf *.txt *.rtf *.png *~
				
