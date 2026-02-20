%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
FILE *fout;
%}
%%

\"[a-zA-Z]([a-zA-Z0-9_]*)\.([a-zA-Z0-9]{1,3})+\"|\'[a-zA-Z0-9_]([a-zA-Z0-9_]*)\.([a-zA-Z0-9]{1,3})+\' 	{ fprintf(fout, "File Name: %s\n", yytext); }
\"(\\.|[^"\\])*\"|\'(\\.|[^'\\])*\'							{ fprintf(fout, "String Literal: %s\n", yytext); }

"/*" {
	int c;
	while ((c = yyinput()) != EOF) {
		if (c == '*') {
			if ((c = yyinput()) == '/') {
				break;
			} else {
				unput(c);
			}
		}
	}
 }
 
 "//" {
 int c; 
 while ((c = yyinput()) != EOF && c != '\n');
 }

^cst[0-9]{4}2010											{ yytext[7] = '\0'; 
															  fprintf(fout, "Student ID: %s\n", yytext); }

\"[a-zA-Z]([a-zA-Z0-9_]*)\.([a-zA-Z0-9]{1,3})+\"|\'[a-zA-Z0-9_]([a-zA-Z0-9_]*)\.([a-zA-Z0-9]{1,3})+\' 	{ fprintf(fout, "File Name: %s\n", yytext); }
\"(\\.|[^"\\])*\"|\'(\\.|[^'\\])*\'							{ fprintf(fout, "String Literal: %s\n", yytext); }
\b(if|else|continue|while|for)\b							{ fprintf(fout, "Keyword: %s\n", yytext); }
^[a-zA-Z0-9]+												{ fprintf(fout, "Identifier at the start of file: %s\n", yytext); }
[+-]?[0-9]+													{ fprintf(fout, "Number: %s\n", yytext); }
[+-]?((0|[1-9][0-9]*)\.[0-9]*|\.[0-9]+)						{ fprintf(fout, "Decimal Number: %s\n", yytext); }
[+-]?((0|[1-9][0-9]*)\.[0-9]*|\.[0-9]+)([EexX][+-]?[0-9]+)? { fprintf(fout, "Scientific Number: %s\n", yytext); }
[ \t]+														{ fprintf(fout, "**\n"); }
--|!=|==|&&|<=|>=|<<|>>|[-+*\/%=<>&!|^]						{ fprintf(fout, "Operator: %s\n", yytext); } 
.|\n



%%

void main(int argc, char **argv) {
	if(argc < 3) {
	printf("\n Error!!! Missing command line arguments. \n");
	printf(" Usage exe <inputfile> <outputfile>");
	exit(1);
	}
	else {
	fout = fopen(argv[2], "w");
	yyin = fopen(argv[1], "r");
	yylex();
	}
}