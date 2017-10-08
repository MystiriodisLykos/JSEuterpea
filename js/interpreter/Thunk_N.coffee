class @Thunk
    constructor: (prog, e) ->
        if not e
            @v = prog
            @evaluated = true
        else
            @e = e
            @prog = prog
            @evaluated = false

    eval: () ->
        if @evaluated
            return @v
        @v = @prog.eval @e
        @evaluated = true
        return @v

    asNum: () ->
        return @eval().val

    asFunc: () ->
        return @eval()

    asMusic: () ->
        return @eval()
