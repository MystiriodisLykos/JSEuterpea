$(document).ready ->
    n1 = new Note('alto_sax', 60, 100, 2)
    n2 = new Note('alto_sax', 60, 100, 2)
    s1 = new Seq(n1, n2)
    s2 = new Seq(n1, n2)
    s1.modInst('synth_drum')
    console.log(s1)
    console.log(s2)