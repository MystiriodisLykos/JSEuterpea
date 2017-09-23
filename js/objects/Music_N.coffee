### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: Music_N.coffee
    * -----------------
    * Contains the information for Note, Seq, and Parallel classes
    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

class @Note
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * Note
        * ----------------
        * A Single note object with a pitch, speed, and duration on an instrument
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    ###
    @instruments = {
        'acoustic_grand_piano': 1,
        'bright_acoustic_piano': 2,
        'electric_grand_piano': 3,
        'honky-tonk piano': 4,
        'electric_piano_1': 5,
        'electric_piano_2': 6,
        'harpsichord': 7,
        'clavi': 8,
        'celesta': 9,
        'glockenspiel': 10,
        'music_box': 11,
        'vibraphone': 12,
        'marimba': 13,
        'xylophone': 14,
        'tubular_bells': 15,
        'dulcimer': 16,
        'drawbar_organ': 17,
        'percussive_organ': 18,
        'rock_organ': 19,
        'church_organ': 20,
        'reed_organ': 21,
        'accordion': 22,
        'harmonica': 23,
        'tango_accordion': 24,
        'acoustic_guitar_nylon': 25,
        'acoustic_guitar_steel': 26,
        'electric_guitar_jazz': 27,
        'electric_guitar_clean': 28,
        'electric_guitar_muted': 29,
        'overdriven_guitar': 30,
        'distortion_guitar': 31,
        'guitar_harmonics': 32,
        'acoustic_bass': 33,
        'electric_bass_finger': 34,
        'electric_bass_pick': 35,
        'fretless_bass': 36,
        'slap_bass_1': 37,
        'slap_bass_2': 38,
        'synth_bass_1': 39,
        'synth_bass_2': 40,
        'violin': 41,
        'viola': 42,
        'cello': 43,
        'contrabass': 44,
        'tremolo_strings': 45,
        'pizzicato_strings': 46,
        'orchestral_harp': 47,
        'timpani': 48,
        'string_ensemble_1': 49,
        'string_ensemble_2': 50,
        'synthstrings_1': 51,
        'synthstrings_2': 52,
        'choir_aahs': 53,
        'voice_oohs': 54,
        'synth_voice': 55,
        'orchestra_hit': 56,
        'trumpet': 57,
        'trombone': 58,
        'tuba': 59,
        'muted_trumpet': 60,
        'french_horn': 61,
        'brass_section': 62,
        'synthbrass_1': 63,
        'synthbrass_2': 64,
        'soprano_sax': 65,
        'alto_sax': 66,
        'tenor_sax': 67,
        'baritone_sax': 68,
        'oboe': 69,
        'english_horn': 70,
        'bassoon': 71,
        'clarinet': 72,
        'piccolo': 73,
        'flute': 74,
        'recorder': 75,
        'pan_flute': 76,
        'blown_bottle': 77,
        'shakuhachi': 78,
        'whistle': 79,
        'ocarina': 80,
        'lead_1_square': 81,
        'lead_2_sawtooth': 82,
        'lead_3_calliope': 83,
        'lead_4_chiff': 84,
        'lead_5_charang': 85,
        'lead_6_voice': 86,
        'lead_7_fifths': 87,
        'lead_8_bass_lead': 88,
        'pad_1_new_age': 89,
        'pad_2_warm': 90,
        'pad_3_polysynth': 91,
        'pad_4_choir': 92,
        'pad_5_bowed': 93,
        'pad_6_metallic': 94,
        'pad_7_halo': 95,
        'pad_8_sweep': 96,
        'fx_1_rain': 97,
        'fx_2_soundtrack': 98,
        'fx_3_crystal': 99,
        'fx_4_atmosphere': 100,
        'fx_5_brightness': 101,
        'fx_6_goblins': 102,
        'fx_7_echoes': 103,
        'fx_8_sci-fi': 104,
        'sitar': 105,
        'banjo': 106,
        'shamisen': 107,
        'koto': 108,
        'kalimba': 109,
        'bag_pipe': 110,
        'fiddle': 111,
        'shanai': 112,
        'tinkle_bell': 113,
        'agogo': 114,
        'steel_drums': 115,
        'woodblock': 116,
        'taiko_drum': 117,
        'melodic_tom': 118,
        'synth_drum': 119,
        'reverse_cymbal': 120,
        'guitar_fret_noise': 121,
        'breath_noise': 122,
        'seashore': 123,
        'bird_tweet': 124,
        'telephone_ring': 125,
        'helicopter': 126,
        'applause': 127,
        'gunshot': 128
    } # All of the instruments in the MIDI library ###
    @instruments = {
        'acoustic_grand_piano': 1,
        'acoustic_guitar_nylon': 24,
        'acoustic_guitar_steel': 25,
        'alto_sax': 66,
        'baritone_sax': 68,
        'brass_section': 62,
        'distortion_guitar': 31,
        'electric_bass_finger': 34,
        'electric_bass_pick': 35,
        'flute': 74,
        'soprano_sax': 65,
        'synth_drum': 119,
        'tenor_sax': 67,
        'trumpet': 57
    }  # Instruments I have files for currently
    constructor: (instrument, @pitch, @velocity, @duration) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * constructor (String instrument, Int pitch, Int velocity, Int duration)
            * ----------------
            * Constructor for a Note. Turns the instrument string into the appropriate number
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @instrumentNum = Note.instruments[instrument]-1

    play: (startTime) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * play (Int startTime)
            * ----------------
            * Plays this Note at the time startTime with the Notes duration
            * returns the time when the Note stops
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        MIDI.programChange 0, this.instrumentNum
        MIDI.setVolume 0, this.velocity
        MIDI.noteOn 0, this.pitch, this.velocity, startTime
        MIDI.noteOff 0, this.pitch, startTime + this.duration

        return startTime + this.duration

    modInst: (instrumentMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
           * modInst (String modInst)
           * ----------------
           * Changes this Notes instrument to the appropriate number for the string instrumentMod
           ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @instrumentNum = Note.instruments[instrumentMod] - 1
        return

    modPitch: (pitchMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
           * modPitch (Int pitchMod)
           * ----------------
           * Modifies this Notes pitch by the pitchMod
           ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @pith *= pitchMod
        return

    modVel: (velocityMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
           * modVel (Int modVel)
           * ----------------
           * Modifies this Notes Velocity by the velocityMod and binds it to less than 129
           ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @velocity = if @velocity * velocityMod > 128 \
        then 128 \
        else velocityMod * @velocity
        return

    newVel: (newVelocity) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
           * newVel (Int newVel)
           * ----------------
           * Changes this Notes Velocity to newVelocity and binds it to less than 129
           ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @velocity = if newVelocity > 128 then 128 else newVelocity
        return

    modDur: (durMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
           * modDur (Int durMod)
           * ----------------
           * Modifies this notes Duration by durMod
           ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @duration *= durMod
        return


class @Seq
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * Seq
        * ----------------
        * Represents two pieces of Music that play Sequentially
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    constructor: (@firstMusic, @secondMusic) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * constructor ('Music' firstMusic, 'Music' secondMusic)
            * ----------------
            * Stores the two pieces of Music that are played sequential
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

    play: (startTime) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * play (Int startTime)
            * ----------------
            * Plays the first piece of music at the time startTime and plays the second piece
            * at the time the first one ends
            * returns the time the second piece ends
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        t1 = @firstMusic.play startTime
        t2 = @secondMusic.play t1
        return t2

    modInst: (instrumentMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * modInst (String instrumentMod)
            * ----------------
            * Changes both pieces instruments to the appropriate number for the string instrumentMod
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @callback 'modInst', instrumentMod
        return

    modPitch: (pitchMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * modPitch (pitchMod)
            * ----------------
            * Modifies both pieces pitch by pitchMod
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @callback 'modPitch', pitchMod
        return

    modVel: (velMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * modVel (velMod)
            * ----------------
            * Modifies both pieces Velocity by velMod
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @callback 'modVel', velMod
        return

    newVel: (newVelocity) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * newVel (newVelocity)
            * ----------------
            * Changes both pieces to newVelocity
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @callback 'newVel', newVelocity
        return

    modDur: (durMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * modDur (durMod)
            * ----------------
            * Modifies both pieces duration by durMod
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @callback 'modDur', durMod
        return

    callback: (funct, args...) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * call (String function, [Object] args)
            * ----------------
            * calls the funct method of firstMusic and secondMusic with the given args
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        funct1 = @firstMusic[funct]
        funct2 = @secondMusic[funct]
        funct1.call @firstMusic, args
        funct2.call @secondMusic, args
        return


class @Para
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * Para
        * ----------------
        * Represents two pieces of Music that play in Parallel
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    constructor: (@firstMusic, @secondMusic) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * constructor ('Music' firstMusic, 'Music' secondMusic)
            * ----------------
            * Stores the two pieces of Music that are played in Parallel
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

    play: (startTime) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * plays (Int startTime)
            * ----------------
            * Plays the two pieces starting at startTime and returns the end time of the longer one.
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        t1 = @firstMusic.play startTime
        t2 = @secondMusic.play startTime
        return Math.max(t1, t2)

    modInst: (instrumentMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * modInst (String instrumentMod)
            * ----------------
            * Changes both pieces instruments to the appropriate number for the string instrumentMod
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @callback 'modInst', instrumentMod
        return

    modPitch: (pitchMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * modPitch (pitchMod)
            * ----------------
            * Modifies both pieces pitch by pitchMod
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @callback 'modPitch', pitchMod
        return

    modVel: (velMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * modVel (velMod)
            * ----------------
            * Modifies both pieces Velocity by velMod
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @callback 'modVel', velMod
        return

    newVel: (newVelocity) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * newVel (newVelocity)
            * ----------------
            * Changes both pieces to newVelocity
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @callback 'newVel', newVelocity
        return

    modDur: (durMod) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * modDur (durMod)
            * ----------------
            * Modifies both pieces duration by durMod
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @callback 'modDur', durMod
        return

    callback: (funct, args...) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * call (String function, [Object] args)
            * ----------------
            * calls the funct method of firstMusic and secondMusic with the given args
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        funct1 = @firstMusic[funct]
        funct2 = @secondMusic[funct]
        funct1.call @firstMusic, args
        funct2.call @secondMusic, args
        return
