%{
#include "main.tab.h"
#include <string.h>
#include <stdlib.h>

void yyerror(const char *s);
%}

%%

[ \t\n]+               ;   /* Ignore whitespace */
"liko"|"লিখ"          { return PRINT; }
"jodi"|"যদি"          { return IF; }
"="                    { return ASSIGN; }
"+"                    { return PLUS; }
"-"                    { return MINUS; }
"*"                    { return MULTIPLY; }
"/"                    { return DIVIDE; }
"("                    { return LPAREN; }
")"                    { return RPAREN; }
"{"                    { return LBRACE; }
"}"                    { return RBRACE; }
";"                    { return SEMICOLON; }
","                    { return COMMA; }
"["                    { return LBRACKET; }
"]"                    { return RBRACKET; }
"<"                    { return LT; }
">"                    { return GT; }
"=="                   { return EQ; }
"!="                   { return NE; }
"++"                   { return INCR; }
"--"                   { return DECR; }

"sajao"|"সাজাও"        { return SORT; }
"ultosajao"|"উল্টে_সাজাও" { return REVERSE_SORT; }
"average"|"গড়"        { return AVERAGE; }

[0-9]+                 { yylval.num = atoi(yytext); return NUMBER; }
\"([^\"]*)\"           { 
    yylval.str = strdup(yytext + 1); 
    yylval.str[strlen(yylval.str) - 1] = '\0'; 
    return STRING_LITERAL; 
}
[অ-৯a-zA-Z_][অ-৯a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENTIFIER; }

%%

int yywrap() {
    return 1;
}
