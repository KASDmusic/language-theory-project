import java.util.*;
 

public class TableSimple {

    // A hash table to recall variables that have been declared so far
    // A variable is represented by its name.
    // We assume that named are not reused, i.e. we can not have a variable x two time
    private HashMap<String, VariableInfo > table = new HashMap<String, VariableInfo >();


    // Main accessor
    public VariableInfo getVariableInfo(String name) { return table.get(name); }
    
    // _n is a short hand for next free address :)
    private int _n = 0;


    // returns the next available address that is available to store a global variable (initially 0).
    public Integer getSize() { return _n;}

    // Add a new variable 
    public void addVar(String name, VariableInfo.Scope scope, String t) {
	if (table.get(name) != null)
	    System.err.println("Erreur : Variable \""+ name + "\" de type " + table.get(name).type + " déjà définie "+table.get(name).scope);
        else 
            {
                VariableInfo vi = new VariableInfo(_n,scope,t);
                table.put(name, vi);
                _n+=VariableInfo.getSize(t);
            }
    }




    // Mainly for debug
    public String toString() { return table.toString(); }
}
    

