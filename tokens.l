%{
    #include "grammar.tab.h"
    #include "htmlStack.c"
    #include <string>
    using namespace std;
%}

%option noyywrap

TOKEN_CHARS [a-zA-Z0-9\-\_\/\:\.]
NAME_TOKEN \"{TOKEN_CHARS}*\"|\'{TOKEN_CHARS}*\'

CONTENT_CHARS [^ \t\n\<\>\&]
CONTENT {CONTENT_CHARS}*

TAGSIGNS [\<\>\/\-\!]
TAG "html"|"head"|"body"|"title"|"h1"|"h2"|"h3"|"h4"|"h5"|"h6"|"p"|"br"|"hr"|"a"|"div"|"span"|"ol"|"ul"|"li"|"img"|"table"|"th"|"tr"|"td"
START_TAG "<"{TAG}
END_TAG "</"{TAG}">"
SELF_CLOSE "/>"

ATTR_NAME "accesskey"|"class"|"contenteditable"|"href"|"id"|"lang"|"src"
BOOL_ATTRIBUTE "hidden"|"checked"|"muted"
ATTRIBUTE {ATTR_NAME}"="{NAME_TOKEN}|{BOOL_ATTRIBUTE}"="{NAME_TOKEN}

STYLE_PROP "color"|"font-size"|"background-color"
STYLE_DEF {STYLE_PROP}":"{TOKEN_CHARS}+\;?
STYLE_ATTR "style="\"{STYLE_DEF}*\"|"style="\'{STYLE_DEF}*\'

%%
exit                                return '\0';
{ATTRIBUTE}                         printf(" Attr"); return ATTRIBUTE;
{BOOL_ATTRIBUTE}                    printf(" BoolAttr"); return BOOL_ATTRIBUTE;
{STYLE_ATTR}                        printf(" Style"); return STYLE_ATTR;


{SELF_CLOSE}                        printf("/>\n");pop();return END_EMPTY_TAG;
{START_TAG}                         removeFirstChar(yytext);printf("\n<Tag:%s", yytext);push(yytext);return START_TAG;

{END_TAG}                           {
                                        convertEndTag(yytext);
                                        if (strcmp(yytext,pop()) == 0)
                                        {
                                            printf("<EndTag:%s>\n", yytext);
                                            return END_TAG;
                                        } 
                                        printf("ERROR: Ending tag does not match.\n");
                                        return 1;
                                    }

{TAGSIGNS}                          printf("%s",yytext); return *yytext;
{CONTENT}                           printf(" Content "); return CONTENT;
[ \t\n]*                            /* skip whitespace */

%%
