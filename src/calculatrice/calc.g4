grammar calc;

start
    : expr EOF;

expr
    : expr '*' expr
    | expr '+' expr
    | ENTIER
    ;

// lexer
NEWLINE : '\r'? '\n'  -> skip;

WS :   (' '|'\t')+ -> skip  ;

ENTIER : ('0'..'9')+  ;

UNMATCH : . -> skip ;
