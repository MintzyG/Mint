%{
#include "function_helper.h"
#include "parser.tab.h"
int last_was_terminator = 0;
%}

/* Mint Definitions */
KEYWORDS "mut"|"const"|"type"|"static"|"map"|"set"|"struct"|"enum"|"if"|"elif"|"else"|"for"|"while"|"break"|"continue"|"in"|"match"|"switch"|"jmp"
TYPES    "int"|"i8"|"i16"|"i32"|"i64"|"i128"|"u8"|"u16"|"u32"|"u64"|"u128"|"bool"|"path"|"float"|"f32"|"f64"|"char"|"string"

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

/* Mint Operators */

OPERATORS {ARITHMETIC_OPERATORS}|{COMPARISON_OPERATORS}|{LOGICAL_OPERATORS}|{BITWISE_OPERATORS}|{ASSIGNMENT_OPERATORS}
ARITHMETIC_OPERATORS "+"|"-"|"*"|"/"|"\\"|"%"
COMPARISON_OPERATORS "=="|"!="|">"|"<"|">="|"<="
LOGICAL_OPERATORS    "&&"|"||"|"!"
BITWISE_OPERATORS    "&"|"|"|"~"|"<<"|">>"|"^"
ASSIGNMENT_OPERATORS "="|"+="|"-="|"*="|"/="|"\\="|"%="|"&="|"|="|"~="|"^="|"<<="|">>="
%%

[ \t]+      /* eat up whitespace */
"//".*     /* skip until end of line */
{KEYWORDS} {
  last_was_terminator = 0;
  switch (yytext[0]) {
    case 'm':
      if (!strcmp(yytext, "mut"))   return MUT;
      if (!strcmp(yytext, "map"))   return MAP;
      if (!strcmp(yytext, "match")) return MATCH;
      break;
    case 'c':
      if (!strcmp(yytext, "const"))    return CONST;
      if (!strcmp(yytext, "continue")) return CONTINUE;
      break;
    case 't':
      if (!strcmp(yytext, "type")) return TYPEKW;
      break;
    case 's':
      if (!strcmp(yytext, "static")) return STATIC;
      if (!strcmp(yytext, "struct")) return STRUCT;
      if (!strcmp(yytext, "switch")) return SWITCH;
      break;
    case 'e':
      if (!strcmp(yytext, "enum")) return ENUM;
      if (!strcmp(yytext, "elif")) return ELIF;
      if (!strcmp(yytext, "else")) return ELSE;
      break;
    case 'i':
      if (!strcmp(yytext, "if")) return IF;
      if (!strcmp(yytext, "in")) return IN;
      break;
    case 'f':
      if (!strcmp(yytext, "for")) return FOR;
      break;
    case 'w':
      if (!strcmp(yytext, "while")) return WHILE;
      break;
    case 'b':
      if (!strcmp(yytext, "break")) return BREAK;
      break;
    case 'j':
      if (!strcmp(yytext, "jmp")) return JMP;
      break;
  }
  // fallback: treat unknown text matching KEYWORDS rule as IDENT maybe?
  return IDENTIFIER;
}
{TYPES} {
  last_was_terminator = 0;
  switch (yytext[0]) {
    case 'i':
      if (!strcmp(yytext, "int"))   return yylval.strval = strdup(yytext), INT;
      if (!strcmp(yytext, "i8"))    return yylval.strval = strdup(yytext), I8;
      if (!strcmp(yytext, "i16"))   return yylval.strval = strdup(yytext), I16;
      if (!strcmp(yytext, "i32"))   return yylval.strval = strdup(yytext), I32;
      if (!strcmp(yytext, "i64"))   return yylval.strval = strdup(yytext), I64;
      if (!strcmp(yytext, "i128"))  return yylval.strval = strdup(yytext), I128;
      break;

    case 'u':
      if (!strcmp(yytext, "u8"))    return yylval.strval = strdup(yytext), U8;
      if (!strcmp(yytext, "u16"))   return yylval.strval = strdup(yytext), U16;
      if (!strcmp(yytext, "u32"))   return yylval.strval = strdup(yytext), U32;
      if (!strcmp(yytext, "u64"))   return yylval.strval = strdup(yytext), U64;
      if (!strcmp(yytext, "u128"))  return yylval.strval = strdup(yytext), U128;
      break;

    case 'b':
      if (!strcmp(yytext, "bool"))  return yylval.strval = strdup(yytext), BOOL;
      break;

    case 'p':
      if (!strcmp(yytext, "path"))  return yylval.strval = strdup(yytext), PATH;
      break;

    case 'f':
      if (!strcmp(yytext, "float")) return yylval.strval = strdup(yytext), FLOAT;
      if (!strcmp(yytext, "f32"))   return yylval.strval = strdup(yytext), F32;
      if (!strcmp(yytext, "f64"))   return yylval.strval = strdup(yytext), F64;
      break;

    case 'c':
      if (!strcmp(yytext, "char"))  return yylval.strval = strdup(yytext), CHAR;
      break;

    case 's':
      if (!strcmp(yytext, "string")) return yylval.strval = strdup(yytext), STRING;
      break;
  }

  // fallback: treat unknown text matching KEYWORDS rule as IDENT maybe?
  return IDENTIFIER;
}
("True"|"true"|"TRUE"|"False"|"false"|"FALSE") { 
  /* printf( "BOOL_LIT(%s)", yytext ); */
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext);
  return BOOL_LIT;
}
{OPERATORS}   { 
  /* printf( "OPERATOR(%s)", yytext ); */
  last_was_terminator = 0; 
}
{IDENTIFIER}  { 
  /* printf( "IDENTIFIER(%s)", yytext ); */
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return IDENTIFIER; 
}
{BINARY_LIT}  { 
  /* printf( "INT_LIT(%s)", yytext ); */
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return BINARY_LIT; 
}
{DECIMAL_LIT} { 
  /* printf( "INT_LIT(%s)", yytext ); */
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return DECIMAL_LIT; 
}
{OCTAL_LIT}   { 
  /* printf( "INT_LIT(%s)", yytext ); */
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return OCTAL_LIT; 
}
{HEX_LIT}     { 
  /* printf( "INT_LIT(%s)", yytext ); */
  last_was_terminator = 0; 
  yylval.strval = strdup(yytext); return HEX_LIT; 
}
{FLOAT_LIT}   { 
  /* printf( "FLOAT_LIT(%s)", yytext ); */
  last_was_terminator = 0; 
}
"("           { last_was_terminator = 0; return OPAREN; }
")"           { last_was_terminator = 0; return CPAREN; }
"{"           { last_was_terminator = 0; return OBRACE; }
"}"           { last_was_terminator = 0; return CBRACE; }
"["           { last_was_terminator = 0; return OBRACK; }
"]"           { last_was_terminator = 0; return CBRACK; }
","           { last_was_terminator = 0; return COMMA; }
"->"          { last_was_terminator = 0; return ARROW; }

{STRING_LIT}  { 
  /* printf( "STRING_LIT(%s)\n", yytext ); */
}
("\n"|";")+   {
  if (!last_was_terminator) {
    /* if (yytext[0] == '\n') printf ("TERMINATOR(\\n)\n");
       else printf("TERMINATOR(;)\n"); */
    last_was_terminator = 1;
  }
  return TERMINATOR;
}

%%

int yywrap() {
  return 1; // Indicate end of input
}

void yyerror(const char *s) {
  fprintf(stderr, "Syntax error: %s\n", s);
}

int main() {
  yyparse(); // Start the lexical analysis
  return 0;
}
