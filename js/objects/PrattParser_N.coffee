### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: PrattParser.coffee
    * -----------------
    * File containing the functions to parse a token string into ASTs
    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

PrattParser = (tokenStream) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * PrattParser([Tokens] tokenStream)
        * ----------------
        *
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
                minPresdx = i
    
