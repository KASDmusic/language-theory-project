# language-theory-project (v.1)
A language theory project which convert mathematical expressions into an "assembler like" language named "MVaP". 

## Arborescence d'exemple de structure :

```
 .
 ├── dist
 │   ├── cbap
 │   │   └── add.mvap.cbap
 │   ├── class
 │   │   ├── AnBn
 │   │   │   ├── AnBnBaseListener.class
 │   │   │   ├── AnBn.g4
 │   │   │   ├── AnBnLexer.class
 │   │   │   ├── AnBnListener.class
 │   │   │   ├── AnBnParser\$AnbnContext.class
 │   │   │   ├── AnBnParser\$FileContext.class
 │   │   │   └── AnBnParser.class
 │   │   └── MVaP
 │   │       ├── MVaPAssembler.class
 │   │       ├── MVaPAssemblerListener.class
 │   │       ├── MVaPBaseListener.class
 │   │       ├── MVaPLexer.class
 │   │       ├── MVaPListener.class
 │   │       ├── MVaPParser\$Commande1Context.class
 │   │       ├── MVaPParser\$Commande2Context.class
 │   │       ├── MVaPParser\$CommandeSautContext.class
 │   │       ├── MVaPParser\$Instr1Context.class
 │   │       ├── MVaPParser\$Instr2Context.class
 │   │       ├── MVaPParser\$Instr2fContext.class
 │   │       ├── MVaPParser\$InstrContext.class
 │   │       ├── MVaPParser\$LabelContext.class
 │   │       ├── MVaPParser\$ProgramContext.class
 │   │       ├── MVaPParser\$SautContext.class
 │   │       └── MVaPParser.class
 │   └── grammar
 │       ├── AnBn
 │       │   ├── AnBnBaseListener.java
 │       │   ├── AnBn.g4
 │       │   ├── AnBnLexer.java
 │       │   ├── AnBnLexer.tokens
 │       │   ├── AnBnListener.java
 │       │   ├── AnBnParser.java
 │       │   └── AnBn.tokens
 │       └── MVaP
 │           ├── MVaPAssembler.class
 │           ├── MVaPAssembler.java
 │           ├── MVaPAssemblerListener.java
 │           ├── MVaPBaseListener.java
 │           ├── MVaPLexer.java
 │           ├── MVaPLexer.tokens
 │           ├── MVaPListener.java
 │           ├── MVaPParser.java
 │           └── MVaP.tokens
 ├── lib
 │   ├── antlr-4.7.1-complete.jar
 │   └── MVaP.jar
 ├── README.md
 └── src
     ├── AnBn
     │   └── AnBn.g4
     └── MVaP
         └── MVaP.g4
```	 
	
  
## Commandes :

### Legende :


```
[] : paramètre obligatoire
() : paramètre optionnel
'' : not a variable, literraly what it is written
```

### ANTLR :

```bash
#Création d'une grammaire
bash exec.sh antlr create [path_to_grammar_g4_file] ('-d')

#Compilation d'une grammaire
bash exec.sh antlr compile [path_to_grammar_folder] ('-d')

#Création et compilation d'une grammaire et avec option -d par défaut
bash exec.sh antlr createCompile [path_to_grammar_g4_file]

#Execution d'une grammaire
bash exec.sh antlr test [path_to_grammar_g4_file_with_.class_files] [axiome] ('-gui')
```


### MVàP :

```bash
#Execution d'un code MVaP avec debugage pour la compilation et l'execution
bash exec.sh mvap execute [path_to_mvap_file] ('true') ('true')

#Execution d'un code MVaP avec debugage pour l'execution
bash exec.sh mvap execute [path_to_mvap_file] (.+) ('true')
```
