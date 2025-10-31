%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "types.h"
#include "parse_int.h"

extern int yylineno;
extern int yycolumn;
extern char *yytext;

int yylex(void);
void yyerror(const char *s);
%}

%locations
%define parse.error verbose

/* Terminal symbols, they come from the lexer, terminals as in they come ready */
%token <strval> INT I8 I16 I32 I64 I128 U8 U16 U32 U64 U128
%token <strval> BOOL PATH
%token <strval> FLOAT F32 F64
%token <strval> CHAR STRING

%token <strval>  DECIMAL_LIT BINARY_LIT OCTAL_LIT HEX_LIT
%token <strval>  FLOAT_LIT
%token <strval>  BOOL_LIT
%token <strfal>  STRING_LIT
%token <strval>  OPAREN CPAREN OBRACE CBRACE OBRACK CBRACK ARROW IDENTIFIER
%right <strval>  COMMA
%token <strval>  TERMINATOR
%token <strval>  MUT CONST TYPEKW STATIC MAP SET STRUCT ENUM IF ELIF ELSE FOR WHILE BREAK CONTINUE IN MATCH SWITCH JMP

%token <strval> ADD_TOK SUB_TOK NEG_TOK MULT_TOK DIV_TOK INTDIV_TOK MOD_TOK LS_TOK RS_TOK
%token <strval> BIN_OR_TOK BIN_AND_TOK BIN_NEG_TOK XOR_TOK
%token <strval> OR_TOK AND_TOK EQ_TOK NEQ_TOK LTE_TOK GTE_TOK LT_TOK GT_TOK

%union {
  int intval;
  char* strval;
  BaseType typeval;
  IdList* idlistval;
  VarDecl vardeclval;
}

/* Non terminals, they are assembled by the parser as in we use the terminal from lexer to build them */
%type <intval> INT_LIT
%type <typeval> NAMED_TYPE
%type <idlistval> IDENTIFIER_LIST
%type <vardeclval> VAR_DECL

%%

program:
      /* empty */
    | program TOP_LEVEL_DECL
    ;

TOP_LEVEL_DECL:
      FUNCTION_DECL { printf("found function\n"); }
    | VAR_DECL { print_var_decl(&$1); }
    ;

VAR_DECL:
      NAMED_TYPE IDENTIFIER_LIST TERMINATOR {
        $$.IdList = *$2;
        $$.Type = $1;
      }
    | NAMED_TYPE error {
        yyerror("Variable declaration must be named");
        yyerrok;
      }
    ;

FUNCTION_DECL:
      IDENTIFIER SIGNATURE BLOCK { }
    ;

SIGNATURE:
      PARAMETERS RESULT { }
    ;

BLOCK:
    OBRACE STATEMENT_LIST CBRACE { }
    ;

STATEMENT_LIST:
      EMPTY
    | STATEMENT_LIST STATEMENT TERMINATOR { printf("found statement\n"); }
    ;

STATEMENT:
      VAR_DECL { }  
    | BLOCK    { }
    | IF_STMT  { printf("found if_stmt\n"); }
    ;

IF_STMT:
      IF EXPRESSION BLOCK { printf("found if\n"); }
    | IF EXPRESSION BLOCK ELSE IF_STMT { printf("found if else if\n"); }
    | IF EXPRESSION BLOCK ELSE BLOCK { printf("found if else\n"); }
    ;

EXPRESSION:
      UNARY_EXPR { }
    | EXPRESSION BINARY_OP EXPRESSION { }
    ;

BINARY_OP:
      ADD_TOK | SUB_TOK | MULT_TOK | DIV_TOK | INTDIV_TOK | MOD_TOK | LS_TOK | RS_TOK
    | BIN_OR_TOK | BIN_AND_TOK | XOR_TOK
    | OR_TOK | AND_TOK | EQ_TOK | NEQ_TOK | LTE_TOK | GTE_TOK | LT_TOK | GT_TOK
    ;     

UNARY_EXPR:
      UNARY_OP EXPRESSION { }
    | PRIMARY_EXPR { }
    ;

UNARY_OP:
      SUB_TOK { }
    | NEG_TOK { }
    | BIN_NEG_TOK { }
    ;

PRIMARY_EXPR:
      OPERAND { }
    ;

OPERAND:
      OPAREN EXPRESSION CPAREN { }
    | IDENTIFIER { }
    ;

RESULT:
      /* empty */ { }
    | ARROW NAMED_TYPE { }
    | ARROW TUPLE_TYPE { }
    ;

PARAMETERS:
      OPAREN CPAREN { }
    | OPAREN PARAMETER_LIST CPAREN { }
    | OPAREN PARAMETER_LIST COMMA CPAREN { }
    ;

PARAMETER_LIST:
      PARAMETER_DECL { }
    | PARAMETER_LIST COMMA PARAMETER_DECL { }
    ;

PARAMETER_DECL:
      NAMED_TYPE { }
    | NAMED_TYPE IDENTIFIER { }
    ;

IDENTIFIER_LIST:
      IDENTIFIER  { 
        $$ = malloc(sizeof(IdList));
        $$->IDs = malloc(sizeof(char*));
        $$->IDs[0] = strdup($1);
        $$->Size = 1;
      }
    | IDENTIFIER_LIST COMMA IDENTIFIER { 
        $$ = $1;
        $$->Size++;
        $$->IDs = realloc($$->IDs, $$->Size * sizeof(char*));
        $$->IDs[$$->Size - 1] = strdup($3); 
      }
    ;

INT_LIT:
      DECIMAL_LIT { $$ = parse_decimal($1); free($1); }
    | OCTAL_LIT   { $$ = parse_octal($1); free($1); }
    | HEX_LIT     { $$ = parse_hex($1); free($1); }
    | BINARY_LIT  { $$ = parse_binary($1); free($1); }
    ;

TYPE:
      NAMED_TYPE { }
    | COMPOSITE_TYPE { }
    ;

COMPOSITE_TYPE:
      TUPLE_TYPE { }
    ;

TUPLE_TYPE:
      OPAREN NAMED_TYPE COMMA TYPE_LIST CPAREN { }
    ;

TYPE_LIST:
      NAMED_TYPE { }
    | TYPE_LIST COMMA NAMED_TYPE { }
    ;

NAMED_TYPE:
      INT    { $$ = TYPE_INT; }
    | I8     { $$ = TYPE_I8; }
    | I16    { $$ = TYPE_I16; }
    | I32    { $$ = TYPE_I32; }
    | I64    { $$ = TYPE_I64; }
    | I128   { $$ = TYPE_I128; }
    | U8     { $$ = TYPE_U8; }
    | U16    { $$ = TYPE_U16; }
    | U32    { $$ = TYPE_U32; }
    | U64    { $$ = TYPE_U64; }
    | U128   { $$ = TYPE_U128; }
    | CHAR   { $$ = TYPE_CHAR; }
    | STRING { $$ = TYPE_STRING; }
    | PATH   { $$ = TYPE_PATH; }
    | FLOAT  { $$ = TYPE_FLOAT; }
    | F32    { $$ = TYPE_F32; }
    | F64    { $$ = TYPE_F64; }
    | BOOL   { $$ = TYPE_BOOL; }
    ;

EMPTY:
      /* empty */ { }
    | TERMINATOR_LIST { }
    ;

TERMINATOR_LIST:
      /* empty */
    | TERMINATOR_LIST TERMINATOR;
    ;
%%
