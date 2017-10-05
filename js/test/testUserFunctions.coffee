plus_nod = new ASTVar(new Token '+', 1, 0, "Name", 0, 0)
one_nod = new ASTConst(new Token 1, 0, 0, 'Integer')
x_nod = new ASTVar(new Token 'x', 2, 0, 'Name')
app1_nod = new ASTApp(plus_nod, one_nod, x_nod)
