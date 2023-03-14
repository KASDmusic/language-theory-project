# language-theory-project (v.1)
A language theory project which convert mathematical expressions into an "assembler like" language named "MVaP". 

## Arborescence d'exemple de structure :

```
.
├── dist
│   ├── cbap
│   │   ├── 3n+2.mvap.cbap
│   │   ├── add.mvap.cbap
│   │   └── test.mvap.cbap
│   ├── class
│   │   ├── CalcToMvap
│   │   │   ├── CalcToMvapBaseListener.class
│   │   │   ├── CalcToMvap.g4
│   │   │   ├── CalcToMvapLexer.class
│   │   │   ├── CalcToMvapListener.class
│   │   │   ├── CalcToMvapParser$AssignationContext.class
│   │   │   ├── CalcToMvapParser$BlocContext.class
│   │   │   ├── CalcToMvapParser$BoucleContext.class
│   │   │   ├── CalcToMvapParser$BoucleWhileContext.class
│   │   │   ├── CalcToMvapParser$CalculContext.class
│   │   │   ├── CalcToMvapParser$ConditionContext.class
│   │   │   ├── CalcToMvapParser$ConditionIfContext.class
│   │   │   ├── CalcToMvapParser$DeclContext.class
│   │   │   ├── CalcToMvapParser$ExpressionContext.class
│   │   │   ├── CalcToMvapParser$ExpressionLogiqueContext.class
│   │   │   ├── CalcToMvapParser$FinInstructionContext.class
│   │   │   ├── CalcToMvapParser$InstructionContext.class
│   │   │   ├── CalcToMvapParser$IoDeclarationContext.class
│   │   │   ├── CalcToMvapParser$StartContext.class
│   │   │   ├── CalcToMvapParser.class
│   │   │   ├── TableSimple.class
│   │   │   ├── TablesSymboles.class
│   │   │   ├── VariableInfo$Scope.class
│   │   │   └── VariableInfo.class
│   ├── Compil
│   │   └── Compil-03-14-14:51:32
│   │       ├── CalcToMvapBaseListener.class
│   │       ├── CalcToMvapBaseListener.java
│   │       ├── CalcToMvap.g4
│   │       ├── CalcToMvap.interp
│   │       ├── CalcToMvapLexer.class
│   │       ├── CalcToMvapLexer.interp
│   │       ├── CalcToMvapLexer.java
│   │       ├── CalcToMvapLexer.tokens
│   │       ├── CalcToMvapListener.class
│   │       ├── CalcToMvapListener.java
│   │       ├── CalcToMvapParser$AssignationContext.class
│   │       ├── CalcToMvapParser$BlocContext.class
│   │       ├── CalcToMvapParser$BoucleContext.class
│   │       ├── CalcToMvapParser$CalculContext.class
│   │       ├── CalcToMvapParser$ConditionContext.class
│   │       ├── CalcToMvapParser$ConditionIfContext.class
│   │       ├── CalcToMvapParser$DeclContext.class
│   │       ├── CalcToMvapParser$ExpressionContext.class
│   │       ├── CalcToMvapParser$ExpressionLogiqueContext.class
│   │       ├── CalcToMvapParser$FinInstructionContext.class
│   │       ├── CalcToMvapParser$InstructionContext.class
│   │       ├── CalcToMvapParser$IoDeclarationContext.class
│   │       ├── CalcToMvapParser$StartContext.class
│   │       ├── CalcToMvapParser.class
│   │       ├── CalcToMvapParser.java
│   │       ├── CalcToMvap.tokens
│   │       ├── D00test.ass.log
│   │       ├── D00test.comp.log
│   │       ├── D00test.mvap
│   │       ├── D00test.mvap.cbap
│   │       ├── D00test.res
│   │       ├── D00test.run.log
│   │       ├── D01test.ass.log
│   │       ├── D01test.comp.log
│   │       ├── D01test.mvap
│   │       ├── D01test.mvap.cbap
│   │       ├── D01test.res.read0
│   │       ├── D01test.res.read1
│   │       ├── D01test.run.log.read0
│   │       ├── D01test.run.log.read1
│   │       ├── TableSimple.class
│   │       ├── TableSimple.java
│   │       ├── TablesSymboles.class
│   │       ├── TablesSymboles.java
│   │       ├── unit
│   │       │   ├── AutoCor.sh
│   │       │   ├── calcs
│   │       │   │   ├── D00test.code
│   │       │   │   └── D01test.code
│   │       │   ├── reads
│   │       │   │   ├── D01test.read0
│   │       │   │   └── D01test.read1
│   │       │   └── writes
│   │       │       ├── D00test.res
│   │       │       ├── D01test.res.read0
│   │       │       └── D01test.res.read1
│   │       ├── VariableInfo$Scope.class
│   │       ├── VariableInfo.class
│   │       └── VariableInfo.java
│   └── grammars
│       ├── CalcToMvap
│       │   ├── CalcToMvapBaseListener.class
│       │   ├── CalcToMvapBaseListener.java
│       │   ├── CalcToMvap.g4
│       │   ├── CalcToMvap.interp
│       │   ├── CalcToMvapLexer.class
│       │   ├── CalcToMvapLexer.interp
│       │   ├── CalcToMvapLexer.java
│       │   ├── CalcToMvapLexer.tokens
│       │   ├── CalcToMvapListener.class
│       │   ├── CalcToMvapListener.java
│       │   ├── CalcToMvapParser$AssignationContext.class
│       │   ├── CalcToMvapParser$BlocContext.class
│       │   ├── CalcToMvapParser$BoucleWhileContext.class
│       │   ├── CalcToMvapParser$CalculContext.class
│       │   ├── CalcToMvapParser$ConditionContext.class
│       │   ├── CalcToMvapParser$DeclContext.class
│       │   ├── CalcToMvapParser$ExpressionContext.class
│       │   ├── CalcToMvapParser$FinInstructionContext.class
│       │   ├── CalcToMvapParser$InstructionContext.class
│       │   ├── CalcToMvapParser$IoDeclarationContext.class
│       │   ├── CalcToMvapParser$StartContext.class
│       │   ├── CalcToMvapParser.class
│       │   ├── CalcToMvapParser.java
│       │   ├── CalcToMvap.tokens
│       │   ├── TableSimple.class
│       │   ├── TableSimple.java
│       │   ├── TablesSymboles.class
│       │   ├── TablesSymboles.java
│       │   ├── VariableInfo$Scope.class
│       │   ├── VariableInfo.class
│       │   └── VariableInfo.java
├── exec.bash
├── lib
│   ├── antlr-4.12.0-complete.jar
│   ├── MVaP.jar
│   └── sources-MVaP-3.1
├── README.md
├── src
│   ├── CalcToMvap
│   │   ├── CalcToMvap.g4
│   │   ├── TableSimple.java
│   │   ├── TablesSymboles.java
│   │   └── VariableInfo.java
├── tempExec.sh
└── unit
    ├── AutoCor.sh
    ├── calcs
    │   ├── D00test.code
    │   └── D01test.code
    ├── reads
    │   ├── D01test.read0
    │   └── D01test.read1
    ├── script.py
    └── writes
        ├── D00test.res
        ├── D01test.res.read0
        └── D01test.res.read1
```
  
## Commandes :

### Legende :


```
[] : paramètre obligatoire
() : paramètre optionnel
'' : not a variable, literraly what it is written
```
### HELP :

```bash
bash exec.sh (param) (param) ... --help
```

### ANTLR :

```bash
#Création d'une grammaire
bash exec.sh antlr create [path_to_grammar_g4_file] ('-d')

#Compilation d'une grammaire
bash exec.sh antlr compile [path_to_grammar_folder] ('-d')

#Création et compilation d'une grammaire et avec option -d par défaut
bash exec.sh antlr createCompile [path_to_grammar_g4_file]

#Création, compilation et test d'une grammaire et avec option -d par défaut
bash exec.sh antlr createCompileTest [path_to_grammar_g4_file] [axiome] ('-gui')

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

### Tests Unitaires :

```bash
#Lancement des tests unitaires fournis par default
bash exec.sh unit test [path_to_grammar_g4_file] (fichier_supplementaire_1) (fichier_supplementaire_2) ... (fichier_supplementaire_n)

#Suppression des fichiers temporaires de compilation situés dans dist/Compil :
bash exec.sh unit clear
```
