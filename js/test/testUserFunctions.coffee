plus_nod = new AST.Var(new Token '+', 1, 0, 'Name', 0, 0)
one_nod = new AST.Var (new Token 'y', 0, 0, 'Name')
x_nod = new AST.Var (new Token 'x', 2, 0, 'Name')
app1_nod = new ASTApp(plus_nod, one_nod, x_nod)
lam1_nod = new ASTLambda app1_nod, (new Token 'x', 0, 0, 'Name'), (new Token 'y', 0, 0, 'Name')
fun1_def = new ASTDef (new Token 'test', 0, 0, 'Name'), lam1_nod

two_nod = new AST.Const (new Token 2, 0, 0, 'Integer')
four_nod = new AST.Const (new Token 4, 0, 0, 'Integer')
app2_nod = new ASTApp (new AST.Var (new Token 'test', 0, 0, 'Name')), two_nod, four_nod
y_def = new ASTDef (new Token 'y', 0, 0, 'Name'), app2_nod

createDefs([fun1_def, y_def])
console.log(window.envP.eval(new Token 'y'))
