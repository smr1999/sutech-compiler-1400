import java.util.Vector;

%%

%class Lexical
%standalone
%line
%column

%state MULTI_COMMENT
%state SINGLE_COMMENT

%{
    
%}


ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
NEWLINE=\r|\n|\r\n
WHITE_SPACE_CHAR=[\n\r\ \t\b\012]
STRING_TEXT=(\\\"|[^\n\r\"\\]|\\{WHITE_SPACE_CHAR}+\\)*
Ident = {ALPHA}({ALPHA}|{DIGIT}|_)*
DATA_TYPE = "void"|"long"|"int"|"String"|"char"|"boolean"|"double"|"float"
STRING_TYPE = "\""{STRING_TEXT}"\""
DOUBLE_TYPE = {DIGIT}+"."{DIGIT}*
NUMERIC_TYPE = {DIGIT}+
BOOLEAN_TYPE = "true"|"false"
CHAR_TYPE = "\'"{ALPHA}"\'"
KEYWORDS_WITHOUT_DT = "public"|"private"|"protected"|"static"|"else if"|"elseif"|"if"|"else"|"then"|"break"|"for"|"while"|"default"|"continue"|"return"

TYPES = {STRING_TYPE}|{CHAR_TYPE}|{DOUBLE_TYPE}|{NUMERIC_TYPE}|{BOOLEAN_TYPE}

%%

<YYINITIAL>{

}

<MULTI_COMMENT>{

}

<SINGLE_COMMENT>{
    
}