grammar AnBn;

// grammar rules 

file 
    :   anbn EOF ;

anbn  
    :   A anbn B
    |   /* vide */ ;

// lexer rules
A   :   'a';
B   :   'b';
C   :   'c';

UNMATCH :  . ->  skip; 