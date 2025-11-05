# only works with the Java extension of yacc: 
# byacc/j from http://troi.lincom-asg.com/~rjamison/byacc/

JFLEX  = java -jar libs/JFlex.jar 
BYACCJ = libs/yacc.linux -tv -J
JAVAC  = javac

# targets:

all: Parser.class

run: Parser.class
	java Parser

build: clean Parser.class

clean:
	rm -f *~ *.class *.o *.s Yylex.java Parser.java y.output ParserVal.java

Parser.class: TS_entry.java TabSimb.java Yylex.java Parser.java
	$(JAVAC) Parser.java

Yylex.java: GeradorDeCodigo.flex
	$(JFLEX) GeradorDeCodigo.flex

Parser.java: GeradorDeCodigo.y
	$(BYACCJ) GeradorDeCodigo.y
