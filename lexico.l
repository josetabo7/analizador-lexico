/***
ESCUELA POLITÉCNICA NACIONAL
INGENIERÍA DE SISTEMAS
COMPILADORES y LENGUAJES 
PROYECTO PRIMER BIMESTRE
ANALIZADOR LÉXICO
	Silvana Malan 
	Jose Tayupanta
GR_01
***/

/*** Sección de declaraciones ***/
%{
/* Código en C que será copiado */
	#include <stdio.h>
	FILE *archSal;
	FILE *archEnt;
%}

/* Esto indica a Flex que lea sólo un fichero de entrada */
%option noyywrap
/* Ordena a Flex que genere un analizador que mantenga el número de la línea actual*/
%option yylineno 


int numLinea=0;
espacio	" "|\t
digito	[0-9]
letra	[a-z|A-Z]
string	\"[^\n"]+\"
/*lib	"#"[a-z]+"<" [a-z]+".h>"*/
   
 
palabra_reservada	"int"|"float"|"double"|"bool"|"char"|"string"|"if"|"then"|"else"|"while"|"do"|"input"|"output"|"return"|"void"

caracteres_especiales	","|";"|":"|"("|")"|"["|"]"|"{"|"}"|"+"|"-"|"*"|"/"|"<"|">"|"="|"!"|"&"|"$"

operandos_compuestos	"<="|">="|"=="|"!="|"&&"|"||"


%%
	/*** Sección de reglas ***/

{espacio}+	     		; /* no cuenta los expacios */
\n				fprintf(archSal,"\n"); /* imprime un enter al final de cada línea */
				
{digito}+|"-"{digito}		fprintf(archSal, "ENTERO ");
{digito}*"."{digito}+		fprintf(archSal, "FLOTANTE "); /* num real */
"true"|"TRUE"|"false"|"FALSE"	fprintf(archSal, "BOOLEAN ");
"'".{1}"'"			fprintf(archSal, "CHAR ");
{string}			fprintf(archSal, "STRING ");
"if"|"else if"|"else"		fprintf(archSal, "CONDI ");
"then"				fprintf(archSal, "THEN ");
"for"|"while"|"do"		fprintf(archSal, "BUCLE ");
{palabra_reservada}		fprintf(archSal, "PAL_RESERVADA ");
"main"				fprintf(archSal, "FUNCION_MAIN " );
[a-z]{letra}*|{digito}*		fprintf(archSal, "ID ");

"+"|"-"|"*"|"/"|"%"		fprintf(archSal, "OPERADOR ");
{operandos_compuestos}		fprintf(archSal, "OP_COMPUESTO ");

";"				fprintf(archSal, "PUNTO_Y_COMA ");
"("				fprintf(archSal, "PAR_ABIERTO ");
")"				fprintf(archSal, "PAR_CERRADO ");
"["				fprintf(archSal, "COR_ABIERTO ");
"]"				fprintf(archSal, "COR_CERRADO ");
"{"				fprintf(archSal, "LLAV_ABIERTA ");
"}"				fprintf(archSal, "LLAV_CERRADA ");
{caracteres_especiales}		fprintf(archSal, "CARACT_ESPECIAL ");

.				fprintf(archSal, " ERROR LEXICO "); /* Ignora todos los demás caracteres e imprime la línea de error */

%%
	/*** Sección de código en C ***/
void main()
{
	//char cadena[200];
	//printf("ingrese el nombre del archivo: "+cadena);
	//yyin=char *fgets(char *cadena, int n, FILE *fichero);
	//yyin= fopen(cadena,"r");
	printf("Ingrese el nombre del archivo]:\n");
	char file[250];
	scanf("%[^\n]",file);
	//printf("cadena: %s",file);
   yyin=fopen(file,"r");//lectura
   archSal=fopen("Resultados.txt","w");//escribe
    yylex();
    fclose(archSal);
}
