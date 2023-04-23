// Compiler Theory and Design
// Duane J. Jarc

// This file contains type definitions and the function
// prototypes for the type checking functions

typedef char* CharPtr;

enum Types {MISMATCH, INT_TYPE, BOOL_TYPE,REAL_TYPE};
enum Operators {LESS, ADD, MULTIPLY,DIVIDE, MODULUS, SUBTRACT,AND, OR ,NOT};

void checkAssignment(Types lValue, Types rValue, string message);
Types checkArithmetic(Types left, Types right);
Types checkLogical(Types left, Types right,Operators op);
Types checkRelational(Types left, Types right);
void checkTypeCompatibility(Types switchType, Types caseType);
void checkBooleanArithmetic(Types type1, Types type2, string message);
void checkBooleanRelational(Types type1, Types type2, string message);
void checkArithmeticLogical(Types type1, Types type2, string message);
void checkNumericReduction(Types type, string message);
void checkRemainder(Types type1, Types type2, string message);
void checkIfThen(Types type1, Types type2, string message);
void checkCase(Types type1, Types type2, string message);
void checkIfCondition(Types type, string message);
void checkCaseExpression(Types type, string message);
void checkVariableInitialization(Types lValue, Types rValue, string variableName);
void checkFunctionReturn(Types lValue, Types rValue, string functionName);
