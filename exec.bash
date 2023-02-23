#!/bin/bash

#Liste des taches

#Executer code MVaP (avec ou sans traces (2 types de traces)); V
#Deplacer les fichiers dist de MVaP; V

#Creer grammaire (antlr) et les déplacer dans un dossier portant le nom de la grammaire V
#Compiler grammaire (antlr) V
#Utiliser grammaire (antlr) V

#Vérifier les commentaires paramètres des fonctions 



#Fonction affichant le help
function help {
	echo "Legende :"
	echo "[] : parametre obligatoire"
	echo "() : parametre optionnel"
	echo ""
	echo ""
	echo "MVaP :"
	echo ""
	echo "#Execution d'un code MVaP"
	echo "exec mvap execute [path_to_mvap_file] (boolean_trace_build) (boolean_trace_execution)"
	echo ""
	echo ""
	echo "ANTLR :"
	echo ""
	echo "#Création d'une grammaire"
	echo "exec antlr create [path_to_grammar_g4_file] (-d)"
	echo ""
	echo "#Compilation d'une grammaire"
	echo "exec antlr compile [path_to_grammar_folder] (-d)"
	echo ""
	echo "#Execution d'une grammaire"
	echo "exec antlr test [path_to_grammar_g4_file_with_.class_files] [axiome] (-gui)"
	echo ""
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
	echo "│       │   ├── AnBn.g4"
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
	#Créé la grammaire
	java -cp "lib/*" org.antlr.v4.Tool $1

	#Prends le nom du fichier sans l'extension et sans le chemin
	grammarName=${1##*/}
	grammarName=${grammarName%.*}

	#Prends le chemin du fichier sans le nom du fichier
	grammarPath=${1%/*}

	#Si il y a -d :
	#liste tout les fichier commençant par le nom de la grammaire et ne finissant pas par .g4 et les déplace dans le dossier de la grammaire
	if [[ "$2" == "-d" ]];
	then
		#Créé le dossier de la grammaire
		mkdir dist/grammars/$grammarName 2> /dev/null

		cp $1 dist/grammars/$grammarName
		for file in $grammarPath/$grammarName*; do
			if [[ "$file" != *".g4" ]];
			then
				mv $file dist/grammars/$grammarName
			fi
		done
	fi
}

#Fonction compilant la grammaire
#parametre :
# $1 = chemin du repertoire de la grammaire contenant les fichiers .java
# $2 = -d pour déplacer les fichiers dans le dossier de la grammaire
function compileGrammar {

	#Prends le nom du dossier sans le chemin
	grammarName=${1##*/}

	#Prends le nom du fichier sans l'extension et sans le chemin
	grammarNameWithoutExt=${grammarName%.*}

	#Compile la grammaire
	if [[ "$2" == "-d" ]];
	then
		mkdir dist/class/$grammarNameWithoutExt 2> /dev/null
		javac -cp "lib/*" -d dist/class/$grammarName $1/*.java
		cp $1/$grammarName*.g4 dist/class/$grammarName
	else
		javac -cp ./lib/antlr-4.12.0-complete.jar:./lib/MVaP.jar $1/$grammarName*.java
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

