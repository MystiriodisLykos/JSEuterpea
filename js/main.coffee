### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: main_N.coffee
    * -----------------
    * This is the main Javascript file.
    * This contains all the Javascript that works top level,
    * meaning all the UI and the call to evaluate which accesses all the dataobjects.
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

$(document).ready -> # Wait for page to load to run JavaScript
    # Variable Declaration

    # Functions
    init = ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * init()
            * ----------------
            * This function is called when the page loads to initialize the web page
            * Please encapsulate any page load calls into this function
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        $('#input').val ''
        $('#input').attr 'rows', '5'
        return

    evaluate = (input) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * evaluate(String inputProgram)
            * ----------------
            * Evaluate is the top function which eventually sends to lexer
            * Notice that lexer is defined in a different file
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

        # First step is to split into an array based on line breaks
        input = Utility.splitByLine input
#        console.log input
        tokenStream = Token.tokenize input
#        console.log tokenStream
        parser tokenStream
#        console.log envP
        console.log envP.eval new Token 'x'
        console.log envP.eval new Token 'y'
        console.log envP.eval new Token 'z'
        return

    # Function Calls * Called when page loads
    init()

    # Click Handlers
    $('#run').click ->
        evaluate $('#input').val()
        return

    $('#runmidi').click ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * 'Run Midi' click event
            * ----------------
            * Evaluates and runs the midi code found in the 'midi tester' text field
            * When the Run Midi button is clicked
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        evalRet = eval $('#midi').val()
        console.log evalRet
        return

    $('#playMusic').click ->
        #Example sequences
#        testMidi = new Note 'acoustic_grand_piano', 60, 100, 2
#        midiStuff = (new Seq \
#            (new Para \
#                (new Note "alto_sax", 55, 40, 3), \
#                (new Note "synth_drum", 65, 100, 3)), \
#            (new Seq \
#                (new Para \
#                    (new Note "alto_sax", 40, 60, 2), \
#                    (new Note "alto_sax", 80, 40, 5)), \
#                (new Note "flute", 50, 40, 1)))
#        midiStuff = new Seq (new Note 'flute', 60, 40, 2), (new Note 'alto_sax', 60, 40, 2)
        #Loading MIDI plugin
        MIDI.loadPlugin
            soundfontUrl: './Resources/MIDI.js-master/soundfont/'
            instrument: [
                'acoustic_grand_piano'
                'synth_drum'
                'acoustic_guitar_nylon'
                'acoustic_guitar_steel'
                'alto_sax'
                'flute'
            ]
            callback: ->
                #Setting instruments to channels (channelNumber, instrumentValue)
                # limited to 5 channels it seems **********
                MIDI.programChange 0, 0
                MIDI.programChange 1, 118
                MIDI.programChange 2, 24
                MIDI.programChange 3, 25
                MIDI.programChange 4, 65

                ###MIDI.programChange 5,67
                MIDI.programChange 6,61
                MIDI.programChange 7,30
                MIDI.programChange 8,33
                MIDI.programChange 9,34
                MIDI.programChange 10,26
                MIDI.programChange 11,73
                MIDI.programChange 12,64
                MIDI.programChange 13,66
                MIDI.programChange 14,56
                ###

                #Setting initial volume level
                MIDI.setVolume 0, 20
                MIDI.setVolume 1, 20
                MIDI.setVolume 2, 20
                MIDI.setVolume 3, 20
                MIDI.setVolume 4, 20
                #Playing notes
                midiStuff.play 0
                # midiStuff.modVel 2
                # midiStuff.play 3
#                testMidi.play 0
                return
        #end MIDI.loadPlugin
        return

    # Keydown Handlers

    return
