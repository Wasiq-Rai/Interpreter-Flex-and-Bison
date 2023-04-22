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
	if (lValue != MISMATCH && rValue != MISMATCH && lValue != rValue)
		appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message);
}

Types checkArithmetic(Types left, Types right) {
    if (left == MISMATCH || right == MISMATCH)
        return MISMATCH;
    if (left != INT_TYPE && left != REAL_TYPE || right != INT_TYPE && right != REAL_TYPE) {
        appendError(GENERAL_SEMANTIC, "Numeric Type Required");
        return MISMATCH;
    }
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