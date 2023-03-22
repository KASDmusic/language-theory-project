grammar CalcToMvap;

@parser::members {

    private int _cur_label = 1;
    /** générateur de nom d'étiquettes pour les boucles */
    private String getNewLabel() { return "Label" +(_cur_label++); }

    private TablesSymboles tablesSymboles = new TablesSymboles();

    private String evalOperation (String op, String type) 
    {
        String res = "\t";
        if(type.equals("double"))
            res+="F";

        switch (op) {
            case "*": return res + "MUL";
            case "/": return res + "DIV";
            case "+": return res + "ADD"; 
            case "-": return res + "SUB";

            case "==": return res + "EQUAL";
            case "!=": return res + "NEQ";
            case "<" : return res + "INF";
            case "<=": return res + "INFEQ";
            case ">" : return res + "SUP";
            case ">=": return res + "SUPEQ";
        }
        
        System.err.println("Opérateur arithmétique incorrect : '"+op+"'");
        throw new IllegalArgumentException("Opérateur arithmétique incorrect : '"+op+"'");
    }
}

start : calcul EOF ;

calcul returns [ String code ]
@init{ $code = new String(); }   // On initialise code, pour l'utiliser comme accumulateur 
@after{ System.out.println($code); } // On affiche l’ensemble du code produit

    : (decl { $code += $decl.code; } finInstruction)*
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
    ;

expression returns [ String code, String type ]
    : '-' expression 
        { 
            $code = $expression.code;
            
            if($expression.type.equals("int"))
                $code += "\tPUSHI -1\n"; 
            else
                $code += "\tPUSHF -1.\n";

            $code += evalOperation("*", $expression.type) + "\n";
            
            $type = $expression.type;
        }
    | '(' expression ')' 
        { 
            $code = $expression.code;
            $type = $expression.type;
        }
    | left=expression op=('*'|'/') right=expression 
        { 
            if($left.type.equals($right.type))
            {
                $type = $left.type;
                $code = $left.code + $right.code;
            }
            else
            {
                $type = "double";
                if($left.type.equals("int"))
                {
                    $code = $left.code + "\tITOF\n" + $right.code;
                }
                else
                {
                    $code = $left.code + $right.code + "\tITOF\n";
                }   
            }  

            $code += evalOperation($op.text, $type) + "\n"; 
        }
    | left=expression op=('+'|'-') right=expression 
        { 
            if($left.type.equals($right.type))
            {
                $type = $left.type;
                $code = $left.code + $right.code;
            }
            else
            {
                $type = "double";
                if($left.type.equals("int"))
                {
                    $code = $left.code + "\tITOF\n" + $right.code;
                }
                else
                {
                    $code = $left.code + $right.code + "\tITOF\n";
                }   
            }  

            $code += evalOperation($op.text, $type) + "\n"; 
        }
    | ENTIER 
        { 
            $type = "int";
            $code = "\tPUSHI "+ $ENTIER.text + "\n"; 
        }
    | DOUBLE 
        { 
            $type = "double";
            $code = "\tPUSHF "+ $DOUBLE.text+"\n"; 
        }
    | IDENTIFIANT 
        { 
            $code = "";
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);

            if(vi.type.equals("int"))
            {
                $type = "int";
                $code += "\tPUSHG " + tablesSymboles.getVar($IDENTIFIANT.text).address + "\n"; 
            }

            if(vi.type.equals("bool"))
            {
                $type = "bool";
                $code += "\tPUSHG " + tablesSymboles.getVar($IDENTIFIANT.text).address + "\n"; 
            }
            
            if(vi.type.equals("double"))
            {
                $type = "double";
                $code += "\tPUSHG " + (tablesSymboles.getVar($IDENTIFIANT.text).address) + "\n";
                $code += "\tPUSHG " + (tablesSymboles.getVar($IDENTIFIANT.text).address+1) + "\n";
            }
        }
    ;

decl returns [ String code ]
    : TYPE IDENTIFIANT
        {
            if($TYPE.text.equals("int")) {
                tablesSymboles.addVarDecl($IDENTIFIANT.text, $TYPE.text);
                $code = "\tPUSHI 0\n";
            }

            if($TYPE.text.equals("double")) {
                tablesSymboles.addVarDecl($IDENTIFIANT.text, $TYPE.text);
                $code = "\tPUSHF 0.\n";
            }

            if($TYPE.text.equals("bool")) {
                tablesSymboles.addVarDecl($IDENTIFIANT.text, $TYPE.text);
                $code = "\tPUSHI 0\n";
            }
        }
    | TYPE IDENTIFIANT '=' expression
        {
            tablesSymboles.addVarDecl($IDENTIFIANT.text, $TYPE.text);
            $code = $expression.code;
        }
    | TYPE IDENTIFIANT '=' expressionLogique
        {
            tablesSymboles.addVarDecl($IDENTIFIANT.text, $TYPE.text);
            $code = $expressionLogique.code;
        }
    ;

assignation returns [ String code ]
    : IDENTIFIANT '=' expression
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            $code = $expression.code;

            if(vi.type.equals("double"))
                $code += "\tSTOREG " + (vi.address+1) + "\n";
            
            $code += "\tSTOREG " + vi.address + "\n";
        }
    | IDENTIFIANT '=' expressionLogique
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            $code = $expressionLogique.code;
            $code += "\tSTOREG " + vi.address + "\n";
        }
    | IDENTIFIANT op=('+'|'-'|'*'|'/') '=' expression
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);

            $code = "\tPUSHG " + (vi.address) + "\n";
            
            if($expression.type.equals("double"))
                $code += "\tPUSHG " + (vi.address+1) + "\n";

            $code += $expression.code;
            $code += evalOperation($op.text, $expression.type) + "\n";

            if(vi.type.equals("double"))
                $code += "\tSTOREG " + (vi.address+1) + "\n";
                
            $code += "\tSTOREG " + vi.address + "\n";
        }
    ;

ioDeclaration returns [ String code ]
    : 'input' '(' IDENTIFIANT ')' finInstruction
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            if(vi.type.equals("int") || vi.type.equals("bool"))
            {
                $code = "\tREAD \n";
                $code += "\tSTOREG " + vi.address + "\n";
            }
            
            if(vi.type.equals("double"))
            {
                $code = "\tREADF \n";
                $code += "\tSTOREG " + (vi.address+1) + "\n";
                $code += "\tSTOREG " + vi.address + "\n";
            }
        }
    | 'print' '(' expression ')' finInstruction
        {
            $code = $expression.code;
            if($expression.type.equals("int") || $expression.type.equals("bool"))
                $code += "\tWRITE \n";
            else
            {
                $code += "\tWRITEF \n";
                $code += "\tPOP \n";
            }
                
            $code += "\tPOP \n";
        }
    | 'print' '(' expressionLogique ')' finInstruction
        {
            $code = $expressionLogique.code;
            $code += "\tWRITE \n";
            $code += "\tPOP \n";
        }
    ;

bloc returns [ String code ]
    : (WS | NEWLINE)* '{' (WS | NEWLINE)* { $code = ""; }
        (instruction { $code += $instruction.code; })*  
        (WS | NEWLINE)*
      '}' (WS | NEWLINE)*
    | instruction { $code = $instruction.code; }
    ;

condition returns [String code]
    : '!' condition 
        { 
            $code = $condition.code;
            $code += "\tPUSHI 1\n";
            $code += "\tSUB\n";
        }
    | '(' condition ')' { $code = $condition.code; }
    | left=expression op=('=='|'!='|'<'|'<='|'>'|'>=') right=expression
        {
            String type;
            if($left.type.equals("int") && $right.type.equals("int"))
            {
                type = "int";
                $code = $left.code + $right.code;
            }
            else
            {
                type = "double";

                $code = $left.code;
                if($left.type.equals("int"))
                    $code += "\tITOF\n";
                
                $code += $left.code;
                if($right.type.equals("int"))
                    $code += "\tITOF\n";
            }
            
            $code += evalOperation($op.text, type) + "\n";
        }
    | IDENTIFIANT { $code = "\tPUSHG " + tablesSymboles.getVar($IDENTIFIANT.text).address + "\n"; }
    | 'false' { $code = "\tPUSHI 0\n"; }
    | 'true'  { $code = "\tPUSHI 1\n"; }
    ;

expressionLogique returns [ String code ]
    : '!' expressionLogique 
        {
            $code = $expressionLogique.code;
            $code += "\tPUSHI 1\n";
            $code += "\tSUB\n";
        }
    | '(' expressionLogique ')' { $code = $expressionLogique.code; }
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
    | condition { $code = $condition.code; }
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

conditionIf returns [ String code ]
    : 'if' '(' expressionLogique ')' bloc1=bloc 'else' bloc2=bloc
        {
            String labelFinIf = getNewLabel();
            String labelFinElse = getNewLabel();
            $code = $expressionLogique.code;
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
            $code = $expressionLogique.code;
            $code += "\tJUMPF " + labelFin + "\n";
            $code += $bloc.code;
            $code += "LABEL " + labelFin + "\n";
        }
    ;

// lexer
TYPE : 'int' | 'double' | 'bool' ;

IDENTIFIANT : ('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9')* ;

//Commentaires mono-ligne avec '%' et multi-ligne avec '/*' et '*/'
COMMENT : ('/*'.*?'*/'|'%'.*?'\n') -> skip ;

NEWLINE : '\r'? '\n';

WS :   (' '|'\t')+ -> skip  ;

ENTIER : ('0'..'9')+  ;

DOUBLE : ('0'..'9')+ '.' ('0'..'9')* ;

BOOLEEN : 'true' | 'false' ;

UNMATCH : . -> skip ;

finInstruction : ( NEWLINE | ';' )+ ;