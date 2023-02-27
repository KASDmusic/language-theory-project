lexer grammar JetonsJava;

//~('\n'|'\r')*

Commentaire
    : ('//'.*?('\n')  | '/*' .*? '*/')
        { System.out.print("[commentaire : "+getText()+" ]"); }
    ;

OPERATEUR
    : '<'|'<='|'>'|'>='|'=='|'!='
        { System.out.print("[opérateur : "+getText()+" ]"); }
    ;

MOTCLE
    :  ('break' | 'class' | 'double' | 'else' | 'if' | 'import' | 'public' | 'static' | 'throws')
        { System.out.print("[motclé : "+getText()+" ]"); }
    ;

NOMBRE
    : ('0'..'9')+
        { System.out.print("[nombre : "+getText()+" ]"); }
    ;

IDENTIFIANT
    :   ('a'..'z' | 'A'..'Z' | '_')('a'..'z' | 'A'..'Z' | '_' | '0'..'9')*
        { System.out.print("[identifiant : "+getText()+" ]"); }
    ;

WHITE_SPACE
    : (' '|'\n'|'\t'|'\r')+
        { System.out.print(getText()); }
    ;

UNMATCH
    : . 
        { System.out.print(getText()); }
    ;