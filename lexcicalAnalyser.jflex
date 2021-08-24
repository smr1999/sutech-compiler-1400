import java_cup.runtime.*;
import java.util.Vector;

%%

%class Lexical

%line
%column

%cup

%state MULTI_COMMENT
%state SINGLE_COMMENT

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }

    public void error_lex(){
        System.err.println(yytext() + " : " + "Invalid syntax .");
        System.exit(0);
    }

    public void print_sym(String name){
        System.out.println(name);
    }

    public void print_sym(String name , String value){
        System.out.println(name + " : " + value);
    }
    
    int counter = 0;
    public Vector<Token> allTokens;

    public void setTable(Vector<Token> allTokens){
        this.allTokens = allTokens;
    }

    public int findToken(String name,Vector<Token> allTokens){
        for(Token t : allTokens){
            if(t.Name.equals(name)){
                return t.ID;
            }
        }
        return 0;
    }

%}

ALPHA=[A-Za-z_]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
NEWLINE=\r|\n|\r\n
WHITE_SPACE_CHAR=[\n\r\ \t\b\012]
STRING_TEXT=(\\\"|[^\n\r\"\\]|\\{WHITE_SPACE_CHAR}+\\)*
Ident = {ALPHA}({ALPHA}|{DIGIT}|_)*
STRING_TYPE = "\""{STRING_TEXT}"\""
DOUBLE_TYPE = {DIGIT}+"."{DIGIT}*
INTEGER_TYPE = {DIGIT}+
BOOLEAN_TYPE = "true"|"false"
CHAR_TYPE = "\'"{ALPHA}"\'"

%%

<YYINITIAL>{
    "/*" {yybegin(MULTI_COMMENT);} //
    "//" {yybegin(SINGLE_COMMENT);} //

    "void" { print_sym("void") ; return symbol(sym.VOID); } //

    "main" { print_sym("MAIN") ; return symbol(sym.MAIN); } //

    "int" { print_sym("INT") ; return symbol(sym.INT,yytext()); } //

    "String" { print_sym("STRING") ; return symbol(sym.STRING,yytext()); } //

    "char" { print_sym("CHAR") ; return symbol(sym.CHAR,yytext()); } //

    "boolean" { print_sym("BOOLEAN") ; return symbol(sym.BOOLEAN,yytext()); } //

    "double" { print_sym("DOUBLE") ; return symbol(sym.DOUBLE,yytext()); } //

    "float" { print_sym("FLOAT") ; return symbol(sym.FLOAT,yytext()); } //

    "if" { print_sym("IF") ; return symbol(sym.IF); } //

    "else" { print_sym("ELSE") ; return symbol(sym.ELSE); } //

    "break" { print_sym("BREAK") ; return symbol(sym.BREAK); }

    "for" { print_sym("FOR") ; return symbol(sym.FOR); }

    "while" { print_sym("WHILE") ; return symbol(sym.WHILE); } //

    "continue" { print_sym("CONTINUE") ; return symbol(sym.CONTINUE); } //

    "return" { print_sym("RETURN") ; return symbol(sym.RETURN); } //

    "==" { print_sym("EQUAL") ; return symbol(sym.EQUAL); } //

    "!=" { print_sym("NOTEQUAL") ; return symbol(sym.NOTEQUAL); } //

    "&&" { print_sym("AND") ; return symbol(sym.AND); } //

    "||" { print_sym("OR") ; return symbol(sym.OR); } //

    "<=" { print_sym("LESSEQUAL") ; return symbol(sym.LESSEQUAL); } //

    ">=" { print_sym("GREATEREQUAL") ; return symbol(sym.QREATEREQUAL); } //

    "++" { print_sym("INCREMENT") ; return symbol(sym.INCREMENT); } //

    "--" { print_sym("DECREMENT") ; return symbol(sym.DECREMENT); } //

    "+=" { print_sym("PLUSEQUAL") ; return symbol(sym.PLUSEQUAL); }

    "-=" { print_sym("MINUSEQUAL") ; return symbol(sym.MINUSEQUAL); }

    "+" { print_sym("PLUS") ; return symbol(sym.PLUS); } //

    "-" { print_sym("MINUS") ; return symbol(sym.MINUS); } //

    "*" { print_sym("MULTIPLY") ; return symbol(sym.MULTIPLY); } //

    "/" { print_sym("DIVIDE") ; return symbol(sym.DIVIDE); } //

    "%" { print_sym("MOD") ; return symbol(sym.MOD); } //

    "=" { print_sym("ASSIGN") ; return symbol(sym.ASSIGN); } //

    "<" { print_sym("LESS") ; return symbol(sym.LESS); } //

    ">" { print_sym("GREATER") ; return symbol(sym.GREATER); } //

    {STRING_TYPE} { print_sym("STRING_VAL",yytext()) ; return symbol(sym.STRING_VAL,yytext()); } //

    {CHAR_TYPE} { print_sym("CHAR_VAL",yytext()) ; return symbol(sym.CHAR_VAL,yytext()); } //

    {DOUBLE_TYPE} { print_sym("DOUBLE_VAL",yytext()) ; return symbol(sym.DOUBLE_VAL,yytext()); } //

    {INTEGER_TYPE} { print_sym("INT_VAL",yytext()) ; return symbol(sym.INT_VAL,yytext()); } //

    {BOOLEAN_TYPE} { print_sym("BOOLEAN_VAL",yytext()) ; return symbol(sym.BOOLEAN_VAL,yytext()); } //

    {Ident} {String tname = yytext();if(findToken(tname,this.allTokens) == 0) {allTokens.add(new Token(++counter,tname,"-"));} print_sym("ID",yytext()) ; return symbol(sym.ID,yytext()); } //

    "(" { print_sym("LPRAREN") ; return symbol(sym.LPAREN); } //

    ")" { print_sym("RPAREN") ; return symbol(sym.RPAREN); } //

    "{" { print_sym("LCURL") ; return symbol(sym.LCURL); } //

    "}" { print_sym("RCURL") ; return symbol(sym.RCURL); } //

    ";" { print_sym("SEMICOLON") ; return symbol(sym.SEMICOLON); } //

    {WHITE_SPACE_CHAR} {/* nothing */}

    . { error_lex(); }
}

<MULTI_COMMENT>{
    "*/" {yybegin(YYINITIAL);}
    .|{NEWLINE} {}
}

<SINGLE_COMMENT>{
    {NEWLINE} {yybegin(YYINITIAL);}
    . {}
}