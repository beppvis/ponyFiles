actor Main 
	new create(env: Env) => 
		env.out.print("Hello, world !")
		env.err.print("Hello, world (stderr) !")
