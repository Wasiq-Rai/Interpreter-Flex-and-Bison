/* Compiler Theory and Design
   Dr. Duane J. Jarc */

/* This file contains flex input file */

%{
#include <string>
#include <vector>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		\-\-.*\n
line		[\n]
id		[A-Za-z][A-Za-z0-9]*
digit		[0-9]
int		{digit}+
punc		[(),:;]
real		{digit}+\.{digit}*(E[+-]?{digit}+)?
%%
{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
"+"      { ECHO; return(ADDOP); }
"<"      { ECHO; return(RELOP); }
">"      { ECHO; return(RELOP); }
">="     { ECHO; return(RELOP); }
"<="     { ECHO; return(RELOP); }
"/="     { ECHO; return(RELOP); }
"*"      { ECHO; return(MULOP); }
"-"      { ECHO; return(ADDOP); }
"/"      { ECHO; return(MULOP); }
"="      { ECHO; return(RELOP); }
"=>"     { ECHO; return(ARROW); }
"**"     { ECHO; return(EXP); }
rem      {ECHO; return(REMOP);}
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
if    { ECHO; return(IF); }
then     { ECHO; return(THEN); }
else     { ECHO; return(ELSE); }
endif    { ECHO; return(ENDIF); }
case		{ ECHO; return(CASE); }
when		{ ECHO; return(WHEN); }
endcase		{ ECHO; return(ENDCASE); }
others		{ ECHO; return(OTHERWISE); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
and		{ ECHO; return(ANDOP); }
not		{ ECHO; return(NOTOP); }
or		{ ECHO; return(OROP); }
real		{ ECHO; return(REAL); }
{real}		{ ECHO; return(REAL_LITERAL); }
{id}		{ ECHO; return(IDENTIFIER);}
{int}		{ ECHO; return(INT_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }

%%