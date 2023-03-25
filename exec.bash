#!/bin/bash

#AUTHOR : Kenzo LECOINDRE

#Liste des taches

#Faire les verifications des bons parametres (extensions, etc)
#Vérifier les commentaires paramètres des fonctions 

#Fonction affichant le help
function help {
	echo ""
	echo "Arborescence d'exemple de structure :"
	echo ""
	echo "."
	echo "├── dist"
	echo "│   ├── cbap"
	echo "│   │   ├── 3n+2.mvap.cbap"
	echo "│   │   ├── add.mvap.cbap"
	echo "│   │   └── test.mvap.cbap"
	echo "│   ├── class"
	echo "│   │   ├── CalcToMvap"
	echo "│   │   │   ├── CalcToMvapBaseListener.class"
	echo "│   │   │   ├── CalcToMvap.g4"
	echo "│   │   │   ├── CalcToMvapLexer.class"
	echo "│   │   │   ├── CalcToMvapListener.class"
	echo "│   │   │   ├── CalcToMvapParser$AssignationContext.class"
	echo "│   │   │   ├── CalcToMvapParser$BlocContext.class"
	echo "│   │   │   ├── CalcToMvapParser$BoucleContext.class"
	echo "│   │   │   ├── CalcToMvapParser$BoucleWhileContext.class"
	echo "│   │   │   ├── CalcToMvapParser$CalculContext.class"
	echo "│   │   │   ├── CalcToMvapParser$ConditionContext.class"
	echo "│   │   │   ├── CalcToMvapParser$ConditionIfContext.class"
	echo "│   │   │   ├── CalcToMvapParser$DeclContext.class"
	echo "│   │   │   ├── CalcToMvapParser$ExpressionContext.class"
	echo "│   │   │   ├── CalcToMvapParser$ExpressionLogiqueContext.class"
	echo "│   │   │   ├── CalcToMvapParser$FinInstructionContext.class"
	echo "│   │   │   ├── CalcToMvapParser$InstructionContext.class"
	echo "│   │   │   ├── CalcToMvapParser$IoDeclarationContext.class"
	echo "│   │   │   ├── CalcToMvapParser$StartContext.class"
	echo "│   │   │   ├── CalcToMvapParser.class"
	echo "│   │   │   ├── TableSimple.class"
	echo "│   │   │   ├── TablesSymboles.class"
	echo "│   │   │   ├── VariableInfo$Scope.class"
	echo "│   │   │   └── VariableInfo.class"
	echo "│   ├── Compil"
	echo "│   │   └── Compil-03-14-14:51:32"
	echo "│   │       ├── CalcToMvapBaseListener.class"
	echo "│   │       ├── CalcToMvapBaseListener.java"
	echo "│   │       ├── CalcToMvap.g4"
	echo "│   │       ├── CalcToMvap.interp"
	echo "│   │       ├── CalcToMvapLexer.class"
	echo "│   │       ├── CalcToMvapLexer.interp"
	echo "│   │       ├── CalcToMvapLexer.java"
	echo "│   │       ├── CalcToMvapLexer.tokens"
	echo "│   │       ├── CalcToMvapListener.class"
	echo "│   │       ├── CalcToMvapListener.java"
	echo "│   │       ├── CalcToMvapParser$AssignationContext.class"
	echo "│   │       ├── CalcToMvapParser$BlocContext.class"
	echo "│   │       ├── CalcToMvapParser$BoucleContext.class"
	echo "│   │       ├── CalcToMvapParser$CalculContext.class"
	echo "│   │       ├── CalcToMvapParser$ConditionContext.class"
	echo "│   │       ├── CalcToMvapParser$ConditionIfContext.class"
	echo "│   │       ├── CalcToMvapParser$DeclContext.class"
	echo "│   │       ├── CalcToMvapParser$ExpressionContext.class"
	echo "│   │       ├── CalcToMvapParser$ExpressionLogiqueContext.class"
	echo "│   │       ├── CalcToMvapParser$FinInstructionContext.class"
	echo "│   │       ├── CalcToMvapParser$InstructionContext.class"
	echo "│   │       ├── CalcToMvapParser$IoDeclarationContext.class"
	echo "│   │       ├── CalcToMvapParser$StartContext.class"
	echo "│   │       ├── CalcToMvapParser.class"
	echo "│   │       ├── CalcToMvapParser.java"
	echo "│   │       ├── CalcToMvap.tokens"
	echo "│   │       ├── D00test.ass.log"
	echo "│   │       ├── D00test.comp.log"
	echo "│   │       ├── D00test.mvap"
	echo "│   │       ├── D00test.mvap.cbap"
	echo "│   │       ├── D00test.res"
	echo "│   │       ├── D00test.run.log"
	echo "│   │       ├── D01test.ass.log"
	echo "│   │       ├── D01test.comp.log"
	echo "│   │       ├── D01test.mvap"
	echo "│   │       ├── D01test.mvap.cbap"
	echo "│   │       ├── D01test.res.read0"
	echo "│   │       ├── D01test.res.read1"
	echo "│   │       ├── D01test.run.log.read0"
	echo "│   │       ├── D01test.run.log.read1"
	echo "│   │       ├── TableSimple.class"
	echo "│   │       ├── TableSimple.java"
	echo "│   │       ├── TablesSymboles.class"
	echo "│   │       ├── TablesSymboles.java"
	echo "│   │       ├── unit"
	echo "│   │       │   ├── AutoCor.sh"
	echo "│   │       │   ├── calcs"
	echo "│   │       │   │   ├── D00test.code"
	echo "│   │       │   │   └── D01test.code"
	echo "│   │       │   ├── reads"
	echo "│   │       │   │   ├── D01test.read0"
	echo "│   │       │   │   └── D01test.read1"
	echo "│   │       │   └── writes"
	echo "│   │       │       ├── D00test.res"
	echo "│   │       │       ├── D01test.res.read0"
	echo "│   │       │       └── D01test.res.read1"
	echo "│   │       ├── VariableInfo$Scope.class"
	echo "│   │       ├── VariableInfo.class"
	echo "│   │       └── VariableInfo.java"
	echo "│   └── grammars"
	echo "│       ├── CalcToMvap"
	echo "│       │   ├── CalcToMvapBaseListener.class"
	echo "│       │   ├── CalcToMvapBaseListener.java"
	echo "│       │   ├── CalcToMvap.g4"
	echo "│       │   ├── CalcToMvap.interp"
	echo "│       │   ├── CalcToMvapLexer.class"
	echo "│       │   ├── CalcToMvapLexer.interp"
	echo "│       │   ├── CalcToMvapLexer.java"
	echo "│       │   ├── CalcToMvapLexer.tokens"
	echo "│       │   ├── CalcToMvapListener.class"
	echo "│       │   ├── CalcToMvapListener.java"
	echo "│       │   ├── CalcToMvapParser$AssignationContext.class"
	echo "│       │   ├── CalcToMvapParser$BlocContext.class"
	echo "│       │   ├── CalcToMvapParser$BoucleWhileContext.class"
	echo "│       │   ├── CalcToMvapParser$CalculContext.class"
	echo "│       │   ├── CalcToMvapParser$ConditionContext.class"
	echo "│       │   ├── CalcToMvapParser$DeclContext.class"
	echo "│       │   ├── CalcToMvapParser$ExpressionContext.class"
	echo "│       │   ├── CalcToMvapParser$FinInstructionContext.class"
	echo "│       │   ├── CalcToMvapParser$InstructionContext.class"
	echo "│       │   ├── CalcToMvapParser$IoDeclarationContext.class"
	echo "│       │   ├── CalcToMvapParser$StartContext.class"
	echo "│       │   ├── CalcToMvapParser.class"
	echo "│       │   ├── CalcToMvapParser.java"
	echo "│       │   ├── CalcToMvap.tokens"
	echo "│       │   ├── TableSimple.class"
	echo "│       │   ├── TableSimple.java"
	echo "│       │   ├── TablesSymboles.class"
	echo "│       │   ├── TablesSymboles.java"
	echo "│       │   ├── VariableInfo$Scope.class"
	echo "│       │   ├── VariableInfo.class"
	echo "│       │   └── VariableInfo.java"
	echo "├── exec.bash"
	echo "├── lib"
	echo "│   ├── antlr-4.12.0-complete.jar"
	echo "│   ├── MVaP.jar"
	echo "│   └── sources-MVaP-3.1"
	echo "├── README.md"
	echo "├── src"
	echo "│   ├── CalcToMvap"
	echo "│   │   ├── CalcToMvap.g4"
	echo "│   │   ├── TableSimple.java"
	echo "│   │   ├── TablesSymboles.java"
	echo "│   │   └── VariableInfo.java"
	echo "├── tempExec.sh"
	echo "└── unit"
	echo "    ├── AutoCor.sh"
	echo "    ├── calcs"
	echo "    │   ├── D00test.code"
	echo "    │   └── D01test.code"
	echo "    ├── reads"
	echo "    │   ├── D01test.read0"
	echo "    │   └── D01test.read1"
	echo "    ├── script.py"
	echo "    └── writes"
	echo "        ├── D00test.res"
	echo "        ├── D01test.res.read0"
	echo "        └── D01test.res.read1"

	echo ""
	echo ""
	echo "COMMANDES :"
	echo ""
	echo ""

	echo "Legende :"
	echo ""
	echo "[] : paramètre obligatoire"
	echo "() : paramètre optionnel"
	echo "'' : not a variable, literraly what it is written"
	echo ""
	echo ""
	echo "HELP :"
	echo ""
	echo "bash exec.sh (param) (param) ... --help"
	echo ""
	echo ""
	echo "ANTLR :"
	echo ""
	echo "#Création d'une grammaire"
	echo "bash exec.sh antlr create [path_to_grammar_g4_file] ('-d')"
	echo ""
	echo "#Compilation d'une grammaire"
	echo "bash exec.sh antlr compile [path_to_grammar_folder] ('-d')"
	echo ""
	echo "#Test d'une grammaire"
	echo "bash exec.sh antlr test [path_to_grammar_g4_file_with_.class_files] [axiome] ('-gui')"
	echo ""
	echo "#Création et compilation d'une grammaire et avec option -d par défaut"
	echo "bash exec.sh antlr createCompile [path_to_grammar_g4_file]"
	echo ""
	echo "#Création, compilation et test d'une grammaire et avec option -d par défaut"
	echo "bash exec.sh antlr createCompileTest [path_to_grammar_g4_file] [axiome] ('-gui')"
	echo ""
	echo ""
	echo "MVàP :"
	echo ""
	echo "#Execution d'un code MVàP avec debugage pour la compilation et l'execution"
	echo "bash exec.sh mvap execute [path_to_mvap_file] ('true') ('true')"
	echo ""
	echo "#Execution d'un code MVàP avec debugage pour l'execution"
	echo "bash exec.sh mvap execute [path_to_mvap_file] (.+) ('true')"
	echo ""
	echo ""
	echo "Tests Unitaires :"
	echo ""
	echo "#Lancement des tests unitaires fournis par default"
	echo "bash exec.sh unit test [path_to_grammar_g4_file] (fichier_supplementaire_1) (fichier_supplementaire_2) ... (fichier_supplementaire_n)"
	echo ""
	echo "#Suppression des fichiers temporaires de compilation situés dans dist/Compil :"
	echo "bash exec.sh unit clear"
	echo ""
}

#Fonction executant le code MVaP
#parametre : 
# $1 = chemin du fichier contenant le code MVaP (.mvap)
# $2 = true si trace pour le build
# $3 = true si trace pour l'execution
function executeMVaP {
	if [[ "$2" == "true" ]];
	then
		java -cp "lib/*" MVaPAssembler -d $1
	else
		java -cp "lib/*" MVaPAssembler $1
	fi
	
	#Prends le nom du fichier sans le chemin
	fileName=${1##*/}

	mkdir dist 2> /dev/null
	mkdir dist/cbap 2> /dev/null

	mv $1.cbap dist/cbap

	if [[ "$3" == "true" ]];
	then
		java -cp "lib/*" CBaP -d dist/cbap/$fileName.cbap
	else
		java -cp "lib/*" CBaP dist/cbap/$fileName.cbap
	fi
}

#Fonction créant la grammaire
#parametre :
# $1 = fichier .g4 de la grammaire
# $2 = -d pour déplacer les fichiers dans le dossier de la grammaire
function createGrammar {

	#Prends le nom du fichier sans l'extension et sans le chemin
	grammarName=${1##*/}
	grammarName=${grammarName%.*}

	#Prends le chemin du fichier sans le nom du fichier
	grammarPath=${1%/*}

	#Si il y a -d, copie tout les fichier du dossier de la grammaire dans un dossier temporaire
	if [[ "$2" == "-d" ]];
	then
		mkdir $grammarPath/temp 2> /dev/null
		
		cp $grammarPath/*.* $grammarPath/temp
	fi

	#Créé la grammaire
	java -cp "lib/*" org.antlr.v4.Tool $1

	#Si il y a -d :
	#liste tout les fichier commençant par le nom de la grammaire et ne finissant pas par .g4 et les déplace dans le dossier de la grammaire
	if [[ "$2" == "-d" ]];
	then
		#Créé le dossier de la grammaire
		mkdir dist 2> /dev/null
		mkdir dist/grammars 2> /dev/null
		mkdir dist/grammars/$grammarName 2> /dev/null

		#Déplace les fichiers
		mv $grammarPath/*.* dist/grammars/$grammarName
		mv $grammarPath/temp/* $grammarPath
		rmdir $grammarPath/temp
	fi
}

#Fonction compilant la grammaire
#parametre :
# $1 = chemin du repertoire de la grammaire contenant les fichiers .java
# $2 = -d pour déplacer les fichiers dans le dossier de la grammaire
function compileGrammar {

	#Prends le chemin et enlever un / à la fin si il y en a un
	if [[ "$1" != */ ]];
	then
		grammarPath=$1
	else
		grammarPath=${1%?}
	fi

	#Prends le nom du dernier repertoire
	grammarName=${grammarPath##*/}

	#Compile la grammaire
	if [[ "$2" == "-d" ]];
	then
		mkdir dist 2> /dev/null
		mkdir dist/class 2> /dev/null
		mkdir dist/class/$grammarName 2> /dev/null

		javac -cp "lib/*" -d dist/class/$grammarName/ $1/*.java
		cp $1/$grammarName*.g4 dist/class/$grammarName
	else
		javac -cp "lib/*" $1/$grammarName*.java
	fi
}

#Fonction permettant le test de la grammaire
#parametre :
# $1 = chemin du fichier contenant la grammaire (.g4)
# $2 = axiome de départ
# $3 = -gui pour l'interface graphique
function testGrammar {

	#Prends le chemin du fichier sans le nom du fichier
	grammarPath=${1%/*}

	#Prends le nom du fichier sans l'extension et sans le chemin
	grammarName=${1##*/}
	grammarName=${grammarName%.*}	

	classpath="dist/class/$grammarName"

	if [[ "$3" == "-gui" ]];
	then
		java -cp "$classpath:lib/*" org.antlr.v4.runtime.misc.TestRig $grammarName "$2" $3
	else
		java -cp "$classpath:lib/*" org.antlr.v4.runtime.misc.TestRig $grammarName "$2"
	fi
}

#Fonction permettant de créer et compiler une grammaire
#parametre :
# $1 = chemin du fichier contenant la grammaire (.g4)
function createCompileGrammar {
	createGrammar $1 -d
	
	#Prends le nom du fichier sans l'extension et sans le chemin
	grammarName=${1##*/}
	grammarName=${grammarName%.*}

	compileGrammar dist/grammars/$grammarName -d
}

#Fonction permettant de créer et compiler une grammaire
#parametre :
# $1 = chemin du fichier contenant la grammaire (.g4)
# $2 = axiome de départ
# $3 = -gui pour l'interface graphique
function createCompileTestGrammar {
	createCompileGrammar $1
	testGrammar $1 $2 $3
}

#Fonction permettant de lancer les tests unitaires
#Cette fonction prend en parametre le chemin du fichier contenant la grammaire (.g4)
#et copie tout les fichiers du dossier de la grammaire dans un dossier temporaire
#puis lance les tests unitaires
#parametre :
# $1 = chemin du fichier contenant la grammaire (.g4)
function unitTest {
	#https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script

	#Prends le chemin du fichier sans le nom du fichier
	grammarPath=${1%/*}
	echo $grammarPath
	
	LANG=fr_FR.ASCII bash unit/AutoCor.sh $1 $grammarPath/*
	
}


#Main

if [[ "$1" == "--help" ]] || [[ "$1" == "-help" ]];
then
	help

elif [[ "$1" == "mvap" ]];
then
	if [[ "$2" == "execute" ]] && [ "$#" -eq 5 ];
	then
		executeMVaP $3 $4 $5
	fi

elif [[ "$1" == "antlr" ]];
then
	if [[ "$2" == "create" ]] && [ "$#" -ge 3 ];
	then
		createGrammar $3 $4

	elif [[ "$2" == "compile" ]] && [ "$#" -ge 3 ]
	then
		compileGrammar $3 $4

	elif [[ "$2" == "createCompile" ]] && [ "$#" -ge 3 ]
	then
		createCompileGrammar $3

	elif [[ "$2" == "createCompileTest" ]] && [ "$#" -ge 4 ]
	then
		createCompileTestGrammar $3 $4 $5

	elif [[ "$2" == "test" ]] && [ "$#" -ge 4 ]
	then
		testGrammar $3 $4 $5
	
	else
		echo "Incorrect command : (--help to learn how to use the script)"
	fi

elif [[ "$1" == "unit" ]];
then
	if [[ "$2" == "test" ]] && [ "$#" -ge 3 ];
	then
		#prends les arguments à partir du 3eme
		shift 2
		unitTest $@
	
	elif [[ "$2" == "clear" ]];
	then
		rm -rf dist/Compil/*
	
	else
		echo "Incorrect command : (--help to learn how to use the script)"
	fi
else
	echo "Incorrect command : (--help to learn how to use the script)"
fi

#executeMVaP lib/sources-MVaP-3.1_1/add.mvap false false 

#createGrammar src/AnBn/AnBn.g4 -d
#compileGrammar dist/grammars/AnBn -d
#testGrammar dist/class/AnBn/AnBn.g4 anbn -gui

# --------------------------------------------------------------

#bash exec.bash unit test src/CalcToMvap/CalcToMvap.g4
#bash exec.bash antlr createCompileTest src/CalcToMvap/CalcToMvap.g4 start

