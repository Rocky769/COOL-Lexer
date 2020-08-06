lexer grammar CoolLexer;

tokens{
	ERROR,
	TYPEID,
	OBJECTID,
	BOOL_CONST,
	INT_CONST,
	STR_CONST,
	LPAREN,
	RPAREN,
	COLON,
	ATSYM,
	SEMICOLON,
	COMMA,
	PLUS,
	MINUS,
	STAR,
	SLASH,
	TILDE,
	LT,
	EQUALS,
	LBRACE,
	RBRACE,
	DOT,
	DARROW,
	LE,
	ASSIGN,
	CLASS,
	ELSE,
	FI,
	IF,
	IN,
	INHERITS,
	LET,
	LOOP,
	POOL,
	THEN,
	WHILE,
	CASE,
	ESAC,
	OF,
	NEW,
	ISVOID,
	NOT
}

/*
  DO NOT EDIT CODE ABOVE THIS LINE
*/

@members{
	/*
		YOU CAN ADD YOUR MEMBER VARIABLES AND METHODS HERE
	*/
	/**
	* Function to report errors.
	* Use this function whenever your lexer encounters any erroneous input
	* DO NOT EDIT THIS FUNCTION
	*/
	public void reportError(String errorString){
		setText(errorString);
		setType(ERROR);
	}

	public void notFound() {
		Token t = _factory.create(_tokenFactorySourcePair, _type, _text, _channel, _tokenStartCharIndex, getCharIndex()-1, _tokenStartLine, _tokenStartCharPositionInLine);
		String text = t.getText();
		reportError(text);
	}

	public void processString() {
		Token t = _factory.create(_tokenFactorySourcePair, _type, _text, _channel, _tokenStartCharIndex, getCharIndex()-1, _tokenStartLine, _tokenStartCharPositionInLine);
		String text = t.getText();

		boolean eof = false, unterminated = false, bslash = false; /* Setting booleans for each case */
		int text_length = text.length();

		if(text.charAt(text_length-1) == '\n'){  /* Unterminated string constant error */
			unterminated = true;
		}

		else if(text.charAt(text_length-1) == '\\'){
			bslash = true;
		}
		else if (text.charAt(text_length-1) != '"'){ /* EOF error */
			eof = true;
		}

		String buf = "";
		int len = 0;
		//write your code to test strings here
			for(int i = 1; i < text_length-1; ++i){
				if(text.charAt(i) == '\u0000'){
					reportError("String contains null character.");  /* Null char error */
					return;
				}
				if(text.charAt(i) == '\\'){ 						/* Escape char in string */
					if(text.charAt(i+1) == 'n'){
						buf = buf + '\n';
					}
					else if(text.charAt(i+1) == 'f'){
						buf = buf + '\f';
					}
					else if(text.charAt(i+1) == 't'){
						buf = buf + '\t';
					}
					else if(text.charAt(i+1) == 'r'){
						buf = buf + '\r';
					}
					else if(text.charAt(i+1) == '\"'){
						if (i>1 && i == text_length-2){   					/* EOF error */
							eof = true;
							break;
						}
						buf = buf + '\"';
					}
					else if(text.charAt(i+1) == '\\'){
						if (i>1 && i == text_length-2){							/* EOF error */
							eof = true;
							bslash = false;
							break;
						}
						buf = buf + '\\';
					}
					else if(text.charAt(i+1) == '\u0000'){
						reportError("String contains escaped null character.");	/* Escaped null char error */
						return;
					}
					else if (text.charAt(i+1) == '\n'){
						if (i>1 && i == text_length-2){						/* EOF error */
							eof = true;
							unterminated = false;
							break;
						}
						buf = buf + '\n';
					}
					else{
						buf = buf + text.charAt(i+1);
					}
					i++;
				}
				else{
					buf = buf + text.charAt(i);
				}
				len ++;
				if(len > 1024) {
					reportError("String constant too long");   /* String constant too long error */
					return;
				}
			}
			if(eof){
				reportError("EOF in string constant");   /* EOF error */
				return;
			}
			if(bslash){
				reportError("backslash at end of file");   /* backslash error */
				return;
			}
			if(unterminated){
				reportError("Unterminated string constant");  /* Unterminated string error */
				return;
			}

		setText(buf);
		return;
	}
}

/*
	WRITE ALL LEXER RULES BELOW
*/

fragment A:('a'|'A');
fragment B:('b'|'B');
fragment C:('c'|'C');
fragment D:('d'|'D');
fragment E:('e'|'E');
fragment F:('f'|'F');
fragment G:('g'|'G');
fragment H:('h'|'H');
fragment I:('i'|'I');
fragment J:('j'|'J');
fragment K:('k'|'K');
fragment L:('l'|'L');
fragment M:('m'|'M');
fragment N:('n'|'N');
fragment O:('o'|'O');
fragment P:('p'|'P');
fragment Q:('q'|'Q');
fragment R:('r'|'R');
fragment S:('s'|'S');
fragment T:('t'|'T');
fragment U:('u'|'U');
fragment V:('v'|'V');
fragment W:('w'|'W');
fragment X:('x'|'X');
fragment Y:('y'|'Y');
fragment Z:('z'|'Z');
fragment STRING_BODY   : ( '\\'(.) | (.));   /* Fragments for convenience */

SEMICOLON : ';' ;
DARROW : '=>' ;

STR_CONST         : ('"')(STRING_BODY)*?(('"')|(('\\')?(EOF))|('\n')) {processString();};

/* as for keywords, they are not case sensitive */

CLASS: C L A S S;
ELSE: E L S E;
FI: F I;
IF: I F;
IN: I N;
INHERITS: I N H E R I T S;
LET: L E T;
LOOP: L O O P;
POOL: P O O L;
THEN: T H E N;
WHILE: W H I L E;
CASE: C A S E;
ESAC: E S A C;
OF: O F;
NEW: N E W;
ISVOID: I S V O I D;
NOT: N O T;

BOOL_CONST : [t] R U E | [f] A L S E; /* since the first letter should be small */
TYPEID : [A-Z][a-zA-Z0-9_]* ;
OBJECTID : [a-z][a-zA-Z0-9_]* ;
INT_CONST : [0-9]+ ;

LPAREN : '(' ;
RPAREN : ')' ;
COLON : ':' ;
ATSYM : '@' ;
COMMA : ',' ;
PLUS : '+' ;
MINUS : '-' ;
STAR : '*' ;
SLASH : '/' ;
TILDE : '~' ;
LT : '<' ;
EQUALS : '=' ;
LBRACE : '{' ;
RBRACE : '}' ;
DOT : '.' ;
LE : '<=' ;
ASSIGN : '<-' ;

WS			: ([ \t\r\n\f] | '\u000b')+ -> skip ;	/* skips spaces, tabs, newlines */

/* FOR DIFFERENT KINDS OF COMMENTS */

LINE_COMMENT : '--' .*? ('\n'|(EOF)) -> skip ;  													/* SINGLE LINE COMMENT CASE */
END_COMMENT	: '*)' EOF { reportError("Unmatched *)"); } ;					/* END OF COMMENT */
INCOMPLETE_COMMENT : '*)' { reportError("Unmatched *)"); } ;			/* INCOMPLETE COMMENT */
ERRS		: '(*' EOF { reportError("EOF in comment"); } ;
COMMENT : '(*'-> pushMode(COMMENT_MODE), skip;										/* START OF COMMENT */
NOTFOUND : . { notFound(); } ;

mode COMMENT_MODE;

ERR : .(EOF) { reportError("EOF in comment"); } ;    							/* IF EOF IS IN COMMENT */
ERRP		: '(*' EOF { reportError("EOF in comment"); } ;
OPENCOMMENT : '(*' -> pushMode(INCOMMENT), skip ;									/* START OF NESTED COMMENT */
CLOSECOMMENT : '*)' -> popMode, skip ;														/* END OF NESTED COMMENT */
IN_COMMENT_TEXT : . -> skip ;

mode INCOMMENT;
ERR2		: .(EOF) { reportError("EOF in comment"); } ;   			/* NESTED COMMENT CASE */
OPEN_COM		: '(*' -> pushMode(INCOMMENT), skip ;
ERR3		: '*)' EOF { reportError("EOF in comment"); } ;
CLOSE_COM		: '*)' -> popMode, skip ;
COMMENT_TEXT	: . -> skip ;
