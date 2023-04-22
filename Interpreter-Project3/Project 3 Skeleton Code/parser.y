/* Compiler Theory and Design
   Duane J. Jarc */

%{

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <cmath>

using namespace std;

#include "values.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);

Symbols<int> symbols;
int result;
bool success = true;

%}

%define parse.error verbose

%union
{
    CharPtr iden;
    Operators oper;
    int value;
    double realValue;
    bool boolValue;
}

%token <iden> IDENTIFIER
%token <value> INT_LITERAL
%token <realValue> REAL_LITERAL
%token <boolValue> BOOL_LITERAL

%token <oper> ADDOP MULOP RELOP ANDOP OROP NOTOP REMOP EXP


%token IS
%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER REAL REDUCE RETURNS
%token ASSIGNMENT
%token IF THEN ELSE ENDIF
%token CASE WHEN ARROW OTHERWISE 
%token ENDCASE
%token WHILE DO
%token FOR BY
%token REPEAT UNTIL
%token NULL_STATEMENT
%token statement_seq

%type <value> statement_ statement

%type <value> program  case_list body reductions expression relation term 
        factor primary    
%type <oper> operator


%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE
%nonassoc LOWER_THAN_REDUCE
%left ADDOP
%left MULOP
%left RELOP
%left ANDOP
%left OROP
%nonassoc NOTOP
%left REMOP
%right EXP


%%

program:
    /* empty */ {$$ = 0;} |
    program function {$$ = 0;} ;

function:	
    function_header optional_variable body {result = $3;} ;
    
function_header:	
    FUNCTION IDENTIFIER parameters RETURNS type ';' ;
    
optional_variable:
    variable | variable optional_variable |  
    ;
    
variable:
	IDENTIFIER  |
    IDENTIFIER ':' type IS statement ';' {symbols.insert($1, $5);} ;

parameters:
    /* empty */ |
    parameters_list ;

parameters_list:
    parameters_list ',' IDENTIFIER ':' type   |
    IDENTIFIER ':' type   ;

type:
    INTEGER |
    BOOLEAN |
    REAL ;

body:
    BEGIN_ statement_ END ';' {$$ = $2;} ;
    
statement_:
    statement ';' |
    statement ';' statement_ |
    error ';' {$$ = 0;} ;

statement:
    expression |
    REDUCE operator reductions ENDREDUCE {$$ = $3;} |
	IF expression THEN statement_ ELSE statement_ ENDIF {$$ = evaluateIfElse($2, $4, $6);} |
    CASE expression IS case_list OTHERWISE ARROW statement_ ENDCASE {$$ = evaluateCase($2, $4,  $<value>6);} |
    NULL_STATEMENT {$$ = 0;} ;
    
expression:
    relation |
    expression ANDOP relation {$$ = evaluateAnd($1, $3);} |
    expression OROP relation {$$ = evaluateOr($1, $3);} |
    NOTOP relation {$$ = evaluateNot($2);} ;

relation:
    term |
    relation RELOP term {$$ = evaluateRelational($1, $2, $3);} ;

term:
    factor |
    term ADDOP factor {$$ = evaluateAddition($1, $3, $2);} |
	term MULOP  factor {$$ = evaluateMultiplication($1 , $3 , $2);} |
	term REMOP  factor {$$ = evaluateRemainder($1,$2,$3);};

factor:
    primary |
    factor MULOP primary {$$ = evaluateMultiplication($1, $3, $2);} |
	factor REMOP primary {$$ =  evaluateRemainder($1,$2,$3);} ;

primary:
    IDENTIFIER |
    INT_LITERAL {$$ = $1;} |
    REAL_LITERAL {$$ = $1;} |
    BOOL_LITERAL {$$ = $1;} |
	primary EXP primary |
    '(' expression ')' {$$ = $2;} |
    ADDOP primary {$$ = evaluateUnaryPlus($2);} |
    NOTOP primary {$$ = evaluateUnaryNot($2);} ;




reductions:
	reductions statement_ {$$ = evaluateReduction($<oper>0, $1, $2);} |
	{$$ = $<oper>0 == ADD ? 0 : 1;} ;

operator:
    ADDOP |
	MULOP |
	REMOP |
	RELOP |
	NOTOP |
	OROP  |
	ANDOP |
	EXP ;

case_list:
    WHEN INT_LITERAL ARROW statement_ case_list |
	;



%%

int main()
{
	firstLine();
    yyparse();
    if (lastLine() == 0){
        cout << "Successful compilation" << endl;
		cout << "Result = " << result << endl;
	}
    else
        cout << "Compilation failed" << endl;
    return 0;
}

void yyerror(const char* message)
{
    success = false;
	appendError(SYNTAX, message);
    cout << "Syntax error: " << message << endl;
}
