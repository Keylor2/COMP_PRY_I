import java_cup.runtime.*;

%%

%unicode
%cup

//Simbolos

nl		    =  \n|\r|\r\n
digD    	=  [0-9]
digP        =  [1-9]
zero        =  0
letra       = [a-zA-Z]
simbolo	    = [|°¬!#$%&/()='?¿¡´¨+*~{[^}]`,;.:-_<>]

//Tipos de funcion

tipoFun     = "int"|"float"|"char"
tipoVar     = "int"|"float"|"char"|"bool"|"string"



%%

{digD}	    {System.out.println("Only one digit:"+yytext());return new Symbol(sym.NUMBERD);}
{digP}	    {System.out.println("Another digit:"+yytext());return new Symbol(sym.NUMBERP);}
{simbolo}	{System.out.println("Whatever symbol:"+yytext());return new Symbol(sym.SYMBOL);}
{letra}	    {System.out.println("Whatever symbol:"+yytext());return new Symbol(sym.LETRA);}

"+"		{System.out.println("PLUS");return new Symbol(sym.PLUS);}
"-"		{System.out.println("MINUS");return new Symbol(sym.MINUS);}

"*"		{System.out.println("TIMES");return new Symbol(sym.TIMES);}
"/"		{System.out.println("DIV");return new Symbol(sym.DIV);}

"^"		{System.out.println("POW");return new Symbol(sym.POW);}
"~"		{System.out.println("COMPLEMENT");return new Symbol(sym.COMPLEMENT);}

"("		{System.out.println("OPEN BRACKET");return new Symbol(sym.OBRACKET);}
")"		{System.out.println("CLOSE BRACKET");return new Symbol(sym.CBRACKET);}

"&"		{System.out.println("AND");return new Symbol(sym.ANDOPERTATOR);}
"|"		{System.out.println("OR");return new Symbol(sym.OROPERATOR);}

"=="	{System.out.println("OPEN BRACKET");return new Symbol(sym.EQUALS);}
"!="	{System.out.println("CLOSE BRACKET");return new Symbol(sym.DIFFERENT);}

">"		{System.out.println("MORE THAN");return new Symbol(sym.MORETHAN);}
"<"		{System.out.println("LESS THAN");return new Symbol(sym.LESSTHAN);}
">="	{System.out.println("MORE EQUAL THAN");return new Symbol(sym.MOREEQ);}
"<="	{System.out.println("LESS EQUAL THAN");return new Symbol(sym.LESSEQ);}

"++"	{System.out.println("PLUS UNARY");return new Symbol(sym.PLUSS);}
"--"	{System.out.println("LESS UNARY");return new Symbol(sym.MINUSS);}

"true"	{System.out.println("BOOLEAN TRUE");return new Symbol(sym.TRUE);}
"false"	{System.out.println("BOOLEAN FALSE");return new Symbol(sym.FALSE);}

"var"   {System.out.println("VARIABLE");return new Symbol(sym.VAR);}
"function" {System.out.println("FUNCTION");return new Symbol(sym.FUNCTION);}
"if"     {System.out.println("IF");return new Symbol(sym.IF);}
"else"   {System.out.println("ELSE");return new Symbol(sym.ELSE);}
"while"  {System.out.println("WHILE");return new Symbol(sym.WHILE);}

"//"  {System.out.println("COMMENT");return new Symbol(sym.COMMENT);}


"="		{System.out.println("EQUAL");return new Symbol(sym.EQUAL);}

{nl}|" " 	{;}

.		{System.out.println("Error:" + yytext());}
