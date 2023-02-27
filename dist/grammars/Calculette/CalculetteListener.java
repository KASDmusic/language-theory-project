// Generated from src/calculatrice/Calculette.g4 by ANTLR 4.12.0
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CalculetteParser}.
 */
public interface CalculetteListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CalculetteParser#start}.
	 * @param ctx the parse tree
	 */
	void enterStart(CalculetteParser.StartContext ctx);
	/**
	 * Exit a parse tree produced by {@link CalculetteParser#start}.
	 * @param ctx the parse tree
	 */
	void exitStart(CalculetteParser.StartContext ctx);
	/**
	 * Enter a parse tree produced by {@link CalculetteParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(CalculetteParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link CalculetteParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(CalculetteParser.ExprContext ctx);
}