### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: environment.js
    * -----------------
    * This file contains all the environment syntax
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
special = ['(', ')', ',', ';', '[', ']', '`', '{', '}']

symbol = []

period = {symbol: '.', pres: 9, assoc: 'r'}
symbol.push period

carrot = {symbol: "^", pres: 8, assoc: "r"};
symbol.push carrot

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

@environment = {
    special: special,
    symbol: symbol
}