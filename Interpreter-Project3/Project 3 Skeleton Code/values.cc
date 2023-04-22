// CMSC 430
// Duane J. Jarc

// This file contains the bodies of the evaluation functions

#include <string>
#include <vector>
#include <cmath>

using namespace std;
#include "values.h"
#include "listing.h"

int evaluateReduction(Operators operator_, int head, int tail)
{
	if (operator_ == ADD)
		return head + tail;
	return head * tail;
}


int evaluateRelational(int left, Operators operator_, int right)
{
	int result;
	switch (operator_)
	{
		case LESS:
			result = left < right;
			break;
	}
	return result;
}

int evaluateArithmetic(int left, Operators operator_, int right)
{
	int result;
	switch (operator_)
	{
		case ADD:
			result = left + right;
			break;
		case MULTIPLY:
			result = left * right;
			break;
	}
	return result;
}



// a function to evaluate an if-else statement
int evaluateIfElse(int left, int middle, int right){
if (left)
return middle;
else
return right;
}

// a function to evaluate a case statement
int evaluateCase(int left, int middle, int right){
if (left == middle)
return right;
else
return 0;
}

// a function to evaluate multiplication
int evaluateMultiplication(int left, int right, Operators operator_ ){
switch (operator_)
{
case MULTIPLY:
return left * right;
case DIVIDE:
return left / right;
case MODULUS:
return left % right;
default:
return 0;
}
}

// a function to evaluate unary plus
int evaluateUnaryPlus(int digit){
return digit;
}

// a function to evaluate unary multiplication
int evaluateUnaryMultiplication(int digit){
return digit;
}

// a function to evaluate unary not
int evaluateUnaryNot(int digit){
if (digit)
return 0;
else
return 1;
}

// a function to evaluate addition
int evaluateAddition(int left, int right, Operators operator_){
switch (operator_)
{
case ADD:
return left + right;
case SUBTRACT:
return left - right;
default:
return 0;
}
}

// a function to evaluate not
int evaluateNot(int digit){
if (digit)
return 0;
else
return 1;
}

// a function to evaluate or
int evaluateOr(int left , int right){
if (left || right)
return 1;
else
return 0;
}

// a function to evaluate and
int evaluateAnd(int left, int right){
if (left && right)
return 1;
else
return 0;
}

// a function to evaluate remainder
int evaluateRemainder(int left, Operators operator_, int right){
return left % right;
}