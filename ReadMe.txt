Réalisations :
	- Création d'un environnement de travail propre ainsi que d'un script
	   d'éxecution écrit en bash pour faciliter la création, la compilation
	   et le test d'une grammaire, ainsi que la lecture de code MVàP.
	   Désormais, il est simple de récupérer le projet et de l'éxecuter sur
	   n'importe quel machine avec le minimum d'installations.

    - Implémentation dans l'environnement des tests unitaires à l'aide du fichier d'execution fourni.
    (j'ai adapté legèrement le fichier fourni à mon utilisation)
	
	- Réalisation des parties A à J du TP Calculatrice (un peu de retard
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

	- bash exec.sh --help (affiche le manuel d'utilisation).
