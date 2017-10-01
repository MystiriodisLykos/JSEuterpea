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
    return if token.type in ['Name', 'Integer'] then true else false

nonWhiteSpace = (tokenStream) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * nonWhiteSpace([Token] tokenStream)
        * ----------------
        * Returns the number of non white space tokens in tokenStream
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    nonWS = 0
    for curToken in tokenStream
        if curToken.type not in ['White Space', 'Newline']
            nonWS++
    return nonWS

findNonWhite = (tokenStream) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * findNonWhite([Token] tokenStream)
        * ----------------
        * Returns the first non white space token in tokenStream
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    for curToken in tokenStream
        if curToken.type not in ['White Space', 'Newline']
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
        if not (curToken instanceof Token)
            return curToken
        switch curToken.type
            when 'Integer' then \
                return createAstConst curToken
            when 'Name' or 'Symbol' then \
                return createAstVar curToken
    minPres = 9
    minPresIdx = 0
    for curToken, i in tokenStream
        if curToken.type not in ['White Space', 'Newline']
            if curToken.pres < minPres
                minPres = curToken.pres
                minPresIdx = i
    tokenStreamL = tokenStream.slice 0, minPresIdx
    tokenStreamR = tokenStream.slice minPresIdx + 1
    astL = PrattParser tokenStreamL
    astR = PrattParser tokenStreamR
    operator = createAstVar tokenStream[minPresIdx]
    return createAstApp operator, astL, astR

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
        if curToken.type != 'White Space'
            if parens
                if curToken.body == ')'
                    parens = false
                    operator = true
            else if curToken.body == '('
                endP = -1
                for endToken, j in tokenStream[i+1..]
                    if endToken.body == ')'
                        endP = j + i + 1;
                        break
                if endP == -1
                    console.log('Error Missing closing ")"')
                else
                    res.push(PrattParser(preParse tokenStream[(i+1)...endP]))
                parens = true

            else if not operator
                operator = true
                if not isOperand curToken
                    console.log "Error"
                    console.log curToken
                else
                    res.push curToken

            else if operator
                operator = false
                if curToken.body == '-' and tokenStream[i - i] and not isOperand tokenStream[i - 1]
                    {body, column, row, type, pres, assoc} = curToken
                    res.push(new Token -body, column, row, type, pres, assoc)
                else if isOperand(curToken)
                    fn = PrattParser [res.pop()]
                    arg = PrattParser [curToken]
                    res.push(createAstApp fn, arg)
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
            name = if tokenStream[i-1].type == 'White Space' then tokenStream[i-2] else tokenStream[i-1]
            idx = -1
            for endToken, j in tokenStream[(i+1)..]
                if endToken.type == 'Newline'
                    if tokenStream[j+i+2]
                        if tokenStream[j+i+2].type != 'White Space'
                            idx = j + i + 1
                            break
                    else
                        idx = j + i + 1
                        break
            body = tokenStream[i+1...idx]
            retAst = PrattParser(preParse body)
            defArr.push(createAstDef name, retAst)
    createDefs(defArr)
