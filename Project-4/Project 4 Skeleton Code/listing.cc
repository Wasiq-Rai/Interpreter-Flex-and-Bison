// Compiler Theory and Design
// Dr. Duane J. Jarc

// This file contains the bodies of the functions that produces the compilation
// listing

#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"

static int lineNumber;
static string error = "";
static int totalErrors = 0;

int semantic_error =0;
int lexical_error =0;
int syntax_error =0;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ",lineNumber);
}

int lastLine()
{
	printf("\r");
	displayErrors();
	printf("     \n");
	return totalErrors;
}
    
void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = { "Lexical Error, Invalid Character ", "",
		"Semantic Error, ", "Semantic Error, Duplicate Identifier: ",
		"Semantic Error, Undeclared " };

	error = messages[errorCategory] + message;
	if(errorCategory == LEXICAL)
		lexical_error++;
	else if(errorCategory == GENERAL_SEMANTIC)
		semantic_error++;
	else if(errorCategory == SYNTAX)
		syntax_error++;

	totalErrors++;
}

void displayErrors()
{
	if (error != "")
		printf("%s\n", error.c_str());
	// error = "";
}
void finalError(){
	printf("     \n");
    printf("Total Errors %d\n", totalErrors);

    printf("Lexical Errors %d\n", lexical_error);
    printf("Syntax Errors %d\n", syntax_error);
    printf("Semantic Errors %d\n", semantic_error);
}