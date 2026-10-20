// Task 2: static and dynamic binding in C#
// Shows the keywords: virtual, override and new

using System;

class Animal
{
    public string Name;

    public Animal(string name)
    {
        Name = name;
    }

    // virtual: the method can be replaced in a derived class,
    // and the real object type decides which version runs (dynamic binding)
    public virtual void MakeSound()
    {
        Console.WriteLine(Name + " (Animal): some generic sound");
    }

    // not virtual: the reference type decides which version runs,
    // and the decision is made at compile time (static binding)
    public void Sleep()
    {
        Console.WriteLine(Name + " (Animal): zzz...");
    }
}

class Dog : Animal
{
    public Dog(string name) : base(name) { }

    // override: replaces the virtual method of the base class
    public override void MakeSound()
    {
        Console.WriteLine(Name + " (Dog): Bark!");
    }

    // new: hides the base method, it does NOT replace it
    public new void Sleep()
    {
        Console.WriteLine(Name + " (Dog): sleeps in a doghouse");
    }
}

class Cat : Animal
{
    public Cat(string name) : base(name) { }

    // new on a virtual method: hides it instead of overriding it,
    // so there is no dynamic binding for this method
    public new void MakeSound()
    {
        Console.WriteLine(Name + " (Cat): Meow!");
    }
}

class Program
{
    static void Main()
    {
        Console.WriteLine("--- 1. override (dynamic binding) ---");
        Animal a1 = new Dog("Rex");
        a1.MakeSound();   // reference is Animal, object is Dog -> Dog version runs

        Console.WriteLine();
        Console.WriteLine("--- 2. new on a virtual method (hiding) ---");
        Animal a2 = new Cat("Tom");
        a2.MakeSound();   // reference is Animal -> Animal version runs
        Cat c = new Cat("Tom");
        c.MakeSound();    // reference is Cat -> Cat version runs

        Console.WriteLine();
        Console.WriteLine("--- 3. non-virtual method (static binding) ---");
        Animal a3 = new Dog("Rex");
        a3.Sleep();       // reference is Animal -> Animal version runs
        Dog d = new Dog("Rex");
        d.Sleep();        // reference is Dog -> Dog version runs

        Console.WriteLine();
        Console.WriteLine("--- 4. array of base references ---");
        Animal[] animals = { new Animal("Generic"), new Dog("Rex"), new Cat("Tom") };
        foreach (Animal a in animals)
        {
            a.MakeSound();
        }
    }
}