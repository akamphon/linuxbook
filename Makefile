THAI_SOURCES = \
	introduction.ltx	\
	basic.ltx	\
	file.ltx	\
	coreutils.ltx	\
	applications.ltx	\
	command.ltx	\
	etc.ltx	\
	debian.ltx	\
	$(NULL)

THAI_TEXS = $(THAI_SOURCES:.ltx=.tex)

all: linux.pdf

%.tex: %.ltx
	swath -u u,u -f latex < $< > $@

linux.pdf: linux.tex mymacro.tex ascii_table.tex $(THAI_TEXS)
	pdflatex linux
	makeindex -s book.ist -T general
	makeindex -s book.ist -T command
	makeindex -s nomencl.ist linux.glo -o linux.gls
	pdflatex linux

clean:
	rm -f *.aux *.glo *.idx *.lof *.log *.lot *.out *.thm *.toc
	rm -f $(THAI_TEXS)

index:
	makeindex -T -s book.ist general
	makeindex -T -s book.ist command

glossary:
	makeindex -T -s nomencl.ist linux.glo -o linux.gls
