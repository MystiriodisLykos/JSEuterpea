### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: PrattParser.coffee
    * -----------------
    * File containing the functions to parse a token string into ASTs
    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

isOperand = (token) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isOperand(Token token)
        * ----------------
        * Takes a token and decided if its an Operand(true) or an Operator(false)
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    return if token.type in ['NAME', 'NUMBER'] then true else false

nonWhiteSpace = (tokenStream) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * nonWhiteSpace([Token] tokenStream)
        * ----------------
        * Returns the number of non white space tokens in tokenStream
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    nonWS = 0
    for curToken in tokenStream
        if curToken.type not in ['WHITESPACE', 'NEWLINE']
            nonWS++
    return nonWS

findNonWhite = (tokenStream) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * findNonWhite([Token] tokenStream)
        * ----------------
        * Returns the first non white space token in tokenStream
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    for curToken in tokenStream
        if curToken.type not in ['WHITESPACE', 'NEWLINE']
            return curToken

PrattParser = (tokenStream) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * PrattParser([Token] tokenStream)
        * ----------------
        * Turns the tokenStream into one large AST recursively
        * The tokenStream may contain predefined ASTs
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    if (nonWhiteSpace tokenStream) == 1
        curToken = findNonWhite tokenStream
        if not (curToken.constructor.name == 'Token')
            return curToken
        switch curToken.type
            when 'NUMBER' then \
                return new AST.Const curToken
            when 'NAME' or 'SYMBOL' then \
                return new AST.Var curToken
    minPres = 9
    minPresIdx = 0
    for curToken, i in tokenStream
        if curToken.type not in ['WHITE SPACE', 'NEWLINE']
            if curToken.pres <= minPres
                minPres = curToken.pres
                minPresIdx = i
    tokenStreamL = tokenStream.slice 0, minPresIdx
    tokenStreamR = tokenStream.slice minPresIdx + 1
    astL = PrattParser tokenStreamL
    astR = PrattParser tokenStreamR
    operator = new AST.Var tokenStream[minPresIdx]
    return new AST.App operator, astL, astR

preParse = (tokenStream) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * preParser([Token] tokenStream)
        * ----------------
        * This part of the parser creates ASTs out of function calls (ex. f x where f is the function x is the arg)
        * and creates ASTs out of things grouped into parentheses.
        * The return value is the tokenStream with these ASTs inserted
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    res = []
    operator = false  # false: Haven't found an operator | true: Have found an operator
    parens = false  # false: Not inside of parens | true: parsing inside of parens       parens :: ()
    for curToken, i in tokenStream
        if curToken.type != 'WHITE SPACE' and curToken.type != 'NEWLINE'
            if parens
                if curToken.body == ')' and i == endP
                    parens = false
                    operator = true
            else if curToken.body == '('
                endP = -1
                parNum = 1
                for endToken, j in tokenStream[i+1..]
                    if endToken.body == '('
                        parNum++
                    else if endToken.body == ')'
                        parNum--
                    if parNum == 0
                        endP = j + i + 1;
                        break
                if endP == -1
                    console.log('Error Missing closing ")"')
                else
                    res.push(PrattParser(preParse tokenStream[(i+1)...endP]))
                parens = true
            else if not operator  # Looking for an operand
                operator = true
                if curToken.body == '-' and (not tokenStream[i - 1] or not isOperand tokenStream[i - 1])
                    {column, row} = curToken
                    res.push(new Token.Token 0, column-1, row, 'NUMBER')
                    res.push(curToken)
                    operator = false
                else if not isOperand curToken
                    console.log "Error"
                    console.log curToken
                else
                    res.push curToken
            else if operator  # Looking for an operator
                operator = false
                if isOperand(curToken)
                    fn = PrattParser [res.pop()]
                    arg = PrattParser [curToken]
                    res.push(new AST.App fn, arg)
                    operator = true
                else
                    res.push curToken
    return res

@parser = (tokenStream) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * parser([Token] tokenStream) Global
        * ----------------
        * Global function that takes tokenStream and turns it into an array of
        * ASTDefinitions that get added to the enviornmnet
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    name = ''
    body = ''
    defArr = []
    for curToken, i in tokenStream
        if curToken.body == '='
#            name = if tokenStream[i-1].type == 'White Space' then tokenStream[i-2] else tokenStream[i-1]

            args = []
            name = ''
            backwards = tokenStream[...i].reverse()
            for e, j in backwards
                if e.type != 'WHITE SPACE' and e.body != ':'
                    if not backwards[j+1] or not backwards[j+2] or \
                       backwards[j+1].type == 'NEWLINE' or backwards[j+2].type == 'NEWLINE'
                        name = e
                        break
                    if backwards[j+1].body == ':' or backwards[j+2].body == ':'
                        args.unshift(e)
                    else
                        args.unshift(e)
                        if backwards[j+1].type == 'WHITE SPACE'
                            name = backwards[j+2]
                        else
                            name = backwards[j+1]
                        break

            idx = -1
            for endToken, j in tokenStream[(i+1)..]
                if endToken.type == 'NEWLINE'
                    if tokenStream[j+i+2]
                        if tokenStream[j+i+2].type != 'WHITESPACE'
                            idx = j + i + 1
                            break
                    else
                        idx = j + i + 1
                        break
            body = tokenStream[i+1...idx]
            retAst = PrattParser(preParse body)

            if args.length > 0
                retAst = new AST.Lambda retAst, args...

            window.envP = (new AST.Def name, retAst, window.envP).eval window.envP
#    e = window.envP
#    while e != null
#        e.val.e = window.envP
#        e = e.parent

    return