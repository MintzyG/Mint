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

#ifdef LEXME
  #define PRINT(text) printf("%s", text)
#else
  #define PRINT(text)
#endif

#define LWT last_was_terminator = 0
#define COPY yylval.strval = strdup(yytext)
%}

%option yylineno

/* Mint Definitions */
STRING_LIT "\""[^\"]*"\""

IDENTIFIER {LETTER}({LETTER}|{DECIMAL_DIGIT})*
LETTER [a-zA-Z_]

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

("True"|"true"|"TRUE"|"False"|"false"|"FALSE") { LWT; PRINT("BOOL_LIT "); COPY; return BOOL_LIT; }
"break" { LWT; PRINT("BREAK "); return BREAK; }
"bool"  { LWT; PRINT("BOOL_KW "); COPY; return BOOL; }

"continue" { LWT; PRINT("CONTINUE_KW "); return CONTINUE; }
"const" { LWT; PRINT("CONST_KW "); return CONST; }
"char"  { LWT; PRINT("CHAR_KW ");
  return yylval.strval = strdup(yytext), CHAR;
}

"elif" { LWT; PRINT("ELIF_KW "); return ELIF; }
"else" { LWT; PRINT("ELSE_KW "); return ELSE; }
"enum" { LWT; PRINT("ENUM_KW "); return ENUM; }

"float" { LWT; PRINT("FLOAT_KW "); COPY; return FLOAT; }
"f32"   { LWT; PRINT("F32_KW "); COPY; return F32; }
"f64"   { LWT; PRINT("F64_KW "); COPY; return F64; }
"for" { LWT; PRINT("FOR_KW "); return FOR; }

"int"   { LWT; PRINT("INT_KW "); COPY; return INT; }
"i8"    { LWT; PRINT("I8_KW "); COPY; return I8; }
"i128"  { LWT; PRINT("I128_KW "); COPY; return I128; }
"i16"   { LWT; PRINT("I16_KW "); COPY; return I16; }
"i32"   { LWT; PRINT("I32_KW "); COPY; return I32; }
"i64"   { LWT; PRINT("I64_KW "); COPY; return I64; }
"if" { LWT; PRINT("IF_KW "); return IF; }
"in" { LWT; PRINT("IN_KW "); return IN; }

"jmp" { LWT; PRINT("JMP_KW "); return JMP; }

"match" { LWT; PRINT("MATCH_KW "); return MATCH; }
"map" { LWT; PRINT("MAP_KW "); return MAP; }
"mut" { LWT; PRINT("MUT_KW "); return MUT; }

"path"  { LWT; PRINT("PATH_KW "); COPY; return PATH; }

"string" { LWT; PRINT("STRING_KW "); COPY; return STRING; }
"struct" { LWT; PRINT("STRUCT_KW "); return STRUCT; }
"static" { LWT; PRINT("STATIC_KW "); return STATIC; }
"switch" { LWT; PRINT("SWITCH_KW "); return SWITCH; }

"type" { LWT; PRINT("TYPEKW_KW "); return TYPEKW; }

"u8"    { LWT; PRINT("U8_KW "); COPY; return U8; }
"u128"  { LWT; PRINT("U128_KW "); COPY; return U128; }
"u16"   { LWT; PRINT("U16_KW "); COPY; return U16; }
"u32"   { LWT; PRINT("U32_KW "); COPY; return U32; }
"u64"   { LWT; PRINT("U64_KW "); COPY; return U64; }

"while" { LWT; PRINT("WHILE_KW "); return WHILE; }

{IDENTIFIER}  { PRINT("IDENTIFIER "); LWT; COPY; return IDENTIFIER; }
{BINARY_LIT}  { PRINT("INT_LIT "); LWT; COPY; return BINARY_LIT; }
{DECIMAL_LIT} { PRINT("INT_LIT "); LWT; COPY; return DECIMAL_LIT; }
{OCTAL_LIT}   { PRINT("INT_LIT "); LWT; COPY; return OCTAL_LIT; }
{HEX_LIT}     { PRINT("INT_LIT "); LWT; COPY; return HEX_LIT; }
{FLOAT_LIT}   { PRINT("FLOAT_LIT "); LWT; COPY; return FLOAT_LIT; }
"("           { PRINT("OPAREN "); LWT; return OPAREN; }
")"           { PRINT("CPAREN "); LWT; return CPAREN; }
"{"           { PRINT("OBRACE "); LWT; return OBRACE; }
"}"           { PRINT("CBRACE "); LWT; return CBRACE; }
"["           { PRINT("OBRACK "); LWT; return OBRACK; }
"]"           { PRINT("CBRACK "); LWT; return CBRACK; }
","           { PRINT("COMMA "); LWT; return COMMA; }
"->"          { PRINT("ARROW "); LWT; return ARROW; }
"\|\|"        { PRINT("OR_TOK "); LWT; return OR_TOK; }
"&&"          { PRINT("AND_TOK "); LWT; return AND_TOK; }
"=="          { PRINT("EQ_TOK "); LWT; return EQ_TOK; }
"!="          { PRINT("NEQ_TOK "); LWT; return NEQ_TOK; }
"<<"          { PRINT("LS_TOK "); LWT; return LS_TOK; }
">>"          { PRINT("RS_TOK "); LWT; return RS_TOK; }
"<="          { PRINT("LTE_TOK "); LWT; return LTE_TOK; }
">="          { PRINT("GTE_TOK "); LWT; return GTE_TOK; }
"<"           { PRINT("LT_TOK "); LWT; return LT_TOK; }
">"           { PRINT("GT_TOK "); LWT; return GT_TOK; }
"+"           { PRINT("ADD_TOK "); LWT; return ADD_TOK; }
"*"           { PRINT("MULT_TOK "); LWT; return MULT_TOK; }
"/"           { PRINT("DIV_TOK "); LWT; return DIV_TOK; }
"\\"          { PRINT("INTDIV_TOK "); LWT; return INTDIV_TOK; }
"%"           { PRINT("MOD_TOK "); LWT; return MOD_TOK; }
"-"           { PRINT("SUB_TOK "); LWT; return SUB_TOK; }
"|"           { PRINT("BIN_OR_TOK "); LWT; return BIN_OR_TOK; }
"&"           { PRINT("BIN_AND_TOK "); LWT; return BIN_AND_TOK; }
"^"           { PRINT("XOR_TOK "); LWT; return XOR_TOK; }
"~"           { PRINT("BIN_NEG_TOK "); LWT; return BIN_NEG_TOK; }
"!"           { PRINT("NEG_TOK "); LWT; return NEG_TOK; }
{STRING_LIT}  { PRINT( "STRING_LIT "); LWT; COPY; return STRING_LIT; }

("\n"|";")+   {
  if (yytext[0] == '\n') { yylineno++; yycolumn = 1; }
  PRINT("TERMINATOR\n");
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
