grammar CalcToMvap;

@parser::members {

    private int _cur_label = 1;
    /** générateur de nom d'étiquettes pour les boucles */
    private String getNewLabel() { return "Label" +(_cur_label++); }

    private TablesSymboles tablesSymboles = new TablesSymboles();

    private String evalOperation (String op) {
        switch (op) {
            case "*": return "\tMUL";
            case "/": return "\tDIV";
            case "+": return "\tADD";
            case "-": return "\tSUB";
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
      {
        $code += "\tJUMP " + "Start" + "\n";
        $code += "LABEL Start" + "\n";
      }

      (instruction { $code += $instruction.code; })*

      { $code += "\tHALT\n"; }
    ;

instruction returns [ String code ] 
    : ioDeclaration { $code = $ioDeclaration.code; }
    | boucle { $code = $boucle.code; }
    | conditionIf { $code = $conditionIf.code; }
    | assignation finInstruction { $code = $assignation.code; }
    | expression finInstruction { $code = $expression.code; }
    | finInstruction { $code=""; }
    ;

expression returns [ String code ]
    : '-' expression { $code = $expression.code + "\tPUSHI -1\nMUL\n"; }
    | '(' expression ')' { $code = $expression.code; }
    | left=expression op=('*'|'/') right=expression { $code = $left.code + $right.code + evalOperation($op.text) + "\n"; }
    | left=expression op=('+'|'-') right=expression { $code = $left.code + $right.code + evalOperation($op.text) + "\n"; }
    | ENTIER { $code = "\tPUSHI "+ $ENTIER.text+"\n"; }
    | IDENTIFIANT { $code = "\tPUSHG " + tablesSymboles.getVar($IDENTIFIANT.text).address + "\n"; }
    ;

decl returns [ String code ]
    : TYPE IDENTIFIANT finInstruction
        {
            tablesSymboles.addVarDecl($IDENTIFIANT.text, $TYPE.text);
            $code = "\tPUSHI 0\n";
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
            $code += "\tSTOREG " + vi.address + "\n";
        }
    | IDENTIFIANT op=('+'|'-'|'*'|'/') '=' expression
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            $code = "\tPUSHG " + vi.address + "\n";
            $code += $expression.code;
            $code += evalOperation($op.text) + "\n";
            $code += "\tSTOREG " + vi.address + "\n";
        }
    ;

ioDeclaration returns [ String code ]
    : 'input' '(' IDENTIFIANT ')' finInstruction
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            $code = "\tREAD \n";
            $code += "\tSTOREG " + vi.address + "\n";
        }
    | 'print' '(' expression ')' finInstruction
        {
            $code = $expression.code;
            $code += "\tWRITE \n";
            $code += "\tPOP \n";
        }
    ;

bloc returns [ String code ]  @init{ $code = new String(); } 
    : '{'
        (instruction { $code += $instruction.code; })*  
      '}'  
      NEWLINE*
    | instruction { $code += $instruction.code; }
    ;

condition returns [String code]
    : 'true'  { $code = "\tPUSHI 1\n"; }
    | 'false' { $code = "\tPUSHI 0\n"; }
    | left=expression op=('=='|'!='|'<'|'<='|'>'|'>=') right=expression
        {
            $code = $left.code + $right.code;
            switch ($op.text) {
                case "==": $code += "\tEQUAL\n"; break;
                case "!=": $code += "\tNEQ\n"; break;
                case "<": $code += "\tINF\n"; break;
                case "<=": $code += "\tINFEQ\n"; break;
                case ">": $code += "\tSUP\n"; break;
                case ">=": $code += "\tSUPEQ\n"; break;
            }
        }
    ;

expressionLogique returns [ String code ]
    : condition { $code = $condition.code; }
    | '!' expressionLogique 
        {
            $code = $expressionLogique.code;
            $code += "\tPUSHI 1\n";
            $code += "\tSUB\n";
        }
    | expressionLogique1=expressionLogique '&&' expressionLogique2=expressionLogique
        {
            $code = $expressionLogique1.code + $expressionLogique2.code;
            $code += "\tMUL\n";
        }
    | expressionLogique1=expressionLogique '||' expressionLogique2=expressionLogique
        {
            $code = $expressionLogique1.code + $expressionLogique2.code;
            $code += "\tADD\n";
        }
    ;

boucle returns [ String code ]
    : 'while' '(' expressionLogique ')' bloc
        {
            String labelBoucle = getNewLabel();
            String labelFin = getNewLabel();
            $code = "LABEL " + labelBoucle + "\n";
            $code += $expressionLogique.code;
            $code += "\tJUMPF " + labelFin + "\n";
            $code += $bloc.code;
            $code += "\tJUMP " + labelBoucle + "\n";
            $code += "LABEL " + labelFin + "\n";
        }
    | 'for' '(' assignation1=assignation ';' condition ';' assignation2=assignation ')' bloc
        {
            String labelBoucle = getNewLabel();
            String labelFin = getNewLabel();
            $code = $assignation1.code;
            $code += "LABEL " + labelBoucle + "\n";
            $code += $condition.code;
            $code += "\tJUMPF " + labelFin + "\n";
            $code += $bloc.code;
            $code += $assignation2.code;
            $code += "\tJUMP " + labelBoucle + "\n";
            $code += "LABEL " + labelFin + "\n";
        }
    ;

conditionIf returns [ String code ] @init{ $code = new String(); } 
    : 'if' '(' expressionLogique ')' bloc1=bloc 'else' bloc2=bloc
        {
            String labelFinIf = getNewLabel();
            String labelFinElse = getNewLabel();
            $code += $expressionLogique.code;
            $code += "\tJUMPF " + labelFinIf + "\n";
            $code += $bloc1.code;
            $code += "\tJUMP " + labelFinElse + "\n";
            $code += "LABEL " + labelFinIf + "\n";
            $code += $bloc2.code;
            $code += "LABEL " + labelFinElse + "\n";
        }
    | 'if' '(' expressionLogique ')' bloc
        {
            String labelFin = getNewLabel();
            $code += $expressionLogique.code;
            $code += "\tJUMPF " + labelFin + "\n";
            $code += $bloc.code;
            $code += "LABEL " + labelFin + "\n";
        }
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