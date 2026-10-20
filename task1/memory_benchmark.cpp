// Task 1: static vs stack vs heap allocation of a large array

#include <iostream>
#include <chrono>
#include <cstdlib>

using namespace std;
using namespace std::chrono;

// 100,000 ints * 4 bytes = about 400 KB.
// This is big enough to be "large", but still safe for the default
// 8 MB stack limit on Linux. Windows has a 1 MB default stack, so
// on Windows this value must be made smaller (see README).
const int ARRAY_SIZE = 100000;

// number of times every function is called (task says at least 100,000)
const int CALLS = 100000;

// The result of every function is added to this variable.
// It is volatile so the compiler cannot decide that the work is useless
// and delete the whole function call when optimizations are on.
volatile long long sink = 0;

// 1) static array: lives in the data/bss segment, created once
//    when the program starts, not on every call.
long long useStaticArray() {
    static int arr[ARRAY_SIZE];

    // volatile pointer: every read and write through it must really happen,
    // so the compiler is not allowed to throw the array away
    volatile int* p = arr;

    p[0] = 1;
    p[ARRAY_SIZE / 2] = 2;
    p[ARRAY_SIZE - 1] = 3;

    return p[0] + p[ARRAY_SIZE / 2] + p[ARRAY_SIZE - 1];
}

// 2) stack array: a new array is created inside the stack frame every
//    time the function is called and it disappears when the function returns.
//    "Allocating" it is only moving the stack pointer.
long long useStackArray() {
    int arr[ARRAY_SIZE];
    volatile int* p = arr;

    p[0] = 1;
    p[ARRAY_SIZE / 2] = 2;
    p[ARRAY_SIZE - 1] = 3;

    return p[0] + p[ARRAY_SIZE / 2] + p[ARRAY_SIZE - 1];
}

// 3) heap array: memory is requested from the allocator with malloc
//    and must be given back with free. Every call asks the allocator
//    for ~1 MB, so this is the slowest one.
long long useHeapArray() {
    int* arr = (int*) malloc(ARRAY_SIZE * sizeof(int));

    if (arr == NULL) {
        cout << "malloc failed" << endl;
        return 0;
    }

    volatile int* p = arr;

    p[0] = 1;
    p[ARRAY_SIZE / 2] = 2;
    p[ARRAY_SIZE - 1] = 3;

    long long result = p[0] + p[ARRAY_SIZE / 2] + p[ARRAY_SIZE - 1];

    free(arr);
    return result;
}

// calls the given function CALLS times and returns the total time in milliseconds
double measure(long long (*func)()) {
    auto start = high_resolution_clock::now();

    for (int i = 0; i < CALLS; i++) {
        sink = sink + func();
    }

    auto end = high_resolution_clock::now();
    duration<double, milli> elapsed = end - start;
    return elapsed.count();
}

int main() {
    cout << "Array size: " << ARRAY_SIZE << " ints ("
         << (ARRAY_SIZE * sizeof(int)) / 1024 << " KB)" << endl;
    cout << "Calls per function: " << CALLS << endl;
    cout << endl;

    double staticTime = measure(useStaticArray);
    double stackTime = measure(useStackArray);
    double heapTime = measure(useHeapArray);

    cout << "Static: " << staticTime << " ms" << endl;
    cout << "Stack:  " << stackTime << " ms" << endl;
    cout << "Heap:   " << heapTime << " ms" << endl;

    return 0;
}