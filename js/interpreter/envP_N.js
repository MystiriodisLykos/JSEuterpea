// Generated by CoffeeScript 1.12.4

/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: envP_N.coffee
    * ----------------
    * Creates an environment with the primative functions and music notes
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

(function() {
  var fn, fnV, mv, name, note, notes;

  this.envP = null;

  for (name in prims) {
    fn = prims[name];
    fnV = new createFunPValue(fn.length, fn);
    this.envP = new Env(name, new Thunk(fnV), this.envP);
  }

  notes = {
    'c3': 36,
    'd3': 38,
    'e3': 40,
    'f3': 41,
    'g3': 43,
    'a4': 45,
    'b4': 47,
    'c4': 48
  };

  for (name in notes) {
    note = notes[name];
    mv = new createMusValue(new Note('acoustic_grad_piano', note, 100, 1));
    this.envP = new Env(name, new Thunk(mv), this.envP);
  }

}).call(this);

//# sourceMappingURL=envP_N.js.map