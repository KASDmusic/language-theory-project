grammar CalcToMvap;

@parser::members {

    //private TablesSymboles tablesSymboles = new TablesSymboles();

    private String evalOperation (String op) {
        switch (op) {
            case "*": return " MUL";
            case "/": return " DIV";
            case "+": return " ADD";
            case "-": return " SUB";
        }
        
        System.err.println("Opérateur arithmétique incorrect : '"+op+"'");
        throw new IllegalArgumentException("Opérateur arithmétique incorrect : '"+op+"'");
    }
}

calcul returns [ String code ]
@init{ $code = new String(); }   // On initialise code, pour l'utiliser comme accumulateur 
@after{ System.out.println($code); } // On affiche l’ensemble du code produit

    :   /*(decl { $code += $decl.code; })**/
        NEWLINE*

        (instruction { $code += $instruction.code; })*

        { $code += "HALT\n"; }
    ;

instruction returns [ String code ] 
    : /*assignation finInstruction
        {
            $code = $assignation.code;
        }
    |*/ expression finInstruction 
        { 
            $code = $expression.code;
        }
   | finInstruction
        {
            $code="";
        }
    ;

expression returns [ String code ]
    : '-' expression { $code = $expression.code + "PUSHI -1\nMUL\n"; }
    | '(' expression ')' { $code = $expression.code; }
    | left=expression op=('*'|'/') right=expression { $code = $left.code + $right.code + evalOperation($op.text) + "\n"; }
    | left=expression op=('+'|'-') right=expression { $code = $left.code + $right.code + evalOperation($op.text) + "\n"; }
    | ENTIER { $code = "PUSHI "+$ENTIER.text+"\n"; }
    ;

/*
decl returns [ String code ]
    : TYPE IDENTIFIANT finInstruction
        {
            // à compléter
        }
    ;

assignation returns [ String code ] 
    : IDENTIFIANT '=' expression
        {  
            // à compléter
        }
    ;
*/

// lexer
TYPE : 'int' | 'double' ;

IDENTIFIANT : ('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9')* ;

//Commentaires mono-ligne avec '%' et multi-ligne avec '/*' et '*/'
COMMENT : ('/*'.*?'*/'|'%'.*?'\n') -> skip ;

NEWLINE : '\r'? '\n'  -> skip;

WS :   (' '|'\t')+ -> skip  ;

ENTIER : ('0'..'9')+  ;

UNMATCH : . -> skip ;

finInstruction : ( NEWLINE | ';' )+ ;