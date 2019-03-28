lexer grammar CommonLexerRules;

//Reserved Keywords
BOOL: 'bool';
INT: 'int';
STRING: 'string';
NULL: 'null';
VOID: 'void';
TRUE: 'true';
FALSE: 'false';
IF: 'if';
ELSE: 'else';
FOR: 'for';
WHILE: 'while';
BREAK: 'break';
CONTINUE: 'continue';
RETURN: 'return';
NEW: 'new';
CLASS: 'class';
THIS: 'this';


//Comment
COMMENT:
    (('/*' .*? '*/')                     //ignore /* ... */
    | ('//' .*? '\n')                //ignore //....
    )
    -> skip;



//IDentifier
ID: [a-zA-Z][_0-9a-zA-Z]*;

//Integer
Integer: '0' | ([1-9][0-9]*);

//String
String: '"' ( ESC | .)*? '"';
fragment ESC: '\\' [btnr"\\];
//WhiteSpace
WS: [ \t\n\r]+ -> skip;
