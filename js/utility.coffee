### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: utility_N.coffee
    * ----------------
    * This file contains what would be "static" utility functions
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

special = ['(', ')', ',', ';', '[', ']', '`', '{', '}']

symbol = []  # . !! ^ ^^ ** * / + - : ++ == /= < <= > >= && || >> >>= $ $!

period = {symbol: '.', pres: 9, assoc: 'r'}
symbol.push period

carrot = {symbol: "^", pres: 8, assoc: "r"};symbol.push carrot

doubleCarrot = {symbol: "^^", pres: 8, assoc: "r"};
symbol.push doubleCarrot

doubleStar = {symbol: "**", pres: 8, assoc: "r"};
symbol.push doubleStar

star = {symbol: "*", pres: 7, assoc: "l"};
symbol.push star

slash = {symbol: "/", pres: 7, assoc: "l"};
symbol.push slash

plus = {symbol: "+", pres: 6, assoc: "l"};
symbol.push plus

minus = {symbol: "-", pres: 6, assoc: "l"};
symbol.push minus

colon = {symbol: ":", pres: 5, assoc: "r"};
symbol.push colon

doubleEquals = {symbol: "==", pres: 4, assoc: "n"};
symbol.push doubleEquals

divEqual = {symbol: "/=", pres: 4, assoc: "n"};
symbol.push divEqual

lessThan = {symbol: "<", pres: 4, assoc: "n"};
symbol.push lessThan

lessThanEqual = {symbol: "<=", pres: 4, assoc: "n"};
symbol.push lessThanEqual

greatEqual = {symbol: ">=", pres: 4, assoc: "n"};
symbol.push greatEqual

greater = {symbol: ">", pres: 4, assoc: "n"};
symbol.push greater

andAnd = {symbol: "&&", pres: 3, assoc: "r"};
symbol.push andAnd

orOr = {symbol: "||", pres: 2, assoc: "r"};
symbol.push orOr

greatGreat = {symbol: ">>", pres: 1, assoc: "l"};
symbol.push greatGreat

greatGreatEqual = {symbol: ">>=", pres: 1, assoc: "l"};
symbol.push greatGreatEqual

equalLessLess = {symbol: "=<<", pres: 1, assoc: "r"};
symbol.push equalLessLess

money = {symbol: "$", pres: 0, assoc: "r"};
symbol.push money

moneyExclam = {symbol: "$!", pres: 0, assoc: "r"};
symbol.push moneyExclam

isInt = (value) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isInt(String value)
        * ----------------
        * This function takes a string returns true if it is an integer
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    c = value.charCodeAt 0
    return 48 <= c <= 57;

isBuiltInFunc = (char) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isBuiltInFunc(String value)
        * ----------------
        * This function takes a string and returns true if it is a keyword
        * This function needs to access the environment
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    if isEnv char
        console.log char + ' is a built in function'
    return

isSpecial = (value) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isSpecial(String value)
        * ----------------
        * This function takes a string and determines if it is a special character
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    for sc in special
        if sc == value
            return true
    return false

isSymbol = (value) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isSymbol(String value)
        * ----------------
        * This function takes a string and determines if it is a symbol
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    for s in symbol
        if s.symbol == value
            return true
    return false

isLetter = (value) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isLetter(String value)
        * ----------------
        * This function takes a string and determines if it is
        * a letter or an _
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    c = value.charCodeAt 0
    return 65 <= c <= 90 or 97 <= c <= 122 or c == 95

isWhiteSpace = (value) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isWhiteSpace(String value)
        * ----------------
        * This function takes a string and determines if it is a space
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    c = value.charCodeAt 0
    return c == 32

getLineBreaks = (text) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * getLineBreaks(String text)
        * ----------------
        * This function returns the number of line breaks in a string
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    return ((text.match /\n/g) or []).length

splitByLine = (text) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * splitByLine(String text)
        * ----------------
        * This functions takes a string and splits it into an array split by line breaks
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    return text.splitWithIndex '\n'
#    ret = []
#    for s in split
#        ret.push s
#    return ret

checkComment = (text) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * checkComment(String text)
        * ----------------
        * Checks if the text is a comment or not
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    return text.length >= 2 and (text.substring 0, 2) == '--'

getPres = (text) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * getPres (String text)
        * ----------------
        * Gets the president of a particular text
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    for s in symbol
        if text == s.symbol
            return s.pres
    return undefined

getAssoc = (text) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * getAssoc (String text)
        * ----------------
        * Gets the association of a particular text
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    for s in symbol
        if text == s.symbol
            return s.assoc
    return undefined

getArrRange = (start, end, array) ->
    console.trace()
    throw 'Use array.slice(start, end)\n'

checkName = (text) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * checkName (String text)
        * ----------------
        * Checks if text is a valid variable name
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    if isInt(text[0])
        return false
    for ch in text
        if isSymbol(ch)
            return false
    return true

@Utility = {
    splitByLine: splitByLine,
    isInt: isInt,
    isSpecial: isSpecial,
    isSymbol: isSymbol,
    isLetter: isLetter,
    isWhiteSpace: isWhiteSpace,
    checkComment: checkComment,
    getPres: getPres,
    getAssoc: getAssoc
}


String::splitWithIndex = (delim) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * string.splitWithIndex (String delim)
        * ----------------
        * This is a string function for splitting said string on the delim and
        * returning a list where the second values are the splits and the first values
        * are the indices of the original string the split is at
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    res = []
    splits = this.split(delim)
    index = 0
    for s in splits
        res.push([index, s])
        index += s.length + delim.length
    return res
