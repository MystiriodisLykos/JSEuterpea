/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ** File: token.js
 ** ----------------
 ** Contains the code which tokenizes an array of Strings
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ** Token(int row, int column, String body, String type,int pres,String assoc)
 ** ----------------
 ** Basic constructor for the Token
 ** Types Possible:
 ** 		Integer
 ** 		Special
 ** 		White Space
 ** 		Symbol
 ** 		Name
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
function Token(body, column, row, type, pres, assoc) {
    this.body = body;
    this.column = column;
    this.row = row;
    this.type = type;
    this.pres = pres;
    this.assoc = assoc;
}

/*
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * tokenize(String [] strArr)
 * Determines what type of token
 * is in the strArr * Returns an associative array with the type associated
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */
function tokenize(lineArr) {
    tokenStream = []; // empty array
    for (var i = 0; i < lineArr.length; i++) { // loop through the rows
        var line = lineArr[i][1];
        var length = line.length;
        var p;
        var c;
        var foundToken = false;
        for (var j = 0; j < length; j++) { // loop through the columns;
            p = j;
            c = line.charAt(j);
            if (Utility.isInt(c)) { // IsInteger
                while (Utility.isInt(c)) {
                    if (p == line.length) {
                        break;
                    }
                    p++;
                    c = line.charAt(p);
                } // close while
                var body = parseInt(line.substring(j, p));
                var newToken = new Token(body, j, i, "Integer");
                tokenStream.push(newToken);
                j = p;
                c = line.charAt(p);
                foundToken = true;
            } else if (Utility.isSpecial(c)) { // Every special is its own token
                var tokenBody = c;
                var newToken = new Token(tokenBody, j, i, "Special");
                p++;
                j = p;
                c = line.charAt(p);
                tokenStream.push(newToken);
                foundToken = true;
            } else if (Utility.isSymbol(c)) {
                while (Utility.isSymbol(c)) {
                    if (p == line.length) {
                        break;
                    }
                    p++;
                    c = line.charAt(p);
                }
                var tokenBody = line.substring(j, p);
                var isComment = Utility.checkComment(tokenBody);
                if (isComment) {	// comment code
                    tokenBody = line.substring(j, line.length);
                    var commentToken = new Token(tokenBody, j, i, "White Space");
                    tokenStream.push(commentToken);
                    j = line.length;
                    p = line.length;
                } else {
                    var newToken = new Token(tokenBody, j, i, "Symbol", 
                        Utility.getPres(tokenBody), Utility.getAssoc(tokenBody));
                    tokenStream.push(newToken); // Symbol Token
                }
                j = p;
                c = line.charAt(p);
                foundToken = true;

            } else if (Utility.isLetter(c)) {
                var count = 0;
                while (Utility.isLetter(c) || (count >= 1 && Utility.isInt(c))) {
                    count++;
                    if (p == line.length) {
                        break;
                    }
                    p++;
                    c = line.charAt(p);
                }
                var tokenBody = line.substring(j, p);
                var newToken = new Token(tokenBody, j, i, "Name");
                tokenStream.push(newToken);
                j = p;
                c = line.charAt(p);
                foundToken = true;
            } else if (Utility.isWhiteSpace(c)) {
                while (Utility.isWhiteSpace(c)) {
                    if (p == line.length) {
                        break;
                    }
                    p++;
                    c = line.charAt(p);
                }
                var tokenBody = line.substring(j, p);
                var newToken = new Token(tokenBody, j, i, "White Space");
                tokenStream.push(newToken);
                j = p;
                c = line.charAt(p);
                foundToken = true;
            } else if (c == "=") {
                p++;
                c = line.charAt(p);
                var tokenBody = line.substring(j, p);
                var newToken = new Token(tokenBody, j, i, "Equals");
                tokenStream.push(newToken);
                j = p;
                c = line.charAt(p);
                foundToken = true;
            }
            if (foundToken) {
                j--;
            }
        } // j loop
        var newLineToken = new Token("\n", j, i, "Newline");
        tokenStream.push(newLineToken);
    } // i 
    if (tokenStream.length > 0) {
        return Utility.cleanWhiteSpace(tokenStream);
    }
    return false;
}
