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

//a function to append parameters
int appendParameter(int left, Operators operator_, int right)
{
return 1;
}
int initializeParameter(int left,  int right){
	return 1;
};
int evaluateIfElse(int left, int middle, int right){
	return 1;
};
int evaluateCase(int left, int middle, int right){
	return 1;
};
int evaluateMultiplication(int left,  int right,Operators operator_ ){
	return 1;
};
int evaluateUnaryPlus(int digit){
	return 1;
};
int evaluateUnaryMultiplication(int digit){
	return 1;
};
int evaluateUnaryNot(int digit){
	return 1;
};
int evaluateAddition(int left,  int right,Operators operator_){
	return 1;
};
int evaluateNot(int digit){
	return 1;
};
int evaluateOr(int left , int right){
	return 1;
};
int evaluateAnd(int left, int right){
	return 1;
};