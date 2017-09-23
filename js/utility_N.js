// Generated by CoffeeScript 1.12.4

/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: utility.js
    * ----------------
    * This file contains what would be "static" utility functions
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

(function() {
  this.isInt = function(value) {

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

  this.sBuiltInFunc = function(char) {

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

  this.isSpecial = function(value) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isSpecial(String value)
        * ----------------
        * This function takes a string and determines if it is a special character
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var j, len, sc;
    for (j = 0, len = special.length; j < len; j++) {
      sc = special[j];
      if (sc === value) {
        return true;
      }
    }
    return false;
  };

  this.isSymbol = function(value) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * isSymbol(String value)
        * ----------------
        * This function takes a string and determines if it is a symbol
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var j, len, s;
    for (j = 0, len = symbol.length; j < len; j++) {
      s = symbol[j];
      if (s.symbol === value) {
        return true;
      }
    }
    return false;
  };

  this.isLetter = function(value) {

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

  this.isWhiteSpace = function(value) {

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

  this.getLineBreaks = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * getLineBreaks(String text)
        * ----------------
        * This function returns the number of line breaks in a string
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    return ((text.match(/\n/g)) || []).length;
  };

  this.splitByLine = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * splitByLine(String text)
        * ----------------
        * This functions takes a string and splits it into an array split by line breaks
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    return text.splitWithIndex('\n');
  };

  this.checkComment = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * checkComment(String text)
        * ----------------
        * Checks if the text is a comment or not
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    return text.length >= 2 && (text.substring(0, 2)) === '--';
  };

  this.cleanWhiteSpace = function(tokenStream) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * cleanWhiteSpace(TokenStream tokenStream)
        * ----------------
        * Makes redundant whitespace types into one whitespace from the TokenStream
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var body, i, j, nt, ref, res, t1, t2;
    res = [];
    for (i = j = 0, ref = tokenStream.length - 1; j <= ref; i = j += 1) {
      t1 = tokenStream[i];
      t2 = tokenStream[i + 1];
      if (t1.type === 'White Space' && t2.type === 'White Space') {
        body = t1.body + t2.body;
        nt = new Token(body, t1.column, t1.row, 'White Space');
        res.push(nt);
      } else {
        res.push(t1);
      }
      if (i === tokenStream.length - 2) {
        res.push(t2);
      }
    }
    return res;
  };

  this.getPres = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * getPres (String text)
        * ----------------
        * Gets the president of a particular text
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var j, len, s;
    for (j = 0, len = symbol.length; j < len; j++) {
      s = symbol[j];
      if (text === s.symbol) {
        return s.pres;
      }
    }
    return void 0;
  };

  this.getAssoc = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * getAssoc (String text)
        * ----------------
        * Gets the association of a particular text
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var j, len, s;
    for (j = 0, len = symbol.length; j < len; j++) {
      s = symbol[j];
      if (text === s.symbol) {
        return s.assoc;
      }
    }
    return void 0;
  };

  this.getArrRange = function(start, end, array) {
    console.trace();
    throw 'Use array.slice(start, end)\n';
  };

  this.checkName = function(text) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * checkName (String text)
        * ----------------
        * Checks if text is a valid variable name
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var ch, j, len;
    if (isInt(text[0])) {
      return false;
    }
    for (j = 0, len = text.length; j < len; j++) {
      ch = text[j];
      if (isSymbol(ch)) {
        return false;
      }
    }
    return true;
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
    var index, j, len, res, s, splits;
    res = [];
    splits = this.split(delim);
    index = 0;
    for (j = 0, len = splits.length; j < len; j++) {
      s = splits[j];
      res.push([index, s]);
      index += s.length + delim.length;
    }
    return res;
  };

}).call(this);

//# sourceMappingURL=utility_N.js.map
