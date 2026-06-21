actor Main
	new create(env:Env) =>
		let x :U64= 10
		bark(env)
		env.out.print("hello")
	/*
		The execution of behaviours inside an actor will always be sequential
		!ponyc ; ./actors
	*/

	be bark(env:Env) =>  // this is an behaviour and they dont have a return value
		env.out.print("Woof woof")
