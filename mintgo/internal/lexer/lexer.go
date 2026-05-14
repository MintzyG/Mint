package lexer

import (
	"io"
	"unicode"
	"unicode/utf8"
)

// keywords maps source text -> TokenKind for all reserved words.
var keywords = map[string]TokenKind{
	// types
	"int": INT, "i8": I8, "i16": I16, "i32": I32, "i64": I64, "i128": I128,
	"uint": UINT, "u8": U8, "u16": U16, "u32": U32, "u64": U64, "u128": U128,
	"float": FLOAT, "f32": F32, "f64": F64,
	"char": CHAR, "achar": ACHAR, "string": STRING, "uri": URI, "bool": BOOL,
	"error": ERROR, "struct": STRUCT, "enum": ENUM, "nil": NIL,
	"result": RESULT, "option": OPTION, "future": FUTURE,
	"map": MAP, "set": SET, "void": VOID,
	// type-adjacent
	"tree": TREE, "interface": INTERFACE, "impl": IMPL, "implements": IMPL,
	"extends": EXTENDS, "where": WHERE, "hooks": HOOKS,
	"mut": MUT, "self": SELF, "it": IT,
	// control flow
	"return": RETURN, "match": MATCH, "fallthrough": FALLTHROUGH,
	"if": IF, "else": ELSE, "for": FOR,
	// async
	"async": ASYNC, "do": DO,
	// top-level
	"import": IMPORT, "package": PACKAGE,
	// testing
	"test": TEST, "bench": BENCH, "group": GROUP,
	"before": BEFORE, "after": AFTER, "setup": SETUP, "teardown": TEARDOWN,
	"expect": EXPECT, "is": IS,
	// booleans
	"true": TRUE, "false": FALSE,
}

// Lexer holds the scanning state.
type Lexer struct {
	src       []byte
	filename  string
	offset    int       // current byte position
	line      int       // current line (1-indexed)
	lineStart int       // byte offset of current line start (for Col)
	prevKind  TokenKind // last emitted kind — used for PATH vs SLASH disambiguation
	errors    []*LexError
}

// New creates a Lexer from source bytes.
// filename is used only for error messages and Pos.File.
func New(src []byte, filename string) *Lexer {
	return &Lexer{src: src, filename: filename, line: 1}
}

// Errors returns all lexer errors accumulated during scanning.
func (l *Lexer) Errors() []*LexError { return l.errors }

// advance returns the next rune and moves the cursor forward.
func (l *Lexer) advance() rune {
	r, size := utf8.DecodeRune(l.src[l.offset:])
	l.offset += size
	if r == '\n' {
		l.line++
		l.lineStart = l.offset
	}
	return r
}

// peek returns the next rune without moving the cursor.
func (l *Lexer) peek() (rune, error) {
	if l.offset >= len(l.src) {
		return 0, io.EOF
	}
	r, _ := utf8.DecodeRune(l.src[l.offset:])
	return r, nil
}

// peek2 returns the rune two positions ahead.
func (l *Lexer) peek2() (rune, error) {
	if l.offset >= len(l.src) {
		return 0, io.EOF
	}
	_, size := utf8.DecodeRune(l.src[l.offset:])
	next := l.offset + size
	if next >= len(l.src) {
		return 0, io.EOF
	}
	r2, _ := utf8.DecodeRune(l.src[next:])
	return r2, nil
}

// pos snapshots the current position for a token's start.
func (l *Lexer) snapPos() Pos {
	return Pos{
		File:   l.filename,
		Offset: l.offset,
		Line:   l.line,
		Col:    l.offset - l.lineStart + 1,
	}
}

func (l *Lexer) pos() Pos {
	return Pos{
		File:   l.filename,
		Offset: l.offset,
		Line:   l.line,
		Col:    l.offset - l.lineStart + 1,
	}
}

func (l *Lexer) tok(k TokenKind, lit string) Token {
	return Token{Kind: k, Lit: lit, Pos: l.pos()}
}

func (l *Lexer) tokAt(k TokenKind, lit string, pos Pos) Token {
	return Token{Kind: k, Lit: lit, Pos: pos}
}

/////////////
// Helpers //
/////////////

// Next returns the next token.
func (l *Lexer) Next() Token {
	if l.offset >= len(l.src) {
		return l.tok(EOF, "")
	}

	r := l.advance()
	for l.isWhiteSpace(r) {
		r = l.advance()
	}

	pos := l.pos()
	if isIdentStart(r) {
		return l.scanIdent(r, pos)
	}

	if isNewLine(r) {
		return l.tok(NEW_LINE, "LINE_FEED")
	}

	return l.tokAt(CHAR_LIT, string(r), pos)

	//switch {
	//case r == '"' || r == '`':
	//	return l.scanString(pos)
	//case r == '\'':
	//	return l.scanChar(pos)
	//case r == '@':
	//	return l.scanAnnotation(pos)
	//case r == '!':
	//	return l.scanDocBang(pos)
	//case r == '/' && l.peekAt(1) == '/':
	//	return l.scanLineComment(pos)
	//case r == '/' && l.peekAt(1) == '*':
	//	return l.scanBlockComment(pos)
	//case r == '.' && l.isPathStart():
	//	return l.scanPath(pos)
	//case r == '~' && (l.peekAt(1) == '/'):
	//	return l.scanPath(pos)
	//case isDigit(r):
	//	return l.scanNumber(pos)
	//case isIdentStart(r):
	//	return l.scanIdent(r, pos)
	//default:
	//	t := l.scanOperator(pos)
	//	if t.Kind == SLASH {
	//		// bare / could be start of absolute path
	//		if l.isAbsolutePath(pos) {
	//			return l.scanPath(pos)
	//		}
	//	}
	//	return t
	//}
}

//func (l *Lexer) scanString(start Pos) Token {
//
//}
//

func (l *Lexer) isWhiteSpace(r rune) bool {
	return r == ' ' || r == '\t'
}

func isIdentStart(r rune) bool {
	return r == '_' || unicode.IsLetter(r)
}

func isNewLine(r rune) bool {
	return r == '\n'
}

func isAlphaNumeric(r rune) bool {
	return r == '_' || unicode.IsLetter(r) || unicode.IsDigit(r)
}

func (l *Lexer) scanIdent(first rune, start Pos) Token {
	buf := []rune{first}

	for {
		r, err := l.peek()
		if err == io.EOF || !isAlphaNumeric(r) {
			break
		}
		buf = append(buf, l.advance())
	}

	lit := string(buf)
	if kind, ok := keywords[lit]; ok {
		return l.tokAt(kind, lit, start)
	}
	return l.tokAt(IDENT, lit, start)
}
