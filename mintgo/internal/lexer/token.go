package lexer

import "fmt"

//go:generate go run golang.org/x/tools/cmd/stringer@latest -type=TokenKind
type TokenKind int

const (
	ILLEGAL TokenKind = iota
	EOF

	COMMENT               // //
	MULTI_LINE_COMMENT    // /**/
	DOC_COMMENT           // !//
	MULT_DOC_LINE_COMMENT // !/**/

	IDENT
	INT_LIT
	FLOAT_LIT
	URI_LIT
	STRING_LIT
	CHAR_LIT
	TRUE
	FALSE

	operatorBeg
	ASSIGN           // =
	INFER            // :=
	PIPE             // |>
	METHOD_PIPE      // ||>
	ARROW            // ->
	FAT_ARROW        // =>
	QUESTION         // ?
	BANG             // !
	PLUS             // +
	MINUS            // -
	STAR             // *
	SLASH            // /
	BACKSLASH        // \
	PERCENT          // %
	AMP              // &
	PIPE_BIT         // |
	TILDE            // ~
	CARET            // ^
	LSHIFT           // <<
	RSHIFT           // >>
	EQ               // ==
	NEQ              // !=
	LT               // <
	GT               // >
	LTE              // <=
	GTE              // >=
	AND              // &&
	OR               // ||
	PLUS_ASSIGN      // +=
	MINUS_ASSIGN     // -=
	STAR_ASSIGN      // *=
	SLASH_ASSIGN     // /=
	BACKSLASH_ASSIGN // \=
	PERCENT_ASSIGN   // %=
	AMP_ASSIGN       // &=
	PIPE_ASSIGN      // |=
	TILDE_ASSIGN     // ~=
	CARET_ASSIGN     // ^=
	LSHIFT_ASSIGN    // <<=
	RSHIFT_ASSIGN    // >>=
	COLON            // :
	SEMICOLON        // ;
	COMMA            // ,
	DOT              // .
	LPAREN           // (
	RPAREN           // )
	LBRACE           // {
	RBRACE           // }
	LBRACKET         // [
	RBRACKET         // ]
	DOUBLE_QUOTE     // "
	SINGLE_QUOTE     // '
	BACKTICK         // `
	UNDERSCORE       // _
	AT               // @
	operatorEnd

	isReservedBegin
	typeBegin
	INT
	I8
	I16
	I32
	I64
	I128
	UINT
	U8
	U16
	U32
	U64
	U128
	FLOAT
	F32
	F64
	CHAR
	ACHAR
	STRING
	URI
	BOOL
	ERROR
	STRUCT
	ENUM
	NIL
	RESULT
	OPTION
	FUTURE
	MAP
	SET
	VOID
	typeEnd

	typeAdjacentBegin
	TREE
	INTERFACE
	IMPL // impl | implements
	EXTENDS
	WHERE
	HOOKS
	MUT
	SELF
	IT
	typeAdjacentEnd

	controlFlowBegin
	RETURN
	MATCH
	FALLTHROUGH
	IF
	ELSE
	FOR
	controlFlowEnd

	asyncBegin
	ASYNC
	DO
	asyncEnd

	IMPORT
	PACKAGE

	TEST
	BENCH
	GROUP
	BEFORE
	AFTER
	SETUP
	TEARDOWN
	EXPECT
	IS
	isReservedEnd

	NEW_LINE
)

type Token struct {
	Kind TokenKind
	Lit  string // raw text for literals; empty for punctuation
	Pos  Pos    // source location
}

func (k TokenKind) IsKeyword() bool {
	return k > isReservedBegin && k < isReservedEnd
}

type Pos struct {
	File   string // filename passed to New()
	Offset int    // byte offset from start of file
	Line   int    // 1-indexed
	Col    int    // 1-indexed, byte offset within line
}

func (p Pos) String() string {
	return fmt.Sprintf("[%s] %d:%d", p.File, p.Line, p.Col)
}
