actor Main
	new create(env:Env) =>
		let human = Human.create("Jhonny")
		human.set_hunger(100)
		env.out.print(human.name)

class Human 
	let name: String 
	var _hunger_level: U64

	new create(name': String) => 
		name = name'
		_hunger_level = 0
	new hungry(name': String, hunger':U64) =>
		name = name'
		_hunger_level = hunger'
	
	fun hunger(): U64 => _hunger_level
	fun ref set_hunger(hunger': U64 = 0): U64 => _hunger_level = hunger'
