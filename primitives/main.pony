// marker value
primitive SwitchOn 
primitive SwitchOff

// Enum
type SwitchState is (SwitchOn | SwitchOff)


// It can be used to bunch up functions together
primitive BasicMath 
	fun add(a : U64 , b : U64):U64 =>
		a+b
	fun sub(a : U64 , b : U64):U64 =>
		a-b

actor Main 
	new create(env:Env) => 
		let switch_state: SwitchState = SwitchOff
		let switch_state_bool : Bool = match switch_state 
			| SwitchOn => true
			| SwitchOff => false 
			end
		env.out.print(switch_state_bool.string())


