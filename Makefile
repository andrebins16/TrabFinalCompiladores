JFLEX  = java -jar libs/JFlex.jar 
BYACCJ = libs/yacc.linux -tv -J
JAVAC  = javac

SRC_DIR = src
GEN_DIR = $(SRC_DIR)/gen
OUT_DIR = target


all: Parser.class

run: Parser.class
	java -cp $(OUT_DIR) Parser

build: clean Parser.class

clean:
	rm -f *~ *.o *.s y.output
	rm -rf $(OUT_DIR)
	rm -rf $(GEN_DIR)

# compila
Parser.class: $(SRC_DIR)/TS_entry.java $(SRC_DIR)/TabSimb.java $(GEN_DIR)/Yylex.java $(GEN_DIR)/Parser.java
	mkdir -p $(OUT_DIR)
	$(JAVAC) -d $(OUT_DIR) $(SRC_DIR)/*.java $(GEN_DIR)/*.java

# gera yylex
$(GEN_DIR)/Yylex.java: $(SRC_DIR)/GeradorDeCodigo.flex
	mkdir -p $(GEN_DIR)
	cd $(SRC_DIR) && java -jar ../libs/JFlex.jar -d gen GeradorDeCodigo.flex

# gera parser
$(GEN_DIR)/Parser.java: $(SRC_DIR)/GeradorDeCodigo.y
	mkdir -p $(GEN_DIR)
	cd $(GEN_DIR) && ../../$(BYACCJ) ../../$(SRC_DIR)/GeradorDeCodigo.y
