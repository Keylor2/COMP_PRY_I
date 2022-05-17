import java_cup.runtime.*;

%%

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
	return symbol(type, yyline, yycolumn);
}
private Symbol symbol(int type, Object value) {
	return symbol(type, yyline, yycolumn, value);
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
FlotanteCero = 0\.[0-9]+
FlotantePositivo = EnteroPositivo\.[0-9]+
FlotanteNegativo = -{FlotanteCero} | -{FlotantePositivo}

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
	"bool"		{System.out.println("TIPO BOOL");return symbol(TIPO_BOOL);}
	"break"  	{System.out.println("BREAK");return symbol(BREAK);}
	"case"   	{System.out.println("CASE");return symbol(CASE);}
	"char"		{System.out.println("TIPO CHAR");return symbol(TIPO_CHAR);}
	"default"  	{System.out.println("DEFAULT");return symbol(DEFAULT);}
	"else"   	{System.out.println("ELSE");return symbol(ELSE);}
	"float"		{System.out.println("TIPO FLOAT");return symbol(TIPO_FLOAT);}
	"if"     	{System.out.println("IF");return symbol(IF);}
	"int"		{System.out.println("TIPO INT");return symbol(TIPO_INT);}
	"main"   	{System.out.println("MAIN");return symbol(MAIN);}
	"null"		{System.out.println("NULL");return symbol(NULL);}
	"return" 	{System.out.println("RETURN");return symbol(RETURN);}
	"string"	{System.out.println("TIPO STRING");return symbol(TIPO_STRING);}
	"switch" 	{System.out.println("SWITCH");return symbol(SWITCH);}
	"while"  	{System.out.println("WHILE");return symbol(WHILE);}
	
	//Entrada y salida estandar
	"sysRead"	{System.out.println("SYSREAD");return symbol(SYSREAD);}
	"sysPrint"  {System.out.println("SYSPRINT");return symbol(SYSPRINT);}
	
	//Separadores
	"("	{System.out.println("PAR ABRIR");return symbol(PARABR);}
	")"	{System.out.println("PAR CERRAR");return symbol(PARCER);}
	"{"	{System.out.println("PAR CURS ABRIR");return symbol(PARCURSABR);}
	"}"	{System.out.println("PAR CURS CERRAR");return symbol(PARCURSCER);}
	"["	{System.out.println("PAR CUAD ABRIR");return symbol(PARCUADABR);}
	"]"	{System.out.println("PAR CUAD CERRAR");return symbol(PARCUADCER);}
	"#"	{System.out.println("HASHTAG");return symbol(HASHTAG);}
	":"	{System.out.println("DOS PUNTOS");return symbol(DOSPUNTOS);}
	","	{System.out.println("COMA");return symbol(COMA);}
	
	//Operadores
	"="		{System.out.println("IGUAL");return symbol(IGUAL);}
	"+"		{System.out.println("MAS");return symbol(MAS);}
	"-"		{System.out.println("MENOS");return symbol(MENOS);}
	"*"		{System.out.println("POR");return symbol(POR);}
	"/"		{System.out.println("DIV");return symbol(DIV);}
	"^"		{System.out.println("POTENCIA");return symbol(POTENCIA);}
	"~"		{System.out.println("COMPLEMENTO");return symbol(COMPLEMENTO);}
	"&"		{System.out.println("AND");return symbol(AND);}
	"|"		{System.out.println("OR");return symbol(OR);}
	"!"		{System.out.println("NOT");return symbol(NOT);}
	"=="	{System.out.println("ES IGUAL");return symbol(ESIGUAL);}
	"!="	{System.out.println("DIFERENTE");return symbol(DIFERENTE);}
	">"		{System.out.println("MAYOR QUE");return symbol(MAYOR);}
	"<"		{System.out.println("MENOR QUE");return symbol(MENOR);}
	">="	{System.out.println("MAYOR IGUAL QUE");return symbol(MAYORIGUAL);}
	"<="	{System.out.println("MENOR IGUAL QUE");return symbol(MENORIGUAL);}
	"++"	{System.out.println("MAS MAS");return symbol(MASMAS);}
	"--"	{System.out.println("MENOS MENOS");return symbol(MENOSMENOS);}
	
	//Literales
	//-Numeros
	{Entero}	{System.out.println("LITERAL ENTERO");return symbol(LIT_ENTERO, new Integer.valueOf(yytext()));}
	{Flotante}	{System.out.println("LITERAL FLOTANTE");return symbol(LIT_FLOTANTE, new Float.valueOf(yytext()));}
	
	//-Booleanos
	"true"		{System.out.println("LITERAL TRUE");return symbol(LIT_BOOLEANO, true);}
	"false"		{System.out.println("LITERAL FALSE");return symbol(LIT_BOOLEANO, false);}
	
	//-Chars (Cambio de seccion)
	\'			{yybegin(CHAR)}
	
	//-Strings (Cambio de seccion)
	\"			{yybegin(STRING); string.setLength(0);}
	
	
	//Identificador
	{Identificador} 	{System.out.println("IDENTIFICADOR");return symbol(IDENTIF, yytext();)}
	
	//Comentarios
	{Comentario}		{System.out.println("COMENTARIO");}
	
	//Espacio en blanco
	{EspacioBlanco}		{ /* Ignorar */ }
}

<STRING> {
	\"					{yybegin(YYINITIAL);
						 System.out.println("LITERAL STRING");
						 return symbol(LIT_STRING, string.toString());}
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
						 return symbol(LIT_CHAR, yytext().charAt(0));}
	
	//Secuencias de escape de caracteres
	"\\b"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(LIT_CHAR, '\b');}
	"\\t"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(LIT_CHAR, '\t');}
	"\\n"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(LIT_CHAR, '\n');}
	"\\f"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(LIT_CHAR, '\f');}
	"\\r"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(LIT_CHAR, '\r');}
	"\\\""\'			{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(LIT_CHAR, '\"');}
	"\\'"\'				{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(LIT_CHAR, '\'');}	
	"\\\\"\'			{yybegin(YYINITIAL);
						 System.out.println("LITERAL CHAR");
						 return symbol(LIT_CHAR, '\\');}

	//Errores
	\\.	{throw new RuntimeException("Secuencia de escape ilegal <" + yytext() + ">");}
	{FinLinea}	{throw new RuntimeException("Literal caracter incompleto al final de linea");}
}

//Error: caracter invalido
[^]		{throw new RuntimeException("Caracter ilegal <" + yytext() + "> en la linea " + yyline + ", columna " + yycolumn);}

//Fin del archivo
<<EOF>>                          { return symbol(EOF); }