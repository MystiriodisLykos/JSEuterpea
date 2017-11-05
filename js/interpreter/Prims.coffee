seq = (fm, sm) ->
    fmv = fm.asMusic()
    smv = sm.asMusic()
    return new createMusValue (Seq fmv, smv)

par = (fm, sm) ->
    fmv = fm.asMusic()
    smv = sm.asMusic()
    return new createMusValue (Par fmv, smv)


modifyInst = (m, inst) ->
    mv = m.asMusic()
    return new createMusValue (mv.modInst inst)

pianoF = (m) ->
    return modifyInst m, 'acoustic_grand_piano'

marimbaF = (m) ->
    return modifyInst m, 'marimba'

violinF = (m) ->
    return modifyInst m, 'violin'


modifyDur = (m, dur) ->
    mv = m.asMusic()
    return new createMusValue (mv.modDur dur)

halfF = (m) ->
    return modifyDur m, .5

quarterF = (m) ->
    return modifyDur m, .25

eighthF = (m) ->
    return modifyDur m, .125

sixteenthF = (m) ->
    return modifyDur m, .0625


modifyPitch = (m, p) ->
    mv = m.asMusic()
    return new createMusValue (mv.modPitch p)

pitchUpF = (m) ->
    return modifyPitch m, 2

pitchDownF = (m) ->
    return modifyPitch m, .5


newDyn = (m, d) ->
    mv = m.asMusic()
    return new createMusValue (mv.newVel d)

dynPF = (m) ->
    return newDyn m, 25

dynMpF = (m) ->
    reutrn newDyn m, 50

dynMfF = (m) ->
    return newDyn m, 75

dynFF = (m) ->
    return newDyn m, 100

dynFfF = (m) ->
    return newDyn m, 125

modifyDyn = (m, d) ->
    mv = m.asMusiic()
    return new createMusValue (mv.modVel d)

dynUpF = (m) ->
    return modifyDyn m, 2

dynDownF = (m) ->
    return modifyDyn m, .5


#@prims = {'+': seq, \
#          '*': par, \
#          'piano': pianoF, \
#          'marimba': marimbaF, \
#          'violin': violinF, \
#          'h': halfF, \
#          'q': quarterF, \
#          'e': eighthF, \
#          's': sixteenthF, \
#          'pUp': pitchUpF, \
#          'pDown': pitchDownF, \
#          'dynP': dynPF, \
#          'dynMp': dynMpF, \
#          'dynMf': dynMfF, \
#          'dynF': dynFF, \
#          'dynFf': dynFfF, \
#          'dynUp': dynUpF, \
#          'dynDown': dynDownF}


plusF = (x, y) ->
    xv = x.asNum()
    yv = y.asNum()
    return new createNumValue xv+yv

minusF = (x, y) ->
    xv = x.asNum()
    yv = y.asNum()
    return new createNumValue xv-yv

mulF = (x, y) ->
    xv = x.asNum()
    yv = y.asNum()
    return new createNumValue xv*yv

divF = (x, y) ->
    xv = x.asNum()
    yv = y.asNum()
    return new createNumValue xv/yv

@prims = {'+': plusF, \
          '-': minusF, \
          '*': mulF, \
          '/': divF}