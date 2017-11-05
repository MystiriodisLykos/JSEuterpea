
class @ConstVal
    constructor: (@val) ->

    apply: (t) ->
        if t
            thow 'Cannot apply Constants'
        return @val

class @FunPVal
    constructor: (n, fn) ->
        if typeof n == 'number'
            @n = n
            @fn = fn
            @args = []
        else
            @n = n.n
            @fn = n.fn
            @args = fn

    apply: (t) ->
        tempArgs = @args.concat([t])
        if tempArgs.length == @n
            return @fn.apply null, tempArgs
        return new FunPVal(@, tempArgs)

class @FunLVal
    constructor: (@arg, @fn, @env) ->

    apply: (t) ->
        envL = new Env(@arg.body, t, @env)
        return @fn.eval(envL)

class @MusVal
    constructor: (@val) ->

    apply: (t) ->
        if t
            throw 'Cannot apply Musical values'
        return @val


@createNumValue = (v) ->
    return new ConstVal v
@createFunPValue = (n, fn) ->
    return new FunPVal n, fn
@createFunLValue = (arg, fn, env) ->
    return new FunLVal arg, fn, env
@createMusValue = (v) ->
    return new MusVal v