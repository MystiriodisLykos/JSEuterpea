### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: Token.coffee
    * -----------------
    * Contains code to create Tokens and to tokenize a string array
    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

tokenTypes =
    '^=': 'Equals',
    '^\\s+': 'White Space',
    '^[a-zA-Z]': 'Name',
    '^\\d+\\.?\\d*': 'Number',
    '^[()\\[\\]{},;`]': 'Special'
    '^(\\.|!{2}|\\*{1,2}|\\^{1,2}|/=?|\\+{1,2}|-|:|==|[<>]{1,2}=?|&&|\\|\\||\\$!?)': 'Symbol'

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
    indLevels = [0]
    res = []
    for [row, s] in lineArr
        col = 0
        re = new RegExp '^\\s+'
        ind = if re.test s then (re.exec s)[0].length else 0
        s.replace re, ''
        col = ind
        if ind > indLevels[indLevels.length-1]
            res.push (new Token '', row, ind, 'Indent')
            indLevels.push ind
        else
            if ind < indLevels[indLevels.length-1]
                dedents = indLevels.indexOf ind
                if dedents == -1
                    throw 'Inconsistent Indents'
                for _ in indLevels.length - dedents - 1
                    res.push (new Token '', row, ind, 'Dedent')
                    indLevels.pop()
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
                throw 'Unknown character at (Row:' + row + ', Col:' + col
        res.push (new Token '\n', col, row, 'Newline')
    if indLevels.length > 1
        for _ in indLevels.length - 1
            res.push (new Token '', 0, row+1, 'Dedent')
    return res