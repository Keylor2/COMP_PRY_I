package comp_proy;
import java_cup.runtime.*;

%%

%public
%class Lexer
%unicode
%cup
%line
%column

%{
	//Almacena el valor al leer strings
	StringBuffer string = new StringBuffer();

	//Fabricas de simbolos
	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
%}

//----Declaraciones----
FinLinea = \n|\r|\r\n
EspacioBlanco = {FinLinea} | [ \t\f]

//Comentarios
CaracterComentario = [^\r\n]

Comentario = {ComentarioMulti} | {ComentarioLinea}
ComentarioMulti = "/*" [^*] ~"*/" | "/*" "*"+ "/"
ComentarioLinea = "//" {CaracterComentario}* {FinLinea}

//Identificadores
Identificador = [:jletter:][:jletterdigit:]*

//Enteros
Entero = 0 | {EnteroPositivo} | {EnteroNegativo}
EnteroPositivo = [1-9][0-9]*
EnteroNegativo = -{EnteroPositivo}

//Flotantes
Flotante = {FlotanteCero} | {FlotantePositivo} | {FlotanteNegativo}
FlotanteCero = 0 \. [0-9]+
FlotantePositivo = {EnteroPositivo} \. [0-9]+
FlotanteNegativo = - ({FlotanteCero}|{FlotantePositivo})

//Strings
CaracterString = [^\r\n\"\\]

//Chars
CaracterChar = [^\r\n\'\\]

//Estados adicionales
%state STRING, CHAR


%%
//----Reglas lexicas----

<YYINITIAL> {
	//Palabras clave
	"bool"		{System.out.println("TIPO BOOL");return symbol(ParserSym.TIPO_BOOL);}
	"break"  	{System.out.println("BREAK");return symbol(ParserSym.BREAK);}
	"case"   	{System.out.println("CASE");return symbol(ParserSym.CASE);}
	"char"		{System.out.println("TIPO CHAR");return symbol(ParserSym.TIPO_CHAR);}
	"default"  	{System.out.println("DEFAULT");return symbol(ParserSym.DEFAULT);}
	"else"   	{System.out.println("ELSE");return symbol(ParserSym.ELSE);}
	"float"		{System.out.println("TIPO FLOAT");return symbol(ParserSym.TIPO_FLOAT);}
	"if"     	{System.out.println("IF");return symbol(ParserSym.IF);}
	"int"		{System.out.println("TIPO INT");return symbol(ParserSym.TIPO_INT);}
	"main"   	{System.out.println("MAIN");return symbol(ParserSym.MAIN);}
	"null"		{System.out.println("NULL");return symbol(ParserSym.NULL);}
	"return" 	{System.out.println("RETURN");return symbol(ParserSym.RETURN);}
	"string"	{System.out.println("TIPO STRING");return symbol(ParserSym.TIPO_STRING);}
	"switch" 	{System.out.println("SWITCH");return symbol(ParserSym.SWITCH);}
	"while"  	{System.out.println("WHILE");return symbol(ParserSym.WHILE);}
	
	//Entrada y salida estandar
	"sysRead"	{System.out.println("SYSREAD");return symbol(ParserSym.SYSREAD);}
	"sysPrint"  {System.out.println("SYSPRINT");return symbol(ParserSym.SYSPRINT);}
	
	//Separadores
	"("	{System.out.println("PAR ABRIR");return symbol(ParserSym.PARABR);}
	")"	{System.out.println("PAR CERRAR");return symbol(ParserSym.PARCER);}
	"{"	{System.out.println("PAR CURS ABRIR");return symbol(ParserSym.PARCURSABR);}
	"}"	{System.out.println("PAR CURS CERRAR");return symbol(ParserSym.PARCURSCER);}
	"["	{System.out.println("PAR CUAD ABRIR");return symbol(ParserSym.PARCUADABR);}
	"]"	{System.out.println("PAR CUAD CERRAR");return symbol(ParserSym.PARCUADCER);}
	"#"	{System.out.println("HASHTAG");return symbol(ParserSym.HASHTAG);}
	":"	{System.out.println("DOS PUNTOS");return symbol(ParserSym.DOSPUNTOS);}
	","	{System.out.println("COMA");return symbol(ParserSym.COMA);}
	
	//Operadores
	"="		{System.out.println("IGUAL");return symbol(ParserSym.IGUAL);}
	"+"		{System.out.println("MAS");return symbol(ParserSym.MAS);}
	"-"		{System.out.println("MENOS");return symbol(ParserSym.MENOS);}
	"*"		{System.out.println("POR");return symbol(ParserSym.POR);}
	"/"		{System.out.println("DIV");return symbol(ParserSym.DIV);}
	"^"		{System.out.println("POTENCIA");return symbol(ParserSym.POTENCIA);}
	"~"		{System.out.println("COMPLEMENTO");return symbol(ParserSym.COMPLEMENTO);}
	"&"		{System.out.println("AND");return symbol(ParserSym.AND);}
	"|"		{System.out.println("OR");return symbol(ParserSym.OR);}
	"!"		{System.out.println("NOT");return symbol(ParserSym.NOT);}
	"=="	{System.out.println("ES IGUAL");return symbol(ParserSym.ESIGUAL);}
	"!="	{System.out.println("DIFERENTE");return symbol(ParserSym.DIFERENTE);}
	">"		{System.out.println("MAYOR QUE");return symbol(ParserSym.MAYOR);}
	"<"		{System.out.println("MENOR QUE");return symbol(ParserSym.MENOR);}
	">="	{System.out.println("MAYOR IGUAL QUE");return symbol(ParserSym.MAYORIGUAL);}
	"<="	{System.out.println("MENOR IGUAL QUE");return symbol(ParserSym.MENORIGUAL);}
	"++"	{System.out.println("MAS MAS");return symbol(ParserSym.MASMAS);}
	"--"	{System.out.println("MENOS MENOS");return symbol(ParserSym.MENOSMENOS);}
	
	//Literales
	//-Numeros
	{Entero}	{System.out.println("LITERAL ENTERO");return symbol(ParserSym.LIT_ENTERO, Integer.valueOf(yytext()));}
	{Flotante}	{System.out.println("LITERAL FLOTANTE");return symbol(ParserSym.LIT_FLOTANTE, Float.valueOf(yytext()));}
	
	//-Booleanos
	"true"		{System.out.println("LITERAL TRUE");return symbol(ParserSym.LIT_BOOLEANO, true);}
	"false"		{System.out.println("LITERAL FALSE");return symbol(ParserSym.LIT_BOOLEANO, false);}
	
	//-Chars (Cambio de seccion)
	\'			{yybegin(CHAR);}
	
	//-Strings (Cambio de seccion)
	\"			{yybegin(STRING); string.setLength(0);}
	
	
	//Identificador
	{Identificador} 	{System.out.println("IDENTIFICADOR");return symbol(ParserSym.IDENTIF, yytext());}
	
	//Comentarios
	{Comentario}		{System.out.println("COMENTARIO");}
	
	//Espacio en blanco
	{EspacioBlanco}		{ /* Ignorar */ }
}

<STRING> {
	\"					{yybegin(YYINITIAL);
						 System.out.println("LITERAL STRING");
						 return symbol(ParserSym.LIT_STRING, string.toString());}
	{CaracterString}+	{string.append( yytext() );}
	
	//Secuencias de escape de caracteres
	"\\b"				{string.append( '\b' );}
	"\\t"				{string.append( '\t' );}
	"\\n"				{string.append( '\n' );}
	"\\f"				{string.append( '\f' );}
	"\\r"				{string.append( '\r' );}
	"\\\""				{string.append( '\"' );}
	"\\'"				{string.append( '\'' );}
	"\\\\"				{string.append( '\\' );}
	
	//Errores
	\\.	{throw new RuntimeException("Secuencia de escape ilegal <" + yytext() + ">");}
	{FinLinea}	{throw new RuntimeException("String incompleta al final de linea");}
}

<CHAR> {
	{CaracterChar}\'	{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(ParserSym.LIT_CHAR, yytext().charAt(0));}
	
	//Secuencias de escape de caracteres
	"\\b"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(ParserSym.LIT_CHAR, '\b');}
	"\\t"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(ParserSym.LIT_CHAR, '\t');}
	"\\n"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(ParserSym.LIT_CHAR, '\n');}
	"\\f"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(ParserSym.LIT_CHAR, '\f');}
	"\\r"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(ParserSym.LIT_CHAR, '\r');}
	"\\\""\'			{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(ParserSym.LIT_CHAR, '\"');}
	"\\'"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(ParserSym.LIT_CHAR, '\'');}	
	"\\\\"\'			{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(ParserSym.LIT_CHAR, '\\');}

	//Errores
	\\.	{throw new RuntimeException("Secuencia de escape ilegal <" + yytext() + ">");}
	{FinLinea}	{throw new RuntimeException("Literal caracter incompleto al final de linea");}
}

//Error: caracter invalido
[^]		{throw new RuntimeException("Caracter ilegal <" + yytext() + "> en la linea " + yyline + ", columna " + yycolumn);}

//Fin del archivo
<<EOF>>                          { return symbol(ParserSym.EOF); }