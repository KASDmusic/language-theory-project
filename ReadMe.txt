Réalisations :
	- Création d'un environnement de travail propre ainsi que d'un script
	   d'éxecution écrit en bash pour faciliter la création, la compilation
	   et le test d'une grammaire, ainsi que la lecture de code MVàP.
	   Désormais, il est simple de récupérer le projet et de l'éxecuter sur
	   n'importe quel machine avec le minimum d'installations.

    - Implémentation dans l'environnement des tests unitaires à l'aide du fichier d'execution fourni
    (j'ai adapté legèrement le fichier fourni à mon utilisation).

	- Réalisations de quelques tests unitaires supplémentaires (pour la partie B et C et pour les types booléens "1_Perso_Print_Bool_Int.code").
	
	- Réalisation des parties A à L (+ quelques uns de O voir ci-dessous) du TP Calculatrice (un peu de retard
	   à cause du temps de développement de l'environnement).

	- Réalisations des autres améliorations : "Supporter plusieurs types", "Cast explicite", "Cast Implicite".

Notes :
	- Ne pas utiliser le .jar de MVàP source mais celui situé dans
	   le dossier lib, car dans celui source, dans le fichier Manifest,
	   la ligne classpath pose problème lorsque l'on veut ajouter 
	   un autre classpath lors de la compilation avec l'option "-cp" 
	   de "javac". Je l'ai donc supprimé dans ma version de la librairie.
	
	- J'ai laissé quelques fichiers tel que le bash d'éxecution et
	   le README.md pour que vous puissiez constater le travail effectué 
	   et consulter plus facilement la documentation situé dans le fichier
	   exec.sh ou le fichier README.md .

	- Pour lancer le bash d'éxecution, il faut de se placer dans le dossier où il se situe

	- bash exec.sh --help (affiche le manuel d'utilisation).

Commentaire :
	- J'ai quelques regrets vis à vis de mon code car je n'avais pas recul necessaire sur ce langage
	   et je n'ai pas pu faire de code propre et efficace. Je trouve donc par exemple qu'il y a beaucoup
	   de duplication de code, et que donc avec le recul j'aurais dû faire plus de fonctions dans la partie "@parser::members".

	- J'aurais voulu faire plus de bonus mais au debut du projet j'ai voulu réaliser un environnement de travail
	   propre, intuitif et bien documenté pour faciliter la réalisation du TP. Cela m'a pris beaucoup de temps et j'ai sous estimé le temps de réalisation du TP.
	   
	- J'ai mis mon code en public sur github durant ce projet pour que des collègues puissent si ils le veulent utiliser mon environnement.
	Aussi, en cas de soupçon de plagiat, je vous invite à consulter mon repo sur github afin de constater la chronologie des commits effectués.
	Je peux également vous inviter à consulter les différents prérendus envoyés.
	voici mon lien de répo github : https://github.com/KASDmusic/language-theory-project

	- Merci de votre attention et bonne correction.