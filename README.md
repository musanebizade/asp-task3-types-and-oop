# CSCI 6221 Advanced Software Paradigms - Assignment 3

Musa Nabizada

Types and OOP concepts. Each task has its own folder with a `README.md` report and the code.

## Contents

| Task | Topic | Report | Code |
|---|---|---|---|
| 1 | Static vs stack vs heap allocation of a large array (C++ benchmark) | [task1/README.md](task1/README.md) | [task1/memory_benchmark.cpp](task1/memory_benchmark.cpp) |
| 2 | Static and dynamic binding in C#: `virtual`, `override`, `new` | [task2/README.md](task2/README.md) | [task2/Program.cs](task2/Program.cs) |
| 3 | Library catalog in Ruby: inheritance, encapsulation, polymorphism | [task3/README.md](task3/README.md) | [task3](task3) |

## Repository structure

```
asp-task3-types-and-oop/
├── README.md                      # this overview
├── task1/
│   ├── README.md                  # report: timing results and explanation
│   └── memory_benchmark.cpp       # static, stack and heap benchmark
├── task2/
│   ├── README.md                  # report: binding and the keywords
│   └── Program.cs                 # Animal, Dog, Cat demo
└── task3/
    ├── README.md                  # report: class design and OOP principles
    ├── library_item.rb            # base class LibraryItem
    ├── book.rb                    # Book < LibraryItem
    ├── dvd.rb                     # DVD < LibraryItem
    ├── cd.rb                      # CD < LibraryItem
    ├── library.rb                 # Library: add, remove, display
    └── main.rb                    # demo script
```

## Requirements

- Task 1: g++ with C++17 (tested with g++ 16.2.0 from MSYS2 on Windows)
- Task 2: an online C# compiler, for example onlinegdb.com. No .NET installation is needed.
- Task 3: Ruby 3 or newer (tested with Ruby 4.0.7 from RubyInstaller)
- No extra libraries are needed.

## Quick start (tested on Windows)

```bash
# Task 1: build and run the benchmark
cd task1
g++ -std=c++17 -O2 -o bench memory_benchmark.cpp
./bench

# Task 2: paste task2/Program.cs into an online C# compiler and run it

# Task 3: run the library demo
cd task3
ruby main.rb
```