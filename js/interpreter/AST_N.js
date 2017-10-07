// Generated by CoffeeScript 1.12.4

/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    * File: utility_N.coffee
    * ----------------
    * Contains all AST (Abstract Syntax Tree) classes
    * Constant            = ASTConst
    * Variable            = ASTVar
    * Assignment          = ASTAssign (definition)
    * Application         = ASTApp
    * Lambda Abstraction  = ASTLambda (Not yet implemented)
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

(function() {
  var slice = [].slice;

  this.ASTConst = (function() {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * ASTConst
        * ----------------
        * AST that represents a constant
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    ASTConst.type = 'Const';

    function ASTConst(token1) {
      this.token = token1;

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * constructor (Token token)
          * ----------------
          * Constructor for an ASTConst
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
    }

    ASTConst.prototype.getAstType = function() {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * getAstType
          * ----------------
          * Deprecated by type static variable
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      console.trace();
      throw 'Use .type to get the type';
    };

    ASTConst.prototype["eval"] = function(env) {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * eval
          * ----------------
          * Returns a NumValue of the token body.
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      return createNumValue(this.token.body);
    };

    return ASTConst;

  })();

  this.ASTVar = (function() {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * ASTVar
        * ----------------
        * AST that represents a Variable name (or Operator)
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    ASTVar.type = 'Var';

    function ASTVar(token1) {
      this.token = token1;

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * constructor (Token token)
          * ----------------
          * Constructor for an ASTVar
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
    }

    ASTVar.prototype.getAstType = function() {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * getAstType
          * ----------------
          * Deprecated by type static variable
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      console.trace();
      throw 'Use .type to get the type';
    };

    ASTVar.prototype["eval"] = function(env) {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * eval (Env env)
          * ----------------
          * Evaluates the token using the env provided. Returns the value provided
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      return env["eval"](this.token);
    };

    return ASTVar;

  })();

  this.ASTApp = (function() {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * ASTApp
        * ----------------
        * AST that represents an application of a function with an argument
        * Currying is used when there is more than 1 argument
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    ASTApp.type = 'App';

    function ASTApp() {
      var args, fn;
      fn = arguments[0], args = 2 <= arguments.length ? slice.call(arguments, 1) : [];

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * constructor (fn, args)
          * ----------------
          * Constructor for an ASTApp
          * fn is the function of this application
          * args are the arguments of said function
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      if (args.length === 1) {
        this.fn = fn;
        this.arg = args[0];
      } else {
        this.arg = args.pop();
        this.fn = (function(func, args, ctor) {
          ctor.prototype = func.prototype;
          var child = new ctor, result = func.apply(child, args);
          return Object(result) === result ? result : child;
        })(ASTApp, [fn].concat(slice.call(args)), function(){});
      }
    }

    ASTApp.prototype.getAstType = function() {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * getAstType
          * ----------------
          * Deprecated by type static variable
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      console.trace();
      throw 'Use .type to get the type';
    };

    ASTApp.prototype["eval"] = function(env) {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * eval (Env env)
          * ----------------
          * Evaluates the function using the env provided and then applies the last argument to the function
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      var arg, func;
      func = this.fn["eval"](env);
      arg = new Thunk(this.arg, env);
      return func.apply(arg);
    };

    return ASTApp;

  })();

  this.ASTDef = (function() {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * ASTDef
        * ----------------
        * AST that represents a variable assigned to another AST
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    ASTDef.type = 'Def';

    function ASTDef(left, ast) {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * constructor (left, ast)
          * ----------------
          * Left contains the name the inner AST will be referenced as
          * Right is the Thunk containing the AST and the envP to evaluate the thunk on
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      this.left = left.body;
      this.right = new Thunk(ast, envP);
    }

    ASTDef.prototype.getAstType = function() {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * getAstType
          * ----------------
          * Deprecated by type static variable
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      console.trace();
      throw 'Use .type to get the type';
    };

    ASTDef.prototype["eval"] = function(env) {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * eval (Env env)
          * ----------------
          * Puts this definition into the environment
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      window.envP = new Env(this.left, this.right, env);
    };

    return ASTDef;

  })();

  this.ASTLambda = (function() {
    function ASTLambda() {
      var args, fn;
      fn = arguments[0], args = 2 <= arguments.length ? slice.call(arguments, 1) : [];
      if (args.length === 1) {
        this.fn = fn;
        this.arg = args[0];
      } else {
        this.arg = args.pop();
        this.fn = (function(func, args, ctor) {
          ctor.prototype = func.prototype;
          var child = new ctor, result = func.apply(child, args);
          return Object(result) === result ? result : child;
        })(ASTLambda, [fn].concat(slice.call(args)), function(){});
      }
    }

    ASTLambda.prototype.getAstType = function() {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * getAstType
          * ----------------
          * Deprecated by type static variable
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      console.trace();
      throw 'Use .type to get the type';
    };

    ASTLambda.prototype["eval"] = function(env) {

      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          * eval (Env env)
          * ----------------
          * Puts this definition into the environment
          ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       */
      var envL;
      envL = new Env(this.arg.body, 'Missing ' + this.arg.body, env);
      return createFunLValue(this.arg, this.fn, envL);
    };

    return ASTLambda;

  })();

  this.createDefs = function(definitions) {

    /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * createDefs ([ASTDef] definitions)
        * ----------------
        * evaluates the array of AST definitions and replaces the thunks in the Env with the new envP
        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    var d, e, i, len, results;
    for (i = 0, len = definitions.length; i < len; i++) {
      d = definitions[i];
      d["eval"](window.envP);
    }
    e = window.envP;
    results = [];
    while (e !== null) {
      e.val.e = window.envP;
      results.push(e = e.parent);
    }
    return results;
  };

  this.createAstConst = function(token) {
    return new ASTConst(token);
  };

  this.createAstVar = function(token) {
    return new ASTVar(token);
  };

  this.createAstApp = function() {
    var args, fn;
    fn = arguments[0], args = 2 <= arguments.length ? slice.call(arguments, 1) : [];
    return (function(func, args, ctor) {
      ctor.prototype = func.prototype;
      var child = new ctor, result = func.apply(child, args);
      return Object(result) === result ? result : child;
    })(ASTApp, [fn].concat(slice.call(args)), function(){});
  };

  this.createAstDef = function(l, r) {
    return new ASTDef(l, r);
  };

}).call(this);

//# sourceMappingURL=AST_N.js.map
