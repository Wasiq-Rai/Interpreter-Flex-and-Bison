/* Compiler Theory and Design Duane J. Jarc */

%{

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <cmath>

using namespace std;

#include "types.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);

Symbols<Types> symbols;
Symbols<int> ints;
Symbols<double> reals;
Symbols<bool> bools;

int result;
bool success = true;
%}

%define parse.error verbose

%union
{
    Types type;
    CharPtr iden;
    Operators oper;
    double realValue;
    bool boolValue;
}

%token <iden> IDENTIFIER
%token <type> INT_LITERAL
%token <type> REAL_LITERAL
%token <type> BOOL_LITERAL

%token <oper> ADDOP MULOP RELOP ANDOP OROP NOTOP REMOP EXP
%token IS
%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER REAL REDUCE RETURNS
%token ASSIGNMENT
%token IF THEN ELSE ENDIF
%token <type> CASE WHEN ARROW OTHERWISE
%token ENDCASE
%token REPEAT UNTIL
%token NULL_STATEMENT

%type <type> statement_ statement 
%type <type> type
%type <type>   case_list body reductions expression relation term variable
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
%{
int arg1, arg2;
bool arg1_set = false, arg2_set = false;
%}

%%



function:
    function_header optional_variable body {result = $3; } ;

function_header:
    FUNCTION IDENTIFIER parameters RETURNS type ';' ;

optional_variable:
    variable optional_variable |
    ;

variable:
    IDENTIFIER {if (!symbols.find($1,$$)) appendError(UNDECLARED, $1); else appendError(DUPLICATE_IDENTIFIER , $1);symbols.insert($1, $$);} |
    IDENTIFIER ':' type ASSIGNMENT primary ';' { checkVariableInitialization($3, $5, "Variable Initialization");symbols.insert($1, $3);} |
    IDENTIFIER ASSIGNMENT expression {symbols.insert($1, $3);$$ = $3; } |
    IDENTIFIER ':' type IS statement ';' {checkVariableInitialization($3, $5, "Variable Initialization");symbols.insert($1, $3);ints.insert($1, $5);} ;

parameters:
    /* empty */ |
    parameters_list ;

parameters_list:
    parameters_list ',' IDENTIFIER ':' type   |
    IDENTIFIER ':' type   ;

type:
    INTEGER {$$ = INT_TYPE;} |
    BOOLEAN {$$ = BOOL_TYPE;} |
    REAL {$$ = REAL_TYPE;};

body:
    BEGIN_ statement_ END ';' {$$ = $2;} ;

expression:
    expression OROP relation {$$ = checkLogical($1, $3, OR);} |
    expression ANDOP relation {$$ = checkLogical($1, $3, AND);}  |
    NOTOP relation {checkIfCondition($2, "If Condition");} |
    relation ;

relation:
    relation RELOP term {$$ = checkRelational($1, $3);} |
    term ;

term:
    term ADDOP factor |
    term MULOP factor {$$ = checkArithmetic($1, $3);} |
    term REMOP factor {checkRemainder($1, $3, "Remainder");} |
    factor ;

factor:
    factor MULOP primary {$$ = checkArithmetic($1, $3);} |
    factor REMOP primary {$$ = checkArithmetic($1, $3);} |
    primary ;

primary:
    '(' expression ')' {$$= $2;} |
    INT_LITERAL {checkNumericReduction(INT_TYPE, "Numeric Reduction"); $$ = $1;}|
    REAL_LITERAL {checkNumericReduction(REAL_TYPE, "Numeric Reduction"); $$ = $1;}|
    BOOL_LITERAL {$$ = $1;}|
    primary EXP primary {checkArithmeticLogical($1, $3, "Arithmetic Logical"); $$ = checkArithmetic($1, $3);} |
    ADDOP primary {checkNumericReduction($2, "Numeric Reduction");}
    NOTOP primary {checkBooleanArithmetic(BOOL_TYPE, $2, "Boolean Arithmetic");} |
    IDENTIFIER {if (!symbols.find($1,$$)) appendError(UNDECLARED, $1);} ;

operator:
    ADDOP |
    MULOP |
    RELOP |
    ANDOP |
    OROP |
    NOTOP |
    REMOP |
    EXP ;

reductions:
    reductions statement_ { $$= checkArithmetic($1, $2);} |
    { $$= INT_TYPE;} ;

case_list:
    WHEN INT_LITERAL ARROW statement_ case_list {checkTypeCompatibility(INT_TYPE, $4);$$= $5;} |
    CASE expression WHEN statement_ ARROW statement_ {checkCaseExpression($4, "CASE expression");checkTypeCompatibility($4, $6);$$= MISMATCH; } |
    CASE expression WHEN statement_ ARROW statement_ case_list {checkCaseExpression($4, "CASE expression");checkTypeCompatibility($4, $6); $$ = $7;} |
    ;

statement_:
    statement ';' |
    error ';' {
    $$ = MISMATCH;
} ;

statement:
    expression |
    REDUCE operator reductions ENDREDUCE {checkNumericReduction($3, "REDUCE operator");$$= INT_TYPE;} |
    IF expression THEN statement_ ENDIF {checkIfCondition( $2, "IF expression");$$= $4;} |
    IF expression THEN statement_ ELSE statement_ ENDIF {checkIfCondition($2, "IF expression"); checkIfThen(BOOL_TYPE, $2, "IF expression");checkArithmeticLogical($4, $6, "IF-ELSE statement");} |
    CASE expression IS case_list OTHERWISE ARROW statement_ ENDCASE ;

%%

int main(int argc, char* argv[])
{
    // Parse program and execute function
    firstLine();
	 yyparse();

    lastLine();
    finalError();
    
    

    return 0;
}

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}
