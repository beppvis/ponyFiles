
// this can be then called by var(),  no need of var.apply()
primitive Red fun apply():String => "Red" 
primitive Blue fun apply():String => "Red"


actor Main
	new create(env:Env) =>
		let red: Red = Red
		env.out.print(red())


/*
## Complex type
```pony
interface HasName
  fun name(): String

interface HasAge
  fun age(): U32

interface HasFeelings
  fun feeling(): String

type Person is (HasName & HasAge & HasFeelings)
```

```pony
trait HasName
  fun name(): String => "Bob"

trait HasAge
  fun age(): U32 => 42

trait HasFeelings
  fun feeling(): String => "Great!"

type Person is (HasName & HasAge & HasFeelings)
```
How Map is in the standard library
type Map[K: (Hashable box & Comparable[K] box), V] is HashMap[K, V, HashEq[K]]

*/
