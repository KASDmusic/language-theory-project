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
        $code += "\tJUMP " + "Main" + "\n";
      }

      (fonction { $code += $fonction.code; })*
      NEWLINE*

      { $code += "LABEL Main" + "\n"; }

      (instruction { $code += $instruction.code; })*

      { $code += "\tHALT\n"; }
    ;

instruction returns [ String code ]
    : ioDeclaration { $code = $ioDeclaration.code; }
    | boucle { $code = $boucle.code; }
    | conditionIf { $code = $conditionIf.code; }
    | assignation finInstruction { $code = $assignation.code; }
    | RETURN expression finInstruction 
        { 
            VariableInfo vi = tablesSymboles.getReturn();
            $code = $expression.code;

            if((vi.type.equals("int") || vi.type.equals("bool")) && $expression.type.equals("double"))
                $code += "\tFTOI\n";
            
            if(vi.type.equals("double") && ($expression.type.equals("int") || $expression.type.equals("bool")))
                $code += "\tITOF\n";

            if(vi.type.equals("double"))
                $code += "\tSTOREL " + (vi.address+1) + "\n";

            $code += "\tSTOREL " + vi.address + "\n";

            $code += "\tRETURN\n";
        }
    | expression finInstruction { $code = $expression.code; }
    ;

expression returns [ String code, String type ]
    : '(' TYPE ')' expression 
        { 
            $type = $TYPE.text;
            $code = $expression.code;

                if(($TYPE.text.equals("int") || $TYPE.text.equals("bool")) && $expression.type.equals("double"))
                    $code += "\tFTOI\n";
                if($TYPE.text.equals("double") && ($expression.type.equals("int") || $expression.type.equals("bool")))
                    $code += "\tITOF\n";
        }
    |'-' expression 
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
                if($left.type.equals("int") || $left.type.equals("bool"))
                {
                    System.err.println("Warning : conversion " + $left.type + " -> double");
                    $code = $left.code + "\tITOF\n" + $right.code;
                }
                else
                {
                    System.err.println("Warning : conversion " + $right.type + " -> double");
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
                if($left.type.equals("int")  || $left.type.equals("bool"))
                {
                    System.err.println("Warning : conversion " + $left.type + " -> double");
                    $code = $left.code + "\tITOF\n" + $right.code;
                }
                else
                {
                    System.err.println("Warning : conversion " + $right.type + " -> double");
                    $code = $left.code + $right.code + "\tITOF\n";
                }   
            }  

            $code += evalOperation($op.text, $type) + "\n"; 
        }
    | IDENTIFIANT '(' args ')'
        {
            $type = tablesSymboles.getFunction($IDENTIFIANT.text);
            
            if($type.equals("int") || $type.equals("bool"))
                $code = "\tPUSHI 0\n";
            else if($type.equals("double"))
                $code = "\tPUSHF 0.\n";
            else
                $code = "";

            $code += $args.code;
            $code += "\tCALL " + $IDENTIFIANT.text + "\n";

            for(int i = 0; i < $args.size; i++)
            {
                $code += "\tPOP\n";
            }
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
            String command;
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);

            $type = vi.type;
            
            if(vi.scope.equals(VariableInfo.Scope.PARAM) || vi.scope.equals(VariableInfo.Scope.LOCAL))
            {
                command = "\tPUSHL ";
            }
            else
            {
                command = "\tPUSHG ";
            }

            if(vi.type.equals("int"))
            {
                $code = command + tablesSymboles.getVar($IDENTIFIANT.text).address + "\n"; 
            }

            if(vi.type.equals("bool"))
            {
                $code = command + tablesSymboles.getVar($IDENTIFIANT.text).address + "\n"; 
            }
            
            if(vi.type.equals("double"))
            {
                $code = command + (tablesSymboles.getVar($IDENTIFIANT.text).address) + "\n";
                $code += command + (tablesSymboles.getVar($IDENTIFIANT.text).address+1) + "\n";
            }
            
        }
    ;

// init nécessaire à cause du ? final et donc args peut être vide (mais $args sera non null) 
args returns [ String code, int size] @init{ $code = new String(); $size = 0; }
    : ( expression
    {
        // code java pour première expression pour arg
        $size++;
        if($expression.type.equals("double"))
            $size++;

        $code += $expression.code;
    }
    ( ',' expression
    {
        // code java pour expression suivante pour arg
        $size++;
        if($expression.type.equals("double"))
            $size++;
            
        $code += $expression.code;
    }
    )*
      )?
    ;

params
    : (TYPE IDENTIFIANT
        {
            // code java gérant une variable locale (arg0)
            tablesSymboles.addParam($IDENTIFIANT.text, $TYPE.text);
        }
        ( ',' TYPE IDENTIFIANT
            {
                // code java gérant une variable locale (argi)
                tablesSymboles.addParam($IDENTIFIANT.text, $TYPE.text);
            }
        )*)?
    ;

fonction returns [ String code ]
@init { tablesSymboles.enterFunction(); }
@after { tablesSymboles.exitFunction(); }
    : type=(TYPE | 'void') IDENTIFIANT 
        {
            tablesSymboles.addFunction($IDENTIFIANT.text, $type.text);
            String label = $IDENTIFIANT.text;
            $code = "LABEL " + label + "\n";
	    }
        '(' params ')' NEWLINE* '{' NEWLINE*

        (decl { $code += $decl.code; } finInstruction)*

        NEWLINE*
        (instruction { $code += $instruction.code; })*

        '}' 

        { $code +=  "RETURN\n";  /* Return de sécurité */ }
        
      NEWLINE*
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

            if(!$TYPE.text.equals($expression.type))
            {
                System.err.println("Warning : conversion " + $expression.type + " -> " + $TYPE.text);
                if($TYPE.text.equals("int") && $expression.type.equals("double"))
                    $code += "\tFTOI\n";
                else
                    $code += "\tITOF\n";
            }
        }
    | TYPE IDENTIFIANT '=' expressionLogique
        {
            tablesSymboles.addVarDecl($IDENTIFIANT.text, $TYPE.text);
            $code = $expressionLogique.code;

            if(!$TYPE.text.equals("bool"))
            {
                System.err.println("Warning : conversion bool -> " + $TYPE.text);
                if($TYPE.text.equals("double"))
                    $code += "\tITOF\n";
            }
        }
    ;

assignation returns [ String code ]
    : IDENTIFIANT '=' expression
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            $code = $expression.code;

            if(!vi.type.equals($expression.type))
            {
                System.err.println("Warning : conversion " + $expression.type + " -> " + vi.type);
                if(vi.type.equals("int") && $expression.type.equals("double"))
                    $code += "\tFTOI\n";
                else
                    $code += "\tITOF\n";
            }

            String command;
            if(vi.scope.equals(VariableInfo.Scope.PARAM) || vi.scope.equals(VariableInfo.Scope.LOCAL))
            {
                command = "\tSTOREL ";
            }
            else
            {
                command = "\tSTOREG ";
            }

            if(vi.type.equals("double"))
                $code += command + (vi.address+1) + "\n";
            
            $code += command + vi.address + "\n";
        }
    | IDENTIFIANT '=' expressionLogique
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            $code = $expressionLogique.code;

            if(!vi.type.equals("bool"))
            {
                System.err.println("Warning : conversion bool -> " + vi.type);
                if(vi.type.equals("double"))
                    $code += "\tITOF\n";
            }

            String command;
            if(vi.scope.equals(VariableInfo.Scope.PARAM) || vi.scope.equals(VariableInfo.Scope.LOCAL))
            {
                command = "\tSTOREL ";
            }
            else
            {
                command = "\tSTOREG ";
            }

            $code += command + vi.address + "\n";
        }
    | IDENTIFIANT op=('+'|'-'|'*'|'/') '=' expression
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);

            String pushCommand;
            if(vi.scope.equals(VariableInfo.Scope.PARAM) || vi.scope.equals(VariableInfo.Scope.LOCAL))
            {
                pushCommand = "\tPUSHL ";
            }
            else
            {
                pushCommand = "\tPUSHG ";
            }

            $code = pushCommand + vi.address + "\n";
            
            if(vi.type.equals("double"))
                $code += pushCommand + (vi.address+1) + "\n";

            $code += $expression.code;

            if(!vi.type.equals($expression.type))
            {
                System.err.println("Warning : conversion " + $expression.type + " -> " + vi.type);
                if(vi.type.equals("int") && $expression.type.equals("double"))
                    $code += "\tFTOI\n";
                else
                    $code += "\tITOF\n";
            }

            $code += evalOperation($op.text, vi.type) + "\n";

            String command;
            if(vi.scope.equals(VariableInfo.Scope.PARAM) || vi.scope.equals(VariableInfo.Scope.LOCAL))
            {
                command = "\tSTOREL ";
            }
            else
            {
                command = "\tSTOREG ";
            }

            if(vi.type.equals("double"))
                $code += command + (vi.address+1) + "\n";
                
            $code += command + vi.address + "\n";
        }
    ;

ioDeclaration returns [ String code ]
    : 'input' '(' IDENTIFIANT ')' finInstruction
        {
            VariableInfo vi = tablesSymboles.getVar($IDENTIFIANT.text);
            if(vi.type.equals("int") || vi.type.equals("bool"))
            {
                String command;
                if(vi.scope.equals(VariableInfo.Scope.PARAM) || vi.scope.equals(VariableInfo.Scope.LOCAL))
                {
                    command = "\tSTOREL ";
                }
                else
                {
                    command = "\tSTOREG ";
                }

                $code = "\tREAD \n";
                $code += command + vi.address + "\n";
            }
            
            if(vi.type.equals("double"))
            {
                String command;
                if(vi.scope.equals(VariableInfo.Scope.PARAM) || vi.scope.equals(VariableInfo.Scope.LOCAL))
                {
                    command = "\tSTOREL ";
                }
                else
                {
                    command = "\tSTOREG ";
                }

                $code = "\tREADF \n";
                $code += command + (vi.address+1) + "\n";
                $code += command + vi.address + "\n";
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
            if($left.type.equals($right.type) && ($right.type.equals("int") || $right.type.equals("bool")))
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
                
                $code += $right.code;
                if($right.type.equals("int"))
                    $code += "\tITOF\n";
            }
            
            $code += evalOperation($op.text, type) + "\n";
        }
    | IDENTIFIANT 
        { 
            String command;
            if(tablesSymboles.getVar($IDENTIFIANT.text).scope.equals(VariableInfo.Scope.PARAM) || tablesSymboles.getVar($IDENTIFIANT.text).scope.equals(VariableInfo.Scope.LOCAL))
            {
                command = "\tPUSHL ";
            }
            else
            {
                command = "\tPUSHG ";
            }
            $code = command + tablesSymboles.getVar($IDENTIFIANT.text).address + "\n"; 
        }
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

RETURN: 'return' ;

IDENTIFIANT : ('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9')* ;

//Commentaires mono-ligne avec '%' et multi-ligne avec '/*' et '*/'
COMMENT : ('/*'.*?'*/'|('%'|'#').*?'\n') -> skip ;

NEWLINE : '\r'? '\n';

WS :   (' '|'\t')+ -> skip  ;

ENTIER : ('0'..'9')+  ;

DOUBLE : ('0'..'9')+ '.' ('0'..'9')* ;

BOOLEEN : 'true' | 'false' ;

UNMATCH : . -> skip ;

finInstruction : ( NEWLINE | ';' )+ ;