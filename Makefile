# Compilador e ferramentas
JFLEX  = java -jar libs/JFlex.jar 
BYACCJ = libs/yacc.linux -tv -J
JAVAC  = javac

# Diretórios
SRC_DIR = src
OUT_DIR = target

# Alvos principais
all: Parser.class

run: Parser.class
	java -cp $(OUT_DIR) Parser

build: clean Parser.class

clean:
	rm -f *~ *.o *.s y.output
	rm -f $(SRC_DIR)/Yylex.java $(SRC_DIR)/Parser.java $(SRC_DIR)/ParserVal.java $(SRC_DIR)/y.output
	rm -rf $(OUT_DIR)

# Compilação
Parser.class: $(SRC_DIR)/TS_entry.java $(SRC_DIR)/TabSimb.java $(SRC_DIR)/Yylex.java $(SRC_DIR)/Parser.java
	mkdir -p $(OUT_DIR)
	$(JAVAC) -d $(OUT_DIR) $(SRC_DIR)/*.java

# Geração do lexer
$(SRC_DIR)/Yylex.java: $(SRC_DIR)/GeradorDeCodigo.flex
	# Força geração dentro de src/
	cd $(SRC_DIR) && java -jar ../libs/JFlex.jar GeradorDeCodigo.flex


# Geração do parser
$(SRC_DIR)/Parser.java: $(SRC_DIR)/GeradorDeCodigo.y
	$(BYACCJ) $(SRC_DIR)/GeradorDeCodigo.y
	@if [ -f Parser.java ]; then mv Parser.java $(SRC_DIR)/Parser.java; fi
	@if [ -f ParserVal.java ]; then mv ParserVal.java $(SRC_DIR)/ParserVal.java; fi
	@if [ -f y.output ]; then mv y.output $(SRC_DIR)/y.output; fi
