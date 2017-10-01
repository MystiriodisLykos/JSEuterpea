// Generated by CoffeeScript 1.12.4

/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: main_N.coffee
    * -----------------
    * This is the main Javascript file.
    * This contains all the Javascript that works top level,
    * meaning all the UI and the call to evaluate which accesses all the dataobjects.
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

(function() {
  $(document).ready(function() {
    var evaluate, init;
    init = function() {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * init()
          * ----------------
          * This function is called when the page loads to initialize the web page
          * Please encapsulate any page load calls into this function
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      $('#input').val('');
      $('#input').attr('rows', '5');
    };
    evaluate = function(input) {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * evaluate(String inputProgram)
          * ----------------
          * Evaluate is the top function which eventually sends to lexer
          * Notice that lexer is defined in a different file
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      var tokenStream;
      input = splitByLine(input);
      tokenStream = tokenize(input);
      parser(tokenStream);
      console.log(envP["eval"](new Token('x')));
      console.log(envP["eval"](new Token('y')));
      console.log(envP["eval"](new Token('z')));
    };
    init();
    $('#run').click(function() {
      evaluate($('#input').val());
    });
    $('#runmidi').click(function() {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * 'Run Midi' click event
          * ----------------
          * Evaluates and runs the midi code found in the 'midi tester' text field
          * When the Run Midi button is clicked
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      var evalRet;
      evalRet = eval($('#midi').val());
      console.log(evalRet);
    });
    $('#playMusic').click(function() {
      var midiStuff;
      midiStuff = new Seq(new Note('flute', 60, 40, 2), new Note('alto_sax', 60, 40, 2));
      MIDI.loadPlugin({
        soundfontUrl: './Resources/MIDI.js-master/soundfont/',
        instrument: ['acoustic_grand_piano', 'synth_drum', 'acoustic_guitar_nylon', 'acoustic_guitar_steel', 'alto_sax', 'flute'],
        callback: function() {
          MIDI.programChange(0, 0);
          MIDI.programChange(1, 118);
          MIDI.programChange(2, 24);
          MIDI.programChange(3, 25);
          MIDI.programChange(4, 65);

          /*MIDI.programChange 5,67
          MIDI.programChange 6,61
          MIDI.programChange 7,30
          MIDI.programChange 8,33
          MIDI.programChange 9,34
          MIDI.programChange 10,26
          MIDI.programChange 11,73
          MIDI.programChange 12,64
          MIDI.programChange 13,66
          MIDI.programChange 14,56
           */
          MIDI.setVolume(0, 20);
          MIDI.setVolume(1, 20);
          MIDI.setVolume(2, 20);
          MIDI.setVolume(3, 20);
          MIDI.setVolume(4, 20);
          midiStuff.play(0);
        }
      });
    });
  });

}).call(this);

//# sourceMappingURL=main_N.js.map