/* Compiler Theory and Design
   Dr. Duane J. Jarc */

/* This file contains flex input file */

%{
#include <string>
#include <vector>

using namespace std;
#include "values.h"
#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws              [ \t\r]+
comment         \-\-.*\n
line            [\n]
id              [A-Za-z][A-Za-z0-9]*
digit           [0-9]
int             {digit}+
punc            [(),:;]
real            {digit}+\.{digit}*(E[+-]?{digit}+)?
bool            true|false
%%
{ws}            { ECHO; }
{comment}       { ECHO; nextLine(); }
{line}          { ECHO; nextLine(); }
"+"             { ECHO; return(ADDOP); }
"-"             { ECHO; return(ADDOP); }
"*"             { ECHO; return(MULOP); }
"/"             { ECHO; return(MULOP); }
">="            { ECHO; return(RELOP); }
">"             { ECHO; return(RELOP); }
"<="            { ECHO; return(RELOP); }
"<"             { ECHO; return(RELOP); }
"/="            { ECHO; return(RELOP); }
"**"            { ECHO; return(EXP); }
"="             { ECHO; return(RELOP); }
"=>"            { ECHO; return(ARROW); }
rem             { ECHO; return(REMOP); }
begin           { ECHO; return(BEGIN_); }
boolean         { ECHO; return(BOOLEAN); }
end             { ECHO; return(END); }
endreduce       { ECHO; return(ENDREDUCE); }
function        { ECHO; return(FUNCTION); }
integer         { ECHO; return(INTEGER); }
is              { ECHO; return(IS); }
if              { ECHO; return(IF); }
then            { ECHO; return(THEN); }
else            { ECHO; return(ELSE); }
endif           { ECHO; return(ENDIF); }
case            { ECHO; return(CASE); }
when            { ECHO; return(WHEN); }
endcase         { ECHO; return(ENDCASE); }
others          { ECHO; return(OTHERWISE); }
reduce          { ECHO; return(REDUCE); }
returns         { ECHO; return(RETURNS); }
and             { ECHO; return(ANDOP); }
not             { ECHO; return(NOTOP); }
or              { ECHO; return(OROP); }
int             { ECHO; return(INTEGER); }
bool            { ECHO; return(BOOLEAN); }
real            { ECHO; return(REAL); }
{bool}          { ECHO; return(BOOL_LITERAL); }
{real}          { ECHO; return(REAL_LITERAL); }
{id}            { ECHO; yylval.iden = (CharPtr)malloc(yyleng + 1); 
                        strcpy(yylval.iden, yytext); return(IDENTIFIER);}
{int}		       { ECHO; yylval.value = atoi(yytext); return(INT_LITERAL); }
{punc}		    { ECHO; return(yytext[0]); }
.		          { ECHO; appendError(LEXICAL, yytext); }                       
%%