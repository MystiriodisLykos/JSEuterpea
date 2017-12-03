// Generated by CoffeeScript 1.12.4
(function() {
  var divF, dynDownF, dynFF, dynFfF, dynMfF, dynMpF, dynPF, dynUpF, eighthF, envP, fn, fnV, halfF, marimbaF, minusF, modifyDur, modifyDyn, modifyInst, modifyPitch, mulF, mv, name, newDyn, note, notes, par, pianoF, pitchDownF, pitchUpF, plusF, prims, quarterF, seq, sixteenthF, violinF;

  seq = function(fm, sm) {
    var fmv, smv;
    fmv = fm.asMusic();
    smv = sm.asMusic();
    return new Value.Mus(Music.Seq(fmv, smv));
  };

  par = function(fm, sm) {
    var fmv, smv;
    fmv = fm.asMusic();
    smv = sm.asMusic();
    return new Value.Mus(Music.Par(fmv, smv));
  };

  modifyInst = function(m, inst) {
    var mv;
    mv = m.asMusic();
    return new Value.Mus(mv.modInst(inst));
  };

  pianoF = function(m) {
    return modifyInst(m, 'acoustic_grand_piano');
  };

  marimbaF = function(m) {
    return modifyInst(m, 'marimba');
  };

  violinF = function(m) {
    return modifyInst(m, 'violin');
  };

  modifyDur = function(m, dur) {
    var mv;
    mv = m.asMusic();
    return new Value.Mus(mv.modDur(dur));
  };

  halfF = function(m) {
    return modifyDur(m, .5);
  };

  quarterF = function(m) {
    return modifyDur(m, .25);
  };

  eighthF = function(m) {
    return modifyDur(m, .125);
  };

  sixteenthF = function(m) {
    return modifyDur(m, .0625);
  };

  modifyPitch = function(m, p) {
    var mv;
    mv = m.asMusic();
    return new Value.Mus(mv.modPitch(p));
  };

  pitchUpF = function(m) {
    return modifyPitch(m, 2);
  };

  pitchDownF = function(m) {
    return modifyPitch(m, .5);
  };

  newDyn = function(m, d) {
    var mv;
    mv = m.asMusic();
    return new Value.Mus(mv.newVel(d));
  };

  dynPF = function(m) {
    return newDyn(m, 25);
  };

  dynMpF = function(m) {
    return reutrn(newDyn(m, 50));
  };

  dynMfF = function(m) {
    return newDyn(m, 75);
  };

  dynFF = function(m) {
    return newDyn(m, 100);
  };

  dynFfF = function(m) {
    return newDyn(m, 125);
  };

  modifyDyn = function(m, d) {
    var mv;
    mv = m.asMusiic();
    return new Value.Mus(mv.modVel(d));
  };

  dynUpF = function(m) {
    return modifyDyn(m, 2);
  };

  dynDownF = function(m) {
    return modifyDyn(m, .5);
  };

  prims = {
    '+': seq,
    '*': par,
    'piano': pianoF,
    'marimba': marimbaF,
    'violin': violinF,
    'h': halfF,
    'q': quarterF,
    'e': eighthF,
    's': sixteenthF,
    'pUp': pitchUpF,
    'pDown': pitchDownF,
    'dynP': dynPF,
    'dynMp': dynMpF,
    'dynMf': dynMfF,
    'dynF': dynFF,
    'dynFf': dynFfF,
    'dynUp': dynUpF,
    'dynDown': dynDownF
  };

  plusF = function(x, y) {
    var xv, yv;
    xv = x.asNum();
    yv = y.asNum();
    return new Value.Const(xv + yv);
  };

  minusF = function(x, y) {
    var xv, yv;
    xv = x.asNum();
    yv = y.asNum();
    return new Value.Const(xv - yv);
  };

  mulF = function(x, y) {
    var xv, yv;
    xv = x.asNum();
    yv = y.asNum();
    return new Value.Const(xv * yv);
  };

  divF = function(x, y) {
    var xv, yv;
    xv = x.asNum();
    yv = y.asNum();
    return new Value.Const(xv / yv);
  };

  prims = {
    '+': plusF,
    '-': minusF,
    '*': mulF,
    '/': divF
  };

  envP = null;

  for (name in prims) {
    fn = prims[name];
    fnV = new Value.FunP(fn.length, fn);
    envP = new Env(name, new Thunk(fnV), envP);
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
    mv = new Value.Mus(new Music.Note('acoustic_grad_piano', note, 100, 1));
    envP = new Env(name, new Thunk(mv), envP);
  }

  this.envP = envP;

}).call(this);

//# sourceMappingURL=Prims.js.map
