import java.util.*;

/** 
 * 3 Tables des symboles :
 *     _ Une table pour les variables globales; 
 *     _ Une pour les paramètres;
 *     _ une pour les variables locales.
 *
 *     Chaque table donne pour chaque variable sa position (son adresse dans la pile).
 *     On recherche d'abord en local puis en paramètre si défini.
 *     Comme on manipule des variables typées, on stocke également le type et le scope.
 *
 *     On utlise ici des tables de hachage stockant des objets VariableInfo
 *
 *     Pour autoriser un fonction et une variable de même nom, on ajoute aussi :
 *     _ Une Table des étiquettes des fonctions.
 *
 *     Note : une pile de tables pourrait être nécessaire,
 *       si on voulait pouvoir définir des fonctions dans des fonctions...
 *
 *    Et on conserve la dernière fonction ajoutée pour savoir le type de la valeur de retour
 */
class TablesSymboles {

    
    private TableSimple _tableGlobale = new TableSimple(); // Table des variables globales 
    private TableSimple _tableParam = null; // Table des paramêtres
    private TableSimple _tableLocale = null; // Table des variables locales
    private HashMap<String, String> _tableFonction = new HashMap<String, String>(); // Table des fonctions 

    private String _returnType = null;

    /* 
     * Partie pour la création / cloture des tables locale
     * À faire lors de l’entrée ou la sortie d’une fonction
     */

    // Créer les tables locales pour les variables dans une fonction
    public void enterFunction() { 
	_tableLocale = new TableSimple();
	_tableParam = new TableSimple();
    }

    // Détruire les tables locales des variables à la sortie d’une fonction
    public void exitFunction() { 
	_tableLocale = null;
        _tableParam = null;
    }



    // Connaitre la taille occupée par les variables locales
    public int getVariableLocalSize() {
	    if ( _tableLocale == null) {
		 System.err.println("Erreur: Impossible de connaître la taille des variables locales car les tables locales ne sont pas initialisées");
		 return 0;
	    }
	    return _tableLocale.getSize();
    }



    /* 
     * Partie pour l’ajout ou la récupération de variable et paramètres
     */

    // Ajouter une nouvelle variable Locale ou globale
    public void addVarDecl(String name, String t) {
	if ( _tableLocale == null ) { // On regarde si on est à l’extérieur d’une fonction
		// On a une variable globale
		_tableGlobale.addVar(name,VariableInfo.Scope.GLOBAL,t); 
	} else {
		// On a une variable locale 
		_tableLocale.addVar(name,VariableInfo.Scope.LOCAL,t);

	}
    }

    // Ajouter un paramètre de fonction
    public void addParam(String name, String t) {
        if ( _tableParam == null ) {
	       	System.err.println("Erreur: Impossible d’ajouter la variable "+name+
			"car les tables locales ne sont pas initialisées");
	} else { 
                _tableParam.addVar(name,VariableInfo.Scope.PARAM,t);
        }
    }

    // Récupérer les infos d’une variable (ou d’un paramètre)
    public VariableInfo  getVar(String name) {
	if ( _tableLocale != null ) {  
		// On cherche d’abord parmi les variables locales
		VariableInfo vi = _tableLocale.getVariableInfo(name);
		if (vi != null) { return vi;} // On a trouvé
	}
	if ( _tableParam != null ) {
		// On cherche ensuite parmi les paramètres
		VariableInfo vi = _tableParam.getVariableInfo(name);
		if (vi != null) 
		{
			return new VariableInfo( 
				vi.address - (_tableParam.getSize() + 2),
				// On calcule l’adresse du paramètre
				vi.scope,
				vi.type);	
		}
	}
	// Enfin, on cherche parmi les variables globales
	VariableInfo vi = _tableGlobale.getVariableInfo(name);
	if (vi != null) {
		return vi;
	}
	System.err.println("## Erreur : la variable \"" + name + "\" n'existe pas");
	return null; // Attention: ceci ne doit pas arriver et va probablement faire planter le programme
    }

    // Récupérer l’adresse de la valeur de retour
    //  Note: Cette fonction ne doit être appelé qu’après avoir déclarer les paramètres
    public VariableInfo getReturn() {
	    if ( _tableParam == null ) {
        	        System.err.println("Erreur: Impossible de calculer l’emplacement"+
					" de la valeur de retour car les tables locales"+
				        " ne sont pas initialisées");
			return null;  // Attention: ceci ne doit pas arriver et va probablement faire planter le programme
	    }
	    return  new VariableInfo(
                         - (_tableParam.getSize() + 2 + VariableInfo.getSize(_returnType)), // On calcule l’adresse du paramètre
                         VariableInfo.Scope.PARAM, 
                         _returnType);
    }


    /* 
     * Partie pour les fonctions 
     *
     */
    public String getFunction(String function) {
	String l = _tableFonction.get(function);
	if (l != null)
	    return l;
	System.err.println("Appel à une fonction non définie \""+function+"\"");
	return null;
    }

    public void addFunction(String function,String type) {
        String fat = _tableFonction.get(function);
	if ( fat!= null ) {
	    System.err.println("Fonction \""+ function + 
			    "\" déjà définie avec type de retour \"" + fat +"\".");
	    return;
	}
	_returnType=type;
	_tableFonction.put(function, type);
	return;
    }

}
    
