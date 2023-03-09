grammar CalcToMvap;

@parser::members {

    private TablesSymboles tablesSymboles = new TablesSymboles();

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

start : calcul EOF ;

calcul returns [ String code ]
@init{ $code = new String(); }   // On initialise code, pour l'utiliser comme accumulateur 
@after{ System.out.println($code); } // On affiche l’ensemble du code produit

    : (decl { $code += $decl.code; })*
      NEWLINE*

      (instruction { $code += $instruction.code; })*

      { $code += "HALT\n"; }
    ;

instruction returns [ String code ] 
    : ioDeclaration { $code = $ioDeclaration.code; }
    | assignation finInstruction { $code = $assignation.code; }
    | expression finInstruction { $code = $expression.code; }
    | finInstruction { $code=""; }
    ;

expression returns [ String code ]
    : '-' expression { $code = $expression.code + "PUSHI -1\nMUL\n"; }
    | '(' expression ')' { $code = $expression.code; }
    | left=expression op=('*'|'/') right=expression { $code = $left.code + $right.code + evalOperation($op.text) + "\n"; }
    | left=expression op=('+'|'-') right=expression { $code = $left.code + $right.code + evalOperation($op.text) + "\n"; }
    | ENTIER { $code = "PUSHI "+$ENTIER.text+"\n"; }
    | IDENTIFIANT { $code = "PUSHG " + tablesSymboles.getVar($IDENTIFIANT.text).address + "\n"; }
    ;

decl returns [ String code ]
    : TYPE IDENTIFIANT finInstruction
        {
            tablesSymboles.addVarDecl($IDENTIFIANT.text, $TYPE.text);
            $code = "PUSHI 0\n";
        }
    | TYPE IDENTIFIANT '=' expression finInstruction
        {
            tablesSymboles.addVarDecl($IDENTIFIANT.text, $TYPE.text);
            $code = $expression.code;
        }
    ;

assignation returns [ String code ] 
    : IDENTIFIANT '=' expression
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            $code = $expression.code;
            $code += "STOREG " + vi.address + "\n";
        }
    | IDENTIFIANT op=('+'|'-'|'*'|'/') '=' expression
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            $code = "PUSHG " + vi.address + "\n";
            $code += $expression.code;
            $code += evalOperation($op.text) + "\n";
            $code += "STOREG " + vi.address + "\n";
        }
    ;

ioDeclaration returns [ String code ]
    : 'input' '(' IDENTIFIANT ')' finInstruction
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            $code = "READ \n";
            $code += "STOREG " + vi.address + "\n";
        }
    | 'print' '(' expression ')' finInstruction
        {
            $code = $expression.code;
            $code += "WRITE \n";
            $code += "POP \n";
        }
    ;

bloc returns [ String code ]  @init{ $code = new String(); } 
    : '{' 
        (instruction { $code += $instruction.code; })*  
      '}'  
      NEWLINE*
    ;


// lexer
TYPE : 'int' | 'double' ;

IDENTIFIANT : ('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9')* ;

//Commentaires mono-ligne avec '%' et multi-ligne avec '/*' et '*/'
COMMENT : ('/*'.*?'*/'|'%'.*?'\n') -> skip ;

NEWLINE : '\r'? '\n';

WS :   (' '|'\t')+ -> skip  ;

ENTIER : ('0'..'9')+  ;

UNMATCH : . -> skip ;

finInstruction : ( NEWLINE | ';' )+ ;