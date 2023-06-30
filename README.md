# yacc-bison-lexer
a C language parser that checks the input file for syntax errors
Required:
- yacc
- bison

File with the .lex extension, which defines the rules of lexical analysis and a file with the extension .yacc, which defines the rules of grammatical parsing. The listings of these files are presented in Appendix A and B, respectively.
The lexical analyzer describes the necessary tokens that will be returned when a sequence of characters matches.
Thus, under conditions, loops, output and return functions, the corresponding tokens will be returned.
When one or more digits are encountered, the NUMBER token will be returned. When a letter or several letters meet, the VAR token. 
For different operation symbols, a pointer to the input text. Special characters are ignored. 
The parser describes the necessary rules for describing the grammar we need.
_simple usage_
![image](https://github.com/nekitalek/yacc-bison-lexer/assets/59126116/ab59c6e2-df97-4ba5-8ff7-a920825a59ec)
