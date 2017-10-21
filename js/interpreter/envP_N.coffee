### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: envP_N.coffee
    * ----------------
    * Creates an environment with the primative functions and music notes
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

@envP = null

for name, fn of prims
    fnV = new Value.FunP fn.length, fn
    @envP = new Env name, (new Thunk fnV), @envP

notes = {'c3': 36, \
         'd3': 38, \
         'e3': 40, \
         'f3': 41, \
         'g3': 43, \
         'a4': 45, \
         'b4': 47, \
         'c4': 48}

for name, note of notes
    mv = new Value.Mus (new Music.Note 'acoustic_grad_piano', note, 100, 1)
    @envP = new Env name, (new Thunk mv), @envP
