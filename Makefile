# data/pages/YPP1
# data/media/YPP1

scm2txt : FORCE ; ./$@

YPP1 = $(addsuffix .scm,$(addprefix konzultace,4 4a 4b 5))
YPP1+= redblack_test.scm
YPP1+= ypp1du.pdf

YPP1 : $(YPP1)
$(YPP1) :
	wget http://phoenix.inf.upol.cz/~konecnja/vyuka/YPP1files/$@

ex1.pdf ex2.pdf ex3.pdf \
pp1-pisemka1.pdf \
pp1_pisemka2.pdf :
	wget http://phoenix.inf.upol.cz/~konecnja/vyuka/PP1files/$@

konzultace%.txt : ; cp $(basename $@).scm $@

FORCE : ;
