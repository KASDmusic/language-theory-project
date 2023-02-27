grammar Calculette;

@parser::members {

    private int evalexpr (int x, String op, int y) {
        if ( op.equals("*") )
        {
            return x*y;
        }

        else if ( op.equals("/") )
        {
            return x/y;
        }
        
        else if ( op.equals("+") )
        {
            return x+y;
        } 

        else if ( op.equals("-") )
        {
            return x-y;
        }
        
        else 
        {
           System.err.println("Opérateur arithmétique incorrect : '"+op+"'");
           throw new IllegalArgumentException("Opérateur arithmétique incorrect : '"+op+"'");
        }
    }
}

start
    : expr EOF {System.out.println($expr.value);}
    ;

expr returns [int value]
    : '(' expr ')' { $value = $expr.value; }
    | a=expr op=('*'|'/') b=expr {$value = evalexpr($a.value, $op.text, $b.value);}
    | a=expr op=('+'|'-') b=expr {$value = evalexpr($a.value, $op.text, $b.value);}
    | ENTIER {$value = $ENTIER.int;}
    ;

// lexer
NEWLINE : '\r'? '\n'  -> skip;

WS :   (' '|'\t')+ -> skip  ;

ENTIER : ('0'..'9')+  ;

UNMATCH : . -> skip ;