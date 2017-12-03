### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: Token.coffee
    * -----------------
    * Contains code to create Tokens and to tokenize a string array
    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

class Token
    constructor: (@body, @column, @row, @type, @pres, @assoc) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * constructor (body, Int column, Int row, String type, Int pres, Int assoc)
            * ----------------
            * Constructor for a Token.
            * type :: [EQUAL, WHITE SPACE, NAME, NUMBER, SPECIAL, SYMBOL, INDENT, DEDENT]
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

tokenize = (lineArr) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * tokenize ([String] lineArr)
        * ----------------
        * lineArr is an array of strings where each string is a line of input
        * Turns the lineArr into an array of Tokens
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    # Regex for each type of token
    tokenTypes =
        '^=': 'EQUAL',
        '^\\s+': 'WHITE SPACE',
        '^[a-zA-Z]\\w*': 'NAME',
        '^\\d+\\.?\\d*': 'NUMBER',
        '^[()\\[\\]{},;`]': 'SPECIAL',
        '^(\\.|!{2}|\\*{1,2}|\\^{1,2}|/=?|\\+{1,2}|-|:|==|[<>]{1,2}=?|&&|\\|\\||\\$!?)': 'SYMBOL',
        '^return': 'RETURN'
    indLevels = [0]  # Stack for keeping track of indentation levels
    res = []  # Result tokenStream
    for [row, s] in lineArr  # Go through each line (row is the row index: s is the string for that row)
        # Finds the number of whitespace characters at the start of the line that indicates the indentation
        re = new RegExp '^\\s+'
        ind = if re.test s then (re.exec s)[0].length else 0
        s = s.replace re, ''  # Remove indentation white space
        col = ind  # set the column index to the end of the indentation
        if ind > indLevels[indLevels.length-1]
            # If the level of indentation is greater than the largest found so far
            res.push (new Token '', row, ind, 'INDENT')  # add an Indent token to the result
            indLevels.push ind  # Push the Indent level to the stack
        else
            if ind < indLevels[indLevels.length-1]
                # If the level of indentation is strictly less than the less than the max indentation
                # Then the dedents need to be added
                dedents = indLevels.indexOf ind  # Number of dedents
                if dedents == -1
                    # If this level of indentation does not exits in the stack than the indentation is inconsistent
                    throw 'Inconsistent Indent on Line: ' + row
                for _ in [0...indLevels.length - dedents - 1]
                    # Add an appropriate number of dedent Tokens
                    res.push (new Token '', row, ind, 'DEDENT')
                    indLevels.pop()
        while s != ''  # While loop used to process the single line
            match = false  # Is a match found yet
            for re, type of tokenTypes  # Go through all the regular expressions for types of tokens
                re = new RegExp re  # Compile re
                if re.test s  # If this token matches this regular expression
                    match = true;
                    body = (re.exec s)[0]  # Grab the match
                    pres = getPres body  # Grab the precedent
                    assoc = getAssoc body  # Grab the association
                    if type == 'NUMBER'
                        # Turn body to a float if it is a number
                        body = parseFloat(body)
                    res.push(new Token body, col, row, type, pres, assoc)  # Add the token
                    col += body.length  # Increment the column
                    s = s.replace re, ''  # Remove string corresponding the token.
                    break
            if not match
                # If a match was not found using the regex
                throw 'Unknown character at (Row:' + row + ', Col:' + col
        res.push (new Token '\n', col, row, 'NEWLINE')  # Add a new line token
    if indLevels.length > 1
        # If the length is greater than 1 there are Indent tokens that are not matched with a Dedent token
        for _ in [0...indLevels.length - 1]
            # Add the appropriate number of Dedent Tokens
            res.push (new Token '', 0, row+1, 'DEDENT')
    return res

@Token =
    Token: Token,
    tokenize: tokenize