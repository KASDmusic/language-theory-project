# language-theory-project (v.3)
A language theory project which convert mathematical expressions into an "assembler like" language named "MVaP". 
  
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

#Test d'une grammaire
bash exec.sh antlr test [path_to_grammar_g4_file_with_.class_files] [axiome] ('-gui')

#Création et compilation d'une grammaire et avec option -d par défaut
bash exec.sh antlr createCompile [path_to_grammar_g4_file]

#Création, compilation et test d'une grammaire et avec option -d par défaut
bash exec.sh antlr createCompileTest [path_to_grammar_g4_file] [axiome] ('-gui')
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
