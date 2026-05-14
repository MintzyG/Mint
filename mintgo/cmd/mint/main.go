package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"

	"mint/internal/lexer"
)

func main() {
	var src []byte
	var err error

	if len(os.Args) < 2 {
		_, _ = fmt.Fprintf(os.Stderr, "usage: %s <file>\n", os.Args[0])
		os.Exit(1)
	}

	path := os.Args[1]
	if filepath.Ext(path) != ".mint" {
		_, _ = fmt.Fprintf(os.Stderr, "error: file must have .mint extension\n")
		os.Exit(1)
	}

	src, err = os.ReadFile(path)
	if err != nil {
		log.Fatal(err)
	}

	lex := lexer.New(src, path)
	for {
		tok := lex.Next()
		if tok.Kind == lexer.EOF {
			break
		}
		fmt.Printf("%s(%s)\n", tok.Kind, tok.Lit)
	}
}
