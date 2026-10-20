# Task 1: Static vs Stack vs Heap

The program compares the cost of getting a large array (100,000 `int`, about 390 KB)
in three different ways. Every way is a separate C++ function and every function is
called 100,000 times.

| Function | Where the array lives | How it is created |
|----------|-----------------------|-------------------|
| `useStaticArray()` | static memory (bss segment) | once, when the program starts |
| `useStackArray()`  | stack frame of the function | on every call, the stack pointer is moved |
| `useHeapArray()`   | heap | on every call with `malloc`, released with `free` |

## Files

- `memory_benchmark.cpp` - the whole program
- `README.md` - this file

## How to build and run

```bash
g++ -std=c++17 -O2 -o bench memory_benchmark.cpp
./bench
```

`ARRAY_SIZE` is 100000 and not bigger, because the default stack on Windows is small
and a very large array on the stack would crash the program.

## How the measurement works

- `measure()` calls a function `CALLS` times and uses `std::chrono::high_resolution_clock`
  to get the total time in milliseconds.
- Each function writes and reads only 3 elements (first, middle, last). So the test
  measures the cost of **getting** the memory, not the cost of filling it.
- The arrays are accessed through a `volatile int*`. With optimizations on, a compiler
  can see that an array is never really needed and remove it. Then the stack
  function would look free and the test would be wrong. A volatile pointer forces the
  real reads and writes, so the array stays.

## Results

Machine: Windows, g++ 16.2.0 (MSYS2), `-O2`, 100,000 calls, 5 runs.
Other computers will give different numbers, but the pattern should be similar.

| Version | Total time | Per call |
|---------|-----------:|---------:|
| Static | 0.16 - 0.67 ms | about 2 - 7 ns |
| Stack  | 47.5 - 67.4 ms (usually about 48 ms) | about 0.5 us |
| Heap (`malloc` / `free`) | 16.5 - 17.0 ms | about 0.17 us |

## Explanation

**Static is the fastest.** The array already exists before `main` starts, so a call
only touches 3 elements. There is no allocation inside the function at all. The
downside is that the memory is used for the whole life of the program, and the
function is not reentrant (every call uses the same array).

**Stack is the slowest in this test, which is surprising.** Normally creating an
array on the stack is very cheap, because it is only moving the stack pointer. But the
frame of `useStackArray()` is about 390 KB, which is about 98 memory pages of 4 KB.
For a frame bigger than one page, the compiler adds a stack probe at the start of the
function. I checked this in the assembly:

```bash
g++ -std=c++17 -O2 -S -o - memory_benchmark.cpp | grep -i chkstk
```

The output has the line `call ___chkstk_ms`. This function touches every page of the
frame in order, because Windows grows the stack page by page. So every call does about
98 extra memory accesses. The measured 0.5 us per call is about 5 ns per page, which
matches this explanation. A small array (less than 4 KB) would not need the probe and
would be much faster, but I did not test this here.

**Heap is slower than static, but faster than the stack in this test.** Every call has
to ask the allocator (`malloc`) for a block and give it back (`free`). The allocator
needs to find a free block and update its own bookkeeping, which costs about
0.17 us per call here. The exact cost depends on the allocator of the operating system
and on the size of the request.

## Summary

| | Static | Stack | Heap |
|-|--------|-------|------|
| Cost to get the memory | none per call | very small for small arrays, but a big frame needs stack probes | allocator work on every call |
| Size limit | memory of the program | small (about 8 MB on Linux, 1 MB on Windows by default) | large, limited by RAM |
| Lifetime | whole program | until the function returns | until `free` is called |
| Main risk | wasted memory, not reentrant | stack overflow | memory leak, fragmentation |

Because the test touches only 3 elements, it hides the cost of using the memory. If
the program filled the whole array, the filling time would be much bigger than the
allocation time and the three results would look closer to each other. I did not
measure this variant.