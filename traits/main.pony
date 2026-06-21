

// example of trait
trait Named 
	fun name(): String => "name :)"

class Jeb is Named // you have to explicitly state `Named` 


// Example of structural interface
interface Human
	fun name(): String
	fun age(): U64 
class Bob
	fun name(): String => "Bob"
	fun age(): U64=> 10 

actor Main
  new create(env: Env) =>
	let bob: Bob = Bob
	let human:Human = bob
	env.out.print(human.name())
	let jeb: Jeb = Jeb
	let named: Named = jeb
	env.out.print(named.name())

/*

Open world enumerations

Traits allow you to create “open world enumerations” that others can participate in. For example:

```pony
trait Color

primitive Red is Color
primitive Blue is Color
```
Here we are using a trait to provide a category of things, Color, that any other types can opt into by declaring itself to be a Color. This creates an “open world” of enumerations that you can’t do using the more traditional Pony approach using type unions.

```pony
primitive Red
primitive Blue

type Color is (Red | Blue)
```

In our trait based example, we can add new colors at any time. With the type union based approach, we can only add them by modifying definition of Color in the package that provides it.

Interfaces can’t be used for open world enumerations. If we defined Color as an interface:

interface Color

Then literally everything in Pony would be a Color because everything matches the Color interface. You can however, do something similar using “marker methods” with an interface:

```pony
interface Color
  fun is_color(): None

primitive Red
  fun is_color(): None => None
```

Here we are using structural typing to create a collection of things that are in the category Color by providing a method that “marks” being a member of the category: is_color.
Open world typing

We’ve covered a couple ways that traits can be better than interfaces, let’s close with the reason for why we say, unless you have a reason to, you should use interface instead of trait. Interfaces are incredibly flexible. Because traits only provide nominal typing, a concrete type can only be in a category if it was declared as such by the programmer who wrote the concrete type. Interfaces allow you to create your own categorizations on the fly, as you need them, to group existing concrete types together however you need to.

Here’s a contrived example:

```pony
interface Compactable
  fun ref compact()
  fun size(): USize

class Compactor
  """
  Compacts data structures when their size crosses a threshold
  """
  let _threshold: USize

  new create(threshold: USize) =>
    _threshold = threshold

  fun ref try_compacting(thing: Compactable) =>
    if thing.size() > _threshold then
      thing.compact()
    end
```

The flexibility of interface has allowed us to define a type Compactable that we can use to allow our Compactor to accept a variety of data types including Array, Map, and String from the standard library.
*/
