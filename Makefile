# only works with the Java extension of yacc: 
# byacc/j from http://troi.lincom-asg.com/~rjamison/byacc/

JFLEX  = java -jar libs/JFlex.jar 
BYACCJ = libs/yacc.linux -tv -J
JAVAC  = javac

# targets:

all: Parser.class

run: Parser.class
	java -cp target Parser

build: clean Parser.class

clean:
	rm -f *~ *.o *.s Yylex.java Parser.java y.output ParserVal.java
	rm -rf target

Parser.class: TS_entry.java TabSimb.java Yylex.java Parser.java
	mkdir -p target
	$(JAVAC) -d target *.java

Yylex.java: GeradorDeCodigo.flex
	$(JFLEX) GeradorDeCodigo.flex

Parser.java: GeradorDeCodigo.y
	$(BYACCJ) GeradorDeCodigo.y
