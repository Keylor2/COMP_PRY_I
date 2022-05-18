package comp_proy;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;

/**
 *
 * @author moral
 */
public class ExtendedSymbol extends java_cup.runtime.Symbol {

    private int line;
    private int column;

    public ExtendedSymbol(int type, int line, int column) {
        this(type, line, column, -1, -1, null);
    }

    public ExtendedSymbol(int type, int line, int column, Object value) {
        this(type, line, column, -1, -1, value);
    }

    public ExtendedSymbol(int type, int line, int column, int left, int right, Object value) {
        super(type, left, right, value);
        this.line = line;
        this.column = column;
    }

    public int getLine() {
        return line;
    }

    public int getColumn() {
        return column;
    }

    private String getNombreSimbolo(int value) {
    for (Field f : ParserSym.class.getDeclaredFields()) {
        int mod = f.getModifiers();
        if (Modifier.isStatic(mod) && Modifier.isPublic(mod) && Modifier.isFinal(mod)) {
            try {
                if((int) f.get(null) == value) {return f.getName();}
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
    }
    return null;
}
    
    public String toString() {
        return "Simbolo " 
                + getNombreSimbolo(sym)
                + ", linea "
                + line
                + ", columna "
                + column
                + (value == null ? "" : (", valor: '" + value + "'"));
    }
}
