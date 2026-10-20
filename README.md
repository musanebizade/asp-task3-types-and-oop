# Advanced Software Paradigms - Assignment A3: Types and OOP Concepts

Three tasks about memory, binding and object-oriented design, each in its own folder
with its own README.

| Folder | Language | Topic |
|--------|----------|-------|
| [`task1`](task1/README.md) | C++ | Static vs stack vs heap allocation of a large array (benchmark) |
| [`task2`](task2/README.md) | C# | Static and dynamic binding: `virtual`, `override`, `new` |
| [`task3`](task3/README.md) | Ruby | Library catalog: classes, inheritance, encapsulation, polymorphism |

## How to run

```bash
# Task 1
cd task1
g++ -std=c++17 -O2 -o bench memory_benchmark.cpp
./bench

# Task 2: paste task2/Program.cs into an online C# compiler (e.g. onlinegdb.com)

# Task 3
cd task3
ruby main.rb
```

## Repository structure

```
asp-task3-types-and-oop/
├── task1/
│   ├── memory_benchmark.cpp
│   └── README.md
├── task2/
│   ├── Program.cs
│   └── README.md
├── task3/
│   ├── library_item.rb
│   ├── book.rb
│   ├── dvd.rb
│   ├── cd.rb
│   ├── library.rb
│   ├── main.rb
│   └── README.md
├── .gitignore
└── README.md
```