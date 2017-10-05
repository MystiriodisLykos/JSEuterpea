### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: utility_N.coffee
    * ----------------
    * Contains all AST (Abstract Syntax Tree) classes
    * Constant            = ASTConst
    * Variable            = ASTVar
    * Assignment          = ASTAssign (definition)
    * Application         = ASTApp
    * Lambda Abstraction  = ASTLambda (Not yet implemented)
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###


class @ASTConst
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * ASTConst
        * ----------------
        * AST that represents a constant
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    @type = 'Const'
    constructor: (@token) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * constructor (Token token)
            * ----------------
            * Constructor for an ASTConst
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

    getAstType: () ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * getAstType
            * ----------------
            * Deprecated by type static variable
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        console.trace()
        throw 'Use .type to get the type'

    eval: (env) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * eval
            * ----------------
            * Returns a NumValue of the token body.
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        return createNumValue(@token.body)


class @ASTVar
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * ASTVar
        * ----------------
        * AST that represents a Variable name (or Operator)
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    @type = 'Var'
    constructor: (@token) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * constructor (Token token)
            * ----------------
            * Constructor for an ASTVar
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###

    getAstType: () ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * getAstType
            * ----------------
            * Deprecated by type static variable
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        console.trace()
        throw 'Use .type to get the type'

    eval: (env) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * eval (Env env)
            * ----------------
            * Evaluates the token using the env provided. Returns the value provided
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        return env.eval(@token)


class @ASTApp
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * ASTApp
        * ----------------
        * AST that represents an application of a function with an argument
        * Currying is used when there is more than 1 argument
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    @type = 'App'
    constructor: (fn, args...) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * constructor (fn, args)
            * ----------------
            * Constructor for an ASTApp
            * fn is the function of this application
            * args are the arguments of said function
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        if args.length == 1  # If there is only 1 argument then assign the instance variables
            @fn = fn
            @arg = args[0]
        else  # If there are 2 or more arguments store last argument and make the function the application of the
              # function and the remaining arguments
            @arg = args.pop()
            @fn = new ASTApp(fn, args...)

    getAstType: () ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * getAstType
            * ----------------
            * Deprecated by type static variable
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        console.trace()
        throw 'Use .type to get the type'

    eval: (env) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * eval (Env env)
            * ----------------
            * Evaluates the function using the env provided and then applies the last argument to the function
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        func = @fn.eval(env)
        arg = new Thunk @arg, env
        return func.apply(arg)


class @ASTDef
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * ASTDef
        * ----------------
        * AST that represents a variable assigned to another AST
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    @type = 'Def'
    constructor: (left, ast) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * constructor (left, ast)
            * ----------------
            * Left contains the name the inner AST will be referenced as
            * Right is the Thunk containing the AST and the envP to evaluate the thunk on
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        @left = left.body
        @right = new Thunk(ast, envP)

    getAstType: () ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * getAstType
            * ----------------
            * Deprecated by type static variable
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        console.trace()
        throw 'Use .type to get the type'
        
    eval: (env) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * eval (Env env)
            * ----------------
            * Puts this definition into the environment
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        window.envP = new Env(@left, @right, env)
        return


class ASTLambda
    constructor: (fn, args...) ->
        if args.length == 1
            @fn = fn
            @arg = args[0]
        else
            @arg = args[0]
            @fn = ASTLambda(fn, args[1...])

    getAstType: () ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * getAstType
            * ----------------
            * Deprecated by type static variable
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        console.trace()
        throw 'Use .type to get the type'

    eval: (env) ->
        ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            * eval (Env env)
            * ----------------
            * Puts this definition into the environment
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
        envL = new Env(@arg.body, 'Missing ' + @arg.body, env)
        return createFunLValue(@arg, @fn, envL)


@createDefs = (definitions) ->
    ### ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * createDefs ([ASTDef] definitions)
        * ----------------
        * evaluates the array of AST definitions and replaces the thunks in the Env with the new envP
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ###
    for d in definitions
        d.eval(window.envP)
    e = window.envP
    while e != null
        e.val.e = window.envP
        e = e.parent


@createAstConst = (token) ->
    return new ASTConst token
@createAstVar = (token) ->
    return new ASTVar token
@createAstApp = (fn, args...) ->
    return new ASTApp fn, args...
@createAstDef = (l, r) ->
    return new ASTDef l, r