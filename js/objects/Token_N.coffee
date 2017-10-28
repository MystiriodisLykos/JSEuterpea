### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: Token.coffee
    * -----------------
    * Contains code to create Tokens and to tokenize a string array
    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

tokenTypes =
    '^\\s+': 'White Space',
    '^\\d+\\.?\\d*': 'Number',
    '^[()\\[\\]{},;`]': 'Special'
#    '^[.^^^***/+-:==/=<<=>=>&&>>>>==<<$$!]': 'Symbol'  Need to figure out symbol regex

class @Token
    constructor: (@body, @column, @row, @type, @pres, @assoc) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * constructor (body, Int column, Int row, String type, Int pres, Int assoc)
            * ----------------
            * Constructor for a Token.
            * type :: [Integer, Special, White Space, Symbol, Name]
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

@tokenize = (lineArr) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * tokenize ([String] lineArr)
        * ----------------
        * Takes a token and decided if its an Operand(true) or an Operator(false)
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    res = []
    for [row, s] in lineArr
        col = 0
        while s != ''
            match = false;
            for re, type of tokenTypes
                re = new RegExp re
                if re.test s
                    body = (re.exec s)[0]
                    match = true;
                    pres = getPres body
                    assoc = getAssoc body
                    res.push(new Token body, col, row, type, pres, assoc)
                    col += body.length
                    s = s.replace re, ''
                    break
            if not match
                throw 'Unknown character'
    return res