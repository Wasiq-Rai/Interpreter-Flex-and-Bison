// CMSC 430
// Duane J. Jarc

// This file contains function definitions for the evaluation functions

typedef char* CharPtr;
enum Operators {LESS, ADD, MULTIPLY,DIVIDE, MODULUS, SUBTRACT};

int evaluateReduction(Operators operator_, int head, int tail);
int evaluateRelational(int left, Operators operator_, int right);
int evaluateArithmetic(int left, Operators operator_, int right);
int appendParameter(int left, Operators operator_, int right);
int initializeParameter(int left,  int right);
int evaluateIfElse(int left,int middle, int right);
int evaluateCase(int left, int middle, int right);
int evaluateMultiplication(int left,  int right,Operators operator_ );
int evaluateUnaryPlus(int digit);
int evaluateUnaryMultiplication(int digit);
int evaluateUnaryNot(int digit);
int evaluateAddition(int left,  int right,Operators operator_);
int evaluateNot(int digit);
int evaluateOr(int left , int right);
int evaluateAnd(int left, int right);
int evaluateRemainder(int  left, Operators operator_, int right);