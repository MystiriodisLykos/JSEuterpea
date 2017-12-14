// Generated by CoffeeScript 1.12.4

/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: utility_N.coffee
    * ----------------
    * This file contains what would be "static" utility functions
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

(function() {
  var andAnd, carrot, checkComment, checkName, colon, divEqual, doubleCarrot, doubleEquals, doubleStar, equalLessLess, getArrRange, getAssoc, getLineBreaks, getPres, greatEqual, greatGreat, greatGreatEqual, greater, isBuiltInFunc, isInt, isLetter, isSpecial, isSymbol, isWhiteSpace, lessThan, lessThanEqual, minus, money, moneyExclam, orOr, period, plus, slash, special, splitByLine, star, symbol;

  special = ['(', ')', ',', ';', '[', ']', '`', '{', '}'];

  symbol = [];

  period = {
    symbol: '.',
    pres: 9,
    assoc: 'r'
  };

  symbol.push(period);

  carrot = {
    symbol: "^",
    pres: 8,
    assoc: "r"
  };

  symbol.push(carrot);

  doubleCarrot = {
    symbol: "^^",
    pres: 8,
    assoc: "r"
  };

  symbol.push(doubleCarrot);

  doubleStar = {
    symbol: "**",
    pres: 8,
    assoc: "r"
  };

  symbol.push(doubleStar);

  star = {
    symbol: "*",
    pres: 7,
    assoc: "l"
  };

  symbol.push(star);

  slash = {
    symbol: "/",
    pres: 7,
    assoc: "l"
  };

  symbol.push(slash);

  plus = {
    symbol: "+",
    pres: 6,
    assoc: "l"
  };

  symbol.push(plus);

  minus = {
    symbol: "-",
    pres: 6,
    assoc: "l"
  };

  symbol.push(minus);

  colon = {
    symbol: ":",
    pres: 5,
    assoc: "r"
  };

  symbol.push(colon);

  doubleEquals = {
    symbol: "==",
    pres: 4,
    assoc: "n"
  };

  symbol.push(doubleEquals);

  divEqual = {
    symbol: "/=",
    pres: 4,
    assoc: "n"
  };

  symbol.push(divEqual);

  lessThan = {
    symbol: "<",
    pres: 4,
    assoc: "n"
  };

  symbol.push(lessThan);

  lessThanEqual = {
    symbol: "<=",
    pres: 4,
    assoc: "n"
  };

  symbol.push(lessThanEqual);

  greatEqual = {
    symbol: ">=",
    pres: 4,
    assoc: "n"
  };

  symbol.push(greatEqual);

  greater = {
    symbol: ">",
    pres: 4,
    assoc: "n"
  };

  symbol.push(greater);

  andAnd = {
    symbol: "&&",
    pres: 3,
    assoc: "r"
  };

  symbol.push(andAnd);

  orOr = {
    symbol: "||",
    pres: 2,
    assoc: "r"
  };

  symbol.push(orOr);

  greatGreat = {
    symbol: ">>",
    pres: 1,
    assoc: "l"
  };

  symbol.push(greatGreat);

  greatGreatEqual = {
    symbol: ">>=",
    pres: 1,
    assoc: "l"
  };

  symbol.push(greatGreatEqual);

  equalLessLess = {
    symbol: "=<<",
    pres: 1,
    assoc: "r"
  };

  symbol.push(equalLessLess);

  money = {
    symbol: "$",
    pres: 0,
    assoc: "r"
  };

  symbol.push(money);

  moneyExclam = {
    symbol: "$!",
    pres: 0,
    assoc: "r"
  };

  symbol.push(moneyExclam);

  isInt = function(value) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isInt(String value)
        * ----------------
        * This function takes a string returns true if it is an integer
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var c;
    c = value.charCodeAt(0);
    return (48 <= c && c <= 57);
  };

  isBuiltInFunc = function(char) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isBuiltInFunc(String value)
        * ----------------
        * This function takes a string and returns true if it is a keyword
        * This function needs to access the environment
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    if (isEnv(char)) {
      console.log(char + ' is a built in function');
    }
  };

  isSpecial = function(value) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isSpecial(String value)
        * ----------------
        * This function takes a string and determines if it is a special character
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var i, len, sc;
    for (i = 0, len = special.length; i < len; i++) {
      sc = special[i];
      if (sc === value) {
        return true;
      }
    }
    return false;
  };

  isSymbol = function(value) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isSymbol(String value)
        * ----------------
        * This function takes a string and determines if it is a symbol
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var i, len, s;
    for (i = 0, len = symbol.length; i < len; i++) {
      s = symbol[i];
      if (s.symbol === value) {
        return true;
      }
    }
    return false;
  };

  isLetter = function(value) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isLetter(String value)
        * ----------------
        * This function takes a string and determines if it is
        * a letter or an _
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var c;
    c = value.charCodeAt(0);
    return (65 <= c && c <= 90) || (97 <= c && c <= 122) || c === 95;
  };

  isWhiteSpace = function(value) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isWhiteSpace(String value)
        * ----------------
        * This function takes a string and determines if it is a space
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var c;
    c = value.charCodeAt(0);
    return c === 32;
  };

  getLineBreaks = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * getLineBreaks(String text)
        * ----------------
        * This function returns the number of line breaks in a string
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    return ((text.match(/\n/g)) || []).length;
  };

  splitByLine = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * splitByLine(String text)
        * ----------------
        * This functions takes a string and splits it into an array split by line breaks
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    return text.splitWithIndex('\n');
  };

  checkComment = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * checkComment(String text)
        * ----------------
        * Checks if the text is a comment or not
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    return text.length >= 2 && (text.substring(0, 2)) === '--';
  };

  getPres = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * getPres (String text)
        * ----------------
        * Gets the president of a particular text
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var i, len, s;
    for (i = 0, len = symbol.length; i < len; i++) {
      s = symbol[i];
      if (text === s.symbol) {
        return s.pres;
      }
    }
    return void 0;
  };

  getAssoc = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * getAssoc (String text)
        * ----------------
        * Gets the association of a particular text
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var i, len, s;
    for (i = 0, len = symbol.length; i < len; i++) {
      s = symbol[i];
      if (text === s.symbol) {
        return s.assoc;
      }
    }
    return void 0;
  };

  getArrRange = function(start, end, array) {
    console.trace();
    throw 'Use array.slice(start, end)\n';
  };

  checkName = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * checkName (String text)
        * ----------------
        * Checks if text is a valid variable name
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var ch, i, len;
    if (isInt(text[0])) {
      return false;
    }
    for (i = 0, len = text.length; i < len; i++) {
      ch = text[i];
      if (isSymbol(ch)) {
        return false;
      }
    }
    return true;
  };

  this.Utility = {
    splitByLine: splitByLine,
    isInt: isInt,
    isSpecial: isSpecial,
    isSymbol: isSymbol,
    isLetter: isLetter,
    isWhiteSpace: isWhiteSpace,
    checkComment: checkComment,
    getPres: getPres,
    getAssoc: getAssoc
  };

  String.prototype.splitWithIndex = function(delim) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * string.splitWithIndex (String delim)
        * ----------------
        * This is a string function for splitting said string on the delim and
        * returning a list where the second values are the splits and the first values
        * are the indices of the original string the split is at
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var i, index, len, res, s, splits;
    res = [];
    splits = this.split(delim);
    index = 0;
    for (i = 0, len = splits.length; i < len; i++) {
      s = splits[i];
      res.push([index, s]);
      index += s.length + delim.length;
    }
    return res;
  };

}).call(this);

//# sourceMappingURL=utility.js.map
