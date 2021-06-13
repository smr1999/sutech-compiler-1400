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
    "/*" {yybegin(MULTI_COMMENT);}
    "//" {yybegin(SINGLE_COMMENT);}

    {KEYWORDS_WITHOUT_DT} {System.out.println(yytext() + " : "+ TokenType.KEYWORD);}

    {DATA_TYPE}{NONNEWLINE_WHITE_SPACE_CHAR}+{Ident}{NONNEWLINE_WHITE_SPACE_CHAR}*"="{NONNEWLINE_WHITE_SPACE_CHAR}*{TYPES} {
        String temp = yytext();
        
        String type_ = temp.substring(0, temp.indexOf(" "));
       
        temp = temp.substring(temp.indexOf(" "), temp.length());

        String name_ = temp.substring(0,temp.indexOf("="));
        name_ = name_.replaceAll("\\s", "");

        String value_ = temp.substring(temp.indexOf("=")+1,temp.length());
        value_ = value_.replaceAll("\\s*", "");

        if(getToken(name_,table)==0){
            table.add(new Token(++counter , name_ , type_ , value_));
        }
        else{
            table.elementAt(getToken(name_,table)-1).Value = value_;
        }

        System.out.println(type_ + " : "+ TokenType.KEYWORD);
        System.out.println(name_ + " : "+ TokenType.IDENTIFIER);
        System.out.println("=" + " : "+ TokenType.OPERATOR);
        System.out.println(value_ + " : "+ TokenType.LITERAL);
    }
    
    {Ident}{NONNEWLINE_WHITE_SPACE_CHAR}*"="{NONNEWLINE_WHITE_SPACE_CHAR}*{TYPES} {
        String temp = yytext();
        
        String name_ = temp.substring(0,temp.indexOf("=")); 
        name_ = name_.replaceAll("\\s", "");

        String value_ = temp.substring(temp.indexOf("=")+1,temp.length());
        value_ = value_.replaceAll("\\s*", "");

        if(getToken(name_,table)==0){
            table.add(new Token(++counter , name_ , "N/A" , value_));
        }
        else{
            table.elementAt(getToken(name_,table)-1).Value = value_;
        }
        
        System.out.println(name_ + " : "+ TokenType.IDENTIFIER);
        System.out.println("=" + " : "+ TokenType.OPERATOR);
        System.out.println(value_ + " : "+ TokenType.LITERAL);
    }

    {DATA_TYPE}{NONNEWLINE_WHITE_SPACE_CHAR}+{Ident} {
        String temp = yytext();
        
        String type_ = temp.substring(0, temp.indexOf(" "));
        temp = temp.substring(temp.indexOf(" "), temp.length());

        temp = temp.replaceAll("\\s", "");

        String name_ = temp.substring(0,temp.length()); 

        if(getToken(name_,table)==0){
            table.add(new Token(++counter , name_ , type_ , "N/A" ));
        }
        else{
            table.elementAt(getToken(name_,table)-1).Type = type_;
        }

        System.out.println(type_ + " : "+ TokenType.KEYWORD);
        System.out.println(name_ + " : "+ TokenType.IDENTIFIER);
    }

    {Ident} {
        String temp = yytext();

        if(getToken(temp,table)==0){
            table.add(new Token(++counter , temp , "N/A" , "N/A"));
        }
        
        System.out.println(temp + " : " + TokenType.IDENTIFIER);
    }


    "=="|"!="|"&&"|"||"|"<="|">="|"++"|"--" {System.out.println(yytext() + " : "+ TokenType.OPERATOR);}

    "+"|"-"|"*"|"/"|"%"|"="|"<"|">" {System.out.println(yytext() + " : "+ TokenType.OPERATOR);}

    {TYPES} {System.out.println(yytext() + " : "+ TokenType.LITERAL);}

    "("|")"|"{"|"}"|";"|"."|"["|"]" {System.out.println(yytext() + " : "+ TokenType.DELIMITER);}

    "|"|"\""|"\'"|"&" {System.out.println(yytext() + " : "+ TokenType.UNDEFINED);}

    {WHITE_SPACE_CHAR} {}

    . {System.out.println(yytext() + " : "+ TokenType.UNDEFINED);}
}

<MULTI_COMMENT>{

}

<SINGLE_COMMENT>{

}