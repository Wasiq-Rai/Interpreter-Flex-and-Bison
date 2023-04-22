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