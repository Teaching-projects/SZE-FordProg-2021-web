%{
    #include <iostream>
    #include <map>
    #include <cstring>
    #include <string>
    using namespace std;
    int yylex();
    int yyerror(string message){
        return 1;
    }

    map<string,int> identifiers;
%}

%union{
    char* text;
}

%token<text> START_TAG
%token<text> END_TAG
%token<text> END_EMPTY_TAG

%token<text> ATTRIBUTE
%token<text> BOOL_ATTRIBUTE
%token<text> STYLE_ATTR

%token<text> TAGSIGNS
%token<text> CONTENT

%type<text> expression attribute

%%

expressions: expressions expression 
    | /* empty */ 
    ;

expression: START_TAG attributes '>' expressions text expressions END_TAG{}
    | START_TAG attributes END_EMPTY_TAG{}
    | '<' '!' '-' '-' text '-' '-' '>'{};

attributes: attribute attributes
    | /* empty */ 
    ;

attribute: ATTRIBUTE
    | BOOL_ATTRIBUTE
    | STYLE_ATTR
    ;

text: CONTENT text
    | /* empty */

%%


int main(){
    if (yyparse() == 0) cout<<"\n<ACC>\n";
    else cout<<"ERROR\n";
    return 0;
}