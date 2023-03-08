#!/bin/bash

#Liste des taches

#Faire les verifications des bons parametres (extensions, etc)
#Vérifier les commentaires paramètres des fonctions 

#Fonction affichant le help
function help {
	echo ""
	echo "Arborescence d'exemple de structure :"
	echo "."
	echo "├── dist"
	echo "│   ├── cbap"
	echo "│   │   └── add.mvap.cbap"
	echo "│   ├── class"
	echo "│   │   ├── AnBn"
	echo "│   │   │   ├── AnBnBaseListener.class"
	echo "│   │   │   ├── AnBn.g4"
	echo "│   │   │   ├── AnBnLexer.class"
	echo "│   │   │   ├── AnBnListener.class"
	echo "│   │   │   ├── AnBnParser\$AnbnContext.class"
	echo "│   │   │   ├── AnBnParser\$FileContext.class"
	echo "│   │   │   └── AnBnParser.class"
	echo "│   │   └── MVaP"
	echo "│   │       ├── MVaPAssembler.class"
	echo "│   │       ├── MVaPAssemblerListener.class"
	echo "│   │       ├── MVaPBaseListener.class"
	echo "│   │       ├── MVaPLexer.class"
	echo "│   │       ├── MVaPListener.class"
	echo "│   │       ├── MVaPParser\$Commande1Context.class"
	echo "│   │       ├── MVaPParser\$Commande2Context.class"
	echo "│   │       ├── MVaPParser\$CommandeSautContext.class"
	echo "│   │       ├── MVaPParser\$Instr1Context.class"
	echo "│   │       ├── MVaPParser\$Instr2Context.class"
	echo "│   │       ├── MVaPParser\$Instr2fContext.class"
	echo "│   │       ├── MVaPParser\$InstrContext.class"
	echo "│   │       ├── MVaPParser\$LabelContext.class"
	echo "│   │       ├── MVaPParser\$ProgramContext.class"
	echo "│   │       ├── MVaPParser\$SautContext.class"
	echo "│   │       └── MVaPParser.class"
	echo "│   └── grammar"
	echo "│       ├── AnBn"
	echo "│       │   ├── AnBnBaseListener.java"
	echo "│       │	   ├── AnBn.g4"
	echo "│       │   ├── AnBnLexer.java"
	echo "│       │   ├── AnBnLexer.tokens"
	echo "│       │   ├── AnBnListener.java"
	echo "│       │   ├── AnBnParser.java"
	echo "│       │   └── AnBn.tokens"
	echo "│       └── MVaP"
	echo "│           ├── MVaPAssembler.class"
	echo "│           ├── MVaPAssembler.java"
	echo "│           ├── MVaPAssemblerListener.java"
	echo "│           ├── MVaPBaseListener.java"
	echo "│           ├── MVaPLexer.java"
	echo "│           ├── MVaPLexer.tokens"
	echo "│           ├── MVaPListener.java"
	echo "│           ├── MVaPParser.java"
	echo "│           └── MVaP.tokens"
	echo "├── lib"
	echo "│   ├── antlr-4.7.1-complete.jar"
	echo "│   └── MVaP.jar"
	echo "├── README.md"
	echo "└── src"
	echo "    ├── AnBn"
	echo "    │   └── AnBn.g4"
	echo "    └── MVaP"
	echo "        └── MVaP.g4"
	echo ""
	echo ""
	echo "Legende :"
	echo "[] : parametre obligatoire"
	echo "() : parametre optionnel"
	echo "'' : not a variable, literraly what it is written"
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
	echo "#Création et compilation d'une grammaire et avec option -d par défaut"
	echo "bash exec.sh antlr createCompile [path_to_grammar_g4_file]"
	echo ""
	echo "#Execution d'une grammaire"
	echo "bash exec.sh antlr test [path_to_grammar_g4_file_with_.class_files] [axiome] ('-gui')"
	echo ""
	echo ""
	echo "MVaP :"
	echo ""
	echo "#Execution d'un code MVaP avec debugage pour la compilation et l'execution"
	echo "bash exec.sh mvap execute [path_to_mvap_file] ('true') ('true')"
	echo ""
	echo "#Execution d'un code MVaP avec debugage pour l'execution"
	echo "bash exec.sh mvap execute [path_to_mvap_file] (.+) ('true')"
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

	if [[ "$3" == "-gui" ]];
	then
		java -cp "$grammarPath:lib/*" org.antlr.v4.runtime.misc.TestRig $grammarName "$2" $3
	else
		java -cp "$grammarPath:lib/*" org.antlr.v4.runtime.misc.TestRig $grammarName "$2"
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
	echo $grammarName

	compileGrammar dist/grammars/$grammarName -d
}

#Main

isCorrectCommand="false"

if [[ "$1" == "--help" ]] || [[ "$1" == "-help" ]]
then
	help
	isCorrectCommand="true"
fi

if [[ "$1" == "mvap" ]]
then
	if [[ "$2" == "execute" ]] && [ "$#" -eq 5 ]
	then
		executeMVaP $3 $4 $5
		isCorrectCommand="true"
	fi
fi

if [[ "$1" == "antlr" ]]
then
	if [[ "$2" == "create" ]] && [ "$#" -ge 3 ]
	then
		createGrammar $3 $4
		isCorrectCommand="true"
	fi

	if [[ "$2" == "compile" ]] && [ "$#" -ge 3 ]
	then
		compileGrammar $3 $4
		isCorrectCommand="true"
	fi

	if [[ "$2" == "createCompile" ]] && [ "$#" -ge 3 ]
	then
		createCompileGrammar $3
		isCorrectCommand="true"
	fi

	if [[ "$2" == "test" ]] && [ "$#" -ge 4 ]
	then
		testGrammar $3 $4 $5
		isCorrectCommand="true"
	fi
fi
		

if [[ "$isCorrectCommand" == "false" ]]
then
	echo "Incorrect command : (--help to learn how to use the script)"
fi

#executeMVaP lib/sources-MVaP-3.1_1/add.mvap false false 

#createGrammar src/AnBn/AnBn.g4 -d
#compileGrammar dist/grammars/AnBn -d
#testGrammar dist/class/AnBn/AnBn.g4 anbn -gui

