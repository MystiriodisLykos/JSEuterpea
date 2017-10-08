/*
 This is the Interface for all Value Types
 */
var valueVar = {};
function createValue() {
    return Object.create(valueVar, {
        // Methods
        getType: {
            value: function () {
                // does nothing -- this is the interface
            },
        },
        apply: {
            value: function (thunk) {
                // interface       
            },
        },
    });
}

var valNumVar = createValue();
function createNumValue(val) {
    var ret = Object.create(valNumVar, {
        getType: {
            value: function () {
                return "Num";
            },
        },
        apply: {
            value: function (thunk) {
                if (thunk) {
                    console.log("ERROR: token not valid for numberValue");
                    console.log(thunk);
                    return;
                }
                return val;
            },
        },
    });
    ret.val = val;
    return ret;
}

var valFunPVar = createValue();
function createFunPValue(n, fn) {
    var ret = Object.create(valFunPVar, {
        getType: {
            value: function () {
                return "FunP";
            },
        },
        apply: {
            value: function (thunk) {
                var tempArgs = this.args.concat([thunk]);
                if (tempArgs.length == ret.n) {
                    return ret.fn.apply(null, tempArgs);
                }
                return createFunPValue(ret, tempArgs);
            },
        },
    });
    if (typeof n == "number") {
        ret.n = n;
        ret.fn = fn;
        ret.args = [];
        return ret;
    }
    var copy = n;
    ret.n = copy.n;
    ret.fn = copy.fn;
    ret.args = fn;
    return ret;
}

var valFunLVar = createValue();
function createFunLValue(arg, fn, env) {
    var ret = Object.create(valFunLVar, {
        apply: {
            value: function(thunk) {
                envL = new Env(ret.arg.body, thunk, ret.env);
                return ret.fn.eval(envL)
            }
        }
    });
    ret.arg = arg;
    ret.fn = fn;
    ret.env = env;
    return ret
}

var valMusVar = createValue();
function createMusValue(val) {
    var ret = Object.create(valMusVar, {
        getType: {
            value: function() {
                return "Music";
            }
        },
        apply: {
            value: function (thunk) {
                if (thunk) {
                    console.log("Cannot apply Music to token");
                    console.log(thunk);
                    return;
                }
                return val;
            }
        }
    });
    ret.val = val;
    return ret;
}
