package comp_proy;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStreamReader;
import javax.swing.JFileChooser;

/**
 *
 * @author moral
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        final JFileChooser fc = new JFileChooser();
        int codigoOper = fc.showOpenDialog(null);
        if (codigoOper == JFileChooser.APPROVE_OPTION) {
            File archivo = fc.getSelectedFile();
            try {
                Parser p = new Parser(new Lexer(new BufferedReader(new FileReader(archivo))));
                Object result = p.parse().value;
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("Operación cancelada.");
        }
    }
    
}
