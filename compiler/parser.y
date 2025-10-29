%{
#include <stdio.h>
#include <stdlib.h>
#include "function_helper.h"
#include "parse_int.h"

int yylex(void);
void yyerror(const char *s);
%}

/* Terminal symbols, they come from the lexer, terminals as in they come ready */
%token <strval> INT I8 I16 I32 I64 I128 U8 U16 U32 U64 U128
%token <strval> BOOL PATH
%token <strval> FLOAT F32 F64
%token <strval> CHAR STRING

%token <strval>  DECIMAL_LIT BINARY_LIT OCTAL_LIT HEX_LIT
%token <strval>  BOOL_LIT
%token <strval>  OPAREN CPAREN OBRACE CBRACE OBRACK CBRACK ARROW IDENTIFIER
%right  <strval>  COMMA
%token <strval>  TERMINATOR
%token <strval>  MUT CONST TYPEKW STATIC MAP SET STRUCT ENUM IF ELIF ELSE FOR WHILE BREAK CONTINUE IN MATCH SWITCH JMP

%union {
    int intval;
    char* strval;
    BaseType typeval;
    IdentifierList* id_listval;
    Param* paramval;
    ParamList* param_listval;
    Function* funcval;
}

/* Non terminals, they are assembled by the parser as in we use the terminal from lexer to build them */
%type <intval> INT_LIT
%type <typeval> TYPE
%type <id_listval> IDENTIFIER_LIST
%type <funcval> FUNCTION_DECL SIGNATURE
%type <param_listval> PARAMETER_LIST PARAMETER_DECL PARAMETERS RESULT

%%

program:
      /* empty */
    | program statement
    ;

statement:
      INT_LIT    { printf("Got INT_LIT: %d\n", $1); }
    | BOOL_LIT   { printf("Got BOOL_LIT: %s\n", $1); }
    | IDENTIFIER { printf("Got IDENTIFIER: %s\n", $1); free($1); }
    | FUNCTION_DECL {  }
    | TERMINATOR
    ;

INT_LIT:
      DECIMAL_LIT { $$ = parse_decimal($1); free($1); }
    | OCTAL_LIT   { $$ = parse_octal($1); free($1); }
    | HEX_LIT     { $$ = parse_hex($1); free($1); }
    | BINARY_LIT  { $$ = parse_binary($1); free($1); }
    ;

FUNCTION_DECL:
      IDENTIFIER SIGNATURE BODY {
        printf("Function(%s)\n", $1); 
      }
    ;

SIGNATURE:
      PARAMETERS ARROW RESULT { }
    | PARAMETERS { }
    ;

RESULT:
      TYPE { }
    | PARAMETERS { }
    ;

BODY:
      OBRACE CBRACE
      { printf("Empty function body detected\n"); }
    ;

PARAMETERS:
      OPAREN CPAREN { }
    | OPAREN PARAMETER_LIST CPAREN { }
    ;

PARAMETER_LIST:
      PARAMETER_DECL PARAMETER_LIST_REST { }
    ;

PARAMETER_LIST_REST:
      /* empty */ { }
    | COMMA PARAMETER_DECL PARAMETER_LIST_REST { }
    ;

PARAMETER_DECL:
      TYPE IDENTIFIER_LIST { }
    | TYPE                { }
    ;

IDENTIFIER_LIST:
      IDENTIFIER IDENTIFIER_LIST_REST { }
    ;

IDENTIFIER_LIST_REST:
      /* empty */ { }
    | COMMA IDENTIFIER IDENTIFIER_LIST_REST { }
    ;

TYPE:
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
%%
