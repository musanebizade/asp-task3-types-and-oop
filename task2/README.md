# Task 2: Static and Dynamic Binding in C#

The program shows the difference between **static binding** (the method is chosen
at compile time, by the type of the reference) and **dynamic binding** (the method
is chosen at run time, by the real type of the object). It uses the keywords
`virtual`, `override` and `new`.

## Files

- `Program.cs` - the whole program (classes `Animal`, `Dog`, `Cat` and `Main`)
- `README.md` - this file

## How to run

No local installation is needed. I used an online compiler
(https://www.onlinegdb.com, language C#): paste `Program.cs` and press Run.

With the .NET SDK installed it also works locally:

```bash
dotnet new console -o demo
# replace demo/Program.cs with task2/Program.cs
dotnet run --project demo
```

## Class design

| Class | Method | Keyword | Meaning |
|-------|--------|---------|---------|
| `Animal` | `MakeSound()` | `virtual` | can be replaced in a derived class |
| `Animal` | `Sleep()` | none | normal method, cannot be replaced |
| `Dog` | `MakeSound()` | `override` | replaces the base method |
| `Dog` | `Sleep()` | `new` | hides the base method |
| `Cat` | `MakeSound()` | `new` | hides the virtual base method |

## Output

```
--- 1. override (dynamic binding) ---
Rex (Dog): Bark!

--- 2. new on a virtual method (hiding) ---
Tom (Animal): some generic sound
Tom (Cat): Meow!

--- 3. non-virtual method (static binding) ---
Rex (Animal): zzz...
Rex (Dog): sleeps in a doghouse

--- 4. array of base references ---
Generic (Animal): some generic sound
Rex (Dog): Bark!
Tom (Animal): some generic sound
```

## Explanation

**1. `virtual` + `override` = dynamic binding.** `a1` has the type `Animal`, but the
object is a `Dog`. `MakeSound()` is virtual and `Dog` overrides it, so the runtime
looks at the real object and calls the `Dog` version. This is the basis of
polymorphism: the same call on a base reference can give different behavior.

**2. `new` on a virtual method = hiding.** `Cat` declares its own `MakeSound()` with
`new`, so it does not take part in the virtual call. Through an `Animal` reference
(`a2`) the base version runs. Through a `Cat` reference (`c`) the `Cat` version runs.
The same object gives different results depending on the type of the variable.

**3. A method without `virtual` = static binding.** `Sleep()` is not virtual, so the
compiler decides at compile time from the reference type. `a3` is an `Animal`
reference and gets `Animal.Sleep()`, even though the object is a `Dog`. `d` is a
`Dog` reference and gets `Dog.Sleep()`. Here `new` only hides the method. It also
removes the compiler warning CS0108, which says that a member hides an inherited
member.

**4. Array of base references.** The loop calls `a.MakeSound()` on every element and
the output shows all three cases together. `Animal` uses its own version, `Dog`
runs the overridden version, and `Cat` runs the `Animal` version, because the
`Cat` method is hidden and not overridden. A `Cat` that overrides `MakeSound()`
would print "Meow!" in this loop.

## Summary

| Keyword | Binding | The version that runs is decided by |
|---------|---------|-------------------------------------|
| `virtual` + `override` | dynamic (run time) | the real type of the object |
| `new` (hiding) | static (compile time) | the type of the reference |
| no keyword (normal method) | static (compile time) | the type of the reference |