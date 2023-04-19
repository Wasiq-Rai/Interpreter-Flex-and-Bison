/* Compiler Theory and Design
   Dr. Duane J. Jarc */

%{

#include <string>

using namespace std;

#include "listing.h"

int yylex();
void yyerror(const char* message);

%}

%define parse.error verbose

%token IDENTIFIER
%token INT_LITERAL
%token REAL_LITERAL
%token BOOL_LITERAL

%left ADDOP
%left MULOP
%left RELOP
%left ANDOP
%token REAL
%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER IS REDUCE RETURNS
%token ASSIGNMENT
%token IF THEN ELSE ENDIF
%token CASE IS WHEN ARROW OTHERWISE ENDCASE
%token WHILE DO END
%token FOR BY
%token REPEAT UNTIL
%token NULL_STATEMENT
%token statement_seq
%%

function:	
	function_header optional_variable body ;
	
function_header:	
	FUNCTION IDENTIFIER RETURNS type ';' ;

optional_variable:
	variable |
	;

variable:
	IDENTIFIER ':' type IS expression ';' ;

type:
	INTEGER |
	BOOLEAN |
	REAL ;

body:
	BEGIN_ statement_ END ';' ;
    
statement_:
	statement ';' |
	error ';' ;
	
statement:
	expression |
	REDUCE operator reductions ENDREDUCE |
	IF expression THEN statement ELSE statement ENDIF ';' |
	CASE expression IS case_list OTHERWISE statement ENDCASE ';' |
	WHILE expression DO statement END ';' |
	FOR IDENTIFIER ASSIGNMENT expression BY expression WHILE expression DO statement END ';' |
	REPEAT statement_seq UNTIL expression ';' |
	NULL_STATEMENT ';' ;

case_list:
	WHEN INT_LITERAL ARROW statement case_list |
	;

operator:
	ADDOP |
	MULOP ;

reductions:
	reductions statement_ |
	;
		    
expression:
	expression ANDOP relation |
	relation ;

relation:
	relation RELOP term |
	term;

term:
	term ADDOP factor |
	factor ;
      
factor:
	factor MULOP primary |
	primary ;

primary:
	'(' expression ')' |
	INT_LITERAL |
	REAL_LITERAL |
	BOOL_LITERAL |
	IDENTIFIER |
	REAL_LITERAL |
	BOOL_LITERAL ;

%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 