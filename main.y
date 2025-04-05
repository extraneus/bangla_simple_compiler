%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declare yyin from Flex
extern FILE *yyin;

// Symbol table functions
typedef struct {
    char *name;
    int value;
} Symbol;

#define MAX_SYMBOLS 100
Symbol symbols[MAX_SYMBOLS];
int symbol_count = 0;

void add_symbol(char *name, int value) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbols[i].name, name) == 0) {
            symbols[i].value = value;
            return;
        }
    }
    if (symbol_count < MAX_SYMBOLS) {
        symbols[symbol_count].name = strdup(name);
        symbols[symbol_count].value = value;
        symbol_count++;
    } else {
        fprintf(stderr, "Error: Symbol table overflow\n");
    }
}

int get_symbol_value(char *name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbols[i].name, name) == 0) {
            return symbols[i].value;
        }
    }
    fprintf(stderr, "Error: Undefined variable '%s'\n", name);
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

extern int yylex();
%}

%union {
    int num;
    char *str;
    struct {
        int values[100];
        int count;
    } array;
}

%token <num> NUMBER
%token <str> IDENTIFIER STRING_LITERAL
%token PRINT IF SORT ASSIGN PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN LBRACE RBRACE SEMICOLON COMMA
%token LBRACKET RBRACKET LT GT EQ NE INCR DECR

%left PLUS MINUS
%left MULTIPLY DIVIDE
%left LT GT EQ NE
%right ASSIGN

%type <num> Expression Term Factor Condition
%type <array> Array NumberList

%%

Program: StatementList { printf("Parsing complete.\n"); }
;

StatementList: Statement
             | Statement StatementList
;

Statement: PrintStmt
         | AssignStmt
         | IfStmt
         | SortStmt
         | IncrStmt SEMICOLON
;

PrintStmt: PRINT LPAREN STRING_LITERAL RPAREN SEMICOLON { printf("Output: %s\n", $3); free($3); }
         | PRINT LPAREN Expression RPAREN SEMICOLON { printf("Output: %d\n", $3); }
;

AssignStmt: IDENTIFIER ASSIGN Expression SEMICOLON {
    add_symbol($1, $3);
    free($1);
}
;

IfStmt: IF LPAREN Condition RPAREN LBRACE StatementList RBRACE
;

IncrStmt: IDENTIFIER INCR { add_symbol($1, get_symbol_value($1) + 1); free($1); }
        | IDENTIFIER DECR { add_symbol($1, get_symbol_value($1) - 1); free($1); }
;

SortStmt: SORT LPAREN Array RPAREN SEMICOLON {
    for (int i = 0; i < $3.count - 1; i++) {
        for (int j = 0; j < $3.count - i - 1; j++) {
            if ($3.values[j] > $3.values[j + 1]) {
                int temp = $3.values[j];
                $3.values[j] = $3.values[j + 1];
                $3.values[j + 1] = temp;
            }
        }
    }
    printf("Sorted array: ");
    for (int i = 0; i < $3.count; i++) {
        printf("%d ", $3.values[i]);
    }
    printf("\n");
}
;

Array: LBRACKET NumberList RBRACKET {
    $$ = $2;
}
;

NumberList: NUMBER {
    $$.values[0] = $1;
    $$.count = 1;
}
| NUMBER COMMA NumberList {
    $$.values[0] = $1;
    for (int i = 0; i < $3.count; i++) {
        $$.values[i + 1] = $3.values[i];
    }
    $$.count = $3.count + 1;
}
;

Expression: Term
          | Expression PLUS Term { $$ = $1 + $3; }
          | Expression MINUS Term { $$ = $1 - $3; }
          | Expression MULTIPLY Term { $$ = $1 * $3; }
          | Expression DIVIDE Term { $$ = $1 / $3; }
;

Term: Factor
    | Term MULTIPLY Factor { $$ = $1 * $3; }
    | Term DIVIDE Factor { $$ = $1 / $3; }
;

Factor: NUMBER { $$ = $1; }
      | IDENTIFIER { $$ = get_symbol_value($1); free($1); }
      | LPAREN Expression RPAREN { $$ = $2; }
;

Condition: Expression LT Expression { $$ = $1 < $3 ? 1 : 0; }
         | Expression GT Expression { $$ = $1 > $3 ? 1 : 0; }
         | Expression EQ Expression { $$ = $1 == $3 ? 1 : 0; }
         | Expression NE Expression { $$ = $1 != $3 ? 1 : 0; }
;

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror(argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        fprintf(stderr, "Error: No input file provided\n");
        return 1;
    }
    return yyparse();
}
