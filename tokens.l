
%{
    #include "grammar.tab.h"
    #include <cstring>
    #include <iostream>
    using namespace std;
%}


%option noyywrap

CONTENT_CHARS [^ \t\n\<\>\&]
CONTENT {CONTENT_CHARS}*

TOKEN_CHARS [a-zA-Z0-9\-\_]
NAME_TOKEN \"{TOKEN_CHARS}*\"|\'{TOKEN_CHARS}*\'

TAGSIGNS [\<\>\/\-\!]
TAG "html"|"head"|"body"|"title"|"h1"|"h2"|"h3"|"h4"|"h5"|"h6"|"p"|"br"|"hr"|"a"|"div"|"span"|"ol"|"ul"|"li"|"img"|"table"|"th"|"tr"|"td"

ATTR_NAME "class"|"id"|"src"|"href"|"lang"
BOOL_ATTRIBUTE "hidden"|"checked"|"muted"
ATTRIBUTE {ATTR_NAME}"="{NAME_TOKEN}|{BOOL_ATTRIBUTE}"="{NAME_TOKEN}

STYLE_PROP "color"|"font-size"|"background-color"
STYLE_DEF {STYLE_PROP}":"{TOKEN_CHARS}";"
STYLE_ATTR "style="\"{STYLE_DEF}+\"

%%
\n                                  return '\0';
{TAG}                               printf("Tag"); return TAG;
{ATTRIBUTE}                         printf(" Attr"); return ATTRIBUTE;
{BOOL_ATTRIBUTE}                    printf(" BoolAttr"); return BOOL_ATTRIBUTE;
{STYLE_ATTR}                        printf(" Style"); return STYLE_ATTR;

{TAGSIGNS}                          cout<<yytext; return *yytext;
{CONTENT}                           printf("Content"); return CONTENT;
[ \t]*                              /* skip whitespace */


%%
