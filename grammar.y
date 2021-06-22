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
    char* name;
}

%token<name> TAG
%token<name> ATTRIBUTE
%token<name> BOOL_ATTRIBUTE
%token<name> STYLE_ATTR

%token<name> TAGSIGNS
%token<name> CONTENT

%type<name> expression attribute

%%

expressions: expressions expression 
    |  /* empty */ 
    ;

expression: '<' TAG attributes '>' expressions '<' '/' TAG '>'{}
    | '<' TAG attributes '>' expressions CONTENT expressions '<' '/' TAG '>'{}
    | '<' TAG attributes '/' '>'{}
    | '<' '!' '-' '-' CONTENT '-' '-' '>'{};

attributes: attribute attributes
    |  /* empty */ 
    ;

attribute: ATTRIBUTE
    | BOOL_ATTRIBUTE
    | STYLE_ATTR
    ;

%%


int main(){
    if (yyparse() == 0) cout<<"\n<ACC>\n";
    else cout<<"ERROR\n";
    return 0;
}