%{
#include "types.h"
#include "parser.tab.h"
int last_was_terminator = 0;

int yycolumn = 1;

#define YY_USER_ACTION \
    yylloc.first_line = yylloc.last_line = yylineno; \
    yylloc.first_column = yycolumn; \
    yylloc.last_column = yycolumn + yyleng - 1; \
    yycolumn += yyleng;
%}

%option yylineno

/* Mint Definitions */
STRING_LIT "\""[^\"]*"\""

IDENTIFIER {LETTER}({LETTER}|{DECIMAL_DIGIT})*
LETTER     [a-zA-Z_]


FLOAT_LIT {DECIMAL_DIGITS}"."{DECIMAL_DIGITS}?{DECIMAL_EXPONENT}?|{DECIMAL_DIGITS}{DECIMAL_EXPONENT}|"."{DECIMAL_DIGITS}{DECIMAL_EXPONENT}?

DECIMAL_LIT "0"|[1-9]("_"?{DECIMAL_DIGITS})?
BINARY_LIT  "0"("b"|"B")"_"?{BINARY_DIGITS}
OCTAL_LIT   "0"("o"|"O")?"_"?{OCTAL_DIGITS}
HEX_LIT     "0"("x"|"X")"_"?{HEX_DIGITS}

DECIMAL_EXPONENT [eE][+-]?{DECIMAL_DIGITS}

DECIMAL_DIGITS {DECIMAL_DIGIT}("_"?{DECIMAL_DIGIT})*
BINARY_DIGITS  {BINARY_DIGIT}("_"?{BINARY_DIGIT})*
OCTAL_DIGITS   {OCTAL_DIGIT}("_"?{OCTAL_DIGIT})*
HEX_DIGITS     {HEX_DIGIT}("_"?{HEX_DIGIT})*

DECIMAL_DIGIT [0-9]
BINARY_DIGIT  [0-1]
OCTAL_DIGIT   [0-7]
HEX_DIGIT     ([0-9]|[A-F]|[a-f])

%%

[ \t]+            /* eat up whitespace */
"//".*            /* skip until end of line */
"/*"(.|"\n")*"*/" /* skip block comments */

("True"|"true"|"TRUE"|"False"|"false"|"FALSE") { 
  #ifdef LEXME
  printf( "BOOL_LIT(%s) ", yytext );
  #endif
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext);
  return BOOL_LIT;
}

"break" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("BREAK_KW ");
  #endif
  return BREAK;
}
"bool"  {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("BOOL_KW ");
  #endif
  return yylval.strval = strdup(yytext), BOOL;
}

"continue" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("CONTINUE_KW ");
  #endif
  return CONTINUE;
}
"const" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("CONST_KW ");
  #endif
  return CONST;
}
"char"  {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("CHAR_KW ");
  #endif
  return yylval.strval = strdup(yytext), CHAR;
}

"elif" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("ELIF_KW ");
  #endif
  return ELIF;
}
"else" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("ELSE_KW ");
  #endif
  return ELSE;
}
"enum" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("ENUM_KW ");
  #endif
  return ENUM;
}

"float" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("FLOAT_KW ");
  #endif
  return yylval.strval = strdup(yytext), FLOAT;
}
"f32"   {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("F32_KW ");
  #endif
  return yylval.strval = strdup(yytext), F32;
}
"f64"   {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("F64_KW ");
  #endif
  return yylval.strval = strdup(yytext), F64;
}
"for" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("FOR_KW ");
  #endif
  return FOR;
}

"int"   {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("INT_KW ");
  #endif
  return yylval.strval = strdup(yytext), INT;
}
"i8"    {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("I8_KW ");
  #endif
  return yylval.strval = strdup(yytext), I8;
}
"i128"  {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("I128_KW ");
  #endif
  return yylval.strval = strdup(yytext), I128;
}
"i16"   {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("I16_KW ");
  #endif
  return yylval.strval = strdup(yytext), I16;
}
"i32"   {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("I32_KW ");
  #endif
  return yylval.strval = strdup(yytext), I32;
}
"i64"   {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("I64_KW ");
  #endif
  return yylval.strval = strdup(yytext), I64;
}
"if" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("IF_KW ");
  #endif
  return IF;
}
"in" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("IN_KW ");
  #endif
  return IN;
}

"jmp" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("JMP_KW ");
  #endif
  return JMP;
}

"match" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("MATCH_KW ");
  #endif
  return MATCH;
}
"map" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("MAP_KW ");
  #endif
  return MAP;
}
"mut" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("MUT_KW ");
  #endif
  return MUT;
}

"path"  {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("PATH_KW ");
  #endif
  return yylval.strval = strdup(yytext), PATH;
}

"string" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("STRING_KW ");
  #endif
  return yylval.strval = strdup(yytext), STRING;
}
"struct" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("STRUCT_KW ");
  #endif
  return STRUCT;
}
"static" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("STATIC_KW ");
  #endif
  return STATIC;
}
"switch" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("SWITCH_KW ");
  #endif
  return SWITCH;
}

"type" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("TYPEKW_KW ");
  #endif
  return TYPEKW;
}

"u8"    {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("U8_KW ");
  #endif
  return yylval.strval = strdup(yytext), U8;
}
"u128"  {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("U128_KW ");
  #endif
  return yylval.strval = strdup(yytext), U128;
}
"u16"   {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("U16_KW ");
  #endif
  return yylval.strval = strdup(yytext), U16;
}
"u32"   {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("U32_KW ");
  #endif
  return yylval.strval = strdup(yytext), U32;
}
"u64"   {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("U64_KW ");
  #endif
  return yylval.strval = strdup(yytext), U64;
}

"while" {
  last_was_terminator = 0;
  #ifdef LEXME
  printf("WHILE_KW ");
  #endif
  return WHILE;
}

{IDENTIFIER}  { 
  #ifdef LEXME
  printf( "IDENTIFIER(%s) ", yytext );
  #endif
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return IDENTIFIER; 
}
{BINARY_LIT}  { 
  #ifdef LEXME
  printf( "INT_LIT(%s) ", yytext );
  #endif
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return BINARY_LIT; 
}
{DECIMAL_LIT} { 
  #ifdef LEXME
  printf( "INT_LIT(%s) ", yytext );
  #endif
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return DECIMAL_LIT; 
}
{OCTAL_LIT}   { 
  #ifdef LEXME
  printf( "INT_LIT(%s) ", yytext );
  #endif
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return OCTAL_LIT; 
}
{HEX_LIT}     { 
  #ifdef LEXME
  printf( "INT_LIT(%s) ", yytext );
  #endif
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return HEX_LIT; 
}
{FLOAT_LIT}   { 
  #ifdef LEXME
  printf( "FLOAT_LIT(%s) ", yytext );
  #endif
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return FLOAT_LIT;
}
"("           { 
  #ifdef LEXME
  printf("OPAREN ");
  #endif
  last_was_terminator = 0; 
  return OPAREN; 
}
")"           { 
  #ifdef LEXME
  printf("CPAREN ");
  #endif
  last_was_terminator = 0; 
  return CPAREN; 
}
"{"           { 
  #ifdef LEXME
  printf("OBRACE ");
  #endif
  last_was_terminator = 0; 
  return OBRACE; 
}
"}"           { 
  #ifdef LEXME
  printf("CBRACE ");
  #endif
  last_was_terminator = 0; 
  return CBRACE; 
}
"["           { 
  #ifdef LEXME
  printf("OBRACK ");
  #endif
  last_was_terminator = 0; 
  return OBRACK; 
}
"]"           { 
  #ifdef LEXME
  printf("CBRACK ");
  #endif
  last_was_terminator = 0; 
  return CBRACK; 
}
","           { 
  #ifdef LEXME
  printf("COMMA ");
  #endif
  last_was_terminator = 0; 
  return COMMA; 
}
"->"          { 
  #ifdef LEXME
  printf("ARROW ");
  #endif
  last_was_terminator = 0; 
  return ARROW; 
}
"\|\|"        { 
  #ifdef LEXME
  printf("OR_TOK ");
  #endif
  last_was_terminator = 0; 
  return OR_TOK; 
}
"&&"          { 
  #ifdef LEXME
  printf("AND_TOK ");
  #endif
  last_was_terminator = 0; 
  return AND_TOK; 
}
"=="          { 
  #ifdef LEXME
  printf("EQ_TOK ");
  #endif
  last_was_terminator = 0; 
  return EQ_TOK; 
}
"!="          { 
  #ifdef LEXME
  printf("NEQ_TOK ");
  #endif
  last_was_terminator = 0; 
  return NEQ_TOK; 
}
"<<"          { 
  #ifdef LEXME
  printf("LS_TOK ");
  #endif
  last_was_terminator = 0; 
  return LS_TOK; 
}
">>"          { 
  #ifdef LEXME
  printf("RS_TOK ");
  #endif
  last_was_terminator = 0; 
  return RS_TOK; 
}
"<="          { 
  #ifdef LEXME
  printf("LTE_TOK ");
  #endif
  last_was_terminator = 0; 
  return LTE_TOK; 
}
">="          { 
  #ifdef LEXME
  printf("GTE_TOK ");
  #endif
  last_was_terminator = 0; 
  return GTE_TOK; 
}
"<"           { 
  #ifdef LEXME
  printf("LT_TOK ");
  #endif
  last_was_terminator = 0; 
  return LT_TOK; 
}
">"           { 
  #ifdef LEXME
  printf("GT_TOK ");
  #endif
  last_was_terminator = 0; 
  return GT_TOK; 
}
"+"           { 
  #ifdef LEXME
  printf("ADD_TOK ");
  #endif
  last_was_terminator = 0; 
  return ADD_TOK; 
}
"*"           { 
  #ifdef LEXME
  printf("MULT_TOK ");
  #endif
  last_was_terminator = 0; 
  return MULT_TOK; 
}
"/"           { 
  #ifdef LEXME
  printf("DIV_TOK ");
  #endif
  last_was_terminator = 0; 
  return DIV_TOK; 
}
"\\"          { 
  #ifdef LEXME
  printf("INTDIV_TOK ");
  #endif
  last_was_terminator = 0; 
  return INTDIV_TOK; 
}
"%"           { 
  #ifdef LEXME
  printf("MOD_TOK ");
  #endif
  last_was_terminator = 0; 
  return MOD_TOK; 
}
"-"           { 
  #ifdef LEXME
  printf("SUB_TOK ");
  #endif
  last_was_terminator = 0; 
  return SUB_TOK; 
}
"|"           { 
  #ifdef LEXME
  printf("BIN_OR_TOK ");
  #endif
  last_was_terminator = 0; 
  return BIN_OR_TOK; 
}
"&"           { 
  #ifdef LEXME
  printf("BIN_AND_TOK ");
  #endif
  last_was_terminator = 0; 
  return BIN_AND_TOK; 
}
"^"           { 
  #ifdef LEXME
  printf("XOR_TOK ");
  #endif
  last_was_terminator = 0; 
  return XOR_TOK; 
}
"~"           { 
  #ifdef LEXME
  printf("BIN_NEG_TOK ");
  #endif
  last_was_terminator = 0; 
  return BIN_NEG_TOK; 
}
"!"           { 
  #ifdef LEXME
  printf("NEG_TOK ");
  #endif
  last_was_terminator = 0; 
  return NEG_TOK; 
}

{STRING_LIT}  { 
  #ifdef LEXME
  printf( "STRING_LIT(%s)\n", yytext );
  #endif
  last_was_terminator = 0;
  return yylval.strval = strdup(yytext), STRING_LIT;
}
("\n"|";")+   {
  if (yytext[0] == '\n') { yylineno++; yycolumn = 1; }
  #ifdef LEXME
  printf("TERMINATOR\n");
  #endif
  if (!last_was_terminator) {
    last_was_terminator = 1;
  }
  return TERMINATOR;
}

%%

int yywrap() {
  return 1; // Indicate end of input
}

void yyerror(const char *s) {
  fprintf(stderr, "Error at line %d, column %d: %s\n", 
      yylloc.first_line, 
      yylloc.first_column, 
      s);

  if (yytext[0] == '\n') yytext = strdup("new line");
  if (yytext && yytext[0] != '\0') {
    fprintf(stderr, "Near token: '%s'\n", yytext);
  }
}

int main() {
  #ifdef LEXME
  int token = 1;
  while (token) {
    token = yylex();
  }
  #else
  yyparse(); 
  #endif
  return 0;
}
