# COOL Compiler 

😁️Report for LEXER Assignment By Revanth.R😁️
--------------------------------------------

Lexical analysis, lexing or tokenization is the process of converting a sequence of characters into a sequence of tokens. A program that performs lexical analysis may be termed a lexer, tokenizer or scanner, though scanner is also a term for the first stage of a lexer. A lexer is generally combined with a parser, which together analyze the syntax of programming languages, web pages, and so forth.
In this assignment, we need to implement only the lexer part.

The order of lexer rules is as follows:

1) Fragments of alphabets and STRING_BODY for convenience.
3) Then comes SEMICOLON and DARROW.
4) STR_CONST to deal with strings.
5) Then come keywords such as CLASS, IF etc.
6) After those, we define lexer rules for BOOL_CONST,TYPEID,OBJECTID,INT_CONST in this particular
   order.
7) Then operators and brackets.
8) Whitespace followed by rules for comments and nested comments.

Keywords and bool constants should be placed before typeid and objectid because the rules which come first take precedence.

----------------
 Error Handling
----------------
1. When an invalid character (one that can’t begin any token) is encountered, a string containing
   just that character is returned as the error string and resumes lexing at the following
   character.

2. If a string contains an unescaped newline, that error is reported as ”Unterminated string
   constant” and lexing is resumed from at the beginning of the next line — we assume the
   programmer simply forgot the close-quote.

3. When a string is too long, the error is reported as ”String constant too long” in the error
   string in the ERROR token. If the string contains invalid characters (i.e., the null character),
   this is reported as “String contains null character”. In either case, lexing is resumed after
   the end of the string. The end of the string is defined as either

   i.  The beginning of the next line if an unescaped newline occurs after these errors are
       encountered; or
   ii. After the closing ” otherwise.

4. If a comment remains open when EOF is encountered, this error is reported with the message ”EOF
   in comment”. The lexer does not tokenize the comment’s contents simply because the terminator is
   missing. Similarly for strings, if an EOF is encountered before the close-quote, this error is
   reported as ”EOF in string constant”.

5. If you see “*)” outside a comment, this error is reported as “Unmatched *)”, rather than
   tokenzing it as * and ).

-------------------------
 Lexer rule for strings
-------------------------

1. When " is encountered, the buf is reset to empty and the string state starts. When a non
   escaped " and non escaped \n is encountered in the string state, we print the respective
   errors.
 
2. In the string state, string length is checked whenever new piece of string is added to buf. It
   reports error if overflow occurs and prints that the string length is too long.

3. Replace \n, \t, \b, \f with a single char which corresponds to their escaped meaning.

4. Report error if null character is encountered.

5. For \c where c isn't equal to n,t,b,f, null return c itself.

6. When an escape is followed by a new line, just add a \n to the buf.

7. When a new line is encountered without an escape, reports error.

8. If EOF is encountered, reports error.

-------------------------
 Lexer rule for comments
-------------------------

1. If "--" is encountered, it is a single line comment. Encountering an EOF in a single
   line comment is not considered an erroneous case.

2. When "(*" is encountered, we enter the comment_mode. When EOF is encountered here, error is
   reported. 

3. A comment ends when it encounters "*)". If not, it reports an error for unmatched *).

4. For nested comments, I added an additional mode called incomment mode. Here we use recursive
   approach to checked for multiple nested comments.

------------
 TEST CASES
------------

As for the test cases, I will be submitting codes with different errors and types of comments and also the correct one too. This covers all the things we want to check for.

1. arith.cl :- This file is a test case which I found on the internet. It tests the lexer for all the cases in which there are no errors. It is quite a long program but it checks
               for every keyword and identifier.

2. Err1.cl :- This file has a unidentified character, unterminated string, backslash error.

3. Err2.cl :- This file has EOF in comment.

4. Err3.cl :- This file has unescaped new line problem which is shown as Unterminated string
              constant.

5. Err4.cl :- This file has null character error.

6. Err5.cl :- This file has escaped null character in string.

7. Err6.cl :- This file has EOF in string error, String const too long error and Unterminated string constant error. 

NOTE:-  Errors in the string constant are shown at the line at which the string starts in .cl file.
