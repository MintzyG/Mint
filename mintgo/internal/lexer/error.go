package lexer

import "fmt"

type LexError struct {
	Pos Pos
	Msg string
}

func (e *LexError) Error() string {
	return fmt.Sprintf("%s: %s", e.Pos, e.Msg)
}
