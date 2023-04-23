// Compiler Theory and Design
// Duane J. Jarc

// This file contains the bodies of the type checking functions

#include <string>
#include <vector>

using namespace std;

#include "types.h"
#include "listing.h"

void checkAssignment(Types lValue, Types rValue, string message)
{
	if (lValue != MISMATCH && rValue != MISMATCH) {
		if (lValue == BOOL_TYPE && (rValue == INT_TYPE || rValue == REAL_TYPE))
			appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". Cannot assign numeric value to Boolean variable.");
		else if ((lValue == INT_TYPE || lValue == REAL_TYPE) && rValue == BOOL_TYPE)
			appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". Cannot assign Boolean value to numeric variable.");
		else if (lValue != rValue){if (lValue == INT_TYPE && rValue == REAL_TYPE)
            appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". Narrowing initialization of real value to integer variable.");
            else
            appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message);
            }
	}
}


Types checkArithmetic(Types left, Types right) {
    if (left == MISMATCH || right == MISMATCH)
        return MISMATCH;
    if (left != INT_TYPE && left != REAL_TYPE || right != INT_TYPE && right != REAL_TYPE) {
        appendError(GENERAL_SEMANTIC, "Numeric Type Required");
        return MISMATCH;
    }
    if (left == INT_TYPE && right == REAL_TYPE)
        return REAL_TYPE;
    if (left == REAL_TYPE && right == INT_TYPE)
        return REAL_TYPE;
    return left == REAL_TYPE || right == REAL_TYPE ? REAL_TYPE : INT_TYPE;
}



Types checkLogical(Types left, Types right, Operators op) {
    if (left == MISMATCH || right == MISMATCH)
        return MISMATCH;
    if (op == AND && (left != BOOL_TYPE || right != BOOL_TYPE)) {
        appendError(GENERAL_SEMANTIC, "Boolean Type Required");
        return MISMATCH;
    } else if ((op == OR || op == NOT) && left != BOOL_TYPE) {
        appendError(GENERAL_SEMANTIC, "Boolean Type Required");
        return MISMATCH;
    }
    return BOOL_TYPE;
}



Types checkRelational(Types left, Types right)
{
	if (checkArithmetic(left, right) == MISMATCH)
		return MISMATCH;
	return BOOL_TYPE;
}
void checkTypeCompatibility(Types switchType, Types caseType) {
    if (switchType == MISMATCH || caseType == MISMATCH)
        return;
    if (switchType != caseType) {
        appendError(GENERAL_SEMANTIC, "Incompatible Types in CASE Statement");
    }
}
void checkBooleanArithmetic(Types type1, Types type2, string message)
{
    if ((type1 == BOOL_TYPE || type2 == BOOL_TYPE) && (type1 != MISMATCH && type2 != MISMATCH))
        appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". Cannot use Boolean expression with arithmetic operator.");
}
void checkBooleanRelational(Types type1, Types type2, string message)
{
    if ((type1 == BOOL_TYPE || type2 == BOOL_TYPE) && (type1 != MISMATCH && type2 != MISMATCH))
        appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". Cannot use Boolean expression with relational operator.");
}
void checkArithmeticLogical(Types type1, Types type2, string message)
{
    if ((type1 == INT_TYPE || type1 == REAL_TYPE) && (type2 == BOOL_TYPE) && (type1 != MISMATCH && type2 != MISMATCH))
        appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". Cannot use arithmetic expression with logical operator.");
}
void checkNumericReduction(Types type, string message)
{
    if ((type != INT_TYPE && type != REAL_TYPE) && (type != MISMATCH))
        appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". Reduction contains nonnumeric type.");
}
void checkRemainder(Types type1, Types type2, string message)
{
    if ((type1 != INT_TYPE || type2 != INT_TYPE) && (type1 != MISMATCH && type2 != MISMATCH))
        appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". Remainder operator requires integer operands.");
}
void checkIfThen(Types type1, Types type2, string message)
{
    if (type1 != type2 && (type1 != MISMATCH && type2 != MISMATCH))
        appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". If-Then statement contains mismatched types.");
}
void checkCase(Types type1, Types type2, string message)
{
    if (type1 != type2 && (type1 != MISMATCH && type2 != MISMATCH))
        appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". Case statement contains mismatched types.");
}
void checkIfCondition(Types type, string message)
{
    if (type != BOOL_TYPE && type != MISMATCH)
        appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". If statement condition must be Boolean type.");
}
void checkCaseExpression(Types type, string message)
{
    if (type != INT_TYPE && type != MISMATCH)
        appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message + ". Case statement expression must be Integer type.");
}
void checkVariableInitialization(Types lValue, Types rValue, string variableName)
{
    if (lValue != MISMATCH && rValue != MISMATCH) {
        if (lValue == INT_TYPE && rValue == REAL_TYPE)
            appendError(GENERAL_SEMANTIC, "Narrowing variable initialization for " + variableName + ". Cannot assign real value to integer variable.");
        else if (lValue == BOOL_TYPE && (rValue == INT_TYPE || rValue == REAL_TYPE))
            appendError(GENERAL_SEMANTIC, "Type Mismatch on variable initialization for " + variableName + ". Cannot assign numeric value to Boolean variable.");
        else if ((lValue == INT_TYPE || lValue == REAL_TYPE) && rValue == BOOL_TYPE)
            appendError(GENERAL_SEMANTIC, "Type Mismatch on variable initialization for " + variableName + ". Cannot assign Boolean value to numeric variable.");
    }
}
void checkFunctionReturn(Types lValue, Types rValue, string functionName)
{
    if (lValue != MISMATCH && rValue != MISMATCH) {
        if (lValue == INT_TYPE && rValue == REAL_TYPE)
            appendError(GENERAL_SEMANTIC, "Narrowing return for function " + functionName + ". Cannot return real value as integer.");
        else if (lValue == BOOL_TYPE && (rValue == INT_TYPE || rValue == REAL_TYPE))
            appendError(GENERAL_SEMANTIC, "Type Mismatch on return value for function " + functionName + ". Cannot return numeric value as Boolean.");
        else if ((lValue == INT_TYPE || lValue == REAL_TYPE) && rValue == BOOL_TYPE)
            appendError(GENERAL_SEMANTIC, "Type Mismatch on return value for function " + functionName + ". Cannot return Boolean value as numeric.");
    }
}

