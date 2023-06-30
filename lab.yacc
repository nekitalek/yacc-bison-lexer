%{
    #include <iostream>
	extern int yylineno;
	extern int yylex();
	bool error_ = 0;
    extern FILE* yyin;
    int num_error = 0;
    void yyerror(const char *s)
	{
        std::cout << "\x1b[41m не оки \x1b[0m" << std::endl;
		std::cout << s << ", \x1b[31m line \x1b[0m" << yylineno << std::endl;
		error_ = 1;
	}
%}

%start commands

%token VAR EQUAL SCOL ERROR NUM MINUS IF OBRACE CBRACE OCLYBRACE CCLYBRACE ELSE WHILE AND OR COMPA OPERATION SIGN PRINT RETURN INC DEC

%%
commands: /* empty */
    |commands command
    |command commands
    |OCLYBRACE commands CCLYBRACE
    |OCLYBRACE commands CCLYBRACE scoln
        ;
command:/* empty */
    |OCLYBRACE command CCLYBRACE
    |OCLYBRACE command CCLYBRACE scoln
    |equal
    |cycle
    |condition
    |RETURN scoln
    |RETURN expr scoln
    |RETURN number scoln
    |PRINT expr scoln
    |PRINT number scoln
    |
    ERROR
    {
    yyerror(NULL);
    num_error++;
    }
    ;
condition:IF OBRACE brcond CBRACE OCLYBRACE commands CCLYBRACE ELSE OCLYBRACE commands CCLYBRACE
    |IF OBRACE brcond CBRACE OCLYBRACE commands CCLYBRACE
    |IF OBRACE brcond CBRACE OCLYBRACE commands CCLYBRACE ELSE command
    |IF OBRACE brcond CBRACE command ELSE OCLYBRACE commands CCLYBRACE
    |IF OBRACE brcond CBRACE command ELSE command
    |IF OBRACE brcond CBRACE scoln
    |IF OBRACE brcond CBRACE command
    ;
brcond:brcond OR brcond
    |brcond AND brcond
    |OBRACE brcond CBRACE
    |expr COMPA expr
    |expr COMPA number
    |number COMPA expr
    |number COMPA number
    |expr
    |number
    ;
number:NUM
    |OBRACE number CBRACE
    |SIGN NUM
    |NUM INC
    |NUM DEC
    |DEC NUM
    |INC NUM
    |number SIGN number
    |number COMPA number
    |number OPERATION number
    ;
expr:VAR
    |OBRACE expr CBRACE
    |SIGN VAR
    |VAR INC
    |INC VAR
    |DEC VAR
    |VAR DEC
    |number SIGN expr
    |number COMPA expr
    |number OPERATION expr
    |expr SIGN expr
    |expr SIGN number
    |expr COMPA expr
    |expr COMPA number
    |expr OPERATION expr
    |expr OPERATION number
    |expr EQUAL expr
    |expr EQUAL number
    ;
equal:expr scoln
    |number scoln
    ;
cycle: WHILE OBRACE brcond CBRACE OCLYBRACE commands CCLYBRACE
    |WHILE OBRACE brcond CBRACE scoln
    |WHILE OBRACE brcond CBRACE command
    ;
scoln: scoln scoln
    |SCOL
%%

int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
	yyparse();
        fclose(yyin);
	if(error_ == 0)
		printf("\x1b[42m все оки \x1b[0m \n");
        
}
