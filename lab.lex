%{
    #include <iostream>
	#include "y.tab.h"
	void yyerror(const char *s);
    
%}

%option yylineno
%option noyywrap

%%
if                                      return IF;
else                                    return ELSE;
print                                   return PRINT;
return                                  return RETURN;
while                                   return WHILE;
[a-zA-Z_][a-zA-Z0-9_]*                  return VAR;
[0-9]+                                  return NUM;
"*"|"/"|"|"|"&"|"<<"|">>"|"%"           return OPERATION;
"+"|"-"                                 return SIGN;
"++"                                    return INC;
"--"                                    return DEC;
"&&"                                    return AND;
"||"                                    return OR;
"/="|"*="|"+="|"-="|"="                 return EQUAL;
>|<|>=|<=|==|!=                         return COMPA;
";"                                     return SCOL;
"("                                     return OBRACE;
")"                                     return CBRACE;
"{"                                     return OCLYBRACE;
"}"                                     return CCLYBRACE;

(\r\n)|\n                               yylval++;
[ \t]+                                  /* empty */
.                                       return ERROR;
%%
