### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: Env.coffee
    * ----------------
    * Simply contains the info for the Env class
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
class Env
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * Env
        * ----------------
        * Env is a link list of all the variables and functions that the user defines
        * and the primative functions
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    constructor: (@name, @val, parent) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * constructor (String name, Token val, Env parent)
            * ----------------
            * name is the name of the variable/function
            * val is a token containing the variable or function value
            * parent contains the next Env in the list
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @parent = if not parent then null else parent

    eval: (t) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * eval (Token t)
            * ----------------
            * Finds the evaluated value of the same name as t and returns it
            * Throws and exception if there is not value with the same name.
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        if @name == t.body
            return @val.eval()
        if @parent == null
            console.trace()
            throw 'Couldn\'t find variable name ' + t.body
        return @parent.eval t


class Thunk
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

@Env =
    Env: Env,
    Thunk: Thunk
