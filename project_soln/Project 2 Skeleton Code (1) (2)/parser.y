/* Compiler Theory and Design
   Dr. Duane J. Jarc */

%{

#include <string>
#include <vector>

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
%left REMOP
%token REMOP
%right EXP
%token EXP


%token IS
%token REAL
%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER REDUCE RETURNS
%token ASSIGNMENT
%token IF THEN ELSE ENDIF
%token CASE WHEN ARROW OTHERWISE ENDCASE
%token WHILE DO
%token FOR BY
%token REPEAT UNTIL
%token NULL_STATEMENT
%token statement_seq
%%

function:	
	function_header optional_variable body ;

function_header:	
	FUNCTION IDENTIFIER parameters RETURNS type ';' ;


optional_variable:
	variable optional_variable|  
	;

variable:
	IDENTIFIER ':' type IS statement ';' ;

parameters:
	/* empty */ |
	parameters_list ;

parameters_list:
	parameters_list ',' IDENTIFIER ':' type |
	IDENTIFIER ':' type ;

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
	IF expression THEN statement_ ELSE statement_ ENDIF |
	CASE expression IS case_list OTHERWISE ARROW statement_ ENDCASE  |
	WHILE expression DO statement_ END ';' |
	FOR IDENTIFIER ASSIGNMENT expression BY expression WHILE expression DO statement_ END ';' |
	REPEAT statement_seq UNTIL expression ';' |
	NULL_STATEMENT ';' ;

case_list:
	WHEN INT_LITERAL ARROW statement_ case_list |
	;

operator:
	ADDOP |
	MULOP |
	RELOP ;

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
	term MULOP factor |
	term REMOP factor |
	factor ;

      
factor:
	factor MULOP primary |
	factor REMOP primary |
	primary ;

primary:
	'(' expression ')' |
	INT_LITERAL |
	REAL_LITERAL |
	BOOL_LITERAL |
	IDENTIFIER |
	primary EXP primary ;
;

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
