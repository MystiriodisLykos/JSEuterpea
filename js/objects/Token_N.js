// Generated by CoffeeScript 1.12.4

/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: Token.coffee
    * -----------------
    * Contains code to create Tokens and to tokenize a string array
    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

(function() {
  this.Token = (function() {
    function Token(body1, column, row1, type1, pres1, assoc1) {
      this.body = body1;
      this.column = column;
      this.row = row1;
      this.type = type1;
      this.pres = pres1;
      this.assoc = assoc1;

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * constructor (body, Int column, Int row, String type, Int pres, Int assoc)
          * ----------------
          * Constructor for a Token.
          * type :: [EQUAL, WHITE SPACE, NAME, NUMBER, SPECIAL, SYMBOL, INDENT, DEDENT]
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
    }

    return Token;

  })();

  this.tokenize = function(lineArr) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * tokenize ([String] lineArr)
        * ----------------
        * lineArr is an array of strings where each string is a line of input
        * Turns the lineArr into an array of Tokens
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var _, assoc, body, col, dedents, i, ind, indLevels, j, k, len, match, pres, re, ref, ref1, ref2, res, row, s, tokenTypes, type;
    tokenTypes = {
      '^=': 'EQUAL',
      '^\\s+': 'WHITE SPACE',
      '^[a-zA-Z]\\w*': 'NAME',
      '^\\d+\\.?\\d*': 'NUMBER',
      '^[()\\[\\]{},;`]': 'SPECIAL',
      '^(\\.|!{2}|\\*{1,2}|\\^{1,2}|/=?|\\+{1,2}|-|:|==|[<>]{1,2}=?|&&|\\|\\||\\$!?)': 'SYMBOL',
      '^return': 'RETURN'
    };
    indLevels = [0];
    res = [];
    for (i = 0, len = lineArr.length; i < len; i++) {
      ref = lineArr[i], row = ref[0], s = ref[1];
      re = new RegExp('^\\s+');
      ind = re.test(s) ? (re.exec(s))[0].length : 0;
      s = s.replace(re, '');
      col = ind;
      if (ind > indLevels[indLevels.length - 1]) {
        res.push(new Token('', row, ind, 'INDENT'));
        indLevels.push(ind);
      } else {
        if (ind < indLevels[indLevels.length - 1]) {
          dedents = indLevels.indexOf(ind);
          if (dedents === -1) {
            throw 'Inconsistent Indent on Line: ' + row;
          }
          for (_ = j = 0, ref1 = indLevels.length - dedents - 1; 0 <= ref1 ? j < ref1 : j > ref1; _ = 0 <= ref1 ? ++j : --j) {
            res.push(new Token('', row, ind, 'DEDENT'));
            indLevels.pop();
          }
        }
      }
      while (s !== '') {
        match = false;
        for (re in tokenTypes) {
          type = tokenTypes[re];
          re = new RegExp(re);
          if (re.test(s)) {
            match = true;
            body = (re.exec(s))[0];
            pres = getPres(body);
            assoc = getAssoc(body);
            if (type === 'NUMBER') {
              body = parseFloat(body);
            }
            res.push(new Token(body, col, row, type, pres, assoc));
            col += body.length;
            s = s.replace(re, '');
            break;
          }
        }
        if (!match) {
          throw 'Unknown character at (Row:' + row + ', Col:' + col;
        }
      }
      res.push(new Token('\n', col, row, 'NEWLINE'));
    }
    if (indLevels.length > 1) {
      for (_ = k = 0, ref2 = indLevels.length - 1; 0 <= ref2 ? k < ref2 : k > ref2; _ = 0 <= ref2 ? ++k : --k) {
        res.push(new Token('', 0, row + 1, 'DEDENT'));
      }
    }
    return res;
  };

}).call(this);

//# sourceMappingURL=Token_N.js.map
