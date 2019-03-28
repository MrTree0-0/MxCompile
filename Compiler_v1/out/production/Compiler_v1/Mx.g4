/*


*/

grammar Mx;

import CommonLexerRules;

//program
prog: (decl)* (mainFunction) (decl)* EOF;

decl: functionDecl | classDecl | declStmt;

mainFunction: INT 'main' '(' ')' block;
functionDecl: typekind ID '(' parameterList? ')' block;
classDecl: CLASS ID classBlock;

classBlock: '{'
    (declStmt | functionDecl | constructedDecl)*
'}'
;

constructedDecl: ID'('parameterList?')' block;

block: '{'
    stmt*
'}';

stmt: exprStmt
    | declStmt
    | loopStmt
    | jumpStmt
    | blankStmt
    | block
    ;


exprStmt: expr ';';

declStmt: typekind ID ('=' expr)? ';';

//If, While, For function
loopStmt: ifStmt | whileStmt | forStmt;
ifStmt: IF '(' ifcond=expr ')' ifBody=stmt (ELSE elseBody=stmt)?;
whileStmt: WHILE '(' expr ')' stmt;
forStmt: FOR '(' init=expr? ';' cond=expr? ';' incr=expr? ')' stmt;

//Jump Stmt
jumpStmt: breakStmt | continueStmt | returnStmt ;
returnStmt: RETURN expr? ';';//return maybe not Integer
breakStmt: BREAK ';';
continueStmt: CONTINUE ';';

blankStmt: ';';

array: type (square)+ ;

square: '[' expr? ']';

typekind: array | type;

type: token=BOOL | token=INT | token=STRING | token=VOID | token=ID;

expr:
    //expr op

     expr '(' exprList? ')'                    #FunctionCall
    | <assoc=right> NEW typekind                #New
    | mainexpr=expr '[' subexpr=expr? ']'       #Subscript
    | main=expr '.' member=expr                               #MemberAccess

    | <assoc=right> op=('++' | '--') expr       #UnaryExpr
    | <assoc=right> op=('+'|'-') expr           #UnaryExpr
    | <assoc=right> op=('!'| '~') expr          #UnaryExpr


    | lf=expr op=('*'|'/'|'%') rt=expr                #BinaryExpr
    | lf=expr op=('+'|'-') rt=expr                    #BinaryExpr
    | lf=expr op=('<<'|'>>') rt=expr                  #BinaryExpr
    | lf=expr op=('<'|'>') rt=expr                    #BinaryExpr
    | lf=expr op=('<='|'>=') rt=expr                  #BinaryExpr
    | lf=expr op=('=='|'!=') rt=expr                  #BinaryExpr
    | lf=expr op='&' rt=expr                          #BinaryExpr
    | lf=expr op='^' rt=expr                          #BinaryExpr
    | lf=expr op='|' rt=expr                          #BinaryExpr
    | lf=expr op='&&' rt=expr                         #BinaryExpr
    | lf=expr op='||' rt=expr                         #BinaryExpr
    | expr op=('++' | '--')                     #PostfixIncDec

    | <assoc=right> lf=expr op='=' rt=expr            #AssignExpr

    | ID                                      #IDExpr
    | literal                                   #LiteralExpr

    | '(' expr ')'                              #SubExpression

;

exprList: expr (',' expr)*;

parameterList: typekind ID (',' typekind ID)*;

literal: (token =(TRUE | FALSE)) | (token = Integer) | (token = String) | (token = NULL) | (token = THIS);
